package com.example.demo.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.example.demo.dao.ReplyDao;
import com.example.demo.dto.Reply;

@Service
public class ReplyService {

    private final ReplyDao replyDao;

    public ReplyService(ReplyDao replyDao) {
        this.replyDao = replyDao;
    }

    public void writeReply(Integer memberId, String nickname, String relTypeCode, int relId, String content, boolean isSecret, boolean isAnonymous, int parentId) {
        replyDao.writeReply(memberId, nickname, relTypeCode, relId, content, isSecret, isAnonymous, parentId);
    }

    public List<Reply> getReplies(String relTypeCode, int relId) {
        return replyDao.getReplies(relTypeCode, relId);
    }
}