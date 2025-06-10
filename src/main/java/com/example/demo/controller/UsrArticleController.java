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
import com.example.demo.dto.Req;
import com.example.demo.service.ArticleService;
import com.example.demo.service.BoardService;
import com.example.demo.util.Util;

@Controller
public class UsrArticleController {
	
	private ArticleService articleService;
	private BoardService boardService;
	private Req req;
	
	public UsrArticleController(ArticleService articleService, BoardService boardService, Req req) {
		this.articleService = articleService;
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
	    @RequestParam String content,
	    @RequestParam int boardId,
	    @RequestParam Integer salaryScore,
	    @RequestParam Integer welfareScore,
	    @RequestParam Integer environmentScore,
	    @RequestParam(required = false) String salaryComment,
	    @RequestParam(required = false) String welfareComment,
	    @RequestParam(required = false) String environmentComment,
	    @RequestParam(required = false) String commuteTimeComment,
	    @RequestParam(required = false) List<String> salaryOptions,
	    @RequestParam(required = false) List<String> welfareOptions,
	    @RequestParam(required = false) List<String> environmentOptions,
	    @RequestParam(required = false) String workType,
	    @RequestParam(required = false) String city,
	    @RequestParam(required = false) String institutionType) {
		
		 
	    if (salaryScore == null) {
	        return Util.jsBack("급여 별점을 선택해 주세요.");
	    }
	    if (welfareScore == null) {
	        return Util.jsBack("복지 별점을 선택해 주세요.");
	    }
	    if (environmentScore == null) {
	        return Util.jsBack("근무환경 별점을 선택해 주세요.");
	    }

	    int memberId = this.req.getLoginedMember().getId();

	    // 한 번만 호출
	    int articleId = this.articleService.writeArticle(
	            institutionName, content, memberId, boardId,
	            salaryScore, welfareScore, environmentScore,
	            salaryComment, welfareComment, environmentComment, commuteTimeComment,
	            salaryOptions, welfareOptions, environmentOptions,
	            workType, city,  institutionType
	    );

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
	    Article article = new Article();  // 빈 객체 생성
	    model.addAttribute("article", article);  // 뷰에서 article 사용 가능하게

	    return "usr/article/workingWrite";
	}

	
	@GetMapping("/usr/article/detail")
	public String detail(Model model, int id) {
	    Article article = articleService.getArticleById(id);

	    System.out.println("salaryScore: " + article.getSalaryScore());
	    System.out.println("welfareScore: " + article.getWelfareScore());
	    System.out.println("environmentScore: " + article.getEnvironmentScore());
	    
	    List<String> salaryOptions = articleService.getOptions(id, "salary");
	    List<String> welfareOptions = articleService.getOptions(id, "welfare");
	    List<String> environmentOptions = articleService.getOptions(id, "environment");

	    salaryOptions = new ArrayList<>(new LinkedHashSet<>(salaryOptions));
	    welfareOptions = new ArrayList<>(new LinkedHashSet<>(welfareOptions));
	    environmentOptions = new ArrayList<>(new LinkedHashSet<>(environmentOptions));

	    article.setSalaryOptions(salaryOptions);
	    article.setWelfareOptions(welfareOptions);
	    article.setEnvironmentOptions(environmentOptions);

	    article.calculateStar();

	    model.addAttribute("article", article);

	    return "usr/article/detail";
	}

	
	@GetMapping("/usr/article/list")
	public String list(Model model,
	                   @RequestParam(required = false) Integer boardId,
	                   @RequestParam(defaultValue = "1") int cPage,
	                   @RequestParam(required = false) String city) {

	    if (boardId == null) {
	        return Util.jsBack("게시판 ID가 필요합니다.");
	    }

	    int articlesInPage = 10;
	    int limitFrom = (cPage - 1) * articlesInPage;

	    int articlesCnt = articleService.getArticlesCnt(boardId, city);
	    int totalPagesCnt = (int) Math.ceil(articlesCnt / (double) articlesInPage);

	    int begin = ((cPage - 1) / 10) * 10 + 1;
	    int end = (((cPage - 1) / 10) + 1) * 10;
	    if (end > totalPagesCnt) end = totalPagesCnt;

	    List<Article> articles = articleService.getArticles(boardId, city, articlesInPage, limitFrom);
	    Board board = boardService.getBoard(boardId);

	    model.addAttribute("board", board);
	    model.addAttribute("cPage", cPage);
	    model.addAttribute("begin", begin);
	    model.addAttribute("end", end);
	    model.addAttribute("totalPagesCnt", totalPagesCnt);
	    model.addAttribute("articlesCnt", articlesCnt);
	    model.addAttribute("articles", articles);
	    model.addAttribute("city", city);

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
	public String doModify(String institutionName, int id, String content) {
		
		this.articleService.modifyArticle(institutionName, id, content);
		
		return Util.jsReplace(String.format("%d번 게시물을 수정했습니다", id), String.format("detail?id=%d", id));
	}
	
	@GetMapping("/usr/article/delete")
	@ResponseBody
	public String delete(int id, int boardId) {
		
		this.articleService.deleteArticle(id);
		
		return Util.jsReplace(String.format("%d번 게시글이 삭제되었습니다", id), String.format("list?boardId=%d", boardId));
	}
	
	@PostMapping("/usr/article/list")
	@ResponseBody
	public void SearchKeyword(Model model, @RequestParam String searchType, @RequestParam String keyword) {
		List<Article> articles = articleService.SearchKeyword(searchType, keyword);
		model.addAttribute("articles", articles);
		
	}
}