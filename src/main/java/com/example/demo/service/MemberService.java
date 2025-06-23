package com.example.demo.service;

import java.io.IOException;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.example.demo.dao.MemberDao;
import com.example.demo.dto.FileDto;
import com.example.demo.dto.Member;

@Service
public class MemberService {

	private final MemberDao memberDao;
	private final FileService fileService;
	
	public MemberService(MemberDao memberDao, FileService fileService) {
		this.memberDao = memberDao;
		this.fileService = fileService;
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

	public int joinInstitutionMember(String loginId, String loginPw, String nickname, String institutionNumber) {
        Member member = new Member();
        member.setLoginId(loginId);
        member.setLoginPw(loginPw);
        member.setNickname(nickname);
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
		Member member = memberDao.getMemberById(id);

		Integer workChkFileId = memberDao.findWorkChkFileByMemberId(id);
		member.setWorkChkFileId(workChkFileId);

		if (workChkFileId != null) {
			FileDto fileDto = fileService.getFileById(workChkFileId);
			if (fileDto != null) {
				member.setWorkChkFileName(fileDto.getSavedName()); 
			}
		}

		return member;
	}
	
	public Integer getWorkChkFileByMemberId(int memberId) {
	    return memberDao.findWorkChkFileByMemberId(memberId);
	}

	public void updateApproveStatus(int memberId, int approveStatus) {
	    memberDao.updateApproveStatus(memberId, approveStatus);
	}


	public List<Member> getPendingInstitutions() {
	    return memberDao.getPendingInstitutions();
	}

	public void updateWorkChkFile(int memberId, String savedName) {
	    memberDao.updateWorkChkFile(memberId, savedName);
	}


	


}