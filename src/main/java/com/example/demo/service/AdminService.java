package com.example.demo.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.example.demo.dao.AdminDao;
import com.example.demo.dto.Article;
import com.example.demo.dto.Member;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class AdminService {

    private final AdminDao adminDao;

    // 가입 대기 중인 기관 목록 조회
    public List<Member> getPendingInstitutions() {
        return adminDao.findPendingInstitution();
    }

    // 기관 승인 처리
    public void approveInstitution(int memberId) {
        adminDao.updateInstitutionStatus(memberId, true);
    }

    // 기관 반려 처리
    public void rejectInstitution(int memberId) {
        adminDao.updateInstitutionStatus(memberId, false);
    }
    
    // 승인 대기 중인 리뷰 목록 조회
    public List<Article> getPendingReviews() {
        return adminDao.findPendingReviews();
    }

    // 리뷰 승인 처리
    public void approveReview(int articleId) {
        adminDao.updateReviewStatus(articleId, 1, null);
    }

    // 리뷰 반려 처리
    public void rejectReview(int articleId, String rejectReason) {
        adminDao.updateReviewStatus(articleId, 2, rejectReason );
    }

	

	public Article getArticleById(int id) {
		return adminDao.findArticleById(id);
	}

}
