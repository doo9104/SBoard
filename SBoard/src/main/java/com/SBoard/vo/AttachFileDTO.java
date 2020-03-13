package com.SBoard.vo;

import lombok.Data;

@Data
public class AttachFileDTO {

	private String fileName;
	private String uploadPath;
	private String UUID;
	private boolean image;
}
