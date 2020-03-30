package com.SBoard.security;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;


import lombok.extern.log4j.Log4j;



@Log4j
public class CustomLoginSuccessHandler implements AuthenticationSuccessHandler{
// 로그인 성공 핸들러
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication auth)
		throws IOException, ServletException {
		
		List<String> roleNames = new ArrayList<>();
		
		auth.getAuthorities().forEach(authority -> {
			roleNames.add(authority.getAuthority());
		});
		
		log.info("ROLE NAMES : " + roleNames);
		
		if (roleNames.contains("ROLE_ADMIN")) {
			response.sendRedirect("/board/list");
		}

		if (roleNames.contains("ROLE_MEMBER")) {
			response.sendRedirect("/board/list");
		}
		
		response.sendRedirect("/board/list");
		
	}
	
	
}
