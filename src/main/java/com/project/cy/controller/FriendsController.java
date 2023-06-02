package com.project.cy.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.cy.model.dto.FriendsDTO;
import com.project.cy.model.service.FriendsService;

@Controller
public class FriendsController {

	@Autowired
	FriendsService service;

	@RequestMapping("/friends")
	public String getFriend(Model model, String id, HttpSession session) {

		// 호스트 아이디 검사
		String hostId = service.getMemberId(id);

		session.setAttribute("hostId", hostId);

		if (hostId != null) {
			List<FriendsDTO> list1 = service.getRecieve(hostId);
			List<FriendsDTO> list2 = service.getSend(hostId);
			list1.addAll(list2);
			
			model.addAttribute("friendsList", list1);
			System.out.println(list1);
		} else {
			return "error";
		}
		return "friends";
	}

	@ResponseBody
	@PostMapping("/deleteFriend")
	public String deleteFriend(@RequestParam int f_num) {
		// String m_id = session.getId();
		int result = service.delete(f_num);
		return "ddd";
	}

}
