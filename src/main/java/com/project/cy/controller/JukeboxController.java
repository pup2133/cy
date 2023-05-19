package com.project.cy.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.cy.model.dao.JukeboxStoreRepository;
import com.project.cy.model.dto.JukeboxDTO;
import com.project.cy.model.dto.JukeboxStoreDTO;
import com.project.cy.model.dto.MyjukeDTO;

@Controller
public class JukeboxController{
	
	@Autowired
	JukeboxStoreRepository dao;

	@GetMapping("/jukestore")
	public String getMusicList(Model model) {
		model.addAttribute("musiclist",dao.All());
		return "jukestore";
	}
	
	//검색시 나오는 창
	@GetMapping("/jukesearchGet")
	public String getMusicListSearch(Model model,@RequestParam("mu_title") String mu_title) {
		model.addAttribute("musiclist",dao.AllSearch(mu_title));
		return "jukestoreSearch";
	}
	
	@PostMapping("/jukesearch")
	@ResponseBody
	public List<JukeboxStoreDTO> getMusicList(Model model,@RequestParam("mu_title") String mu_title) {
		return dao.AllSearch(mu_title);
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

	@GetMapping("/myjuke")
	public String getMyjuke(Model model) {
		//아이디 세션 가져오기
		//String m_id = session.getId();
		String m_id = "dd";  //임시
		model.addAttribute("mylist",dao.getMyjuke(m_id));
		return "myjuke";
	}
	

	
}
