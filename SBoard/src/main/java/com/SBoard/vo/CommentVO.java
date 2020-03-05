package com.SBoard.vo;

import java.util.Date;
import lombok.Data;

@Data
public class CommentVO {
	private Long cno;
	private Long bno;
	
	private String ccomment;
	private String cwriter;
	private Date cregdate;
	private Date cupdateregdate;
}
