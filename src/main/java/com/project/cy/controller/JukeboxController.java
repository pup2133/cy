package com.project.cy.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.project.cy.model.dao.JukeboxRepository;
import com.project.cy.model.dao.JukeboxStoreRepository;
import com.project.cy.model.dto.JukeboxDTO;

@Controller
public class JukeboxController {
	
	@Autowired
	JukeboxStoreRepository dao;
	
	@Autowired
	JukeboxRepository dao2;

	
	@GetMapping("/jukestore")
	public String getMusicList(Model model) {
		model.addAttribute("musiclist",dao.All());
		return "jukestore";
	}
	
	@RequestMapping("/buymusic")
	public void buyMusic( ) {		
		//아이디 세션 가져오기
		//String m_id = session.getId();
		String m_id = "dd";  //임시
		//뮤직코드 가져오기
		String mu_code = "a02";
		
		JukeboxDTO dto = new JukeboxDTO();
		dto.setMu_code(mu_code);
		dto.setM_id(m_id);
		dao2.insert(dto);
	}
	
}
