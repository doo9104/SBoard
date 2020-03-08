package com.SBoard.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.SBoard.vo.BoardPageVO;
import com.SBoard.vo.CommentVO;
import com.SBoard.vo.SearchDTO;

public interface CommentMapper {
	
	// 댓글 작성 메서드  C
	public int insert(CommentVO vo);
	
	// 댓글 조회 메서드 R
	public CommentVO read(Long bno);
	
	// 댓글 수정 메서드 U
	public int update(CommentVO ccontent);
	
	// 댓글 삭제 메서드 D
	public int delete(Long bno);
	
	// 댓글 리스트 가져오기
	public List<CommentVO> getList(
			@Param("page") BoardPageVO pageN,
			@Param("bno") Long bno);

	


}
