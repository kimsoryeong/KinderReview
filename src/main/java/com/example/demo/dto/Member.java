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
	private String nickname;    
	private String institutionName; 
	private String institutionNumber;
	private int institutionAccepted; 
	private int authLevel;  
	private String workChkFile;
	public int reviewStatus; 
	public int approveStatus;
	private Integer workChkFileId;
	private String workChkFileName;
	private String rejectReason;
    private String zipCode;       
    private String address;    
	private String addressDetail;

	public String getWorkChkFileName() {
	    return workChkFileName;
	}
	public void setWorkChkFileName(String workChkFileName) {
	    this.workChkFileName = workChkFileName;
	}
	
}