package com.SBoard.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.SBoard.vo.BoardPageVO;
import com.SBoard.vo.BoardVO;
import com.SBoard.mapper.BoardMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;


@Log4j
@Service // 비즈니스 영역을 담당하는 객체임을 표시하기 위한 어노테이션
@AllArgsConstructor
public class BoardServiceImpl implements BoardService {
	private BoardMapper mapper;
	
	@Override
	public void register(BoardVO board) {
		log.info("게시글 등록" + board);
		mapper.insert(board);
		
	}

	@Override
	public BoardVO get(Long bno) {
		log.info("글 조회" + bno);
		return mapper.read(bno);
	}

	@Override
	public boolean modify(BoardVO board) {
		log.info("글  수정" + board);
		return mapper.update(board) == 1;
	}

	@Override
	public boolean remove(Long bno) {
		log.info("글 삭제" + bno);
		return mapper.delete(bno) == 1;
	}

	@Override
	public List<BoardVO> getList(BoardPageVO page) {
		log.info("글 가져오기" + page);
		return mapper.getListPaging(page);
	}

}
