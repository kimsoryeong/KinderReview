package com.example.demo.controller;

import java.util.ArrayList;
import java.util.LinkedHashSet;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.dto.Article;
import com.example.demo.dto.Board;
import com.example.demo.dto.Reply;
import com.example.demo.dto.Req;
import com.example.demo.service.ArticleService;
import com.example.demo.service.BoardService;
import com.example.demo.service.ReplyService;
import com.example.demo.util.Util;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Controller
public class UsrArticleController {
	
	private ArticleService articleService;
	private BoardService boardService;
	private Req req;
	private ReplyService replyService;
	
	public UsrArticleController(ArticleService articleService, BoardService boardService, Req req, ReplyService replyService) {
		this.articleService = articleService;
		this.replyService = replyService;
		this.boardService = boardService;
		this.req = req;
	}
	
	@GetMapping("/usr/article/mainWrite")
	public String mainWrite(@RequestParam(required = false) Integer boardId, Model model) {
	    model.addAttribute("boardId", boardId); 
	    return "usr/article/mainWrite";
	}


	@PostMapping("/usr/article/doWrite")
	@ResponseBody
	public String doWrite(
	    @RequestParam String institutionName,
	    @RequestParam(required = false) String institutionComment,
	    @RequestParam String boardName,
	    @RequestParam(required = false) Integer salaryScore,
	    @RequestParam(required = false) Integer welfareScore,
	    @RequestParam(required = false) Integer environmentScore,
	    @RequestParam(required = false) Integer interviewScore,
	    @RequestParam(required = false) Integer practiceScore,
	    @RequestParam(required = false) String salaryComment,
	    @RequestParam(required = false) String welfareComment,
	    @RequestParam(required = false) String environmentComment,
	    @RequestParam(required = false) String commuteTimeComment,
	    @RequestParam(required = false) List<String> salaryOptions,
	    @RequestParam(required = false) List<String> welfareOptions,
	    @RequestParam(required = false) String workType,
	    @RequestParam(required = false) String city,
	    @RequestParam(required = false) String institutionType,
	    @RequestParam(required = false) String interviewComment,
	    @RequestParam(required = false) String personalHistory,
	    @RequestParam(required = false) String interviewMaterial,
	    @RequestParam(required = false) String interviewQnA,
	    @RequestParam(required = false) String interviewCompleted,
	    @RequestParam(required = false) String interviewResults,
	    @RequestParam(required = false) String interviewTip,
	    @RequestParam(required = false) String interviewProgress,
	    @RequestParam(required = false) String practiceComment,
	    @RequestParam(required = false) String educationalBackground,
	    @RequestParam(required = false) String practiceAtmosphere,
	    @RequestParam(required = false) String practiceExperience,
	    @RequestParam(required = false) String practiceReview
	) {
	    int memberId = this.req.getLoginedMember().getId();

	    Article article = new Article();
	    article.setInstitutionName(institutionName);
	    article.setInstitutionComment(institutionComment);
	    article.setBoardName(boardName);
	    article.setMemberId(memberId);
	    article.setWorkType(workType);
	    article.setCity(city);
	    article.setInstitutionType(institutionType);

	    if ("근무 리뷰".equals(boardName)) {
	        article.setSalaryScore(salaryScore != null ? salaryScore : 0);
	        article.setWelfareScore(welfareScore != null ? welfareScore : 0);
	        article.setEnvironmentScore(environmentScore != null ? environmentScore : 0);
	        article.setSalaryComment(salaryComment);
	        article.setWelfareComment(welfareComment);
	        article.setEnvironmentComment(environmentComment);
	        article.setCommuteTimeComment(commuteTimeComment);

	        article.setSalaryOptions(salaryOptions);
	        article.setWelfareOptions(welfareOptions);

	        article.setSalaryOptionsStr(
	            (salaryOptions != null && !salaryOptions.isEmpty()) ? String.join(",", salaryOptions) : null
	        );
	        article.setWelfareOptionsStr(
	            (welfareOptions != null && !welfareOptions.isEmpty()) ? String.join(",", welfareOptions) : null
	        );
	    } else if ("면접 리뷰".equals(boardName)) {
	        article.setInterviewScore(interviewScore != null ? interviewScore : 0);
	        article.setInterviewComment(interviewComment);
	        article.setPersonalHistory(personalHistory);
	        article.setInterviewMaterial(interviewMaterial);
	        article.setInterviewQnA(interviewQnA);
	        article.setInterviewProgress(interviewProgress);
	        article.setInterviewTip(interviewTip);
	        article.setInterviewCompleted(interviewCompleted);
	        article.setInterviewResults(interviewResults);
	    } else if ("실습 및 봉사 리뷰".equals(boardName)) {
	        article.setPracticeScore(practiceScore != null ? practiceScore : 0);
	        article.setPracticeComment(practiceComment);
	        article.setEducationalBackground(educationalBackground);
	        article.setPracticeAtmosphere(practiceAtmosphere);
	        article.setPracticeExperience(practiceExperience);
	        article.setPracticeReview(practiceReview);
	    }

	    int articleId = this.articleService.writeArticle(article);
	    return Util.jsReplace("게시글 작성!", String.format("detail?id=%d", articleId));
	}



	@GetMapping("/usr/article/interviewWrite")
	public String interviewWrite() {
		return "usr/article/interviewWrite";
	}
	
	@GetMapping("/usr/article/practiceWrite")
	public String practiceWrite() {
		return "usr/article/practiceWrite";
	}
	
	@GetMapping("/usr/article/workingWrite")
	public String workingWrite(Model model) {
	    Article article = new Article();  
	    model.addAttribute("article", article);  

	    return "usr/article/workingWrite";
	}

	
	@GetMapping("/usr/article/detail")
	public String detail(HttpServletRequest request, HttpServletResponse response,Model model, int id) {
	
		Cookie[] cookies = request.getCookies();
		boolean isViewed = false;
		
		if (cookies != null) {
			for (Cookie cookie : cookies) {
				if (cookie.getName().equals("viewedArticle_" + id)) {
					isViewed = true;
					break;
				}
			}
		}
		
		if (!isViewed) {
			this.articleService.increaseViews(id);
			Cookie cookie = new Cookie("viewedArticle_" + id, "true");
			cookie.setMaxAge(60 * 30);
			cookie.setPath("/");
			response.addCookie(cookie);
		}
		
	    Article article = articleService.getArticleById(id);
	    Board board = boardService.getBoard(article.getBoardId());
	   
	    List<String> salaryOptions = articleService.getOptions(id, "salary");
	    List<String> welfareOptions = articleService.getOptions(id, "welfare");
	    List<Reply> replies = this.replyService.getReplies("article", id);

	    salaryOptions = new ArrayList<>(new LinkedHashSet<>(salaryOptions));
	    welfareOptions = new ArrayList<>(new LinkedHashSet<>(welfareOptions));

	    article.calculateStar();

	    model.addAttribute("article", article);
	    model.addAttribute("board", board);
	    model.addAttribute("replies", replies);
	    model.addAttribute("relId", id);
	    model.addAttribute("relTypeCode", "article");
	    
	    return "usr/article/detail";
	}

	
	@GetMapping("/usr/article/list")
	public String list(Model model,
	                   @RequestParam(required = false) Integer boardId,
	                   @RequestParam(defaultValue = "1") int cPage,
	                   @RequestParam(required = false) String city,
	                   @RequestParam(required = false) String searchType,
	                   @RequestParam(required = false) String keyword) {

	    if (boardId == null) {
	        return Util.jsBack("게시판 ID가 필요합니다.");
	    }

	    Board board = boardService.getBoard(boardId);
	    int articlesInPage = 10;
	    int limitFrom = (cPage - 1) * articlesInPage;

	    List<Article> articles;
	    int articlesCnt;

	    if (keyword != null && !keyword.trim().isEmpty()) {
	        articles = articleService.SearchKeyword(boardId, searchType, keyword);
	        articlesCnt = articles.size();
	    } else {
	        articles = articleService.getArticles(boardId, city, articlesInPage, limitFrom);
	        articlesCnt = articleService.getArticlesCnt(boardId, city);
	    }

	    int totalPagesCnt = (int) Math.ceil(articlesCnt / (double) articlesInPage);
	    int begin = ((cPage - 1) / 10) * 10 + 1;
	    int end = (((cPage - 1) / 10) + 1) * 10;
	    if (end > totalPagesCnt) end = totalPagesCnt;

	    model.addAttribute("board", board);
	    model.addAttribute("cPage", cPage);
	    model.addAttribute("begin", begin);
	    model.addAttribute("end", end);
	    model.addAttribute("totalPagesCnt", totalPagesCnt);
	    model.addAttribute("articlesCnt", articlesCnt);
	    model.addAttribute("articles", articles);
	    model.addAttribute("city", city);
	    model.addAttribute("keyword", keyword);
	    model.addAttribute("searchType", searchType);
	    model.addAttribute("workingTopArticles", articleService.getTopArticlesByViews(4));
	    model.addAttribute("interviewTopArticles", articleService.getTopArticlesByViews(5));
	    model.addAttribute("practiceTopArticles", articleService.getTopArticlesByViews(6));
	    
	    return "usr/article/list";
	}

	@GetMapping("/usr/article/modify")
	public String modify(Model model, int id) {
		
		Article article = this.articleService.getArticleById(id);
		
		model.addAttribute("article", article);
		
		return "usr/article/modify";
	}
	
	@PostMapping("/usr/article/doModify")
	@ResponseBody
	public String doModify(
	    String institutionName,
	    int id,
	    @RequestParam(required = false) String workType,
	    @RequestParam(required = false) String city,
	    @RequestParam(required = false) String institutionType,
	    @RequestParam(required = false) String institutionComment,
	    @RequestParam(required = false) List<String> salaryOptions,
	    @RequestParam(required = false) List<String> welfareOptions,
	    @RequestParam(required = false) String salaryComment,
	    @RequestParam(required = false) String welfareComment,
	    @RequestParam(required = false) String environmentComment,
	    @RequestParam(required = false) String commuteTimeComment,
	    @RequestParam(required = false) Integer salaryScore,
	    @RequestParam(required = false) Integer welfareScore,
	    @RequestParam(required = false) Integer environmentScore,
	    @RequestParam(required = false) Integer interviewScore,
	    @RequestParam(required = false) String interviewComment,
	    @RequestParam(required = false) String interviewResults,
	    @RequestParam(required = false) String personalHistory,
	    @RequestParam(required = false) String interviewMaterial,
	    @RequestParam(required = false) String interviewProgress,
	    @RequestParam(required = false) String interviewCompleted,
	    @RequestParam(required = false) String interviewQnA,
	    @RequestParam(required = false) String interviewTip,
	    @RequestParam(required = false) Integer practiceScore,
	    @RequestParam(required = false) String practiceComment,
	    @RequestParam(required = false) String educationalBackground,
	    @RequestParam(required = false) String practiceExperience,
	    @RequestParam(required = false) String practiceReview,
	    @RequestParam(required = false) String practiceAtmosphere
	) {
	    String salaryOptionsStr = (salaryOptions != null && !salaryOptions.isEmpty()) ? String.join(",", salaryOptions) : null;
	    String welfareOptionsStr = (welfareOptions != null && !welfareOptions.isEmpty()) ? String.join(",", welfareOptions) : null;

	    articleService.modifyArticle(
	        institutionName, id, workType, city, institutionType, institutionComment,
	        salaryOptionsStr, welfareOptionsStr, salaryComment, welfareComment, environmentComment, commuteTimeComment,
	        salaryScore, welfareScore, environmentScore, interviewScore, interviewComment, interviewResults, personalHistory,
	        interviewMaterial, interviewProgress, interviewCompleted, interviewQnA, interviewTip,
	        practiceScore, practiceComment, educationalBackground, practiceExperience, practiceReview, practiceAtmosphere
	    );

	    return Util.jsReplace(String.format("%d번 게시물을 수정했습니다", id), String.format("detail?id=%d", id));
	}


	
	@GetMapping("/usr/article/delete")
	@ResponseBody
	public String delete(int id, int boardId) {
		
		this.articleService.deleteArticle(id);
		
		return Util.jsReplace(String.format("%d번 게시글이 삭제되었습니다", id), String.format("list?boardId=%d", boardId));
	}
	

	
	
}