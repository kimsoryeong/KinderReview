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
		            practiceReview = #{practiceReview}
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
				        <if test="institutionComment != null and institutionComment != ''">
				        	, institutionComment = #{institutionComment}
				        </if>
				    WHERE id = #{id}
			    </script>
				""")
		public void modifyArticle(String institutionName, int id, String institutionComment);
	
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
			            <choose>
			                <when test="searchType == 'institution'">
			                    a.institutionName LIKE CONCAT('%', #{keyword}, '%')
			                </when>
			                <when test="searchType == 'content'">
			                    (
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
			                    (
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
		List<Article> searchKeyword(String searchType, String keyword);
	
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

	

}