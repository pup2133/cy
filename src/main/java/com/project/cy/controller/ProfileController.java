package com.project.cy.controller;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.cy.model.dao.ProfileRepository;
import com.project.cy.model.dto.ProfileDTO;
import com.project.cy.model.service.ProfileService;

@Controller
public class ProfileController {
	
	ProfileService service;
	
	@Autowired
	public void setService(ProfileService service) {
		this.service = service;
	}

	@GetMapping("profile")
	public String getProfile(Model model, String m_id, HttpSession session) throws Exception {
		session.setAttribute("sessionId", "rhkddlf");
		
		ProfileDTO profile = (ProfileDTO) service.selectProfile(m_id);
		
		model.addAttribute("profile", profile);
		
		return "profile";
	}
	
	@PostMapping("profile/profileUpdate")
	public void updateProfile(@RequestParam Map<String, String> map) {
		System.out.println(map.get("m_id"));
		System.out.println(map.get("m_name"));
		System.out.println(map.get("m_birth"));
		System.out.println(map.get("m_email"));
		System.out.println(map.get("m_tel"));
		System.out.println(map.get("p_text"));
		
		service.updateProfile1(map);
		service.updateProfile2(map);
	}
}
