package com.SBoard.vo;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class MemberVO {

	private String userid;
	private String userpw;
	private String username;
	private boolean enabled;
	private String email;
	private String authkey;
	private int activeCode;
	
	private Date regDate;
	private Date updateDate;
	private List<AuthVO> authList;
}
