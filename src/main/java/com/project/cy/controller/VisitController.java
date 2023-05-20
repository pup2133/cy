package com.project.cy.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
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
	public String visit(Model model, String id, HttpSession session) {
		try {

			String hostId = dao.findMemberId(id);
			
			session.setAttribute("sessionId", "yun2");
			String sessionId = (String) session.getAttribute("sessionId");

			if (hostId != null) {

				List<visit> result = dao.selectVisit();

				model.addAttribute("member", dao.select(sessionId));
				model.addAttribute("list", result);
				model.addAttribute("host", hostId);
				model.addAttribute("sessionId", sessionId);

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
	public String commentUpdate(visit v) {

		visit vi = new visit(v.getV_num(), v.getV_text(), v.getV_time(), v.getV_hostId(), v.getV_guestId());		
		String host = v.getV_hostId();

		try {
			dao.update(vi);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return "s";

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
