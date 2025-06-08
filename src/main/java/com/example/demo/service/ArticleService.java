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

	public void writeArticle(String title, String content, int loginedMemberId, int boardId) {
		this.articleDao.writeArticle(title, content, loginedMemberId, boardId);
	}

	public List<Article> getArticles(int boardId, String city, String district, int articlesInPage, int limitFrom) {
	    return articleDao.getArticlesWithRegion(boardId, city, district, articlesInPage, limitFrom);
	}


	public Article getArticleById(int id) {
		return this.articleDao.getArticleById(id);
	}

	public void modifyArticle(int id, String title, String content) {
		this.articleDao.modifyArticle(id, title, content);
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