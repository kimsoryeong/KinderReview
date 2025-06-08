package com.example.demo.dao;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.example.demo.dto.Article;

@Mapper
public interface ArticleDao {
	
	@Insert("""
			INSERT INTO article
			    SET regDate = NOW()
			        , updateDate = NOW()
			        , memberId = #{loginedMemberId}
			        , boardId = #{boardId}
			        , title = #{title}
			        , content = #{content}
			""")
	public void writeArticle(String title, String content, int loginedMemberId, int boardId);

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
			SELECT a.*, m.loginId AS writerName
			    FROM article a
			    INNER JOIN `member` m
			    ON a.memberId = m.id
				WHERE a.id = #{id}
			""")
	public Article getArticleById(int id);

	@Update("""
			<script>
			UPDATE article
			    SET updateDate = NOW()
			    	<if test="title != null and title != ''">
			        	, title = #{title}
			        </if>
			        <if test="content != null and content != ''">
			        	, content = #{content}
			        </if>
			    WHERE id = #{id}
		    </script>
			""")
	public void modifyArticle(int id, String title, String content);

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
		    AND (#{district} IS NULL OR district = #{district})
		""")
		int getArticlesCntWithRegion(@Param("boardId") int boardId,
		                             @Param("city") String city,
		                             @Param("district") String district);

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
		        <if test="district != null and district != ''">
		            AND a.district = #{district}
		        </if>
		        ORDER BY a.id DESC
		        LIMIT #{limitFrom}, #{articlesInPage}
		    </script>
		""")
		List<Article> getArticlesWithRegion(
		    @Param("boardId") int boardId,
		    @Param("city") String city,
		    @Param("district") String district,
		    @Param("articlesInPage") int articlesInPage,
		    @Param("limitFrom") int limitFrom
		);

	

}