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
		Member member = new Member();
		member.setLoginId(loginId);
		member.setLoginPw(loginPw);
		member.setNickname(nickname);
		member.setAuthLevel(1);
		member.setApproveStatus(1);
		
		memberDao.joinPersonalMember(loginId, loginPw, nickname);
	}

	 public int joinInstitutionMember(String loginId, String loginPw, String institutionName, String institutionNumber) {
	        Member member = new Member();
	        member.setLoginId(loginId);
	        member.setLoginPw(loginPw);
	        member.setInstitutionName(institutionName);
	        member.setInstitutionNumber(institutionNumber);
	        member.setAuthLevel(2);
	        member.setApproveStatus(0);
	        
	        memberDao.joinInstitutionMember(member);

	        return member.getId();  
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
	
	public String getWorkChkFileByMemberId(int memberId) {
	    return memberDao.findWorkChkFileByMemberId(memberId);
	} //사업자등록증 확인용


}