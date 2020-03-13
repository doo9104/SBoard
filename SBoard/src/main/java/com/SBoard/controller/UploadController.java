package com.SBoard.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnailator;

@Controller
@Log4j
public class UploadController {

	// 폴더 생성
	private String getFolder() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		Date date = new Date();
		
		String str = sdf.format(date);
		
		return str.replace("-", File.separator);
	}
	
	// 이미지 파일 판단
	private boolean checkImageType(File file) {
		
		try {
			String contentType = Files.probeContentType(file.toPath());
			
			return contentType.startsWith("image");
		} catch (IOException e) {
			e.printStackTrace();
		}
		return false;
	}
	
	
	
	
	@PostMapping("/uploadAjaxAction")
	public void uploadFormPost(MultipartFile[] uploadFile) {
		
		String uploadFolder = "C:\\upload";
		
		// 폴더 생성
		File uploadPath = new File(uploadFolder, getFolder());
		log.info("upload path : " + uploadPath);
		
		if(uploadPath.exists() == false) {
			uploadPath.mkdirs();
		}
		// yyyy/MM/dd 형태로 폴더를 만든다
		
		for(MultipartFile multipartFile : uploadFile) {
		
		log.info("=========================");
		log.info("Upload File Name : " + multipartFile.getOriginalFilename());
		log.info("Upload File Size : " + multipartFile.getSize());
		
		String uploadFileName = multipartFile.getOriginalFilename();
		
		// 인터넷 익스플로러 일 경우 모든 경로가 나오기 때문에 잘라내는 작업
		uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\") + 1);
		log.info("only file name : " + uploadFileName);
		
		// UUID 생성
		UUID uuid = UUID.randomUUID();
		uploadFileName = uuid.toString() + "_" + uploadFileName;
		
		
		
		try {
			File saveFile = new File(uploadPath, uploadFileName);
			multipartFile.transferTo(saveFile);
			// 이미지 타입인지 검사
			if (checkImageType(saveFile)) {
				FileOutputStream thumbnail = new FileOutputStream(new File(uploadPath, "s_" + uploadFileName));
				Thumbnailator.createThumbnail(multipartFile.getInputStream(), thumbnail, 100, 100);
				thumbnail.close();
			}
		} catch (Exception e) {
			log.error(e.getMessage());
		} // end catch
		
		
	} // end for
}
}