package com.SBoard.vo;


import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class SearchDTO extends BoardPageVO {


	private String keyword = "";
	private String searchType = "";
	
	

}
