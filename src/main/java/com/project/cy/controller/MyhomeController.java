package com.project.cy.controller;

import java.util.HashMap;
import java.util.List;
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
import com.project.cy.model.dto.FriendsDTO;

@Controller
public class MyhomeController {
	
	@Autowired
	HomeRepository homedao;
	
	@Autowired
	DiaryRepository diarydao;

	
	@GetMapping("/myhome")
	public String getHomeProfile(Model model,String id,HttpSession session) {
		// 임시 세션 아이디
		//session.setAttribute("sessionId", "dd");
		String sessionId = (String) session.getAttribute("sessionId");
		
		//호스트 아이디 검사
		String hostId = homedao.getMemberId(id);
		
		if(hostId!=null) {
			try {
				//아이디정보
				
				model.addAttribute("hostId",hostId);
				model.addAttribute("sessionId",sessionId);
				//헤더, 프로필
				model.addAttribute("headerProfile",homedao.getHomeProfile(sessionId));
				model.addAttribute("homeProfile",homedao.getHomeProfile(hostId));
				model.addAttribute("previewNum", homedao.getPreview(hostId));
				model.addAttribute("banner",homedao.getBanner(hostId));
				model.addAttribute("recieveFriends",homedao.getRecieveFriends(sessionId));
				model.addAttribute("alertCount",homedao.getRecieveFriends(sessionId).size());
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
	//일촌확인
	@PostMapping("/isFriend")
	@ResponseBody
	public int isFriend(String id,HttpSession session) {
		String sessionId = (String) session.getAttribute("sessionId");
		
		//호스트 아이디 검사
		String hostId = homedao.getMemberId(id);
		List<FriendsDTO> list1 = homedao.getRecieve(hostId);
		List<FriendsDTO> list2 = homedao.getSend(hostId);
		list1.addAll(list2);
		int result=0;
		for(Object a:list1) {
			System.out.println(((FriendsDTO)a).getM_id());
			if((((FriendsDTO)a).getM_id()).equals(sessionId)) {
				result=1;
			}
		}
		return result;
	}
	//일촌신청
	@PostMapping("/sendFriend")
	@ResponseBody
	public int sendFriend(String id,HttpSession session) {
		String sessionId = (String) session.getAttribute("sessionId");
		
		//호스트 아이디 검사
		String hostId = homedao.getMemberId(id);
		int result = homedao.sendFriend(sessionId, hostId);
		System.out.println(result);
		return result;
	}
	
	//로그아웃
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/login";
	}
}
