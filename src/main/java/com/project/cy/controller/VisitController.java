package com.project.cy.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.cy.model.dao.visitRepository;
import com.project.cy.model.dto.visit;
import com.project.cy.model.service.visitService;

@Controller
public class VisitController {

	visitService service;

	@Autowired
	public VisitController(visitService service) {
		this.service = service;
	}

	@GetMapping("visit")
	public String visit(@RequestParam(defaultValue = "1") int page, Model model, String id, HttpSession session) {

		// 임시 세션 아이디
		session.setAttribute("sessionId", "yun2");
		String sessionId = (String) session.getAttribute("sessionId");

		try {
			
			int totalCount = service.getTotalCount(); // 방명록이 총 몇개 있는지
			int itemsPerPage = 4; // 방명록 페이지당 보여줄 개수
			int totalPages = (int) Math.ceil((double) totalCount / itemsPerPage); // 방명록 총 페이지 수
			int startItem = (page - 1) * itemsPerPage; // 조회 시작 위치
			int maxPaginationLinks = 5; // 보여줄 페이지 제한 최대 5개까지만
			int startPage = Math.max(1, page - maxPaginationLinks / 2); // 시작 페이지
			int endPage = Math.min(startPage + maxPaginationLinks - 1, totalPages); // 끝 페이지

			String hostId = service.getMemberId(id); // 호스트 아이디가 존재하는지 확인
			
			System.out.println(hostId);

			if (hostId != null) {

				List<visit> visitList = service.getVisit(startItem, itemsPerPage);

				model.addAttribute("host", hostId);
				model.addAttribute("sessionId", sessionId);
				model.addAttribute("member", service.getMember(sessionId));
				model.addAttribute("list", visitList);
				model.addAttribute("totalPages", totalPages);
				model.addAttribute("currentPage", page);
				model.addAttribute("startPage", startPage);
				model.addAttribute("endPage", endPage);

			} else {
				return "error"; // 없는 페이지일 경우 에러페이지로 이동
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

		visit editVisit = new visit(dto.getV_num(), dto.getV_text(), dto.getV_time(), dto.getV_hostId(), dto.getV_guestId());

		try {
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
