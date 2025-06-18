package com.example.demo.controller;

import java.io.IOException;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.example.demo.dto.LoginedMember;
import com.example.demo.dto.Member;
import com.example.demo.dto.Req;
import com.example.demo.dto.ResultData;
import com.example.demo.service.FileService;
import com.example.demo.service.MemberService;
import com.example.demo.util.Util;

@Controller
public class UsrMemberController {
	
	private MemberService memberService;
	private Req req;
	private final FileService fileService;
	
	public UsrMemberController(MemberService memberService, Req req, FileService fileService) {
		this.memberService = memberService;
		this.fileService = fileService;
		this.req = req;
	}
	
	// 메인 회원가입 선택 페이지
	@GetMapping("/usr/member/join")
	public String mainJoin() {
		return "usr/member/mainJoin";  // 메인 회원가입 선택 페이지
	}
	
	// 개인회원 가입 페이지
	@GetMapping("/usr/member/personalJoin")
	public String personalJoin() {
		return "usr/member/personalJoin"; // 개인회원 가입 폼
	}
	
	// 기업회원 가입 페이지
	@GetMapping("/usr/member/institutionJoin")
	public String companyJoin() {
		return "usr/member/institutionJoin";  // 기업회원 가입 폼
	}
	
	// 개인회원 가입 처리
	@PostMapping("/usr/member/doPersonalJoin")
	@ResponseBody
	public String doPersonalJoin(String loginId, String loginPw, String nickname) {
		memberService.joinPersonalMember(loginId, loginPw, nickname);
		return Util.jsReplace(String.format("[ %s ] 님의 개인회원 가입이 완료되었습니다", nickname), "/");
	}
	
	@PostMapping("/usr/member/doInstitutionJoin")
	@ResponseBody
	public String doInstitutionJoin(
	    String loginId, 
	    String loginPw, 
	    String institutionName, 
	    String institutionNumber, 
	    MultipartFile bizFile
	) throws IOException {
	    int memberId = memberService.joinInstitutionMember(loginId, loginPw, institutionName, institutionNumber);

	    if (!bizFile.isEmpty()) {
	        fileService.saveFile(bizFile, "member", memberId);
	    }

	    return Util.jsReplace(String.format("[ %s ] 님의 기업회원 가입이 완료되었습니다", institutionName), "/");
	}


	
	// 중복 검사 API (닉네임/아이디) - 개인/기업 공통으로 사용 가능
	@GetMapping("/usr/member/nicknameDupChk")
	@ResponseBody
	public ResultData nicknameDupChk(String nickname) {
		Member member = memberService.getMemberBynickname(nickname);
		if (member != null) {
			return ResultData.from("F-1", String.format("[ %s ] 은(는) 이미 사용중인 닉네임입니다", nickname));
		}
		return ResultData.from("S-1", String.format("[ %s ] 은(는) 사용가능한 닉네임입니다", nickname));
	}
	
	@GetMapping("/usr/member/loginIdDupChk")
	@ResponseBody
	public ResultData loginIdDupChk(String loginId) {
		Member member = memberService.getMemberByLoginId(loginId);
		if (member != null) {
			return ResultData.from("F-1", String.format("[ %s ] 은(는) 이미 사용중인 아이디입니다", loginId));
		}
		return ResultData.from("S-1", String.format("[ %s ] 은(는) 사용가능한 아이디입니다", loginId));
	}
	

	@GetMapping("/usr/member/login")
	public String login() {
		return "usr/member/login";
	}
	
	@PostMapping("/usr/member/doLogin")
	@ResponseBody
	public String doLogin(String loginId, String loginPw) {
		
		Member member = this.memberService.getMemberByLoginId(loginId);
		
		if (member == null) {
			return Util.jsReplace(String.format("[ %s ] 은(는) 존재하지 않는 회원입니다", loginId), "login");
		}
		
		if (member.getLoginPw().equals(loginPw) == false) {
			return Util.jsReplace("비밀번호가 일치하지 않습니다", "login");
		}
		
		this.req.login(new LoginedMember(member.getId(), member.getAuthLevel(), member.getNickname()));

		
		return Util.jsReplace(String.format("[ %s ] 님 환영합니다", member.getLoginId()), "/");
	}
	
	@GetMapping("/usr/member/logout")
	@ResponseBody
	public String logout() {
		
		this.req.logout();
		
		return Util.jsReplace("정상적으로 로그아웃 되었습니다", "/");
	}
}