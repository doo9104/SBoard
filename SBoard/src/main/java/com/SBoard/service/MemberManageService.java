package com.SBoard.service;

import org.springframework.beans.factory.annotation.Autowired;

import com.SBoard.mapper.BoardMapper;
import com.SBoard.vo.MemberVO;

import lombok.Setter;

public interface MemberManageService {


	
	// 유저 아이디 가져오기
	public MemberVO getUserId(MemberVO vo);
	
	// 유저 닉네임 가져오기
	
	
	// 유저 이메일 가져오기

}
