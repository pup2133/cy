package com.project.cy.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.cy.model.dto.LoginDTO;
import com.project.cy.model.service.LoginService;

@Controller
public class LoginController {
	
	@Autowired
	LoginService service;
	
	// 회원가입
	@GetMapping("/register")
	public String registerForm() {
		return "register";
	}
	
	// 로그인
	@GetMapping("/login")
	public String loginForm() {
		return "login";
	}
	
	// 아이디찾기
	@GetMapping("/findid")
	public String FindIdForm() {
		return "FindId";
	}
	
	// 비밀번호 찾기
	@GetMapping("/findpw")
	public String FindPwForm() {
		return "FindPw";
	}
	
	// 로그인
	@PostMapping("/login")
	public String login(String id, String pw, HttpSession session, Model model) {
		LoginDTO member = service.login(id);
		model.addAttribute("member",member);
		
		if (member == null) {
			System.out.println("로그인 실패");
			System.out.println(member);
			return "login";
		} else if (member.getM_id().equals(id) && member.getM_pw().equals(pw)) {
			System.out.println("로그인 성공");
			session.setAttribute("sessionId", id);
			session.setAttribute("hostId", id);

			// 세션 아이디 확인용
			String sessionId = (String) session.getAttribute("sessionId");
			System.out.println(sessionId);
			return "redirect:/myhome?id=" + id;
		} else {
			System.out.println("로그인실패");
			return "redirect:/login";

		}
	}

	// 회원가입
	@PostMapping("register")
	public String register(LoginDTO dto) {
	     LoginDTO member = new LoginDTO(dto.getM_id(), dto.getM_pw(), dto.getM_name(), dto.getM_nick(), dto.getM_birth(), dto.getM_email(), dto.getM_tel());
		 service.register(member);
		 //배너 테이블 자동생성
		 service.createBanner(dto.getM_id());
		 service.createP_text(dto.getM_id());
	    	return "redirect:/login";
	}

	// 아이디 중복확인
	@PostMapping("dup")
	@ResponseBody
	public Boolean duplication(String m_id) {
		System.out.println(m_id);
		String result = service.duplication(m_id);

		if (result == null) {
			return true;
		} else {
			return false;
		}
		
		

	}

	// 아이디 찾기
	@PostMapping("FindId")
	@ResponseBody
	public String FindId(@RequestParam("m_name") String name, @RequestParam("m_email") String email) {

		String foundId = service.findId(name, email);

		if (foundId != null) {
			return foundId;
		} else {
			return "1";
		}
	}

	// 패스워드 찾기
	@PostMapping("FindPw")
	@ResponseBody
	public String FindPw(String m_id, String m_name, String m_email) {

		String foundPw = service.findPw(m_id, m_name, m_email);

		if (foundPw != null) {
			return foundPw;
		} else {
			return "1";
		}
	}
}