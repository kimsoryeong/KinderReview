package com.example.demo.service;

import org.springframework.stereotype.Service;

import com.example.demo.dao.MemberDao;
import com.example.demo.dto.Member;

@Service
public class MemberService {

	private MemberDao memberDao;
	
	public MemberService(MemberDao memberDao) {
		this.memberDao = memberDao;
	}

	public void joinPersonalMember(String loginId, String loginPw, String nickname) {
		memberDao.joinPersonalMember(loginId, loginPw, nickname);
	}

	 public int joinInstitutionMember(String loginId, String loginPw, String institutionName, String institutionNumber) {
	        Member member = new Member();
	        member.setLoginId(loginId);
	        member.setLoginPw(loginPw);
	        member.setInstitutionName(institutionName);
	        member.setInstitutionNumber(institutionNumber);
	        member.setAuthLevel(2);

	        memberDao.joinInstitutionMember(member);

	        return member.getId();  // insert 후 자동으로 id가 채워짐
	    }


	public Member getMemberByLoginId(String loginId) {
		return this.memberDao.getMemberByLoginId(loginId);
	}


	public Member getMemberBynickname(String nickname) {
		return this.memberDao.getMemberBynickname(nickname);
	}

	public Member getMemberById(int id) {
		return this.memberDao.getMemberById(id);
	}

}