package com.example.demo.dto;

import java.io.IOException;

import org.springframework.context.annotation.Scope;
import org.springframework.context.annotation.ScopedProxyMode;
import org.springframework.stereotype.Component;

import com.example.demo.util.Util;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.Getter;
import org.springframework.beans.factory.annotation.Autowired;

@Component
@Scope(value = "request", proxyMode = ScopedProxyMode.TARGET_CLASS)
public class Req {

    @Getter
    private LoginedMember loginedMember;

    private final HttpServletResponse resp;
    private final HttpSession session;

    // 생성자 주입
    @Autowired
    public Req(HttpServletRequest request, HttpServletResponse resp) {
        this.resp = resp;
        this.session = request.getSession();

        this.loginedMember = (LoginedMember) session.getAttribute("loginedMember");

        if (this.loginedMember == null) {
            this.loginedMember = new LoginedMember();
        }

        // 현재 Req 객체를 request attribute에 저장
        request.setAttribute("req", this);
    }

    public void init() {
        // 필요시 초기화 로직 추가 가능
    }

    public void login(LoginedMember loginedMember) {
        this.session.setAttribute("loginedMember", loginedMember);
        this.loginedMember = loginedMember;
    }

    public void logout() {
        this.session.removeAttribute("loginedMember");
        this.loginedMember = new LoginedMember();
    }

    public void jsPrintReplace(String msg, String uri) {
        this.resp.setContentType("text/html;charset=UTF-8");

        try {
            this.resp.getWriter().append(Util.jsReplace(msg, uri));
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public boolean isLogined() {
        return loginedMember != null && loginedMember.getId() != 0;
    }

    // getter는 @Getter 어노테이션으로 자동 생성됨

}