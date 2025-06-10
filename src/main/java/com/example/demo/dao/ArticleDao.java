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
		            boardId = #{boardId},
		            content = #{content},
		            salaryScore = #{salaryScore},
		            welfareScore = #{welfareScore},
		            environmentScore = #{environmentScore},
		            salaryComment = #{salaryComment},
		            welfareComment = #{welfareComment},
		            environmentComment = #{environmentComment},
		            commuteTimeComment = #{commuteTimeComment},
		            workType = #{workType},
		            city = #{city},
		            institutionType = #{institutionType}
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
				    a.content,
				    a.boardId,
				    a.memberId,
				    a.salaryScore,
				    a.welfareScore,
				    a.environmentScore,
				    a.salaryComment,
				    a.welfareComment,
				    a.environmentComment,
				    a.commuteTimeComment,
				    a.workType,
				    a.city,
				    a.institutionType,
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
				        <if test="content != null and content != ''">
				        	, content = #{content}
				        </if>
				    WHERE id = #{id}
			    </script>
				""")
		public void modifyArticle(String institutionName, int id, String content);
	
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
				SELECT a.title, a.content
			    FROM article AS a
			    INNER JOIN board AS b
			    ON a.boardId = b.Id
			    WHERE a.title LIKE CONCAT ('%', #{keyword} ,'%')
			    OR a.content  LIKE CONCAT ('%', #{keyword} ,'%')
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