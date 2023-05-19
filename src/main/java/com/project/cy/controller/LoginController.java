package com.project.cy.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.cy.model.dao.LoginRepository;
import com.project.cy.model.dto.Login;

@Controller
public class LoginController {

	@Autowired
	LoginRepository dao;

	@GetMapping("/login")
	public String loginForm() {
		return "login";
	}

	@GetMapping("/findpw")
	public String FindPwForm() {
		return "FindPw";
	}

	@GetMapping("/findid")
	public String FindIdForm() {
		return "FindId";
	}
	
	@GetMapping("/register")
	public String registerForm() {
		return "register";
	}
	
	@PostMapping("/login")
	public String login(@RequestParam("id") String id, @RequestParam("pw") String pw) {

		Login member = dao.findMember(id);

		if (member == null) {
			return "login";
		} else if (member.getM_id().equals(id) && member.getM_pw().equals(pw)) {
			System.out.println("로그인성공");

			return "redirect:/login";
		} else {
			System.out.println("로그인실패");
			return "home";

		}
	}

	@PostMapping("FindPw")
	public String FindPw() {
		System.out.println("Ffsad");
		return "redirect:/FindPw";
	}
}
