package com.SBoard.controller;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class CommonController {

	
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
	
	
	
	
	
}
