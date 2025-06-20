package com.example.demo.dao;

import com.example.demo.dto.Article;
import com.example.demo.dto.Member;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface AdminDao {

    @Select("""
        SELECT *
        FROM member
        WHERE authLevel = 2 AND approveStatus = 0
        ORDER BY regDate DESC
    """)
    List<Member> findPendingInstitution();

    @Update("""
        UPDATE member
        SET approveStatus = #{approveStatus},
            rejectReason = #{rejectReason},
    		updateDate = NOW()
        WHERE id = #{memberId}
    """)
    void updateInstitutionStatus(@Param("memberId") int memberId, @Param("approveStatus") int approveStatus, @Param("rejectReason") String rejectReason);

    @Select("""
        SELECT *
        FROM article
        WHERE reviewStatus = 0
        AND boardName = '근무 리뷰'
        ORDER BY regDate DESC
    """)
    List<Article> findPendingReviews();

    @Update("""
        UPDATE article
        SET reviewStatus = #{reviewStatus},
    		rejectReason = #{rejectReason},
            updateDate = NOW()
        WHERE id = #{id}
    """)
    void updateReviewStatus(@Param("id") int id,  @Param("reviewStatus") int reviewStatus,@Param("rejectReason") String rejectReason);


}