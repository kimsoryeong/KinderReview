package com.example.demo.service;


import java.time.LocalDate;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.example.demo.dao.ArticleDao;
import com.example.demo.dto.Article;
import com.example.demo.dto.ArticleModifyDTO;
import com.example.demo.dto.FileDto;

@Service
public class ArticleService {

	 private final ArticleDao articleDao;
	 private final BoardService boardService;
	 private final FileService fileService;
	 
	 public ArticleService(BoardService boardService, ArticleDao articleDao, FileService fileService) {
		this.articleDao = articleDao;
		this.boardService = boardService;
		this.fileService = fileService;
	}
	
	public int writeArticle(Article article) {
			int boardId = boardService.getBoardIdByName(article.getBoardName());
			article.setBoardId(boardId);

			if (boardId == 4) {
		        article.setReviewStatus(0); 
		    } else {
		        article.setReviewStatus(1); 
		    }
			
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

    public List<Article> getPendingReviews() {
        return articleDao.getPendingReviews();
    }

    
    public Article getArticleByIdWithFiles(int id) {
        Article article = articleDao.getArticleById(id);
        if (article == null) {
            return null;
        }
        List<FileDto> files = fileService.getFilesByArticleId(id);
        article.setFiles(files);
        return article;
    }

    public void modifyArticle(ArticleModifyDTO modifyDTO) {
        String salaryOptionsStr = (modifyDTO.getSalaryOptions() != null && !modifyDTO.getSalaryOptions().isEmpty()) 
            ? String.join(",", modifyDTO.getSalaryOptions()) : null;
        String welfareOptionsStr = (modifyDTO.getWelfareOptions() != null && !modifyDTO.getWelfareOptions().isEmpty()) 
            ? String.join(",", modifyDTO.getWelfareOptions()) : null;
        
        modifyDTO.setSalaryOptionsStr(salaryOptionsStr);
        modifyDTO.setWelfareOptionsStr(welfareOptionsStr);
        
        articleDao.modifyArticle(modifyDTO);
    }

	public int getReplyCountByArticleId(int articleId) {
		return articleDao.getReplyCountByArticleId(articleId);
	}


	public void reuploadFile(int articleId, String fileName) {
	    articleDao.updateReuploadFile(articleId, fileName);
	}


   

  

    

}