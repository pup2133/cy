package com.project.cy.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.project.cy.model.dao.JukeboxStoreRepository;

@Controller
public class JukeboxController {
	
	@Autowired
	JukeboxStoreRepository dao;
	
	@GetMapping("/jukestore")
	public String test(Model model) {
		model.addAttribute("musiclist",dao.All());
		return "jukestore";
	}
	
}
