package com.SBoard.mapper;

import java.util.List;

import com.SBoard.vo.BoardVO;

public interface BoardMapper {

	// 게시글 불러오기 메서드
	public List<BoardVO> getList();
	
	// 글쓰기 메서드 C
	public void insert(BoardVO board);
	
	// 글읽기 메서드 R
	public BoardVO read(Long bno);
	
	// 글수정 메서드 U
	public int update(BoardVO board);
	
	// 글삭제 메서드 D
	public int delete(Long bno);
	
	
}

