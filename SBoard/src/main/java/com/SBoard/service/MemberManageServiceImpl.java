package com.SBoard.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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

}
