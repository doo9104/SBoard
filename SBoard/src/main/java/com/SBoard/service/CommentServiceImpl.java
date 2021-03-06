package com.SBoard.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.SBoard.mapper.BoardMapper;
import com.SBoard.mapper.CommentMapper;
import com.SBoard.vo.BoardPageVO;
import com.SBoard.vo.CommentPageDTO;
import com.SBoard.vo.CommentVO;


import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class CommentServiceImpl implements CommentService {


	@Setter(onMethod_ = @Autowired)
	private CommentMapper mapper;
	
	@Setter(onMethod_ = @Autowired)
	private BoardMapper boardMapper;
	
	@Transactional
	@Override
	public int register(CommentVO vo) {

		log.info("register.." + vo);
		
		boardMapper.updateCommentCnt(vo.getBno(), 1);
		
		return mapper.insert(vo);
	}

	@Override
	public CommentVO get(Long cno) {

		log.info("get.." + cno);
		return mapper.read(cno);
	}

	@Override
	public int modify(CommentVO vo) {

		log.info("modify.." + vo);
		return mapper.update(vo);
	}

	@Transactional
	@Override
	public int remove(Long cno) {

		log.info("remove.." + cno);
		
		CommentVO vo = mapper.read(cno);
		
		boardMapper.updateCommentCnt(vo.getBno(), -1);
		return mapper.delete(cno);
	}

	@Override
	public List<CommentVO> getList(BoardPageVO pageN, Long bno) {

		log.info("get comment list " + bno);
		return mapper.getList(pageN, bno);
	}

	
	 @Override 
	 public CommentPageDTO getListPage(BoardPageVO pageN, Long bno) {
	  
		 log.info("get comment list page"); 
	  
		  return new CommentPageDTO(
		  mapper.getCountByBno(bno), 
		  mapper.getListPaging(pageN, bno)); 
	 }
	 

}
