package com.SBoard.service;

import java.util.List;

import com.SBoard.vo.BoardPageVO;
import com.SBoard.vo.CommentPageDTO;
import com.SBoard.vo.CommentVO;


public interface CommentService {

	public int register(CommentVO vo);
	
	public CommentVO get(Long cno);
	
	public int modify(CommentVO vo);
	
	public int remove(Long cno);
	
	 public List<CommentVO> getList(BoardPageVO pageN, Long bno); 
	
	public CommentPageDTO getListPage(BoardPageVO pageN, Long bno);
	

}
