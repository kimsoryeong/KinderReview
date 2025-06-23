package com.example.demo.dao;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Options;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import com.example.demo.dto.Article;
import com.example.demo.dto.ArticleModifyDTO;

@Mapper
public interface ArticleDao {
	
	@Insert("""
		    INSERT INTO article
		        SET regDate = NOW(),
		            updateDate = NOW(),
		            memberId = #{memberId},
		            institutionName = #{institutionName},
		            boardName = #{boardName},
		            boardId = #{boardId},
		            institutionComment = #{institutionComment},
		            salaryScore = #{salaryScore},
		            welfareScore = #{welfareScore},
		            environmentScore = #{environmentScore},
		            interviewScore = #{interviewScore},
		            practiceScore = #{practiceScore},
		            salaryComment = #{salaryComment},
		            welfareComment = #{welfareComment},
		            environmentComment = #{environmentComment},
		            commuteTimeComment = #{commuteTimeComment},
		            workType = #{workType},
		            city = #{city},
		            institutionType = #{institutionType},
		            interviewComment = #{interviewComment},
		            personalHistory = #{personalHistory},
		            interviewMaterial = #{interviewMaterial},
		            interviewQnA = #{interviewQnA},
		            interviewProgress = #{interviewProgress},
		            interviewTip = #{interviewTip},
		            interviewCompleted = #{interviewCompleted},
		            interviewResults = #{interviewResults},
		            practiceComment = #{practiceComment},
		            educationalBackground = #{educationalBackground},
		            practiceAtmosphere = #{practiceAtmosphere},
		            practiceExperience = #{practiceExperience},
		            practiceReview = #{practiceReview},
		            salaryOptionsStr = #{salaryOptionsStr},
		            welfareOptionsStr = #{welfareOptionsStr},
		            title = #{title},
		            content = #{content},
		            phoneNumber = #{phoneNumber},
		            hireSalary = #{hireSalary},
		            reviewStatus = #{reviewStatus},
		            deadline = #{deadline},
		            fileName = #{fileName}
		""")
	@Options(useGeneratedKeys = true, keyProperty = "id")
	int writeArticle(Article article);

	@Insert({
        "<script>",
        "INSERT INTO article_option (articleId, type, value) VALUES ",
        "<foreach collection='options' item='opt' separator=','>",
        "(#{articleId}, #{type}, #{opt})",
        "</foreach>",
        "</script>"
    })
    void insertOptions(@Param("articleId") int articleId, @Param("type") String type, @Param("options") List<String> options);

	@Select("""
	        SELECT value FROM article_option
	        WHERE articleId = #{articleId}
	        AND type = #{type}
	    """)
    List<String> getOptionsByType(@Param("articleId") int articleId, @Param("type") String type);

	@Select("SELECT LAST_INSERT_ID()")
	int getLastInsertId();

	@Select("""
			SELECT a.*, m.loginId AS writerName
			    FROM article a
			    INNER JOIN `member` m ON a.memberId = m.id
			    WHERE boardId = #{boardId}
			    AND reviewStatus = 1
				ORDER BY a.id DESC
				LIMIT #{limitFrom}, #{articlesInPage}
			""")
	public List<Article> getArticles(int boardId, int articlesInPage, int limitFrom);
	
	@Select("""
	        SELECT
			    a.id,
			    a.regDate,
			    a.updateDate,
			    a.institutionName,
			    a.institutionComment,
			    a.boardId,
			    a.memberId,
			    a.salaryScore,
			    a.welfareScore,
			    a.environmentScore,
			    a.interviewScore,
			    a.practiceScore,
			    a.salaryComment,
			    a.welfareComment,
			    a.environmentComment,
			    a.commuteTimeComment,
			    a.salaryOptionsStr,
				a.welfareOptionsStr,
			    a.workType,
			    a.city,
			    a.institutionType,
			    a.interviewComment,
	            a.personalHistory,
	            a.interviewMaterial,
	            a.interviewTip,
	            a.interviewProgress,
	            a.interviewCompleted,
	            a.interviewQnA,
	            a.interviewResults,
	            a.practiceComment,
	            a.educationalBackground,
	            a.practiceAtmosphere,
	            a.practiceExperience,
				a.practiceReview,
				a.views,
				a.title,
				a.content,
				a.phoneNumber,
				a.hireSalary,
				a.deadline,
				a.fileName,
			    m.loginId,
			    m.nickname AS nickname
			FROM article a
			JOIN member m ON a.memberId = m.id
			WHERE a.id = #{id}
	    """)
	    Article getArticleById(int id);

	@Update("""
		    <script>
		    UPDATE article
		        SET updateDate = NOW()
		        <if test="institutionName != null and institutionName != ''">
		            , institutionName = #{institutionName}
		        </if>
		        <if test="workType != null and workType != ''">
		            , workType = #{workType}
		        </if>
		        <if test="city != null and city != ''">
		            , city = #{city}
		        </if>
		        <if test="institutionType != null and institutionType != ''">
		            , institutionType = #{institutionType}
		        </if>
		        <if test="institutionComment != null and institutionComment != ''">
		            , institutionComment = #{institutionComment}
		        </if>
		        <if test="salaryOptionsStr != null and salaryOptionsStr != ''">
		            , salaryOptionsStr = #{salaryOptionsStr}
		        </if>
		        <if test="welfareOptionsStr != null and welfareOptionsStr != ''">
		            , welfareOptionsStr = #{welfareOptionsStr}
		        </if>
		        <if test="salaryComment != null and salaryComment != ''">
		            , salaryComment = #{salaryComment}
		        </if>
		        <if test="welfareComment != null and welfareComment != ''">
		            , welfareComment = #{welfareComment}
		        </if>
		        <if test="environmentComment != null and environmentComment != ''">
		            , environmentComment = #{environmentComment}
		        </if>
		        <if test="commuteTimeComment != null and commuteTimeComment != ''">
		            , commuteTimeComment = #{commuteTimeComment}
		        </if>
		        <if test="salaryScore != null">
		            , salaryScore = #{salaryScore}
		        </if>
		        <if test="welfareScore != null">
		            , welfareScore = #{welfareScore}
		        </if>
		        <if test="environmentScore != null">
		            , environmentScore = #{environmentScore}
		        </if>
		        <if test="interviewScore != null">
		            , interviewScore = #{interviewScore}
		        </if>
		        <if test="interviewComment != null and interviewComment != ''">
		            , interviewComment = #{interviewComment}
		        </if>
		        <if test="interviewResults != null and interviewResults != ''">
		            , interviewResults = #{interviewResults}
		        </if>
		        <if test="personalHistory != null and personalHistory != ''">
		            , personalHistory = #{personalHistory}
		        </if>
		        <if test="interviewMaterial != null and interviewMaterial != ''">
		            , interviewMaterial = #{interviewMaterial}
		        </if>
		        <if test="interviewProgress != null and interviewProgress != ''">
		            , interviewProgress = #{interviewProgress}
		        </if>
		        <if test="interviewCompleted != null and interviewCompleted != ''">
		            , interviewCompleted = #{interviewCompleted}
		        </if>
		        <if test="interviewQnA != null and interviewQnA != ''">
		            , interviewQnA = #{interviewQnA}
		        </if>
		        <if test="interviewTip != null and interviewTip != ''">
		            , interviewTip = #{interviewTip}
		        </if>
		        <if test="practiceScore != null">
		            , practiceScore = #{practiceScore}
		        </if>
		        <if test="practiceComment != null and practiceComment != ''">
		            , practiceComment = #{practiceComment}
		        </if>
		        <if test="educationalBackground != null and educationalBackground != ''">
		            , educationalBackground = #{educationalBackground}
		        </if>
		        <if test="practiceExperience != null and practiceExperience != ''">
		            , practiceExperience = #{practiceExperience}
		        </if>
		        <if test="practiceReview != null and practiceReview != ''">
		            , practiceReview = #{practiceReview}
		        </if>
		        <if test="practiceAtmosphere != null and practiceAtmosphere != ''">
		            , practiceAtmosphere = #{practiceAtmosphere}
		        </if>
		        <if test="title != null and title != ''">
		            , title = #{title}
		        </if>
		        <if test="content != null and content != ''">
		            , content = #{content}
		        </if>
		        <if test="phoneNumber != null and phoneNumber != ''">
		            , phoneNumber = #{phoneNumber}
		        </if>
		        <if test="hireSalary != null and hireSalary != ''">
		            , hireSalary = #{hireSalary}
		        </if>
		        <if test="nickname != null and nickname != ''">
		            , nickname = #{nickname}
		        </if>
		    WHERE id = #{id}
		    </script>
		""")
		void modifyArticle(ArticleModifyDTO modifyDTO);

	@Delete("""
			DELETE FROM article
				WHERE id = #{id}
			""")
	public void deleteArticle(int id);

	@Select("""
			SELECT LAST_INSERT_ID()
			""")
	public int getLastArticleId();

	@Select("""
		    SELECT COUNT(id)
		    FROM article
		    WHERE boardId = #{boardId}
		    AND (#{city} IS NULL OR city = #{city})
		    AND reviewStatus = 1
		""")
	int getArticlesCntWithRegion(@Param("boardId") int boardId,
	                             @Param("city") String city);

	@Select("""
		    <script>
		        SELECT a.*
		        FROM article a
		        WHERE a.boardId = #{boardId}
		        AND a.reviewStatus = 1
		        <if test="keyword != null and keyword != ''">
		            <choose>
		                <when test="searchType.equals('institutionName')">
							AND a.institutionName LIKE CONCAT('%', #{keyword}, '%')
		                </when>
		                <when test="searchType ==('title')">
							AND a.title LIKE CONCAT('%', #{keyword}, '%')
		                </when>
		                <when test="searchType == 'content'">
		                    AND (
		                        a.institutionComment LIKE CONCAT('%', #{keyword}, '%')
		                        OR a.salaryComment LIKE CONCAT('%', #{keyword}, '%')
		                        OR a.welfareComment LIKE CONCAT('%', #{keyword}, '%')
		                        OR a.environmentComment LIKE CONCAT('%', #{keyword}, '%')
		                        OR a.commuteTimeComment LIKE CONCAT('%', #{keyword}, '%')
		                        OR a.interviewComment LIKE CONCAT('%', #{keyword}, '%')
		                        OR a.personalHistory LIKE CONCAT('%', #{keyword}, '%')
		                        OR a.interviewMaterial LIKE CONCAT('%', #{keyword}, '%')
		                        OR a.interviewQnA LIKE CONCAT('%', #{keyword}, '%')
		                        OR a.interviewResults LIKE CONCAT('%', #{keyword}, '%')
		                        OR a.interviewProgress LIKE CONCAT('%', #{keyword}, '%')
		                        OR a.interviewTip LIKE CONCAT('%', #{keyword}, '%')
		                        OR a.interviewCompleted LIKE CONCAT('%', #{keyword}, '%')
		                        OR a.practiceComment LIKE CONCAT('%', #{keyword}, '%')
		                        OR a.educationalBackground LIKE CONCAT('%', #{keyword}, '%')
		                        OR a.practiceAtmosphere LIKE CONCAT('%', #{keyword}, '%')
		                        OR a.practiceExperience LIKE CONCAT('%', #{keyword}, '%')
		                        OR a.practiceReview LIKE CONCAT('%', #{keyword}, '%')
		                        OR a.content LIKE CONCAT('%', #{keyword}, '%')
		                        OR a.phoneNumber LIKE CONCAT('%', #{keyword}, '%')
		                        OR a.hireSalary LIKE CONCAT('%', #{keyword}, '%')
		                    )
		                </when>
		                <otherwise>
		                   AND (
		                        a.institutionName LIKE CONCAT('%', #{keyword}, '%')
		                        OR a.title LIKE CONCAT('%', #{keyword}, '%')
		                        OR a.institutionComment LIKE CONCAT('%', #{keyword}, '%')
		                        OR a.salaryComment LIKE CONCAT('%', #{keyword}, '%')
		                        OR a.welfareComment LIKE CONCAT('%', #{keyword}, '%')
		                        OR a.environmentComment LIKE CONCAT('%', #{keyword}, '%')
		                        OR a.commuteTimeComment LIKE CONCAT('%', #{keyword}, '%')
		                        OR a.interviewComment LIKE CONCAT('%', #{keyword}, '%')
		                        OR a.personalHistory LIKE CONCAT('%', #{keyword}, '%')
		                        OR a.interviewMaterial LIKE CONCAT('%', #{keyword}, '%')
		                        OR a.interviewQnA LIKE CONCAT('%', #{keyword}, '%')
		                        OR a.interviewResults LIKE CONCAT('%', #{keyword}, '%')
		                        OR a.interviewProgress LIKE CONCAT('%', #{keyword}, '%')
		                        OR a.interviewTip LIKE CONCAT('%', #{keyword}, '%')
		                        OR a.interviewCompleted LIKE CONCAT('%', #{keyword}, '%')
		                        OR a.practiceComment LIKE CONCAT('%', #{keyword}, '%')
		                        OR a.educationalBackground LIKE CONCAT('%', #{keyword}, '%')
		                        OR a.practiceAtmosphere LIKE CONCAT('%', #{keyword}, '%')
		                        OR a.practiceExperience LIKE CONCAT('%', #{keyword}, '%')
		                        OR a.practiceReview LIKE CONCAT('%', #{keyword}, '%')
		                        OR a.content LIKE CONCAT('%', #{keyword}, '%')
		                        OR a.phoneNumber LIKE CONCAT('%', #{keyword}, '%')
		                        OR a.hireSalary LIKE CONCAT('%', #{keyword}, '%')
		                    )
		                </otherwise>
		            </choose>
		          </if>
		    </script>
		""")
	List<Article> searchKeyword(@Param("boardId") int boardId,@Param("searchType") String searchType, @Param("keyword") String keyword);

	@Select("""
		    <script>
		        SELECT a.*, m.loginId AS writerName
		        FROM article a
		        INNER JOIN `member` m ON a.memberId = m.id
		        WHERE a.boardId = #{boardId}
		        AND a.reviewStatus = 1
		        <if test="city != null and city != ''">
		            AND a.city = #{city}
		        </if>
		        ORDER BY a.id DESC
		        LIMIT #{limitFrom}, #{articlesInPage}
		    </script>
		""")
	List<Article> getArticlesWithRegion(
	    @Param("boardId") int boardId,
	    @Param("city") String city,
	    @Param("articlesInPage") int articlesInPage,
	    @Param("limitFrom") int limitFrom
	);

	@Update("""
			UPDATE article
				SET views = views + 1
				WHERE id = #{id}
			""")
	public void increaseViews(int id);

	@Select("""
		    SELECT a.*, 
		           (SELECT COUNT(*) 
		            FROM reply r 
		            WHERE r.relTypeCode = 'article' 
		              AND r.relId = a.id) AS replyCount
		    FROM article a
		    WHERE a.boardId = #{boardId}
		      AND a.reviewStatus = 1
		    ORDER BY a.views DESC
		    LIMIT 3
		""")
		List<Article> getTopArticlesByViews(@Param("boardId") int boardId);


	@Select("""
		    SELECT *
		    FROM article
		    WHERE boardId = #{boardId}
		    ORDER BY regDate DESC
		    LIMIT #{limit}
		""")
	List<Article> getLatestArticlesByBoardId(@Param("boardId") int boardId, @Param("limit") int limit);

	@Select("""
		    SELECT *
		    FROM article
		    WHERE memberId = #{memberId}
		    ORDER BY regDate DESC
		""")
	List<Article> getArticlesByMemberId(@Param("memberId") int memberId);

	@Select("""
		    SELECT a.*
			FROM article a
		    INNER JOIN likePoint lp ON a.id = lp.relId
		    WHERE lp.memberId = #{memberId}
		    AND lp.relTypeCode = #{relTypeCode}
		    ORDER BY a.regDate DESC
		""")
	List<Article> getLikedArticlesByMemberId(int memberId, String relTypeCode);

	@Select("""
		    SELECT * 
			FROM article 
			WHERE memberId = #{memberId} 
			AND reviewStatus = 0 
			ORDER BY regDate DESC
		""")
	List<Article> getPendingArticlesByMemberId(int memberId);

	
	 @Select("""
		        SELECT COUNT(*) 
				FROM reply 
				WHERE relTypeCode = 'article' AND relId = #{articleId};
		    """)
	int getReplyCountByArticleId(int articleId);

	 @Select("""
			    SELECT a.*, m.nickname AS nickname
			    FROM article a
			    JOIN member m ON a.memberId = m.id
			    WHERE a.reviewStatus = 0
			    ORDER BY a.regDate DESC
			""")
			List<Article> getPendingReviews();

	 
	 @Update("""
			    UPDATE article
			    SET 
			        fileName = #{fileName},
			        reviewStatus = 0,
			        updateDate = NOW()
			    WHERE id = #{articleId}
			""")
			void updateReuploadFile(@Param("articleId") int articleId, @Param("fileName") String fileName);


}