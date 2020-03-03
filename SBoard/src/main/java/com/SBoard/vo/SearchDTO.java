package com.SBoard.vo;


import org.springframework.web.util.UriComponentsBuilder;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class SearchDTO extends BoardPageVO {


	private String keyword = "";
	private String searchType = "";
	
	
	
	/* 
	 * URI를 동적으로 생성해주는 클래스
	 * 파라미터가 조합된 URI를 쉽게 만들어준다
	 * rest스타일로 개발하는데 편리
	*/
	public String makeParam() {
		UriComponentsBuilder builder = UriComponentsBuilder.fromPath("")
				.queryParam("pageNum", this.getPageNum())
				.queryParam("amount", this.getAmount())
				.queryParam("searchType", this.getSearchType())
				.queryParam("keyword", this.getKeyword());
				
		return builder.toUriString();
	}
}
