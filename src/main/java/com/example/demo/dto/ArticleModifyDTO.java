package com.example.demo.dto;

import java.time.LocalDate;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ArticleModifyDTO {
    private String institutionName;
    private int id;
    private String boardName;
    private String workType;
    private String city;
    private String institutionType;
    private String institutionComment;
    private List<String> salaryOptions;
    private List<String> welfareOptions;
    private String salaryComment;
    private String welfareComment;
    private String environmentComment;
    private String commuteTimeComment;
    private Integer salaryScore;
    private Integer welfareScore;
    private Integer environmentScore;
    private Integer interviewScore;
    private String interviewComment;
    private String interviewResults;
    private String personalHistory;
    private String interviewMaterial;
    private String interviewProgress;
    private String interviewCompleted;
    private String interviewQnA;
    private String interviewTip;
    private Integer practiceScore;
    private String practiceComment;
    private String educationalBackground;
    private String practiceExperience;
    private String practiceReview;
    private String practiceAtmosphere;
    private String title;
    private String content;
    private String phoneNumber;
    private String hireSalary;
    private String communityBoard;
    private LocalDate deadline;
    private String nickname;
    private MultipartFile workCertFile;
    
    private String salaryOptionsStr;
    private String welfareOptionsStr;

    
    public String getSalaryOptionsStr() {
        return salaryOptionsStr;
    }

    public void setSalaryOptionsStr(String salaryOptionsStr) {
        this.salaryOptionsStr = salaryOptionsStr;
    }

    public String getWelfareOptionsStr() {
        return welfareOptionsStr;
    }

    public void setWelfareOptionsStr(String welfareOptionsStr) {
        this.welfareOptionsStr = welfareOptionsStr;
    }

	public void setWorkCertFileName(String savedFileName) {
		
	}

}


	