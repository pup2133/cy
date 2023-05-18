package com.project.cy.controller;

import java.util.Collections;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.project.cy.model.dao.visitRepository;
import com.project.cy.model.dto.visit;

@Controller
public class VisitController {
	
	@Autowired
	visitRepository dao;
	
	@GetMapping("visit")
	public String visit(Model model, String id) {
		try {
			String hg = dao.findMemberId(id);
			
			if(hg != null) {
				System.out.println(dao.select(id));
				System.out.println(dao.selectVisit());
				
				List<visit> result = dao.selectVisit();
				Collections.reverse(result);
				model.addAttribute("member",dao.select(id));
				model.addAttribute("list", result);
				model.addAttribute("host",hg);
			}else {
				return "home";
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "visit";
	}

   @PostMapping("visit/Reg")
	public String visitReg(visit v){
		try {
			visit vi = new visit(v.getV_text(),v.getV_hostId(),v.getV_guestId());
			dao.insert(vi);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "redirect:/visit";
	}
}
