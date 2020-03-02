package com.SBoard.vo;

import lombok.Data;

@Data
public class BoardPageVO {

	private int pageNum;
	private int amount;
	
	
	// 추후 확장성을 고려해 데이터를 객체화하여 전달
	// 기본값 1페이지, 한 화면에 데이터 amount개 표시
	public BoardPageVO() {
		this(1,10);
	}
	
public BoardPageVO(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
	}
	
}
