package com.example.demo.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class LoginedMember {
    private int id;
    private int authLevel;
    private String nickname;  // 닉네임 필드 추가

    // 기존 getNickname() 제거해도 됨, Lombok이 자동 생성해줌
}