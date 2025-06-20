package com.example.demo.service;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.dao.ArticleDao;
import com.example.demo.dto.Article;

@Service
public class ArticleService {

	 private final ArticleDao articleDao;
	 private final BoardService boardService;
	 
	 @Autowired
	 public ArticleService(BoardService boardService, ArticleDao articleDao) {
		this.articleDao = articleDao;
		this.boardService = boardService;
	}
	
	public int writeArticle(Article article) {
			int boardId = boardService.getBoardIdByName(article.getBoardName());
			article.setBoardId(boardId);

			if (article.getSalaryOptions() != null && !article.getSalaryOptions().isEmpty()) {
		        article.setSalaryOptionsStr(String.join(",", article.getSalaryOptions()));
		    } else {
		        article.setSalaryOptionsStr(null);
		    }
		    if (article.getWelfareOptions() != null && !article.getWelfareOptions().isEmpty()) {
		        article.setWelfareOptionsStr(String.join(",", article.getWelfareOptions()));
		    } else {
		        article.setWelfareOptionsStr(null);
		    }
		    
			articleDao.writeArticle(article);
			int articleId = article.getId();

			if (article.getSalaryOptions() != null && !article.getSalaryOptions().isEmpty()) {
				articleDao.insertOptions(articleId, "salary", article.getSalaryOptions());
			}
			if (article.getWelfareOptions() != null && !article.getWelfareOptions().isEmpty()) {
				articleDao.insertOptions(articleId, "welfare", article.getWelfareOptions());
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
		
	    return articleDao.getArticleById(id);
	}


	 public List<Article> SearchKeyword(Integer boardId, String searchType, String keyword) {
	        return articleDao.searchKeyword(boardId, searchType, keyword);
	    }




	public void modifyArticle(
		    String institutionName, int id, String workType, String city, String institutionType, String institutionComment,
		    String salaryOptions, String welfareOptions, String salaryComment, String welfareComment, String environmentComment, String commuteTimeComment,
		    Integer salaryScore, Integer welfareScore, Integer environmentScore, Integer interviewScore, String interviewComment, String interviewResults, String personalHistory,
		    String interviewMaterial, String interviewProgress, String interviewCompleted, String interviewQnA, String interviewTip,
		    Integer practiceScore, String practiceComment, String educationalBackground, String practiceExperience, String practiceReview, String practiceAtmosphere
		) {
		    articleDao.modifyArticle(
		        institutionName, id, workType, city, institutionType, institutionComment,
		        salaryOptions, welfareOptions, salaryComment, welfareComment, environmentComment, commuteTimeComment,
		        salaryScore, welfareScore, environmentScore, interviewScore, interviewComment, interviewResults, personalHistory,
		        interviewMaterial, interviewProgress, interviewCompleted, interviewQnA, interviewTip,
		        practiceScore, practiceComment, educationalBackground, practiceExperience, practiceReview, practiceAtmosphere
		    );
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
    
    public void increaseViews(int id) {
    	 System.out.println("increaseViews called for id: " + id);
		this.articleDao.increaseViews(id);
	}

    public List<Article> getTopArticlesByViews(int boardId) {
        return articleDao.getTopArticlesByViews(boardId);
    }

    public List<Article> getLatestArticlesByBoardId(int boardId, int limit) {
        return articleDao.getLatestArticlesByBoardId(boardId, limit);
    }
    
    public List<Article> getArticlesByMemberId(int memberId) {
        return articleDao.getArticlesByMemberId(memberId);
    }


    public List<Article> getLikedArticlesByMemberId(int memberId) {
        return articleDao.getLikedArticlesByMemberId(memberId, "article");
    } 
    
   

    public List<Article> getPendingArticlesByMemberId(int memberId) {
        return articleDao.getPendingArticlesByMemberId(memberId);
    }



}