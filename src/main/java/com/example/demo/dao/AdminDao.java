package com.example.demo.dao;

import com.example.demo.dto.Article;
import com.example.demo.dto.Member;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface AdminDao {

    // 가입 승인 대기 중인 기관 리스트 조회
    @Select("""
        SELECT *
        FROM member
        WHERE authLevel = 2 AND institutionAccepted = 0
        ORDER BY regDate DESC
    """)
    List<Member> findPendingInstitution();

    // 기관 가입 승인/반려 상태 업데이트 (true: 승인, false: 반려)
    @Update("""
        UPDATE member
        SET companyAccepted = 
            CASE WHEN #{approved} = true THEN 1 ELSE 2 END,
            updateDate = NOW()
        WHERE id = #{memberId}
    """)
    void updateInstitutionStatus(@Param("memberId") int memberId, @Param("approved") boolean approved);

    // 대기 중인 근무 리뷰 리스트 조회
    @Select("""
        SELECT *
        FROM article
        WHERE reviewStatus = 0
        AND boardName = '근무 리뷰'
        ORDER BY regDate DESC
    """)
    List<Article> findPendingReviews();

    // 근무 리뷰 상태 업데이트 (1: 승인, 2: 반려)
    @Update("""
        UPDATE article
        SET reviewStatus = #{status},
    		rejectReason = #{rejectReason},
            updateDate = NOW()
        WHERE id = #{articleId}
    """)
    void updateReviewStatus(@Param("articleId") int articleId, @Param("status") int status,@Param("rejectReason") String rejectReason);

    @Select("""
    	    SELECT *
    	    FROM article
    	    WHERE id = #{id}
    	""")
    	Article findArticleById(@Param("id") int id);

}
