package com.SBoard.vo;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class BoardVO {
	
	private Long bno; 
	private String btitle;
	private String bcontent;
	private String bwriter;
	private long bhit;
	private long brec_up;
	private long brec_dn;
	private Date bregdate;
	private Date bupdateregdate;
	private int commentCnt;
	
	private List<BoardAttachVO> attachList;
}
