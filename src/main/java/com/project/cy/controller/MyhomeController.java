package com.project.cy.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
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

import com.project.cy.model.dao.DiaryRepository;
import com.project.cy.model.dao.HomeRepository;
import com.project.cy.model.dto.FriendsDTO;
import com.project.cy.model.dto.JukeboxDTO;
import com.project.cy.model.dto.MyjukeDTO;
import com.project.cy.service.FriendsService;

@Controller
public class MyhomeController {
	
	@Autowired
	HomeRepository homedao;
	
	@Autowired
	DiaryRepository diarydao;
	
	FriendsService friendsService;
	@Autowired
	public void setFriendsService(FriendsService friendsService) {
		this.friendsService = friendsService;
	}

	
	@GetMapping("/myhome")
	public String getHomeProfile(Model model,String id,HttpSession session) {
		// 임시 세션 아이디
		String sessionId = (String) session.getAttribute("sessionId");
		
		//호스트 아이디 검사
		String hostId = homedao.getMemberId(id);
		
		if(hostId!=null) {
			try {
				//아이디정보
				model.addAttribute("hostId",hostId);
				model.addAttribute("sessionId",sessionId);
				//헤더, 프로필, 네비게이션
				model.addAttribute("headerProfile",homedao.getHomeProfile(sessionId));
				model.addAttribute("homeProfile",homedao.getHomeProfile(hostId));
				model.addAttribute("previewNum", homedao.getPreview(hostId));
				model.addAttribute("banner",homedao.getBanner(hostId));
				model.addAttribute("recieveFriends",homedao.getRecieveFriends(sessionId));
				model.addAttribute("alertCount",homedao.getRecieveFriends(sessionId).size());
				List<MyjukeDTO> list =  homedao.getPlay(hostId);
				ArrayList<String> urllist = new ArrayList<>();
				ArrayList<String> titlelist = new ArrayList<>();
				for(MyjukeDTO item: list) {
					urllist.add(item.getMu_url());
					titlelist.add(item.getMu_title());
				}
				model.addAttribute("urllist",urllist);
				model.addAttribute("titlelist",titlelist);
				model.addAttribute("myplayList",homedao.getPlay(hostId));
				
				//메인
				model.addAttribute("diaryList",diarydao.selectDiary2(hostId));
				model.addAttribute("visitList",homedao.getHomeVisit(hostId));
				model.addAttribute("galleryList",homedao.getHomeGallery(hostId));
				
				
				
				//광일님부분
				session.setAttribute("hostId", id);
				
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
				Calendar c1 = Calendar.getInstance();
				String strToday = sdf.format(c1.getTime());
				
				session.setAttribute("today", strToday);
				
				ArrayList<FriendsDTO> friends = (ArrayList<FriendsDTO>) friendsService.getRecieve(id);
				friends.addAll(friendsService.getSend(id));
				
				String r_id = "";
				if(!friends.isEmpty()) {
					Random r = new Random();
					int r_num = r.nextInt(friends.size());
					r_id = friends.get(r_num).getM_id();
				}
				
				
				model.addAttribute("friends", friends);
				model.addAttribute("r_id", r_id);
				
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
	
	//프로필 메시지 수정
	@PostMapping("/editMsg")
	@ResponseBody
	public int editMsg(String id,String h_msg, HttpSession session) {
		String sessionId = (String) session.getAttribute("sessionId");
		String hostId = homedao.getMemberId(id);
		System.out.println(h_msg);
		int result = homedao.editMsg(h_msg, hostId);
		System.out.println(result);
		return result;
	}
	//플리가져오기
	@PostMapping("/getPlay")
	@ResponseBody
	public List<MyjukeDTO> getPlay(String id,HttpSession session) {
		session.setAttribute("sessionId", "dd");
		String sessionId = (String) session.getAttribute("sessionId");
		
		//호스트 아이디 검사
		String hostId = homedao.getMemberId(id);
		return homedao.getPlay(hostId);
	}
	//아이디검색
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