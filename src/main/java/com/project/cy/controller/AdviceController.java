package com.project.cy.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.project.cy.model.dao.HomeRepository;
import com.project.cy.model.dto.MyjukeDTO;
import com.project.cy.service.FriendsService;

//@ControllerAdvice
public class AdviceController {
	
	@Autowired
	HomeRepository homedao;

    @ModelAttribute
    public void populateModel(Model model, HttpSession session) {
		String sessionId = (String)session.getAttribute("sessionId");
		session.setAttribute("hostId", "qq");
		String hostId = (String)session.getAttribute("hostId");

		//헤더, 프로필, 네이게이션
		model.addAttribute("headerProfile",homedao.getHomeProfile(sessionId));
		model.addAttribute("banner",homedao.getBanner(hostId));
		model.addAttribute("recieveFriends",homedao.getRecieveFriends(sessionId));
		model.addAttribute("alertCount",homedao.getRecieveFriends(sessionId).size());
	
		List<MyjukeDTO> list =  homedao.getPlay(hostId);
		ArrayList<String> urllist = new ArrayList<>();
		ArrayList<String> titlelist = new ArrayList<>();
		for(MyjukeDTO item: list) {
			System.out.println(item.getMu_url());
			urllist.add(item.getMu_url());
			titlelist.add(item.getMu_title());
		}
		model.addAttribute("urllist",urllist);
		model.addAttribute("titlelist",titlelist);
		model.addAttribute("myplayList",homedao.getPlay(hostId));
    }
}
