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

	FriendsService service;
	
	@Autowired
	public FriendsController(FriendsService service) {
		super();
		this.service = service;
	}

	@RequestMapping("/friends")
	public String getFriend(Model model, String id, HttpSession session) {

		if (id != null) {
			List<FriendsDTO> list1 = service.getRecieve(id);
			List<FriendsDTO> list2 = service.getSend(id);
			list1.addAll(list2);
			
			model.addAttribute("friendsList", list1);
		} else {
			return "error";
		}
		return "friends";
	}

	@ResponseBody
	@PostMapping("/deleteFriend")
	public String deleteFriend(@RequestParam int f_num) {
		service.delete(f_num);
		return "ddd";
	}

}
