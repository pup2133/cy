package com.project.cy.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.cy.model.dao.FriendsRepository;
import com.project.cy.model.dao.HomeRepository;
import com.project.cy.model.dto.FriendsDTO;
import com.project.cy.model.dto.MyjukeDTO;
import com.project.cy.model.service.FriendsService;
import com.project.cy.model.service.JukeboxService;

@Controller	
public class FriendsController {
	
	@Autowired
	JukeboxService jservice;
	
	@Autowired
	HomeRepository homedao;

	FriendsService friendsService;
	@Autowired
	public void setFriendsService(FriendsService friendsService) {
		this.friendsService = friendsService;
	}
	//
	@Autowired
	FriendsService service;
	
	@RequestMapping("/friends")
	public String getFriend(Model model,String id, HttpSession session){
		//아이디정보
		String sessionId = (String) session.getAttribute("sessionId");
		String hostId = homedao.getMemberId(id);
		model.addAttribute("hostId",hostId);
		model.addAttribute("sessionId",sessionId);
		//헤더, 프로필, 네비게이션
		model.addAttribute("headerProfile",homedao.getHomeProfile(sessionId));
		model.addAttribute("homeProfile",homedao.getHomeProfile(hostId));
		model.addAttribute("previewNum", homedao.getPreview(hostId));
		model.addAttribute("banner",homedao.getBanner(hostId));
		model.addAttribute("recieveFriends",homedao.getRecieveFriends(sessionId));
		model.addAttribute("alertCount",homedao.getRecieveFriends(sessionId).size());
		model.addAttribute("myplayList",homedao.getPlay(hostId));
		model.addAttribute("mylist",jservice.getMyjuke(hostId));
		model.addAttribute("myplay",jservice.getMyplay(hostId));
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
		//아이디검색
		ArrayList<FriendsDTO> friends = (ArrayList<FriendsDTO>) friendsService.getRecieve(id);
		friends.addAll(friendsService.getSend(id));
		
		model.addAttribute("friends", friends);
		
		
		
		
		if(hostId!=null) {
			List<FriendsDTO> list1 = service.getRecieve(hostId);
			List<FriendsDTO> list2 = service.getSend(hostId);
			list1.addAll(list2);
			model.addAttribute("hostId",hostId);
			model.addAttribute("sessionId",sessionId);
			model.addAttribute("friendsList",list1);
			System.out.println(list1);
		}else {
			return "error";
		}
		return "friends";
	}
	@ResponseBody
	@PostMapping("/deleteFriend")
	public String deleteFriend(@RequestParam int f_num) {
		//String m_id = session.getId();
		int result = service.delete(f_num);
		return "ddd";
	}
	
	
}
