package com.SBoard.controller;

import java.util.List;


import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.SBoard.service.CommentService;
import com.SBoard.vo.BoardPageVO;
import com.SBoard.vo.CommentPageDTO;
import com.SBoard.vo.CommentVO;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@RequestMapping("/comments/")
@RestController
@Log4j
@AllArgsConstructor
public class CommentController {
	
	private CommentService service;
	
	
	
	
	
	// REST 방식으로 처리할 때 외부에서 서버를 호출할때와 서버에서 보내주는 데이터의 타입을 명확히 해야한다.
	@PreAuthorize("isAuthenticated()")
	@PostMapping(value = "/new",
			consumes = "application/json",
			produces = { MediaType.TEXT_PLAIN_VALUE })
	public ResponseEntity<String> create(@RequestBody CommentVO vo) {
		// create()는 @PostMapping으로 POST방식으로만 동작하도록 설계하고 consumes와 produces를 이용해서 JSON만 처리하게 하고 문자열을 반환하도록 설정
		// create()의 파라미터는 @RequestBody를 적용해서 JSON 데이터를 CommentVO 타입으로 변환하도록 지정
		// CommentServiceImpl을 호출해서 register()를 호출하고 댓글이 추가된 숫자를 확인해서 브라우저에서 200OK 혹은 500 인터널 에러를 반환하도록한다
		log.info("CommentVO : " + vo);
		
		int insertCount = service.register(vo);
		
		log.info("Comment INSERT COUNT : " + insertCount);
		
		return insertCount == 1
		? new ResponseEntity<>("success", HttpStatus.OK)
		: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		// 삼항 연산자 처리
	}

	
	
	/*
	 * @GetMapping(value = "/pages/{bno}/{page}", produces = {
	 * MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_UTF8_VALUE })
	 * public ResponseEntity<List<CommentVO>> getList(
	 * 
	 * @PathVariable("page") int page,
	 * 
	 * @PathVariable("bno") Long bno) {
	 * 
	 * 
	 * 
	 * 
	 * log.info("getList......"); BoardPageVO pageN = new BoardPageVO(page,10);
	 * log.info(pageN); return new ResponseEntity<>(service.getList(pageN, bno),
	 * HttpStatus.OK); // getList() 는 BoardPageVO를 이용해서 파라미터를 수집한다. // 게시물의
	 * 번호는 @PathVariable를 이용해서 파라미터로 처리한다. }
	 */
	@GetMapping(value = "/pages/{bno}/{page}",
			produces = {
					MediaType.APPLICATION_XML_VALUE,
					MediaType.APPLICATION_JSON_UTF8_VALUE })
		public ResponseEntity<CommentPageDTO> getList(
			@PathVariable("page") int page,
			@PathVariable("bno") Long bno) {
			
			
			
		
		log.info("getList......");
		BoardPageVO pageN = new BoardPageVO(page,10);
		log.info(pageN);
		return new ResponseEntity<>(service.getListPage(pageN, bno), HttpStatus.OK);
		// getList() 는 BoardPageVO를 이용해서 파라미터를 수집한다.
		// 게시물의 번호는 @PathVariable를 이용해서 파라미터로 처리한다.
	}

	// 댓글 조회
	@GetMapping(value = "/{cno}",
			produces = {
					MediaType.APPLICATION_XML_VALUE,
					MediaType.APPLICATION_JSON_UTF8_VALUE })
	public ResponseEntity<CommentVO> get(@PathVariable("cno") Long cno) {
		log.info("get : " + cno);
		
		return new ResponseEntity<>(service.get(cno), HttpStatus.OK);
		
	}
	
	// 댓글 삭제
	@DeleteMapping(value = "/{cno}",
			produces = { MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> remove(@PathVariable("cno") Long cno) {
		log.info("remove : " + cno);
		
		return service.remove(cno) == 1
				? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		
	}
	
	// 댓글 수정
	@RequestMapping(method = { RequestMethod.PUT, RequestMethod.PATCH },
			value = "/{cno}",
			consumes = "application/json",
			produces = { MediaType.TEXT_PLAIN_VALUE })
	public ResponseEntity<String> modify(
				@RequestBody CommentVO vo,
				@PathVariable("cno") Long cno) { 
			vo.setCno(cno);
				
			log.info("cno : " + cno);
			log.info("modify : " + vo);
				
			return service.modify(vo) == 1
				? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
			
	
	
	
	
	
	
	
	
}
