package com.example.demo.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.example.demo.dao.ArticleDao;
import com.example.demo.dto.Article;

@Service
public class ArticleService {

	private ArticleDao articleDao;
	
	public ArticleService(ArticleDao articleDao) {
		this.articleDao = articleDao;
	}

	public int writeArticle(Article article, List<String> salaryOptions, List<String> welfareOptions, List<String> environmentOptions) {
        // article 객체로 insert 수행
        articleDao.writeArticle(article);
        int articleId = article.getId();

        if (salaryOptions != null && !salaryOptions.isEmpty()) {
            articleDao.insertOptions(articleId, "salary", salaryOptions);
        }
        if (welfareOptions != null && !welfareOptions.isEmpty()) {
            articleDao.insertOptions(articleId, "welfare", welfareOptions);
        }
        if (environmentOptions != null && !environmentOptions.isEmpty()) {
            articleDao.insertOptions(articleId, "environment", environmentOptions);
        }

        return articleId;
    }
	
	
	
	public List<String> getOptions(int articleId, String type) {
        return articleDao.getOptionsByType(articleId, type);
    }


	public List<Article> getArticles(int boardId, String city, String district, int articlesInPage, int limitFrom) {
        return articleDao.getArticlesWithRegion(boardId, city, district, articlesInPage, limitFrom);
    }

    public Article getArticleById(int id) {
        return this.articleDao.getArticleById(id);
    }

    public void modifyArticle(String institutionName, int id, String content) {
        this.articleDao.modifyArticle(institutionName, id, content);
    }

    public void deleteArticle(int id) {
        this.articleDao.deleteArticle(id);
    }

    public int getLastArticleId() {
        return this.articleDao.getLastArticleId();
    }

    public int getArticlesCnt(int boardId, String city, String district) {
        return articleDao.getArticlesCntWithRegion(boardId, city, district);
    }
    
    public List<Article> SearchKeyword(String searchType, String keyword) {
        return articleDao.searchKeyword(searchType, keyword);
    }
	
	

}