package com.example.demo.dao;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.example.demo.dto.Reply;

@Mapper
public interface ReplyDao {

    @Insert("""
        INSERT INTO reply
        SET regDate = NOW(),
            updateDate = NOW(),
            memberId = #{memberId},
            nickname = #{nickname},
            relTypeCode = #{relTypeCode},
            relId = #{relId},
            content = #{content},
            isSecret = #{isSecret},
            isAnonymous = #{isAnonymous},
            parentId = #{parentId}
        """)
    void writeReply(Integer memberId, String nickname, String relTypeCode, int relId, String content, boolean isSecret, boolean isAnonymous, int parentId);

    @Select("""
        SELECT *
        FROM reply
        WHERE relTypeCode = #{relTypeCode}
          AND relId = #{relId}
        ORDER BY regDate ASC
        """)
    List<Reply> getReplies(String relTypeCode, int relId);
}