package com.project.cy.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.project.cy.model.dao.HomeRepository;
import com.project.cy.model.dto.FriendsDTO;
import com.project.cy.model.dto.MyjukeDTO;
import com.project.cy.model.dto.ProfileDTO;
import com.project.cy.model.service.FriendsService;
import com.project.cy.model.service.JukeboxService;
import com.project.cy.model.service.ProfileService;
import com.project.cy.util.fileUpload;

@Controller
public class ProfileController {
	
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
	
	ProfileService service;
	
	@Autowired
    private ServletContext servletContext;
	
	@Autowired
	public void setService(ProfileService service) {
		this.service = service;
	}
	
	ProfileDTO profile;

	@GetMapping("profile")
	public String getProfile(Model model, String id, HttpSession session) throws Exception {
		
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
		
		//
		profile = (ProfileDTO) service.selectProfile(id);
		model.addAttribute("profile", profile);
		model.addAttribute("hostId",id);
		model.addAttribute("sessionId",sessionId);
		
		return "profile";
	}
	
	@PostMapping("profile/profileUpdate")
	public void updateProfile(@RequestParam Map<String, String> map) {
		
		service.updateProfile1(map);
		service.updateProfile2(map);
		service.updateProfile3(map);
	}
	
	@PostMapping("fileSet")
	@ResponseBody
	public String fileSet(@RequestParam MultipartFile file) {
		String p_pic = profile.getP_pic();
		
		if(!file.isEmpty()) {
			String realPath = servletContext.getRealPath("/resources/file/profile");
			System.out.println("realPath: " + realPath);
			fileUpload upload = new fileUpload();	
			p_pic = upload.upload(file,realPath);
		}
			
		
		return p_pic;
	}
}
