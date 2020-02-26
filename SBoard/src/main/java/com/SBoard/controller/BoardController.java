package com.SBoard.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.SBoard.service.BoardService;
import com.SBoard.vo.BoardVO;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/board/*")
@AllArgsConstructor // BoardController는 BoardService에 의존적이므로 @AllArgsConstructor를 사용하여 생성자를 만들고 자동으로 주입
public class BoardController {

	
	private BoardService service;
	
	@GetMapping("/list") // list는 게시물의 목록을 전송해야 하므로 addAttribute를 사용해 model을 파라미터로 설정하고 이를 BoardServiceImpl 객체의 getList() 결과를 담아 전달함 
	public void list(Model model) {
		
		log.info("list");
		
		model.addAttribute("list",service.getList());
	}
	
	@PostMapping("/register")
	public String register(BoardVO board, RedirectAttributes rttr) {
		
		// 게시글 등록후 목록화면으로 이동하기 위해 RedirectAttributes를 파라미터로 지정하고 새로 등록된 게시물의 번호를 같이 전달하기 위해 사용
		log.info("register" + board);
		
		service.register(board);
		
		rttr.addFlashAttribute("result", board.getBno());
		return "redirect:/board/list";
	}
	
	@GetMapping("/get")
	public void get(@RequestParam("bno") Long bno, Model model) {
		// 화면으로 해당 bno의 게시글을 전달해야하므로 model을 파라미터로 지정
		log.info("get");
		model.addAttribute("board",service.get(bno));
	}
	
	@PostMapping("/modify")
	public String modify(BoardVO board, RedirectAttributes rttr) {
		//service.modify는 수정 여부를 boolean타입으로 지정했으므로 성공한 경우에만 RedirectAttributes에 저장
		log.info("modify" + board);
		
		if(service.modify(board)) {
			rttr.addFlashAttribute("result", "success");
		}
		return "redirect:/board/list";
	}
	
	@PostMapping("/remove")
	public String remove(@RequestParam("bno") Long bno, RedirectAttributes rttr) {
		
		log.info("remove" + bno);
		if(service.remove(bno)) {
			rttr.addFlashAttribute("result","success");
		}
		return "redirect:/board/list";
	}
	
}
