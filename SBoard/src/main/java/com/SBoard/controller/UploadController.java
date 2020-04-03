package com.SBoard.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.SBoard.vo.AttachFileDTO;

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
	
	
	
	@PreAuthorize("isAuthenticated()")	
	@PostMapping(value = "/uploadAjaxAction", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<AttachFileDTO>>
	uploadAjaxPost(MultipartFile[] uploadFile) {
		
		List<AttachFileDTO> list = new ArrayList<>();
		String uploadFolder = "C:\\upload";
		
		String uploadFolderPath = getFolder();
		// 폴더 생성
		File uploadPath = new File(uploadFolder, uploadFolderPath);
		
		if(uploadPath.exists() == false) {
			uploadPath.mkdirs();
		}
		// yyyy/MM/dd 형태로 폴더를 만든다
		
		for(MultipartFile multipartFile : uploadFile) {
		
			AttachFileDTO attachDTO = new AttachFileDTO();
			
		String uploadFileName = multipartFile.getOriginalFilename();
		
		// 인터넷 익스플로러 일 경우 모든 경로가 나오기 때문에 잘라내는 작업
		uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\") + 1);
		log.info("only file name : " + uploadFileName);
		attachDTO.setFileName(uploadFileName);
		
		// UUID 생성
		UUID uuid = UUID.randomUUID();
		uploadFileName = uuid.toString() + "_" + uploadFileName;
		
		
		
		try {
			File saveFile = new File(uploadPath, uploadFileName);
			multipartFile.transferTo(saveFile);
			
			attachDTO.setUUID(uuid.toString());
			attachDTO.setUploadPath(uploadFolderPath);
			
			// 이미지 타입인지 검사
			if (checkImageType(saveFile)) {
				attachDTO.setImage(true);
				FileOutputStream thumbnail = new FileOutputStream(new File(uploadPath, "s_" + uploadFileName));
				Thumbnailator.createThumbnail(multipartFile.getInputStream(), thumbnail, 100, 100);
				thumbnail.close();
			}
			
			//리스트에 추가
			list.add(attachDTO);
		} catch (Exception e) {
			log.error(e.getMessage());
		} // end catch
		
		
	} // end for
		return new ResponseEntity<>(list,HttpStatus.OK);
}
	
	@GetMapping("/display")
	@ResponseBody
	public ResponseEntity<byte[]> getFile(String fileName) {
		
		log.info("fileName : " + fileName);
		
		File file = new File("C:\\upload\\" + fileName);
		log.info("file : " + file);
		
		ResponseEntity<byte[]> result = null;
		
		try {
			HttpHeaders header = new HttpHeaders();
			header.add("Content-Type", Files.probeContentType(file.toPath()));
			result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file),
					header, HttpStatus.OK);
			} catch (IOException e) {
				e.printStackTrace();
			}
		return result;
	}
	
	
	
	
	// 첨부파일 다운로드
		// 첨부파일은 서버에서 MIME타입을 다운로드 타입으로 지정
		@GetMapping(value="/download", produces = MediaType.APPLICATION_OCTET_STREAM_VALUE)
		@ResponseBody
		public ResponseEntity<Resource> downloadFile(@RequestHeader("User-Agent") String userAgent, String fileName) {
			
			Resource resource = new FileSystemResource("c:\\upload\\" + fileName);

			
			if(resource.exists() == false) {
				return new ResponseEntity<>(HttpStatus.NOT_FOUND);
			}
			
			String resourceName = resource.getFilename();
			
			//UUID 지우기
			String resourceOriginName = resourceName.substring(resourceName.indexOf("_") + 1);
			
			
			HttpHeaders headers = new HttpHeaders();
			try {
				String downloadName = null;
				if(userAgent.contains("Trident")) {
					downloadName = URLEncoder.encode(resourceName, "UTF-8").replaceAll("\\+", " ");
				} else if(userAgent.contains("Edge")) {
					log.info("Edge browser");
					downloadName = URLEncoder.encode(resourceName, "UTF-8").replaceAll("\\+", " ");
					log.info("Edge name : " + downloadName);
				} else {
					log.info("Chrome brower");
					downloadName = new String(resourceName.getBytes("UTF-8"), "ISO-8859-1");
				}
				
				headers.add("Content-Disposition", "attachment; filename=" + downloadName);
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
			
			return new ResponseEntity<Resource>(resource, headers, HttpStatus.OK);
		}
	
	
	
	// 첨부파일 삭제
		@PreAuthorize("isAuthenticated()")
		@PostMapping("/deleteFile")
		@ResponseBody
		public ResponseEntity<String> deleteFile(String fileName, String type) {
			
			log.info("deleteFile : " + fileName);
			
			File file;
			
			try {
				file = new File("c:\\upload\\" + URLDecoder.decode(fileName, "UTF-8"));
				file.delete();
				
				if(type.equals("image")) {
					
					String largeFileName = file.getAbsolutePath().replace("s_", "");
					log.info("largeFileName : " + largeFileName);
					file = new File(largeFileName);
					file.delete();
				}
				} catch (UnsupportedEncodingException e) {
					e.printStackTrace();
					return new ResponseEntity<>(HttpStatus.NOT_FOUND);
				}
				return new ResponseEntity<String>("deleted",HttpStatus.OK);
			
			
		}
	
	
	
	
	
	
	
}