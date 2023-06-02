package com.project.cy.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.cy.model.dao.HomeSettingRepository;
import com.project.cy.model.dto.HomeSettingDTO;

@Controller
public class SettingController {
	
	@Autowired
	HomeSettingRepository dao;

	@GetMapping("/homeSetting")
	public String homeSettingForm(Model model) {
		return "homeSetting";
	}
	
	@GetMapping("/informModify")
	public String informModifyForm() {
		return "informModify";
	}

	//세팅 업데이트
	@PostMapping("savesetting")
	public String homesetting(HttpSession session, HomeSettingDTO dto) {
		
														//세션아이디 키값
			String sessionId = (String) session.getAttribute("sessionId");
		
			HomeSettingDTO user = new HomeSettingDTO(sessionId,dto.getB_hide_profile(), dto.getB_hide_music(),dto.getB_hide_diary(),dto.getB_hide_gallery());
			
			//
			int result = dao.updatesetting(dto); // homesetting 메서드를 호출하여 업데이트 작업 수행
			
			if (result > 0) {
			// 업데이트 성공
			// 성공 시 수행할 동작이나 페이지로 리다이렉트 등을 추가하세요
			return "redirect:/homesetting";
			} else {
			// 업데이트 실패
			// 실패 시 수행할 동작이나 페이지로 리다이렉트 등을 추가하세요
			return "login";
			}
}
	
}
