package com.SBoard.mapper;

import com.SBoard.vo.MemberVO;

public interface MemberManageMapper {
	
	public MemberVO getUserId(MemberVO vo);
	
	public MemberVO getUserName(MemberVO vo);
	
	public MemberVO getUserEmail(MemberVO vo);
	
	public void createNewMember(MemberVO vo);
	
	public void giveAuth(MemberVO vo);
}
