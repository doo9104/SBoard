package com.SBoard.mapper;

import com.SBoard.vo.CommentVO;

public interface CommentMapper {
	
	// 댓글 작성 메서드  C
	public int insert(CommentVO vo);
	
	// 댓글 조회 메서드 R
	public CommentVO read(Long bno);
	
	// 댓글 수정 메서드 U
	public int update(CommentVO vo);
	
	// 댓글 삭제 메서드 D
	public int delete(int cno);
}
