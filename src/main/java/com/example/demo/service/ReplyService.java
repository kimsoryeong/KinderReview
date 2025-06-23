package com.example.demo.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.demo.dao.ReplyDao;
import com.example.demo.dto.Article;
import com.example.demo.dto.Reply;

@Service
public class ReplyService {

    private final ReplyDao replyDao;
    private final ArticleService articleService;
    

    public ReplyService(ReplyDao replyDao, ArticleService articleService) {
        this.replyDao = replyDao;
        this.articleService = articleService;
    }

    public void writeReply(Integer memberId, String nickname, String relTypeCode, int relId, String content, boolean isSecret, boolean isAnonymous, int parentId) {
        replyDao.writeReply(memberId, nickname, relTypeCode, relId, content, isSecret, isAnonymous, parentId);
    }

    public List<Reply> getReplies(String relTypeCode, int relId, int memberId) {
        List<Reply> replies = replyDao.getReplies(relTypeCode, relId);
        
        for (Reply reply : replies) {
            if (reply.isSecret()) {
                Article article = articleService.getArticleById(relId); 
                if (article != null && !(reply.getMemberId() == memberId || article.getMemberId() == memberId)) {
                    reply.setContent("비밀댓글입니다."); 
                }
            }
        }
        return replies;
    }

    public List<Reply> getReplyByMemberId(int memberId) {
        return replyDao.getReplyByMemberId(memberId, "article");
    }
    

    @Transactional
    public void modifyReply(int id, String content, int memberId) {
        replyDao.updateReply(id, content, memberId);
    }

    public Reply getReplyById(int id) {
        return replyDao.getReplyById(id);
    }

    public int getArticleIdByReplyId(int replyId) {
        return replyDao.getArticleIdByReplyId(replyId);
    }

    public void deleteReply(int id) {
        this.replyDao.deleteReply(id);
    }


}