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
		            welfareOptionsStr = #{welfareOptionsStr}
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
				    INNER JOIN `member` m
				    ON a.memberId = m.id
				    WHERE boardId = #{boardId}
					ORDER BY a.id DESC
					LIMIT #{limitFrom}, #{articlesInPage}
				""")
		public List<Article> getArticles( int boardId, int articlesInPage, int limitFrom);
		
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
				    m.loginId AS writerName
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
			    WHERE id = #{id}
			    </script>
			""")

		void modifyArticle(
			    String institutionName, int id, String workType, String city, String institutionType, String institutionComment,
			    String salaryOptionsStr, String welfareOptionsStr, String salaryComment, String welfareComment, String environmentComment, String commuteTimeComment,
			    Integer salaryScore, Integer welfareScore, Integer environmentScore, Integer interviewScore, String interviewComment, String interviewResults, String personalHistory,
			    String interviewMaterial, String interviewProgress, String interviewCompleted, String interviewQnA, String interviewTip,
			    Integer practiceScore, String practiceComment, String educationalBackground, String practiceExperience, String practiceReview, String practiceAtmosphere
			);


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
			""")
			int getArticlesCntWithRegion(@Param("boardId") int boardId,
			                             @Param("city") String city);
	
		@Select("""
			    <script>
			        SELECT a.*
			        FROM article a
			        <where>
			        a.boardId = #{boardId}
			            <choose>
			                <when test="searchType.equals('institutionName')">
								AND a.institutionName LIKE CONCAT('%', #{keyword}, '%')
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
			                    )
			                </when>
			                <otherwise>
			                   AND (
			                        a.institutionName LIKE CONCAT('%', #{keyword}, '%')
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
			                    )
			                </otherwise>
			            </choose>
			        </where>
			    </script>
			""")
		List<Article> searchKeyword(@Param("boardId") int boardId,@Param("searchType") String searchType, @Param("keyword") String keyword);
	
		@Select("""
			    <script>
			        SELECT a.*, m.loginId AS writerName
			        FROM article a
			        INNER JOIN `member` m ON a.memberId = m.id
			        WHERE a.boardId = #{boardId}
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
			    SELECT *
			    FROM article
			    WHERE boardId = #{boardId}
			    ORDER BY views DESC
			    LIMIT 2
			""")
			List<Article> getTopArticlesByViews(int boardId);




		@Select("""
			    SELECT *
			    FROM article
			    WHERE boardId = #{boardId}
			    ORDER BY regDate DESC
			    LIMIT #{limit}
			""")
			List<Article> getLatestArticlesByBoardId(@Param("boardId") int boardId, @Param("limit") int limit);



		

	

	

}