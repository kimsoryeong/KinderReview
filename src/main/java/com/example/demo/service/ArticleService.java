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
	
	public int writeArticle(String institutionName, String content, int memberId, int boardId,
            Integer salaryScore, Integer welfareScore, Integer environmentScore,
            String salaryComment, String welfareComment, String environmentComment, String commuteTimeComment,
            List<String> salaryOptions, List<String> welfareOptions, List<String> environmentOptions,
            String workType, String city, String institutionType) {

		Article article = new Article();
		article.setInstitutionName(institutionName);
		article.setContent(content);
		article.setMemberId(memberId);
		article.setBoardId(boardId);
		article.setSalaryScore(salaryScore);
		article.setWelfareScore(welfareScore);
		article.setEnvironmentScore(environmentScore);
		article.setSalaryComment(salaryComment);
		article.setWelfareComment(welfareComment);
		article.setEnvironmentComment(environmentComment);
		article.setEnvironmentComment(commuteTimeComment);
		article.setWorkType(workType);
		article.setCity(city);
		article.setInstitutionType(institutionType);
		
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


	public List<Article> getArticles(int boardId, String city, int articlesInPage, int limitFrom) {
        return articleDao.getArticlesWithRegion(boardId, city, articlesInPage, limitFrom);
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

    public int getArticlesCnt(int boardId, String city) {
        return articleDao.getArticlesCntWithRegion(boardId, city);
    }
    
    public List<Article> SearchKeyword(String searchType, String keyword) {
        return articleDao.searchKeyword(searchType, keyword);
    }

	
	
	

}