package com.SBoard.mapper;

import java.util.List;

import com.SBoard.vo.BoardPageVO;
import com.SBoard.vo.BoardVO;

public interface BoardMapper {

	// 게시글 불러오기 메서드
	public List<BoardVO> getList();
	
	// BoardPageVO에서 넘어오는 파라미터를 사용하는 메서드(페이징)
	public List<BoardVO> getListPaging(BoardPageVO page);
	
	// 글쓰기 메서드 C
	public void insert(BoardVO board);
	
	// 글읽기 메서드 R
	public BoardVO read(Long bno);
	
	// 글수정 메서드 U
	public int update(BoardVO board);
	
	// 글삭제 메서드 D
	public int delete(Long bno);
	
	// 전체 글 갯수 구하기 메서드 BoardPageVO page타입을 파라미터로 사용
	public int totalCount(BoardPageVO page);
	
	
	
}

