package com.project.cy.controller;

import java.util.Collections;
import java.util.List;

import javax.servlet.http.HttpSession;

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
	public String visit(Model model, String id, HttpSession session) {
		try {
			String hg = dao.findMemberId(id);
			session.setAttribute("sId", "yun");
			
			
			String sid = (String) session.getAttribute("sId");
			
			System.out.println(sid);
			
			if(hg != null) {
				
				List<visit> result = dao.selectVisit();
				Collections.reverse(result);
				
				model.addAttribute("member",dao.select(sid));
				model.addAttribute("list", result);
				model.addAttribute("host",hg);
				model.addAttribute("sid",sid);
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
			e.printStackTrace();
		}
		return "redirect:/visit?id=yun";
	}
   
   @PostMapping("visit/commentUpdate")
   public String commentUpdate(visit v) {
	   
	   visit vi = new visit(v.getV_num(),v.getV_text(),v.getV_time(),v.getV_hostId(),v.getV_guestId());
	 
	   try {
		dao.update(vi);
	} catch (Exception e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	   
	   return "redirect:/visit?id=yun";
	   
   }
   
   @PostMapping("visit/delete")
   public String commentDelete(String v_num) {
	   try {
		dao.delete(v_num);
	} catch (Exception e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	   return "redirect:/visit?id=yun";
	   
   }
   
}
