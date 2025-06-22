package com.example.demo.controller;


import java.io.IOException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.LinkedHashSet;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.example.demo.dto.Article;
import com.example.demo.dto.ArticleModifyDTO;
import com.example.demo.dto.Board;
import com.example.demo.dto.FileDto;
import com.example.demo.dto.LoginedMember;
import com.example.demo.dto.Member;
import com.example.demo.dto.Reply;
import com.example.demo.dto.Req;
import com.example.demo.service.ArticleService;
import com.example.demo.service.BoardService;
import com.example.demo.service.FileService;
import com.example.demo.service.MemberService;
import com.example.demo.service.ReplyService;
import com.example.demo.util.Util;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
public class UsrArticleController {
	
	private ArticleService articleService;
	private BoardService boardService;
	private Req req;
	private ReplyService replyService;
	private final FileService fileService;
	private final MemberService memberService;
	
	public UsrArticleController(ArticleService articleService, BoardService boardService, Req req, ReplyService replyService, FileService fileService, MemberService memberService) {
		this.articleService = articleService;
		this.replyService = replyService;
		this.boardService = boardService;
		this.req = req;
		this.fileService = fileService;
		this.memberService = memberService;
	}
	
	@GetMapping("/usr/article/mainWrite")
	public String mainWrite(@RequestParam(required = false) Integer boardId, Model model) {
	    model.addAttribute("boardId", boardId); 
	    return "usr/article/mainWrite";
	}


	@PostMapping("/usr/article/doWrite")
	@ResponseBody
	public String doWrite(
		@RequestParam(required = false) String institutionName,
	    @RequestParam(required = false) String institutionComment,
	    @RequestParam(required = false) String nickname,
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
	    @RequestParam(required = false) String practiceReview,
	    @RequestParam(required = false) String title,
	    @RequestParam(required = false) String content,
	    @RequestParam(required = false) String phoneNumber,
	    @RequestParam(required = false) String hireSalary,
	    @RequestParam(required = false) String communityBoard,
	    @RequestParam(required = false) LocalDate deadline,
	    @RequestParam(required = false) MultipartFile workCertFile
	) throws IOException {
	    int memberId = this.req.getLoginedMember().getId();

	    Article article = new Article();
	    article.setInstitutionName(institutionName);
	    article.setInstitutionComment(institutionComment);
	    article.setBoardName(boardName);
	    article.setMemberId(memberId);
	    article.setWorkType(workType);
	    article.setCity(city);
	    article.setInstitutionType(institutionType);
	    article.setTitle(title);
	    article.setContent(content);
	    article.setPhoneNumber(phoneNumber);
	    article.setHireSalary(hireSalary);
	    article.setNickname(nickname);
	    article.setPersonalHistory(personalHistory);
	    article.setDeadline(deadline);

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

	    article.setReviewStatus(0);  
	    int articleId = this.articleService.writeArticle(article);

	    if (workCertFile != null && !workCertFile.isEmpty()) {
	        fileService.saveFile(workCertFile, "article", articleId);
	    }


	    if(boardName == null || boardName.trim().isEmpty()) {
	        return Util.jsReplace("게시판을 선택해 주세요.", "back");
	    }

	    if ("근무 리뷰".equals(boardName)) {
	        return Util.jsReplace("관리자의 승인 후 게시글이 등록됩니다.", "/usr/member/myPage");
	    } else {
	        return Util.jsReplace("게시글 작성!", String.format("detail?id=%d", articleId));
	    }
	}



	@GetMapping("/usr/article/interviewWrite")
	public String interviewWrite() {
		return "usr/article/interviewWrite";
	}

	@GetMapping("/usr/article/hireWrite")
	@ResponseBody
	public String hireWrite(HttpSession session) {
		
		LoginedMember loginedMember = (LoginedMember) session.getAttribute("loginedMember");

		 if (loginedMember == null) {
		        return Util.jsReplace("로그인이 필요합니다", "/usr/member/login");
		    }

		 Member freshMember = memberService.getMemberById(loginedMember.getId());
		 LoginedMember refreshedLoginedMember = new LoginedMember(
	        freshMember.getId(),
	        freshMember.getAuthLevel(),
	        freshMember.getNickname(),
	        freshMember.getApproveStatus()
	    );
	    session.setAttribute("loginedMember", refreshedLoginedMember);

	    if (freshMember.getAuthLevel() == 0 || (freshMember.getAuthLevel() == 2 && freshMember.getApproveStatus() == 1)) {
	        return Util.jsReplace("", "/usr/article/hireWritePage");
	    } else {
	        return Util.jsReplace("관리자의 승인 후 작성 가능합니다", "/");
	    }
	}
	
	@GetMapping("/usr/article/hireWritePage")
	public String hireWritePage(Model model) {
		Article article = new Article(); 
		model.addAttribute("article", article);
	    return "usr/article/hireWrite"; 
	}
	
	@GetMapping("/usr/article/communityWrite")
	@ResponseBody
	public String communityWrite(HttpSession session) {
	    LoginedMember loginedMember = (LoginedMember) session.getAttribute("loginedMember");

	    if (loginedMember == null) {
	        return Util.jsReplace("로그인이 필요합니다", "/usr/member/login");
	    }

	    if (loginedMember.getAuthLevel() == 2) {
	        return Util.jsReplace("글 작성 권한이 없습니다", "/");
	    }

	    return Util.jsReplace("", "/usr/article/communityWritePage");
	}

	@GetMapping("/usr/article/communityWritePage")
	public String communityWritePage() {
	    return "usr/article/communityWrite"; 
	}
	
	@GetMapping("/usr/article/practiceWrite")
	public String practiceWrite() {
		return "usr/article/practiceWrite";
	}
	
	@GetMapping("/usr/article/workingWrite")
	public String workingWrite(HttpServletRequest req, Model model) {
	    model.addAttribute("article", new Article());
	    return "usr/article/workingWrite";
	}
	
	@GetMapping("/usr/article/detail")
	public String detail(HttpServletRequest request, HttpServletResponse response, Model model, int id) {

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

	    Article article = articleService.getArticleByIdWithFiles(id);
	    
	    if ("근무 리뷰".equals(article.getBoardName()) && article.getReviewStatus() != 1) {
	        return "common/notAuthorized";
	    }
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
	    model.addAttribute("salaryOptions", salaryOptions);
	    model.addAttribute("welfareOptions", welfareOptions);

	    Req req = (Req) request.getAttribute("req");
	    int authLevel = 999;
	    if (req != null && req.isLogined()) {
	        authLevel = req.getLoginedMember().getAuthLevel();
	    }
	    model.addAttribute("isAdmin", authLevel == 0);

	    List<FileDto> files = fileService.getFilesByRel("article", id);
	    model.addAttribute("files", files);
	    

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
	    boolean onlyApproved = "근무 리뷰".equals(board.getBoardName());

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
	    model.addAttribute("freeTopArticles", articleService.getTopArticlesByViews(11));
	    model.addAttribute("qnaTopArticles", articleService.getTopArticlesByViews(12));
	    
	    return "usr/article/list";
	}

	@GetMapping("/usr/article/modify")
	public String modify(Model model, int id) {
	    Article article = this.articleService.getArticleById(id);
	    List<FileDto> files = fileService.getFilesByRelId(id);  

	    LoginedMember loginedMember = req.getLoginedMember();
	    if (article.getMemberId() != loginedMember.getId()) {
	        model.addAttribute("error", "권한이 없는 페이지입니다.");
	        return "redirect:/usr/article/list";
	    }

	    model.addAttribute("article", article);
	    model.addAttribute("files", files); 
	    return "usr/article/modify"; 
	}

	@PostMapping("/usr/article/doModify")
	@ResponseBody
	public String doModify(@ModelAttribute ArticleModifyDTO modifyDTO, Model model) {
	    MultipartFile file = modifyDTO.getWorkCertFile();
	    if (file != null && !file.isEmpty()) {
	        String savedFileName = fileService.saveFile(modifyDTO.getId(), file);
	        modifyDTO.setWorkCertFileName(savedFileName); 
	    }

	    articleService.modifyArticle(modifyDTO);

	    List<FileDto> files = fileService.getFilesByRelId(modifyDTO.getId());
	    model.addAttribute("files", files);

	    return Util.jsReplace(String.format("%d번 게시물을 수정했습니다", modifyDTO.getId()), String.format("detail?id=%d", modifyDTO.getId()));
	}




	
	@GetMapping("/usr/article/delete")
	@ResponseBody
	public String delete(int id, int boardId) {
		
		this.articleService.deleteArticle(id);
		
		return Util.jsReplace(String.format("%d번 게시글이 삭제되었습니다", id), String.format("list?boardId=%d", boardId));
	}
	

	
	
}