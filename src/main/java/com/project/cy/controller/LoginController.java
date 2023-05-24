package com.project.cy.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

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
			System.out.println("로그인 성공");
			return "redirect:/login";
		} else {
			System.out.println("로그인실패");
			return "home";

		}
	}
	
	@PostMapping("register")
	public String register(Login dto) {
		Login member = new Login(dto.getM_id(),dto.getM_pw(),dto.getM_name(),dto.getM_nick(),dto.getM_birth(),dto.getM_email(),dto.getM_tel());
		dao.register(member);
		System.out.println(member);
		return "redirect:/login";
		
	}
	
	@PostMapping("dup")
	@ResponseBody
	public Boolean duplication(String m_id) {
		System.out.println(m_id);
		String result = dao.duplication(m_id);
		
		if(result == null) {
			return true;
		} else {
			return false;
		}
	
	}
	
	@PostMapping("/FindId")
	public String FindId() {
		System.out.println("findid 테스트");
		return "redirect:/FindId";
	}
	
	@PostMapping("/FindPw")
	public String FindPw() {
		System.out.println("findpw 테스트");
		return "redirect:/FindPw";
	}
}
