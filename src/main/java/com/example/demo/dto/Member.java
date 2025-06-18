package com.example.demo.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Member {
	private int id;
	private String regDate;
	private String updateDate;
	private String loginId;
	private String loginPw;
	private String nickname;    // 개인회원용 닉네임
	private String institutionName; // 기업회원용 회사명
	private String institutionNumber; // 기업회원용 사업자번호
	private int institutionAccepted; // 기관승인 구분 (0=대기, 1=승인, 2=반려)
	private int authLevel;      // 권한 구분(1: 개인, 2: 기업)
	private String workChkFile;
	public int reviewStatus; {
		
	}
}
