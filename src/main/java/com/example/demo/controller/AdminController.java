package com.example.demo.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.demo.dto.Article;
import com.example.demo.dto.Member;
import com.example.demo.service.AdminService;
import com.example.demo.util.Util;


@Controller
@RequestMapping("/admin")
public class AdminController {

	@Autowired
    private AdminService adminService;

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
    public String approveInstitution(@RequestParam int memberId) {
        adminService.approveInstitution(memberId);
        return Util.jsReplace("기관 가입 승인!", "/admin/institution/list");
    }

    @PostMapping("/institution/reject")
    public String rejectInstitution(@RequestParam int memberId) {
        adminService.rejectInstitution(memberId);
        return Util.jsReplace("기관 가입 반려!", "/admin/institution/list");
    }

    @GetMapping("/review/list")
    public String reviewList(Model model) {
        List<Article> reviews = adminService.getPendingReviews();
        model.addAttribute("reviews", reviews);
        return "admin/reviewList";
    }

    @PostMapping("/review/approve")
    public String approveReview(@RequestParam int articleId) {
        adminService.approveReview(articleId);
        return Util.jsReplace("리뷰 승인 완료!", "/admin/review/list");
    }

    @PostMapping("/review/reject")
    public String rejectReview(@RequestParam int articleId) {
        adminService.rejectReview(articleId);
        return Util.jsReplace("리뷰 반려 완료!", "/admin/review/list");
    }
}
