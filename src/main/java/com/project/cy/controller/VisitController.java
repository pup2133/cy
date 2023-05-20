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

@Controller
public class VisitController {

	visitRepository dao;

	@Autowired
	public VisitController(visitRepository dao) {
		this.dao = dao;
	}

	@GetMapping("visit")
	public String visit(@RequestParam(defaultValue = "1") int page, Model model, String id, HttpSession session) {

		try {
			int totalCount = dao.getTotalCount();
			int itemsPerPage = 4; // 페이지당 데이터 개수
			int totalPages = (int) Math.ceil((double) totalCount / itemsPerPage); // 총 페이지 수

			int startItem = (page - 1) * itemsPerPage; // 조회 시작 위치
			// int endItem = startItem + itemsPerPage - 1; // 조회 끝 위치

			int maxPaginationLinks = 5; // 보여줄 링크 개수 제한
			int startPage = Math.max(1, page - maxPaginationLinks / 2);
			int endPage = Math.min(startPage + maxPaginationLinks - 1, totalPages);

			String hostId = dao.findMemberId(id);

			session.setAttribute("sessionId", "yun2");
			String sessionId = (String) session.getAttribute("sessionId");

			if (hostId != null) {

				List<visit> result = dao.selectVisit(startItem, itemsPerPage);

				model.addAttribute("member", dao.select(sessionId));
				model.addAttribute("list", result);
				model.addAttribute("host", hostId);
				model.addAttribute("sessionId", sessionId);
				model.addAttribute("totalPages", totalPages);
				model.addAttribute("currentPage", page);
				model.addAttribute("startPage", startPage);
				model.addAttribute("endPage", endPage);

			} else {
				return "error";
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return "visit";
	}

	@PostMapping("visit/Reg")
	public String visitReg(visit v) {

		String host = v.getV_hostId();

		try {
			visit vi = new visit(v.getV_text(), v.getV_hostId(), v.getV_guestId());
			dao.insert(vi);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:/visit?id=" + host;
	}

	@PostMapping("visit/commentUpdate")
	@ResponseBody
	public Boolean commentUpdate(visit v) {
		
		visit vi = new visit(v.getV_num(), v.getV_text(), v.getV_time(), v.getV_hostId(), v.getV_guestId());
		
		try {
			dao.update(vi);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return true;

	}

	@PostMapping("visit/delete")
	public String commentDelete(String v_num, String hOr) {

		try {
			dao.delete(v_num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:/visit?id=" + hOr;

	}

}
