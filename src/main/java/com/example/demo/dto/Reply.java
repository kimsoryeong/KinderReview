package com.example.demo.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Reply {
	private int id;
	private String regDate;
	private String updateDate;
	private int memberId;
	private String nickname;
	private String relTypeCode;
	private int relId;
	private String content;
	private Boolean isSecret;
	private Boolean isAnonymous;
	private int parentId;

	public boolean isSecret() {
        return isSecret;
    }

    public void setSecret(boolean isSecret) {
        this.isSecret = isSecret;
    }
    
    public class ReplyCountDto {
        private int count;
    }
}