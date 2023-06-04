package com.project.cy.util;

import java.text.SimpleDateFormat;
import java.util.Calendar;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.project.cy.model.service.FriendsService;

public class Handler implements HandlerInterceptor {
	
	@Autowired
	FriendsService service;

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		HttpSession session = request.getSession();
		String id = (String) session.getAttribute("sessionId");
		String hostId = request.getParameter("id");
		String host = service.getMemberId(hostId);
		
		if(id == null) {
			response.sendRedirect("./login");
			return false;
		}else if(host==null) {
			response.sendRedirect("./error");
			return false;

		}
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		Calendar c1 = Calendar.getInstance();
		String strToday = sdf.format(c1.getTime());
		session.setAttribute("days", strToday);


		if(hostId==null) {
			hostId = (String)session.getAttribute("hostId");
			session.setAttribute("hostId", hostId);
		}else {
			session.setAttribute("hostId", hostId);
		}
		
		return true;
	}

	
	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		// TODO Auto-generated method stub
		HandlerInterceptor.super.afterCompletion(request, response, handler, ex);
	}
	
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		// TODO Auto-generated method stub
		HandlerInterceptor.super.postHandle(request, response, handler, modelAndView);
	}
}