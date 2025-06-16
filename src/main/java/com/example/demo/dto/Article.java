package com.example.demo.dto;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Article {
    private int id;
    private String regDate;
    private String updateDate;
    private String institutionName;
    private String institutionComment;
    private String boardName;
    private int boardId;
    private int memberId;
    private String writerName;
    private String searchType;
    private String keyword;
    private String city;
    private String workType;
    private String institutionType;
    private int salaryScore;
    private int welfareScore;
    private int environmentScore;
    private int interviewScore;
    private int practiceScore;
    private String salaryComment;
    private String welfareComment;
    private String environmentComment;
    private String commuteTimeComment;
    private List<String> salaryOptions;
    private List<String> welfareOptions;
    private String salaryOptionsStr;
    private String welfareOptionsStr;
    private String interviewComment;
    private String personalHistory;
    private String interviewMaterial;
    private String interviewQnA;
    private String interviewProgress;
    private String interviewResults;
    private String interviewTip;
    private String interviewCompleted;
    private String practiceComment;
    private String educationalBackground;
    private String practiceAtmosphere;
    private String practiceExperience;
    private String practiceReview;
    private int likePoint;
	private int views;

    public void setWelfareOptionsStr(String welfareOptionsStr) {
        this.welfareOptionsStr = welfareOptionsStr;
        if (welfareOptionsStr != null && !welfareOptionsStr.isEmpty()) {
            this.welfareOptions = Arrays.asList(welfareOptionsStr.split("\\s*,\\s*"));
        } else {
            this.welfareOptions = new ArrayList<>();
        }
    }
    public void setSalaryOptionsStr(String salaryOptionsStr) {
        this.salaryOptionsStr = salaryOptionsStr;
        if (salaryOptionsStr != null && !salaryOptionsStr.isEmpty()) {
            this.salaryOptions = Arrays.asList(salaryOptionsStr.split("\\s*,\\s*"));
        } else {
            this.salaryOptions = new ArrayList<>();
        }
    }



    public double calculateStar() {
        int total = salaryScore + welfareScore + environmentScore;
        return Math.round((total / 3.0) * 10) / 10.0;
    }

    public double getStar() {
        return calculateStar();
    }

    public int getPracticeScore() {
        return practiceScore;
    }

    public int getInterviewScore() {
        return interviewScore;
    }
}