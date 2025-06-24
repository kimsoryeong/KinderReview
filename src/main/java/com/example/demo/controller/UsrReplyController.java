package com.example.demo.controller;


import java.io.IOException;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.demo.dto.Article;
import com.example.demo.dto.Reply;
import com.example.demo.dto.Reply.ReplyCountDto;
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


    @PostMapping("/usr/reply/delete")
    @ResponseBody
    public String delete(@RequestParam int id, HttpServletRequest request, HttpServletResponse response) {
        if (!req.isLogined()) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            return "로그인이 필요합니다.";
        }

        int loginedMemberId = req.getLoginedMember().getId();
        int authLevel = req.getLoginedMember().getAuthLevel();

        Reply reply = replyService.getReplyById(id);

        if (reply == null) {
            response.setStatus(HttpServletResponse.SC_NOT_FOUND);
            return "존재하지 않는 댓글입니다.";
        }

        if (reply.getMemberId() != loginedMemberId && authLevel != 0) {
            response.setStatus(HttpServletResponse.SC_FORBIDDEN);
            return "삭제 권한이 없습니다.";
        }

        replyService.deleteReply(id);
        return "댓글이 삭제되었습니다.";
    }
    
    @GetMapping("/usr/reply/count")
    @ResponseBody
    public int getReplyCount(@RequestParam int relId) {
        return articleService.getReplyCountByArticleId(relId);
    }


   


}








