package com.example.demo.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.dto.Article;
import com.example.demo.dto.FileDto;
import com.example.demo.dto.Member;
import com.example.demo.service.AdminService;
import com.example.demo.service.FileService;
import com.example.demo.util.Util;


@Controller
@RequestMapping("/admin")
public class AdminController {

	@Autowired
    private AdminService adminService;
	@Autowired
	private FileService fileService;

    @GetMapping("/dashboard")
    public String adminDashboard() {
        return "admin/dashboard";
    }

    @GetMapping("/institution/list")
    public String institutionList(Model model) {
        List<Member> institutionList = adminService.getPendingInstitutions();
        model.addAttribute("institutionList", institutionList);
        return "admin/institutionList";
    }

    @PostMapping("/institution/approve")
    @ResponseBody
    public String approveInstitution(@RequestParam int memberId) {
        adminService.approveInstitution(memberId);
        return Util.jsReplace("기관 가입이 승인 처리 되었습니다", "/admin/institution/list");
    }

    @PostMapping("/institution/reject")
    @ResponseBody
    public String rejectInstitution(@RequestParam int memberId, @RequestParam String rejectReason) {
        adminService.rejectInstitution(memberId, rejectReason);
        return Util.jsReplace("기관 가입이 반려 처리 되었습니다", "/admin/institution/list");
    }

    @GetMapping("/review/list")
    public String reviewList(Model model) {
        List<Article> reviews = adminService.getPendingReviews();
        model.addAttribute("reviews", reviews);
        return "admin/reviewList";
    }

    @PostMapping("/review/approve")
    @ResponseBody
    public String approveReview(@RequestParam int id) {
        adminService.approveReview(id);
        return Util.jsReplace("리뷰가 승인 처리 되었습니다", "/admin/review/list");
    }

    @PostMapping("/review/reject")
    @ResponseBody
    public String rejectReview(@RequestParam int id, @RequestParam String rejectReason) {
        adminService.rejectReview(id, rejectReason);
        return Util.jsReplace("리뷰가 반려 처리 되었습니다", "/admin/review/list");
    }
    
  

}