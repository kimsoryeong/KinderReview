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

    public List<Member> getPendingInstitutions() {
        return adminDao.findPendingInstitution();
    }

    public void approveInstitution(int memberId) {
        adminDao.updateInstitutionStatus(memberId, 1, null);
    }

    public void rejectInstitution(int memberId, String rejectReason) {
        adminDao.updateInstitutionStatus(memberId, 2, rejectReason);
    }
    
    public List<Article> getPendingReviews() {
        return adminDao.findPendingReviews();
    }

    public void approveReview(int id ) {
        adminDao.updateReviewStatus(id, 1, null);
    }

    public void rejectReview(int id, String rejectReason) {
        adminDao.updateReviewStatus(id, 2, rejectReason );
    }


}