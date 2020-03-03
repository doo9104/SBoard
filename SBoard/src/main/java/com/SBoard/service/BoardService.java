package com.SBoard.service;

import java.util.List;

import com.SBoard.vo.BoardPageVO;
import com.SBoard.vo.BoardVO;
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
}
