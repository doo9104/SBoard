package com.SBoard.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
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
	public void loginInput(String error, String logout, Model model,HttpServletRequest req) {
		
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
	public int getUserID(@RequestBody MemberVO vo) {
		int result=0;
		log.info("vo : " + vo);
		MemberVO userid = service.getUserId(vo);
		if(userid!=null) result=1;
		
		log.info("아이디 체크 결과 : " + result);
		return result;
	}
	
	
	@RequestMapping(value = "/nameCheck", method=RequestMethod.POST,consumes = "application/json",produces = {
			MediaType.APPLICATION_JSON_UTF8_VALUE })
	@ResponseBody
	public int getUserName(@RequestBody MemberVO vo) {
		int result=0;
		log.info("vo : " + vo);
		MemberVO username = service.getUserName(vo);
		if(username!=null) result=1;
		
		log.info("닉네임 체크 결과 : " + result);
		return result;
	}
	
	
	@RequestMapping(value = "/emailCheck", method=RequestMethod.POST,consumes = "application/json",produces = {
			MediaType.APPLICATION_JSON_UTF8_VALUE })
	@ResponseBody
	public int getUserEmail(@RequestBody MemberVO vo) {
		int result=0;
		log.info("vo : " + vo);
		MemberVO email = service.getUserEmail(vo);
		if(email!=null) result=1;
		
		log.info("이메일체크 결과 : " + result);
		return result;
	}	
	
	
	@RequestMapping(value = "/join", method=RequestMethod.POST,consumes = "application/json",produces = {
			MediaType.APPLICATION_JSON_UTF8_VALUE })
	public void createMember(@RequestBody MemberVO vo) throws Exception{
		
		log.info("vo : " + vo);
		
		 service.createNewMember(vo);
	}
	
	@RequestMapping(value = "/joinConfirm", method=RequestMethod.GET)
	public String joinConfirm(MemberVO vo,Model model) throws Exception {
		
		
		vo.setActiveCode(1); // enabled를 1로 업데이트
		log.info(vo);
		service.setActivity(vo);
		
		model.addAttribute("userid",vo.getUserid());
		
		
		
		return "/joinConfirm";
	}
	
	
	////////////////////////////////////////////////////////////////////////////////
	//									마이페이지									  //
	////////////////////////////////////////////////////////////////////////////////
	@GetMapping("/mypage")
	public void mypage() {
						
	}
										
	@RequestMapping(value = "/mypage/passwordConfirm", method=RequestMethod.POST,consumes = "application/json",produces = {
			MediaType.APPLICATION_JSON_UTF8_VALUE })
	public void passwordConfirm(@RequestBody MemberVO vo) throws Exception{		
	log.info(vo.getUserpw());
	boolean result = service.checkPassword(vo.getUserpw());
	if(result) {
		log.info("비밀번호 일치!!");
	} else {
		log.info("비밀번호 불일치");
	}
	
		
	}
}
