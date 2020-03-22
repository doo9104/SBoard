package com.SBoard.service;

import java.util.HashMap;
import java.util.List;

import com.SBoard.vo.BoardAttachVO;
import com.SBoard.vo.BoardPageVO;
import com.SBoard.vo.BoardVO;
import com.SBoard.vo.RecVO;
import com.SBoard.vo.SearchDTO;

public interface BoardService {

	public void register(BoardVO board);
	
	public BoardVO get(Long bno);
	
	public boolean modify(BoardVO board);
	
	public boolean remove(Long bno);
	
//	public List<BoardVO> getList();
	
	/* public List<BoardVO> getList(BoardPageVO page); */
	public List<BoardVO> getList(SearchDTO page);
	public int totalCount(SearchDTO page);
	
	// 조회수 증가
	public void updateHit(Long bno);
	
	public List<BoardAttachVO> getAttachList(Long bno);
	
	// 추천수 증가
	public void createRecLike(RecVO vo);
	
	//추천수 취소
	public void deleteRecLike(RecVO vo);
	
	// 추천수 게시글 반영
	public void updateBoardLike(RecVO vo);
	
	// 추천 했는지 확인
	public int getBoardLike(RecVO vo);
	
}
