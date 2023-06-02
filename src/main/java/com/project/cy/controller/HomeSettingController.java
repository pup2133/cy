package com.project.cy.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.project.cy.model.dto.HomeSettingDTO;
import com.project.cy.model.dto.LoginDTO;
import com.project.cy.model.service.HomeSettingService;
import com.project.cy.model.service.LoginService;

@Controller
public class HomeSettingController {

	@Autowired
	HomeSettingService service;
	
	@Autowired
	LoginService lService;
	
	//기존 배너 공개,비공개 설정 세팅 가져오기
	@GetMapping("/homeSetting")
	public String homeSettingForm(HttpSession session, Model model) {
		String sessionId = (String) session.getAttribute("sessionId");
		HomeSettingDTO setting = service.getsetting(sessionId);
		System.out.println(setting);
		model.addAttribute("setting", setting);
		return "homeSetting";
	}
	
	// 배너 공개,비공개 설정 세팅 업데이트
	@PostMapping("savesetting")
	public String homesetting(HomeSettingDTO dto) {

		HomeSettingDTO user = new HomeSettingDTO(dto.getM_id(), dto.getB_hide_profile(), dto.getB_hide_music(), dto.getB_hide_diary(), dto.getB_hide_gallery());
		int result = service.updatesetting(user); //updatesetting 메서드를 호출하여 업데이트 작업 수행

		if (result > 0) {
			// 업데이트 성공
			return "redirect:/homeSetting";
		} else {
			// 업데이트 실패
			return "error";
		}
	}

	// 회원정보 수정화면에서 정보 가져오기
	@GetMapping("/informModify")
	public String informModifyForm(HttpSession session, Model model) {
		String sessionId = (String) session.getAttribute("sessionId");
						//Id 셀렉트 
		LoginDTO member = lService.getInformation(sessionId);		
		model.addAttribute("member" , member);
		
		return "informModify";
	}
	
	//정보 업데이트
	@PostMapping("updateInform")
	public String Modify(LoginDTO dto) {
		LoginDTO member = new LoginDTO(dto.getM_id(),dto.getM_pw(),dto.getM_name(),dto.getM_nick(),dto.getM_birth(),dto.getM_email(),dto.getM_tel(),dto.getM_wave());
		int result = lService.modify(member);
		
		if (result > 0) {
			// 업데이트 성공
			return "redirect:/informModify";
		} else {
			// 업데이트 실패
			return "error";
		}
	
	}


}