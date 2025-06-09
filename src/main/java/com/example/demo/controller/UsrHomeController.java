package com.example.demo.controller;

import java.io.IOException;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class UsrHomeController {
	
	@GetMapping("/usr/home/main")
	public String showMain() throws IOException {
		return "usr/home/main";
	}
	
	@GetMapping("/")
	public String showRoot() {
		return "redirect:/usr/home/main";
	}
	
	@GetMapping("/usr/home/apiTest1")
	public String apiTest1() {
		return "usr/home/apiTest1";
	}
}