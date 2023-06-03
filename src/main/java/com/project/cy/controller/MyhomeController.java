package com.project.cy.controller;

import java.util.ArrayList;
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

import com.project.cy.model.dto.FriendsDTO;
import com.project.cy.model.dto.MyjukeDTO;
import com.project.cy.model.service.DiaryService;
import com.project.cy.model.service.FriendsService;
import com.project.cy.model.service.HomeService;

@Controller
public class MyhomeController {

	@Autowired
	HomeService hservice;

	@Autowired
	DiaryService dservice;

	FriendsService friendsService;

	@Autowired
	public void setFriendsService(FriendsService friendsService) {
		this.friendsService = friendsService;
	}

	@GetMapping("/myhome")
	public String getHomeProfile(Model model, String id, HttpSession session) {

		String sessionId = (String) session.getAttribute("sessionId");
		String hostId = hservice.getMemberId(id);

		if (hostId != null) {
			try {

				hservice.updateToday(hostId);

				// 메인
				model.addAttribute("homeProfile", hservice.getHomeProfile(hostId));
				model.addAttribute("previewNum", hservice.getPreview(hostId));
				model.addAttribute("recieveFriends", hservice.getRecieveFriends(sessionId));
				model.addAttribute("today", hservice.getToday(hostId));
				model.addAttribute("diaryList", dservice.selectDiary2(hostId));
				model.addAttribute("visitList", hservice.getHomeVisit(hostId));
				model.addAttribute("galleryList", hservice.getHomeGallery(hostId));

				ArrayList<FriendsDTO> waves = (ArrayList<FriendsDTO>) friendsService.getSearchList(hostId);
				
				model.addAttribute("friends", waves);

				String r_id = "";
				if (!waves.isEmpty()) {
					Random r = new Random();
					int r_num = r.nextInt(waves.size());
					r_id = waves.get(r_num).getM_id();
				}

				session.setAttribute("hostId", hostId);
				model.addAttribute("r_id", r_id);

			} catch (Exception e) {
				e.printStackTrace();
			}
		} else {
			return "error";
		}
		return "home";
	}

	// 일촌수락
	@PostMapping("/accept")
	@ResponseBody
	public void acceptFriends(int f_num) {
		hservice.acceptFriends(f_num);
		System.out.println(f_num + "수락됨");
	}

	// 일촌거절
	@PostMapping("/reject")
	@ResponseBody
	public void rejectFriends(int f_num) {
		hservice.rejectFriends(f_num);
		System.out.println(f_num + "거절됨");
	}

	// 일촌확인
	@PostMapping("/isFriend")
	@ResponseBody
	public int isFriend(String id, HttpSession session) {
		String sessionId = (String) session.getAttribute("sessionId");

		// 호스트 아이디 검사
		String hostId = hservice.getMemberId(id);
		List<FriendsDTO> list1 = hservice.getRecieve(hostId);
		List<FriendsDTO> list2 = hservice.getSend(hostId);
		list1.addAll(list2);
		int result = 0;
		for (Object a : list1) {
			if ((((FriendsDTO) a).getM_id()).equals(sessionId)) {
				result = 1;
			}
		}
		return result;
	}

	// 일촌신청
	@PostMapping("/sendFriend")
	@ResponseBody
	public int sendFriend(String id, HttpSession session) {
		String sessionId = (String) session.getAttribute("sessionId");

		// 호스트 아이디 검사
		String hostId = hservice.getMemberId(id);
		int result = hservice.sendFriend(sessionId, hostId);

		return result;
	}

	// 로그아웃
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/login";
	}

	// 프로필 메시지 수정
	@PostMapping("/editMsg")
	@ResponseBody
	public int editMsg(String id, String h_msg, HttpSession session) {
		String hostId = hservice.getMemberId(id);
		int result = hservice.editMsg(h_msg, hostId);
		return result;
	}

	// 플리가져오기
	@PostMapping("/getPlay")
	@ResponseBody
	public List<MyjukeDTO> getPlay(String id, HttpSession session) {
		// 호스트 아이디 검사
		String hostId = hservice.getMemberId(id);
		return hservice.getPlay(hostId);
	}

	@RequestMapping(value = "searchList", method = RequestMethod.GET, produces = "application/text; charset=UTF-8")
	@ResponseBody
	public String getSearchList(HttpSession session) {

		String id = (String) session.getAttribute("hostId");
		ArrayList<FriendsDTO> list = (ArrayList<FriendsDTO>) friendsService.getSearchList(id);

		JSONArray jslist = new JSONArray();
		for (FriendsDTO f : list) {
			JSONObject data = new JSONObject();

			data.put("m_id", f.getM_id());
			data.put("m_nick", f.getM_nick());

			jslist.put(data);
		}

		return jslist.toString();
	}
}