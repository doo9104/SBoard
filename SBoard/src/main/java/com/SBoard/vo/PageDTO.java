package com.SBoard.vo;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class PageDTO {

	private int startPage;
	private int endPage;
	private boolean prev, next;
	
	private int total;
	private BoardPageVO page;
	
	public PageDTO(BoardPageVO page, int total) {
		
		this.page = page;
		this.total = total;
		
		this.endPage = (int) (Math.ceil(page.getPageNum() / 10.0)) * 10;
		this.startPage = this.endPage - 9;
		
		int realEnd = (int) (Math.ceil(total * 1.0) / page.getAmount());
		/* page = total / unit +(total % unit == 0 ? 0 + 1) */
		
		if(realEnd < this.endPage) {
			this.endPage = realEnd;
		}
		
		this.prev = this.startPage > 1;
		this.next = this.endPage < realEnd;
	}
}
