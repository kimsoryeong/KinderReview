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
    private String salaryComment;
    private String welfareComment;
    private String environmentComment;
    private String commuteTimeComment;
    private List<String> salaryOptions;
    private List<String> welfareOptions;
    private List<String> environmentOptions;


    public double calculateStar() {
        int total = salaryScore + welfareScore + environmentScore;
        return Math.round((total / 3.0) * 10) / 10.0;
    }

    public double getStar() {
        return calculateStar();
    }

}