package com.SBoard.vo;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;

@Data
@AllArgsConstructor
@Getter
public class CommentPageDTO {
	/* 오늘만든거 */
	private int commentCount;
	private List<CommentVO> list;
	
}
