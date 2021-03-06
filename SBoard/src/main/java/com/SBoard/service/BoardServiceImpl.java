package com.SBoard.service;

import java.util.List;

import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.SBoard.vo.BoardAttachVO;
import com.SBoard.vo.BoardPageVO;
import com.SBoard.vo.BoardVO;
import com.SBoard.vo.RecVO;
import com.SBoard.vo.SearchDTO;
import com.SBoard.mapper.BoardAttachMapper;
import com.SBoard.mapper.BoardMapper;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;


@Log4j
@Service // 비즈니스 영역을 담당하는 객체임을 표시하기 위한 어노테이션
public class BoardServiceImpl implements BoardService {
	
	@Setter(onMethod_= @Autowired)
	private BoardMapper mapper;
	
	@Setter(onMethod_= @Autowired)
	private BoardAttachMapper attachMapper;
	
	@Transactional
	@Override
	public void register(BoardVO board) {
		log.info("게시글 등록" + board);
		
		mapper.insert(board);
		
		if(board.getAttachList() == null || board.getAttachList().size() <= 0) {
			return;
		}
		
		board.getAttachList().forEach(attach -> {
			
			attach.setBno(board.getBno());
			attachMapper.insert(attach);
		});
		
		
	}

	@Override
	public BoardVO get(Long bno) {
		log.info("글 조회" + bno);
		return mapper.read(bno);
	}

	@Transactional
	@Override
	public boolean modify(BoardVO board) {
		log.info("글  수정" + board);
		
		attachMapper.deleteAll(board.getBno());
		log.info("board.getbno : " + board.getBno());
		boolean modifyResult = mapper.update(board) == 1;
		
		if(modifyResult && board.getAttachList() != null && board.getAttachList().size() > 0) {
			board.getAttachList().forEach(attach -> {
				attach.setBno(board.getBno());
				attachMapper.insert(attach);
			});
		}
		
		return modifyResult;
	}

	@Transactional
	@Override
	public boolean remove(Long bno) {
		log.info("글 삭제" + bno);
		attachMapper.deleteAll(bno);
		return mapper.delete(bno) == 1;
	}

	@Override
	public List<BoardVO> getList(SearchDTO page) {
		log.info("글 가져오기" + page);
		return mapper.getListPaging(page);
	}
	
	@Override
	public int totalCount(SearchDTO page) {
		log.info("전체 게시글 갯수 가져오기");
		return mapper.totalCount(page);
	}
	
	@Override
	public void updateHit(Long bno) {
		log.info("조회수 증가");
		this.mapper.updateHit(bno);
	}
	
	@Override
	public List<BoardAttachVO> getAttachList(Long bno) {
		log.info("attach list : " + bno);
		return attachMapper.findByBno(bno);
	}
	
	
	@Override
	public void createRecLike(RecVO vo) {
		mapper.createRecLike(vo);
	}
	
	@Override
	public void deleteRecLike(RecVO vo) {
		mapper.deleteRecLike(vo);
	}
	
	@Override
	public void updateBoardLike(RecVO vo) {
		mapper.updateBoardLike(vo);
	}
	
	@Override
	public int getBoardLike(RecVO vo) {
		return mapper.getBoardLike(vo);		
	}

}
