package com.example.demo.dto;

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
	private String content;
	private int boardId;
	private int memberId;
	private String writerName;
	private String searchType;
	private String keyword;
	private String city;
	private String district;
	private String workType;
	private String institutionType;
	private int salaryScore;
    private int welfareScore;
    private int environmentScore;
    private String salaryComment;
    private String welfareComment;
    private String environmentComment;
    private List<String> salaryOptions;
    private List<String> welfareOptions;
    private List<String> environmentOptions;

    private double star;

    // 기존 getStar()는 계산용 메서드로 유지하거나, 아래처럼 이름 바꾸기 권장
    public double calculateStar() {
        int total = salaryScore + welfareScore + environmentScore;
        return Math.round((total / 3.0) * 10) / 10.0;
    }
    
    // star getter/setter
    public double getStar() {
        return star;
    }

    public void setStar(double star) {
        this.star = star;
    }

    
}
