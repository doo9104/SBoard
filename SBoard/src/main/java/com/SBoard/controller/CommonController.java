package com.SBoard.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;


import com.SBoard.service.MemberManageService;
import com.SBoard.vo.MemberVO;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class CommonController {
	
	@Autowired(required=true)
	private MemberManageService service;
	
	// 접근 권한 거부
	@GetMapping("/accessError")
	public void accessDenied(Authentication auth, Model model) {
		
		log.info("Access Denied : " + auth);
		
		model.addAttribute("msg", "Access Denied");
	}
	
	
	// 커스텀로그인
	@GetMapping("/customLogin")
	public void loginInput(String error, String logout, Model model) {
		
		log.info("Error : " + error);
		log.info("logout : " + logout);
		
		if (error != null) {
			model.addAttribute("error", "Login Error! Check your account");
		}
		
		if (logout != null) {
			model.addAttribute("logout", "Logout!");
		}
		
	}
	
	// 커스텀 로그아웃
	@GetMapping("/customLogout")
	public void logoutGET() {
		log.info("logout");

	}
	
	@GetMapping("/join")
	public void join() {
		
	}
	
	@RequestMapping(value = "/idCheck", method=RequestMethod.POST,consumes = "application/json",produces = {
			MediaType.APPLICATION_JSON_UTF8_VALUE })
	@ResponseBody
	public int test(@RequestBody MemberVO vo) {
		int result=0;
		log.info("vo : " + vo);
		MemberVO userid = service.getUserId(vo);
		if(userid!=null) result=1;
		
		log.info("아이디 체크 결과 : " + result);
		return result;
	}
	
	
	
}
