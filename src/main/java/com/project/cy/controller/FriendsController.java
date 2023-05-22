package com.project.cy.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.cy.model.dao.FriendsRepository;
import com.project.cy.model.dto.FriendsDTO;

@Controller	
public class FriendsController {
	
	@Autowired
	FriendsRepository dao;
	
	@RequestMapping("/friends")
	public String getFriend(Model model){
		//아이디 세션 가져오기
		//String m_id = session.getId();
		String m_id = "dd";  //임시
		
		List<FriendsDTO> list1 = dao.getRecieve(m_id);
		List<FriendsDTO> list2 = dao.getSend(m_id);
		list1.addAll(list2);
		model.addAttribute("friendsList",list1);
		System.out.println(list1);
		return "friends";
	}
	
	@PostMapping("/deleteFriend")
	public String deleteFriend(@RequestParam int f_num) {
		//String m_id = session.getId();
		int result = dao.delete(f_num);
		return "";
	}
	
	
}
