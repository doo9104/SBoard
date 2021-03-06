package com.SBoard.controller;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.security.Principal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.SBoard.service.BoardService;
import com.SBoard.vo.BoardAttachVO;
import com.SBoard.vo.BoardPageVO;
import com.SBoard.vo.BoardVO;
import com.SBoard.vo.PageDTO;
import com.SBoard.vo.RecVO;
import com.SBoard.vo.SearchDTO;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/board/*")
@AllArgsConstructor // BoardController는 BoardService에 의존적이므로 @AllArgsConstructor를 사용하여 생성자를 만들고 자동으로 주입
public class BoardController {

	@Autowired(required=true)
	private HttpServletRequest request;
	@Autowired(required=true)
	private HttpServletResponse response;
	
	private BoardService service;
	
	@GetMapping("/list") // list는 게시물의 목록을 전송해야 하므로 addAttribute를 사용해 model을 파라미터로 설정하고 이를 BoardServiceImpl 객체의 getList() 결과를 담아 전달함 
	public void list(SearchDTO page,Model model) {
		
		log.info("list " + page);
		
		model.addAttribute("list",service.getList(page));
		
	
		int total = service.totalCount(page);
		model.addAttribute("pageMaker", new PageDTO(page,total));
	}
	
	/*
	 * @PreAuthorize("isAuthenticated()")
	 */	
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/register")
	public void register() {
		
	}
	
	@PreAuthorize("isAuthenticated()")
	@PostMapping("/register")
	public String register(BoardVO board, RedirectAttributes rttr) {
		
		// 게시글 등록후 목록화면으로 이동하기 위해 RedirectAttributes를 파라미터로 지정하고 새로 등록된 게시물의 번호를 같이 전달하기 위해 사용
		log.info("register : " + board);
		
		if(board.getAttachList() != null) {
			board.getAttachList().forEach(attach -> log.info(attach));
		}
		
		
		 service.register(board);
		
		 //일회성으로 데이터를 전달하는 addFlashAttribute를 이용
		rttr.addFlashAttribute("result", board.getBno());
		return "redirect:/board/list";
	}
	
	
	
	/*
	 * // 중괄호로 감싸주면 여러개 매핑처리 가능
	 * 
	 * @GetMapping("/get") public void get(@RequestParam("bno") Long
	 * bno,@ModelAttribute("page") SearchDTO page, Model model) { // 화면으로 해당 bno의
	 * 게시글을 전달해야하므로 model을 파라미터로 지정 log.info("get : " + bno); //
	 * service.updateHit(bno); // 조회수 증가
	 * model.addAttribute("board",service.get(bno)); }
	 */
	
	
	
	// 중괄호로 감싸주면 여러개 매핑처리 가능
	@GetMapping("/get")
	public void get(@RequestParam("bno") Long bno, @ModelAttribute("page") SearchDTO page,Model model) {
		// 화면으로 해당 bno의 게시글을 전달해야하므로 model을 파라미터로 지정
		log.info("get : " + bno);
	
		Cookie[] cookies = request.getCookies();	
		// 비교하기 위해 새로운 널값 쿠키 생성
		Cookie viewCookie = null;
		// 쿠키가 있을 경우 
        if (cookies != null && cookies.length > 0) 
        {
            for (int i = 0; i < cookies.length; i++)
            {
                // Cookie의 name이 cookie+bno와 일치하는 쿠키를 viewCookie에 넣어줌 
                if (cookies[i].getName().equals("cookie"+bno))
                { 
                	viewCookie = cookies[i];
                }
            }
        }		
        if (bno != null) {        	
        	if (viewCookie == null) {
        		log.info("쿠키가 존재하지 않으므로 쿠키 생성");
        		// 쿠키 생성(이름, 값)
                Cookie newCookie = new Cookie("cookie"+ bno, "|" + bno + "|");
                newCookie.setMaxAge(60*60*24); 
				/* 쿠키 추가
				 * 쿠키값 한글 입력 시에는 URLEncoder를 이용해 문자열을 감싸주면 된다.
				 * - Cookie newCookie = new Cookie("kor", URLEncoder.encode("데이터","UTF-8");
				 */
                response.addCookie(newCookie);
                
                // 쿠키를 추가 시키고 조회수 증가시킴
                service.updateHit(bno);
                log.info("조회수 증가");
                
        	} else { // 쿠키 있을경우
				String value = viewCookie.getValue();
				log.info("쿠키 값(value) : " + value);
			}
       }
    	model.addAttribute("board",service.get(bno));		
	}
	
	@GetMapping("/modify")
	public void modify(@RequestParam("bno") Long bno,@ModelAttribute("page") SearchDTO page, Model model) {
		// 화면으로 해당 bno의 게시글을 전달해야하므로 model을 파라미터로 지정
		log.info("modify" + bno);
		model.addAttribute("board",service.get(bno));
	}
	
	
	@PreAuthorize("principal.username == #bwriter")
	@PostMapping("/modify")
	/*
	 * public String modify(BoardVO board, @ModelAttribute("page") SearchDTO
	 * page,RedirectAttributes rttr) {
	 */
	public String modify(BoardVO board, SearchDTO page,RedirectAttributes rttr) {
		//service.modify는 수정 여부를 boolean타입으로 지정했으므로 성공한 경우에만 RedirectAttributes에 저장
		log.info("modify : " + board);
		
		if(service.modify(board)) {
			rttr.addFlashAttribute("result", "success");
			log.info("modify success");
		}
		
		/*
		 * rttr.addAttribute("pageNum",page.getPageNum());
		 * rttr.addAttribute("amount",page.getAmount());
		 * rttr.addAttribute("keyword",page.getKeyword());
		 * rttr.addAttribute("searchType",page.getSearchType());
		 */
		
		return "redirect:/board/list" + page.makeParam();
	}
	
	@PreAuthorize("principal.username == #bwriter")
	@PostMapping("/remove")
	public String remove(@RequestParam("bno") Long bno,@ModelAttribute("page") SearchDTO page, RedirectAttributes rttr, String bwriter) {
		
		log.info("remove : " + bno);
		
		List<BoardAttachVO> attachList = service.getAttachList(bno);
		
		if(service.remove(bno)) {
			deleteFiles(attachList);
			rttr.addFlashAttribute("result","success");
		}
		/*rttr.addAttribute("pageNum",page.getPageNum());
		rttr.addAttribute("amount",page.getAmount());
		rttr.addAttribute("keyword",page.getKeyword());
		rttr.addAttribute("searchType",page.getSearchType());*/
		
		return "redirect:/board/list" + page.makeParam();
	}
	
	@GetMapping(value = "/getAttachList",
			produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<BoardAttachVO>> getAttachList(Long bno) {
		log.info("getAttachList : " + bno);
		
		return new ResponseEntity<>(service.getAttachList(bno), HttpStatus.OK);
	}
			
	private void deleteFiles(List<BoardAttachVO> attachList) {
		if(attachList == null || attachList.size() == 0) {
			return;
		}
		
		log.info("delete attach files...");
		log.info(attachList);
		
		attachList.forEach(attach -> {
			try {
				Path file = Paths.get("C:\\upload\\"+attach.getUploadPath()+"\\"+attach.getUuid()+"_"+attach.getFileName());
				
				Files.deleteIfExists(file);
				if(Files.probeContentType(file).startsWith("image")) {
					Path thumbNail = Paths.get("C:\\upload\\"+attach.getUploadPath()+"\\s_"+attach.getUuid()+"_"+attach.getFileName());
				Files.delete(thumbNail);
			}
		}catch(Exception e) {
			log.error("delete file error : " + e.getMessage());
		}//end catch
				
	});//end foreach
		
	}
	
	@PreAuthorize("isAuthenticated()")
	@RequestMapping(value = "/like", method=RequestMethod.POST,consumes = "application/json",
			produces = { MediaType.TEXT_PLAIN_VALUE })
	@ResponseBody
	public String like(@RequestBody RecVO vo) {

		log.info("RecVO : " + vo);
		int result = service.getBoardLike(vo);
		if(result > 0) {
			// 이미 추천했을경우
			service.deleteRecLike(vo);
			service.updateBoardLike(vo);
			return "already";
		} else {
		// 처음 추천일경우
		log.info("처음 추천했을때 result : " + result);
		service.createRecLike(vo);
		service.updateBoardLike(vo);
		return "success";
		}
	}
	
	
	// 좋아요 여부 확인
	@RequestMapping(value = "/likecheck", method=RequestMethod.POST,consumes = "application/json",produces = {
			MediaType.APPLICATION_JSON_UTF8_VALUE })
	@ResponseBody
	public int likeCheck(@RequestBody RecVO vo) {
		int result = service.getBoardLike(vo);
		// 0이면 처음, 1이면 이미 추천 이력 있음
		log.info("check vo : " +vo);
		log.info("좋아요여부 result : " +result);
		return result;
	}
	
	
	
	
}
