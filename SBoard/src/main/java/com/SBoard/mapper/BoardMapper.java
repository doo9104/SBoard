package com.SBoard.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.SBoard.vo.BoardPageVO;
import com.SBoard.vo.BoardVO;
import com.SBoard.vo.RecVO;
import com.SBoard.vo.SearchDTO;

public interface BoardMapper {

	// 게시글 불러오기 메서드
	public List<BoardVO> getList();
	
	// BoardPageVO에서 넘어오는 파라미터를 사용하는 메서드(페이징)
	/* public List<BoardVO> getListPaging(BoardPageVO page); */
	
	public List<BoardVO> getListPaging(SearchDTO page);
	
	// 글쓰기 메서드 C
	public void insert(BoardVO board);
	
	// 글읽기 메서드 R
	public BoardVO read(Long bno);
	
	// 글수정 메서드 U
	public int update(BoardVO board);
	
	// 글삭제 메서드 D
	public int delete(Long bno);
	
	// 전체 글 갯수 구하기 메서드 BoardPageVO page타입을 파라미터로 사용
	/* public int totalCount(BoardPageVO page); */
	public int totalCount(SearchDTO page);
	
	// 조회수 증가 메서드
	void updateHit(Long bno);
	
	// 댓글 수를 업데이트하는 메서드
	public void updateCommentCnt(@Param("bno") Long bno, @Param("amount") int amount);
	
	// 추천
	public void createRecLike(RecVO vo);
	
	// 추천 취소
	public void deleteRecLike(RecVO vo);
	
	// 추천수 게시글에 반영
	public void updateBoardLike(RecVO vo);
	
	// 추천수 확인
	public int getBoardLike(RecVO vo);
	
	
	
}

