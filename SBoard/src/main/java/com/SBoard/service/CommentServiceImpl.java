package com.SBoard.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.SBoard.mapper.CommentMapper;
import com.SBoard.vo.CommentVO;
import com.SBoard.vo.SearchDTO;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
@AllArgsConstructor
public class CommentServiceImpl implements CommentService {

	private CommentMapper mapper;
	
	@Override
	public int register(CommentVO vo) {

		log.info("register.." + vo);
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

	@Override
	public int remove(Long cno) {
		
		log.info("remove.." + cno);
		return mapper.delete(cno);
	}

	@Override
	public List<CommentVO> getList(SearchDTO page, Long bno) {

		log.info("get comment list " + bno);
		return mapper.getListPaging(page, bno);
	}

}
