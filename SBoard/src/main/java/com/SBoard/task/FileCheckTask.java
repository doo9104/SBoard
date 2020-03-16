package com.SBoard.task;

import java.io.File;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.SBoard.mapper.BoardAttachMapper;
import com.SBoard.vo.BoardAttachVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Component
public class FileCheckTask {
	
	
	/* 초/분/시/일/월/요일/연도 
	 * *는 모든조건 즉, 와일드카드
	 * 매일 오후 2시(14시) 10분 36초 에 실행 => 36 10 14 * * ?
	 * https://developer-davii.tistory.com/23
	 * */
	
	/*
	 * @Scheduled(cron="0 * * * * *") public void checkFiles()throws Exception{
	 * log.info("file check task run...."); }
	 */
	
	@Setter(onMethod_ = { @Autowired })
	private BoardAttachMapper attachMapper;
	
	private String getFolderYesterDay() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		Calendar cal = Calendar.getInstance();
		
		cal.add(Calendar.DATE, -1);
		
		String str = sdf.format(cal.getTime());
		return str.replace("-", File.separator);
	}
	
	@Scheduled(cron = "0 0 2 * * *")
	public void checkFiles() throws Exception {
		log.warn("file check task run.......");
		
		//데이터베이스의 파일리스트
		List<BoardAttachVO> fileList = attachMapper.getOldFiles();
		
		//
		List<Path> fileListPaths = fileList.stream()
				.map(vo -> Paths.get("C:\\upload", vo.getUploadPath(), "s_" + vo.getUuid() + "_" + vo.getFileName()))
				.collect(Collectors.toList());
		
		// 썸네일 이미지
		fileList.stream().filter(vo -> vo.isFileType() == true)
		.map(vo -> Paths.get("C:\\upload", vo.getUploadPath(), "s_" + vo.getUuid() + "_" + vo.getFileName()))
		.forEach(p -> fileListPaths.add(p));
		
		log.warn("===================");
		
		fileListPaths.forEach(p -> log.warn(p));
		
		// 전날 폴더의 파일
		File targetDir = Paths.get("C:\\upload", getFolderYesterDay()).toFile();
		
		File[] removeFiles = targetDir.listFiles(file -> fileListPaths.contains(file.toPath()) == false);
		
		log.warn("------------------");
		for (File file : removeFiles) {
			log.warn(file.getAbsolutePath());
			file.delete();
		}
		
	}
	

}
