package com.project.cy.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.cy.model.dao.DiaryRepository;
import com.project.cy.model.dto.DiaryCommentDTO;
import com.project.cy.model.dto.DiaryDTO;

@Controller
public class DiaryController {
	
	@Autowired
	DiaryRepository dao;
	
	ArrayList<DiaryDTO> list;
	ArrayList<DiaryCommentDTO> listC;

	@GetMapping("diary")
	public String diary(Model model, String m_id, HttpSession session) {
		try {
			session.setAttribute("sessionId", "rhkddlf");
			
			list = (ArrayList<DiaryDTO>) dao.selectDiary(m_id);
			
			listC = (ArrayList<DiaryCommentDTO>) dao.selectDiaryComment(m_id);
			System.out.println("삭제후 크기: "+listC.size());			
			
			model.addAttribute("list", list);
			model.addAttribute("listC", listC);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "diary";
	}
	
	@PostMapping("diary/commentUpdate")
	public String commentUpdate(@RequestParam("dc_num") String dc_num, @RequestParam("dc_text") String dc_text) {
		
		DiaryCommentDTO dc = new DiaryCommentDTO(dc_num, dc_text);
		
		dao.updateComment(dc);
	
		return "redirect:/diary?m_id=rhkddlf";
	}
	
	@PostMapping("diary/commentDelete")
	public String commentDelete(Model model,@RequestParam("dc_num") String dc_num, String m_id) {
		
		dao.deleteComment(dc_num);
		
		ArrayList<DiaryCommentDTO> del_list = new ArrayList<DiaryCommentDTO>();
		for(DiaryCommentDTO l : listC) {
			if(dc_num.equals(l.getD_num())) {
				del_list.add(l);
			}
		}
		
		try {
			listC = (ArrayList<DiaryCommentDTO>) dao.selectDiaryComment(m_id);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		model.addAttribute("listC", listC);
		
		return "redirect:/diary?m_id=rhkddlf";
	}

}
