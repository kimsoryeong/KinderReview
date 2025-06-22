package com.example.demo.controller;


import java.io.IOException;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.demo.dto.Article;
import com.example.demo.dto.Reply;
import com.example.demo.dto.Req;
import com.example.demo.service.ArticleService;
import com.example.demo.service.ReplyService;
import com.example.demo.util.Util;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Controller
public class UsrReplyController {

    private final ReplyService replyService;
    private final Req req;
    private final ArticleService articleService;
    
    public UsrReplyController(ReplyService replyService, Req req, ArticleService articleService) {
        this.replyService = replyService;
        this.req = req;
        this.articleService = articleService;
    }

    @PostMapping("/usr/reply/doWrite")
    public String doWrite(
        String relTypeCode,
        @RequestParam(name = "relId", defaultValue = "0") int relId,
        String content,
        @RequestParam(defaultValue = "false") boolean isSecret, 
        HttpServletResponse response,
        @RequestParam(defaultValue = "0") int parentId
    ) throws IOException {

        if (!req.isLogined()) {
            String script = Util.jsBack("로그인 후 작성 가능합니다.");
            response.setContentType("text/html;charset=UTF-8");
            response.getWriter().write(script);
            return null; 
        }

        int memberId = req.getLoginedMember().getId();
        String nickname;
        boolean isAnonymous;

        Article article = articleService.getArticleById(relId);
        if (article == null) {
            String script = Util.jsBack("존재하지 않는 게시글입니다.");
            response.setContentType("text/html;charset=UTF-8");
            response.getWriter().write(script);
            return null; 
        }
        int boardId = article.getBoardId();

        if (boardId == 4 || boardId == 5 || boardId == 6) {
            if (req.getLoginedMember().getAuthLevel() == 2) {
                String script = Util.jsBack("해당 게시판에서는 기관회원은 댓글을 작성할 수 없습니다.");
                response.setContentType("text/html;charset=UTF-8");
                response.getWriter().write(script);
                return null;
            }
            isAnonymous = true;
            nickname = "익명";
        } else {
            isAnonymous = false;
            nickname = req.getLoginedMember().getNickname();
        }

        replyService.writeReply(memberId, nickname, relTypeCode, relId, content, isSecret, isAnonymous, parentId);

        return "redirect:/usr/article/detail?id=" + relId;
    }
    
    @PostMapping("/usr/reply/doModify")
    public String doModify(@RequestParam int id, @RequestParam String content, HttpServletResponse response) {
        int loginedMemberId = req.getLoginedMember().getId(); 
        try {
            replyService.modifyReply(id, content, loginedMemberId);  
            int articleId = replyService.getArticleIdByReplyId(id);  
            return "redirect:/usr/article/detail?id=" + articleId; 
        } catch (Exception e) {
            return "redirect:/usr/article/detail?id=" + id;  
        }
    }


    @PostMapping("/usr/reply/doDelete")
    public String doDelete(@RequestParam int id, HttpServletRequest req, HttpServletResponse response, Model model) {
        Integer loginedMemberId = (Integer) req.getSession().getAttribute("loginedMemberId");  
        if (loginedMemberId == null) {
            return "redirect:/usr/login";  
        }
        try {
            replyService.deleteReply(id, loginedMemberId);

            List<Reply> updatedReplies = replyService.getReplies("article", id, loginedMemberId);
            
            model.addAttribute("replies", updatedReplies);

            return "redirect:/usr/article/detail?id=" + id;
        } catch (Exception e) {
            e.printStackTrace();
            return "redirect:/usr/article/detail?id=" + id;  
        }
    }









}
