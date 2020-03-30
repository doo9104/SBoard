package com.SBoard.mapper;

import org.apache.ibatis.annotations.Param;

import com.SBoard.vo.MemberVO;

public interface MemberManageMapper {
	
	public MemberVO getUserId(MemberVO vo);
	
	public MemberVO getUserName(MemberVO vo);
	
	public MemberVO getUserEmail(MemberVO vo);
	
	public void createNewMember(MemberVO vo);
	
	public void giveAuth(MemberVO vo);
	
	public void setActivity(MemberVO vo);
	
	public boolean checkPassword(String userpw);
}
