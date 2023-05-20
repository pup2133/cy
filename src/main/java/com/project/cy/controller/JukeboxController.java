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

	//--주크박스 상점--
	@GetMapping("/jukestore")
	public String getMusicList(Model model) {
		model.addAttribute("musiclist",dao.All());
		return "jukestore";
	}
	//음악검색
	@PostMapping("/jukesearch")
	@ResponseBody
	public List<JukeboxStoreDTO> getMusicList(Model model,@RequestParam("mu_artist") String mu_artist) {
		return dao.AllSearch(mu_artist);
	}
	//음악구매
	@PostMapping("/buymusic")
	public void buyMusic(@RequestParam("mu_code") String mu_code) {		
		//아이디 세션 가져오기 - 매개변수에 httprequest추가해서 가져오기
		//String m_id = session.getId();
		String m_id = "dd";  //임시
		//뮤직코드 가져오기
		//String mu_code = "a02";
		
		JukeboxDTO dto = new JukeboxDTO();
		dto.setMu_code(mu_code);
		dto.setM_id(m_id);
		dao.insert(dto);
	}

	//--마이 주크박스--
	@GetMapping("/myjuke")
	public String getMyjuke(Model model) {
		//아이디 세션 가져오기
		//String m_id = session.getId();
		String m_id = "dd";  //임시
		model.addAttribute("mylist",dao.getMyjuke(m_id));
		//System.out.println(model.addAttribute("mylist",dao.getMyjuke(m_id)));
		return "myjuke";
	}
	
	//플레이리스트 추가
//	@GetMapping("/addPlaylist")
//	public List<MyjukeDTO> addPlaylist(){
//		//해당되는 리스트 no으로 가져오기
//		//no이 0 이면 1로 바꿔주고 1이면 그냥 두기
//		//
//		return ;
//		
//	}
	
	

	
}
