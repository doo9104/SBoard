package com.SBoard.vo;

import lombok.Data;

@Data
public class BoardPageVO {

	private int pageNum;
	private int amount;
	
	public BoardPageVO() {
		this(1,10);
	}
	
public BoardPageVO(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
	}
	
}
