package com.project.cy.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.project.cy.model.dao.DiaryRepository;
import com.project.cy.model.dto.DiaryCommentDTO;
import com.project.cy.model.dto.DiaryDTO;

@Controller
public class DiaryController {
	
	@Autowired
	DiaryRepository dao;

	@GetMapping("diary")
	public String diary(Model model, String m_id) {
		try {
			ArrayList<DiaryDTO> list = (ArrayList<DiaryDTO>) dao.selectDiary(m_id);
			System.out.println(list.size());
			
			ArrayList<DiaryCommentDTO> listC = (ArrayList<DiaryCommentDTO>) dao.selectDiaryComment(m_id);
			System.out.println(listC.size());
			
			for(DiaryCommentDTO dc : listC)
				System.out.println(dc);
			
			model.addAttribute("list", list);
			model.addAttribute("listC", listC);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "diary";
	}
}
