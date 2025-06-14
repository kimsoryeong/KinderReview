package com.example.demo.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.example.demo.dao.ArticleDao;
import com.example.demo.dto.Article;

@Service
public class ArticleService {

	private ArticleDao articleDao;
	 private final BoardService boardService;
	 
	 public ArticleService(BoardService boardService, ArticleDao articleDao) {
		this.articleDao = articleDao;
		this.boardService = boardService;
	}
	
	public int writeArticle(Article article) {
			int boardId = boardService.getBoardIdByName(article.getBoardName());
			article.setBoardId(boardId);

			articleDao.writeArticle(article);
			int articleId = article.getId();

			if (article.getSalaryOptions() != null && !article.getSalaryOptions().isEmpty()) {
				articleDao.insertOptions(articleId, "salary", article.getSalaryOptions());
			}
			if (article.getWelfareOptions() != null && !article.getWelfareOptions().isEmpty()) {
				articleDao.insertOptions(articleId, "welfare", article.getWelfareOptions());
			}
			if (article.getEnvironmentOptions() != null && !article.getEnvironmentOptions().isEmpty()) {
				articleDao.insertOptions(articleId, "environment", article.getEnvironmentOptions());
			}

			return articleId;
	}
		
	public List<String> getOptions(int articleId, String type) {
        return articleDao.getOptionsByType(articleId, type);
    }


	public List<Article> getArticles(int boardId, String city, int articlesInPage, int limitFrom) {
        return articleDao.getArticlesWithRegion(boardId, city, articlesInPage, limitFrom);
    }

    public Article getArticleById(int id) {
        return this.articleDao.getArticleById(id);
    }

    public void modifyArticle(String institutionName, int id, String institutionComment) {
        this.articleDao.modifyArticle(institutionName, id, institutionComment);
    }

    public void deleteArticle(int id) {
        this.articleDao.deleteArticle(id);
    }

    public int getLastArticleId() {
        return this.articleDao.getLastArticleId();
    }

    public int getArticlesCnt(int boardId, String city) {
        return articleDao.getArticlesCntWithRegion(boardId, city);
    }
    
    public List<Article> SearchKeyword(String searchType, String keyword) {
        return articleDao.searchKeyword(searchType, keyword);
    }

	

	
	
	
	

}