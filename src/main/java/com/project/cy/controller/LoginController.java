package com.project.cy.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;

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
	
	
	// 로그인
	@PostMapping("/login")
	public String login(@RequestParam("id") String id, @RequestParam("pw") String pw,HttpSession session) {

		Login member = dao.findMember(id);

		if (member == null) {
			return "login";
		} else if (member.getM_id().equals(id) && member.getM_pw().equals(pw)) {
			System.out.println("로그인 성공");
			session.setAttribute("m_id", id);
			System.out.println(id);
			return "redirect:/login";
		} else {
			System.out.println("로그인실패");
			return "home";

		}
	}
	
	//회원가입
	@PostMapping("register")
	public String register(Login dto) {
		Login member = new Login(dto.getM_id(),dto.getM_pw(),dto.getM_name(),dto.getM_nick(),dto.getM_birth(),dto.getM_email(),dto.getM_tel());
		dao.register(member);
		System.out.println(member);
		return "redirect:/login";
		
	}
	
	//아이디 중복확인 
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
	
	//아이디 찾기
	@PostMapping("FindId")
	@ResponseBody
	public String FindId(@RequestParam("m_name") String name, @RequestParam("m_email") String email) {
		
		 String foundId = dao.FindId(name, email);
		    
		    if (foundId != null) {
		        return foundId;
		    } else {
		        return "1";
		    }

	}
	
	//패스워드 찾기
	@PostMapping("/FindPw")
	public String FindPw() {
		System.out.println("findpw 테스트");
		return "redirect:/FindPw";
	}
}
