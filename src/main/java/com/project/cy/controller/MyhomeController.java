package com.project.cy.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

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
}
