package com.project.cy.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.cy.model.dao.JukeboxStoreRepository;
import com.project.cy.model.dto.JukeboxDTO;

@Controller
public class JukeboxController{
	
	@Autowired
	JukeboxStoreRepository dao;

	
	@GetMapping("/jukestore")
	public String getMusicList(Model model) {
		model.addAttribute("musiclist",dao.All());
		return "jukestore";
	}
	
	@PostMapping("/buymusic")
	public void buyMusic(@RequestParam("mu_code") String mu_code) {		
		//아이디 세션 가져오기
		//String m_id = session.getId();
		String m_id = "dd";  //임시
		//뮤직코드 가져오기
		//String mu_code = "a02";
		
		JukeboxDTO dto = new JukeboxDTO();
		dto.setMu_code(mu_code);
		dto.setM_id(m_id);
		dao.insert(dto);
	}
	
}
