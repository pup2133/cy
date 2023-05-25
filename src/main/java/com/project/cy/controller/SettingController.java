package com.project.cy.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class SettingController {

	@GetMapping("/homeSetting")
	public String homeSettingForm() {
		return "homeSetting";
	}
	
	@GetMapping("/informModify")
	public String informModifyForm() {
		return "informModify";
	}
	
	@GetMapping("/garden")
	public String homeForm() {
		return "home";
	}
}
