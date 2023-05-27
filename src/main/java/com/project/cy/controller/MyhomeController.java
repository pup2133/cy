package com.project.cy.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.cy.model.dao.DiaryRepository;
import com.project.cy.model.dao.HomeRepository;

@Controller
public class MyhomeController {
	
	@Autowired
	HomeRepository homedao;
	
	@Autowired
	DiaryRepository diarydao;

	
	@GetMapping("/myhome")
	public String getHomeProfile(Model model,String id,HttpSession session) {
		// 임시 세션 아이디
		session.setAttribute("sessionId", "dd");
		String sessionId = (String) session.getAttribute("sessionId");
		
		//호스트 아이디 검사
		String hostId = homedao.getMemberId(id);
		
		if(hostId!=null) {
			try {
				//아이디정보
				
				model.addAttribute("hostId",hostId);
				model.addAttribute("sessionId",sessionId);
				//헤더, 프로필
				model.addAttribute("homeProfile",homedao.getHomeProfile(hostId));
				model.addAttribute("previewNum", homedao.getPreview(hostId));
				model.addAttribute("banner",homedao.getBanner(hostId));
				model.addAttribute("recieveFriends",homedao.getRecieveFriends(hostId));
				model.addAttribute("alertCount",homedao.getRecieveFriends(hostId).size());
				//메인
				model.addAttribute("diaryList",diarydao.selectDiary(hostId));
				model.addAttribute("visitList",homedao.getHomeVisit(hostId));
				model.addAttribute("galleryList",homedao.getHomeGallery(hostId));
				
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}else {
			return "error";
		}
		return "home";
	}
	//일촌수락
	@PostMapping("/accept")
	@ResponseBody
	public void acceptFriends(int f_num) {
		homedao.acceptFriends(f_num);
		System.out.println(f_num+"수락됨");
	}
	//일촌거절
	@PostMapping("/reject")
	@ResponseBody
	public void rejectFriends(int f_num) {
		homedao.rejectFriends(f_num);
		System.out.println(f_num+"거절됨");
	}
}
