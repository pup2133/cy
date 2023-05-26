package com.project.cy.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Random;

import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.cy.model.dto.FriendsDTO;
import com.project.cy.service.FriendsService;

@Controller
public class HomeController {
	
	FriendsService friendsService;
	
	@Autowired
	public void setFriendsService(FriendsService friendsService) {
		this.friendsService = friendsService;
	}


	@GetMapping("home")
	public String home(Model model, HttpSession session, String id) {
		session.setAttribute("hostId", id);
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		Calendar c1 = Calendar.getInstance();
		String strToday = sdf.format(c1.getTime());
		
		session.setAttribute("today", strToday);
		
		ArrayList<FriendsDTO> friends = (ArrayList<FriendsDTO>) friendsService.getRecieve(id);
		friends.addAll(friendsService.getSend(id));
		
		Random r = new Random();
		
		int r_num = r.nextInt(friends.size());
		
		String r_id = friends.get(r_num).getM_id();
		
		model.addAttribute("friends", friends);
		model.addAttribute("r_id", r_id);
		
		return "home";
	}
	
	@RequestMapping(value="searchList", method=RequestMethod.GET, produces="application/text; charset=UTF-8")
	@ResponseBody
	public String getSearchList(HttpSession session) {
		String id = (String) session.getAttribute("hostId");
		ArrayList<FriendsDTO> list = (ArrayList<FriendsDTO>) friendsService.getSearchList(id);
		
		JSONArray jslist = new JSONArray();
		for(FriendsDTO f : list) {
			JSONObject data = new JSONObject();
			
			data.put("m_id", f.getM_id());
			data.put("m_nick", f.getM_nick());
			
			jslist.put(data);
		}
		
		return jslist.toString();
	}
}
