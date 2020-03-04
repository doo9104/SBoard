package com.SBoard.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.SBoard.service.BoardService;
import com.SBoard.vo.BoardPageVO;
import com.SBoard.vo.BoardVO;
import com.SBoard.vo.PageDTO;
import com.SBoard.vo.SearchDTO;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/board/*")
@AllArgsConstructor // BoardController는 BoardService에 의존적이므로 @AllArgsConstructor를 사용하여 생성자를 만들고 자동으로 주입
public class BoardController {

	
	private BoardService service;
	
	@GetMapping("/list") // list는 게시물의 목록을 전송해야 하므로 addAttribute를 사용해 model을 파라미터로 설정하고 이를 BoardServiceImpl 객체의 getList() 결과를 담아 전달함 
	public void list(SearchDTO page,Model model) {
		
		log.info("list " + page);
		
		model.addAttribute("list",service.getList(page));


		int total = service.totalCount(page);
		model.addAttribute("pageMaker", new PageDTO(page,total));
	}
	
	
	@GetMapping("/register")
	public void register() {
		
	}
	
	
	@PostMapping("/register")
	public String register(BoardVO board, RedirectAttributes rttr) {
		
		// 게시글 등록후 목록화면으로 이동하기 위해 RedirectAttributes를 파라미터로 지정하고 새로 등록된 게시물의 번호를 같이 전달하기 위해 사용
		log.info("register : " + board);
		
		service.register(board);
		
		// 일회성으로 데이터를 전달하는 addFlashAttribute를 이용
		rttr.addFlashAttribute("result", board.getBno());
		return "redirect:/board/list";
	}
	
	// 중괄호로 감싸주면 여러개 매핑처리 가능
	@GetMapping({"/get","/modify"})
	public void get(@RequestParam("bno") Long bno,@ModelAttribute("page") SearchDTO page, Model model) {
		// 화면으로 해당 bno의 게시글을 전달해야하므로 model을 파라미터로 지정
		log.info("get or modify" + bno);
		service.updateHit(bno);
		model.addAttribute("board",service.get(bno));
	}
	
	
	
	@PostMapping("/modify")
	public String modify(BoardVO board, @ModelAttribute("page") SearchDTO page,RedirectAttributes rttr) {
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
	
	@PostMapping("/remove")
	public String remove(@RequestParam("bno") Long bno,@ModelAttribute("page") SearchDTO page, RedirectAttributes rttr) {
		
		log.info("remove : " + bno);
		if(service.remove(bno)) {
			rttr.addFlashAttribute("result","success");
		}
		/*rttr.addAttribute("pageNum",page.getPageNum());
		rttr.addAttribute("amount",page.getAmount());
		rttr.addAttribute("keyword",page.getKeyword());
		rttr.addAttribute("searchType",page.getSearchType());*/
		
		return "redirect:/board/list" + page.makeParam();
	}
	
}
