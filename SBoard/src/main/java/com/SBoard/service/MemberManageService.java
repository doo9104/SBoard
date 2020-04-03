package com.SBoard.service;

import com.SBoard.vo.MemberVO;



public interface MemberManageService {


	
	// 유저 아이디 가져오기
	public MemberVO getUserId(MemberVO vo);
	
	// 유저 닉네임 가져오기
	public MemberVO getUserName(MemberVO vo);
	
	// 유저 이메일 가져오기
	public MemberVO getUserEmail(MemberVO vo);
	
	// 회원가입
	public void createNewMember(MemberVO vo) throws Exception;
	
	// 이메일인증 클릭 활성화
	public void setActivity(MemberVO vo);
	
	// 비밀번호 확인
	public int checkPassword(MemberVO vo);
	
	// 유저 정보 가져오기 - 마이페이지
	public MemberVO getUserInfo(MemberVO vo);
	
	// 유저정보 업데이트 - 마이페이지
	public void modifyUserInfo(MemberVO vo);
}
