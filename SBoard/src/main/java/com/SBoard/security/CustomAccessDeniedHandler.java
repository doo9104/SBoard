package com.SBoard.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.web.access.AccessDeniedHandler;

import lombok.extern.log4j.Log4j;

@Log4j
public class CustomAccessDeniedHandler implements AccessDeniedHandler{
// 접근 권한 거부 메세지에 대한 핸들러
	@Override
	public void handle(HttpServletRequest request, HttpServletResponse response, AccessDeniedException accessException)
		throws IOException, ServletException {
		
		log.error("Access Denied Handler");
		
		log.error("redirect...");
		
		response.sendRedirect("/accessError");
	}
}
