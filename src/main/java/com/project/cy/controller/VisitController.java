package com.project.cy.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.cy.model.dao.HomeRepository;
import com.project.cy.model.dto.FriendsDTO;
import com.project.cy.model.dto.MyjukeDTO;
import com.project.cy.model.dto.visit;
import com.project.cy.model.service.FriendsService;
import com.project.cy.model.service.JukeboxService;
import com.project.cy.model.service.visitService;
import com.project.cy.util.pagination;

@Controller
public class VisitController {
	
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
	visitService service;

	@Autowired
	public VisitController(visitService service) {
		this.service = service;
	}

	@GetMapping("visit")
	public String visit(@RequestParam(defaultValue = "1") int page, Model model, String id, HttpSession session) {

		String sessionId = (String) session.getAttribute("sessionId");

		try {
			String hostId = service.getMemberId(id); // 호스트 아이디가 존재하는지 확인
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
			if (hostId != null) {
				
				int totalCount = service.getTotalCount(); // 방명록이 총 몇개 있는지

				pagination p = new pagination();
				Map<String, Integer> pagination = p.pagination(totalCount, page, 4);

				List<visit> visitList = service.getVisit(pagination.get("startItem"), pagination.get("itemsPerPage"));

				model.addAttribute("host", hostId);
				model.addAttribute("sessionId", sessionId);
				model.addAttribute("member", service.getMember(sessionId));
				model.addAttribute("list", visitList);
				model.addAttribute("totalPages", pagination.get("totalPages"));
				model.addAttribute("currentPage", page);
				model.addAttribute("startPage", pagination.get("startPage"));
				model.addAttribute("endPage", pagination.get("endPage"));

			} else {
				return "error";
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return "visit";
	}
	
	@PostMapping("visit/reg")
	public String visitReg(visit dto) {

		String hostId = dto.getV_hostId();

		try {
			visit newVisit = new visit(dto.getV_text(), dto.getV_hostId(), dto.getV_guestId());
			service.addVisit(newVisit);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "redirect:/visit?id=" + hostId;
	}

	@PostMapping("visit/edit")
	@ResponseBody
	public Boolean commentUpdate(visit dto) {

		try {
			visit editVisit = new visit(dto.getV_num(), dto.getV_text(), dto.getV_time(), dto.getV_hostId(), dto.getV_guestId());
			service.editVisit(editVisit);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return true;
	}

	@PostMapping("visit/delete")
	public String commentDelete(String v_num, String userType) {

		try {
			service.deleteVisit(v_num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:/visit?id=" + userType;

	}

}
