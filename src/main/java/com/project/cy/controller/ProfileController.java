package com.project.cy.controller;

import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.cy.model.dao.ProfileRepository;
import com.project.cy.model.dto.ProfileDTO;

@Controller
public class ProfileController {
	
	@Autowired
	ProfileRepository dao;
	
	@GetMapping("profile")
	public String getProfile(Model model, String m_id, HttpSession session) throws Exception {
		session.setAttribute("sessionId", "rhkddlf");
		
		ProfileDTO profile = (ProfileDTO) dao.selectProfile(m_id);
		
		model.addAttribute("profile", profile);
		
		return "profile";
	}
	
	@PostMapping("profile/profileUpdate")
	public void updateProfile(@RequestParam Map<String, String> map) {
		System.out.println(map.get("m_name"));
	}
}
