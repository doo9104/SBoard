package com.SBoard.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.SBoard.mapper.BoardMapper;
import com.SBoard.mapper.MemberManageMapper;
import com.SBoard.vo.MemberVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class MemberManageServiceImpl implements MemberManageService {

	@Setter(onMethod_= @Autowired)
	private MemberManageMapper mapper;
	
	@Override
	public MemberVO getUserId(MemberVO vo) {
		return mapper.getUserId(vo);
	}

	@Override
	public MemberVO getUserName(MemberVO vo) {
		return mapper.getUserName(vo);
	}
	
	@Override
	public MemberVO getUserEmail(MemberVO vo) {
		return mapper.getUserEmail(vo);
	}

	@Transactional
	@Override
	public void createNewMember(MemberVO vo) {
		mapper.createNewMember(vo);
		mapper.giveAuth(vo);
	}



	
	
	

}
