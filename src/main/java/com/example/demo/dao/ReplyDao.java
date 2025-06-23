package com.example.demo.dao;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

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

    @Select("""
        SELECT *
        FROM reply
        WHERE memberId = #{memberId}
        AND relTypeCode = #{relTypeCode}
        ORDER BY regDate DESC
    """)
    List<Reply> getReplyByMemberId(@Param("memberId") int memberId, @Param("relTypeCode") String relTypeCode);

    @Select("""
            SELECT *
            FROM reply
            WHERE id = #{id}
        """)
        Reply getReplyById(int id);


    @Update("""
        UPDATE reply
        SET content = #{content}, updateDate = NOW()
        WHERE id = #{id} AND memberId = #{memberId}
    """)
    void updateReply(@Param("id") int id, @Param("content") String content, @Param("memberId") int memberId);

    @Select("""
        SELECT relId
        FROM reply
        WHERE id = #{replyId}
    """)
    int getArticleIdByReplyId(int replyId);

    @Delete("""
    	    DELETE FROM reply
    	    WHERE id = #{id}
    	""")
    	void deleteReply(int id);

    
}