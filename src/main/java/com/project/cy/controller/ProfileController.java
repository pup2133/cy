package com.project.cy.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

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
		
		System.out.println(profile);
		
		model.addAttribute("profile", profile);
		
		return "profile";
	}
}
