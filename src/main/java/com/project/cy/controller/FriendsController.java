package com.project.cy.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.cy.model.dao.FriendsRepository;
import com.project.cy.model.dto.FriendsDTO;
import com.project.cy.service.FriendsService;

@Controller	
public class FriendsController {
	
	@Autowired
	FriendsService service;
	
	@RequestMapping("/friends")
	public String getFriend(Model model,String id, HttpSession session){
		// 임시 세션 아이디
		session.setAttribute("sessionId", "dd");
		String sessionId = (String) session.getAttribute("sessionId");
		
		//호스트 아이디 검사
		String hostId = service.getMemberId(id);
		
		if(hostId!=null) {
			List<FriendsDTO> list1 = service.getRecieve(hostId);
			List<FriendsDTO> list2 = service.getSend(hostId);
			list1.addAll(list2);
			model.addAttribute("hostId",hostId);
			model.addAttribute("sessionId",sessionId);
			model.addAttribute("friendsList",list1);
			System.out.println(list1);
		}else {
			return "error";
		}
		return "friends";
	}
	@ResponseBody
	@PostMapping("/deleteFriend")
	public String deleteFriend(@RequestParam int f_num) {
		//String m_id = session.getId();
		int result = service.delete(f_num);
		return "ddd";
	}
	
	
}
