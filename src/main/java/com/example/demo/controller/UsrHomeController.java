package com.example.demo.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.example.demo.dto.Article;
import com.example.demo.service.ArticleService;




@Controller
public class UsrHomeController {

    @Autowired
    private ArticleService articleService;

    @GetMapping("/")
    public String showRoot() {
        return "redirect:/usr/home/main";
    }

    @GetMapping("/usr/home/main")
    public String showMain(Model model) {
        int boardId = 4;
        List<Article> latestReviewArticles = articleService.getLatestArticlesByBoardId(boardId, 4);
        model.addAttribute("latestReviewArticles", latestReviewArticles);

        return "usr/home/main";
    }


    

}