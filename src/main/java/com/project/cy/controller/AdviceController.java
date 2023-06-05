package com.project.cy.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.project.cy.model.dto.MyjukeDTO;
import com.project.cy.model.service.HomeService;

@ControllerAdvice(assignableTypes = { DiaryController.class, FriendsController.class, GalleryController.class,
		JukeboxController.class, MyhomeController.class, ProfileController.class, HomeSettingController.class,
		VisitController.class })
public class AdviceController {

	HomeService service;

	@Autowired
	public AdviceController(HomeService service) {
		this.service = service;
	}

	@ModelAttribute
	public void populateModel(Model model, HttpSession session, HttpServletResponse response) throws IOException {
		String sessionId = (String) session.getAttribute("sessionId");
		String hostId = (String) session.getAttribute("hostId");
		
		if(sessionId==hostId) {
			
		}

		// 헤더, 프로필, 네이게이션
		model.addAttribute("headerProfile", service.getHomeProfile(sessionId));
		model.addAttribute("banner", service.getBanner(hostId));
		model.addAttribute("alertCount", service.getRecieveFriends(sessionId).size());

		List<MyjukeDTO> list = service.getPlay(hostId);
		ArrayList<String> urllist = new ArrayList<>();
		ArrayList<String> titlelist = new ArrayList<>();
		for (MyjukeDTO item : list) {
			urllist.add(item.getMu_url());
			titlelist.add(item.getMu_title());
		}

		model.addAttribute("urllist", urllist);
		model.addAttribute("titlelist", titlelist);
		model.addAttribute("myplayList", service.getPlay(hostId));
	}

}