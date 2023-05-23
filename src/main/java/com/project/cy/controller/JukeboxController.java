package com.project.cy.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
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
	
	@PostMapping("/checkDuplicatePurchase")
	@ResponseBody
	public String checkDuplicatePurchase(@RequestParam("mu_code") String mu_code) {
		System.out.println(mu_code);
		//아이디 세션 가져오기
		//String m_id = session.getId();
		String m_id = "dd";  //임시
		String isDu = "false";
		ArrayList<MyjukeDTO> mylist = (ArrayList<MyjukeDTO>) dao.getMyjuke(m_id);
		for(Object item:mylist) {
			if(((MyjukeDTO)item).getMu_code().equals(mu_code)) {
				isDu="true";
			}
		}
		return isDu;
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
	//sessionId와 hostId가 같아야 보이는 기능들 /host따로 받을 필요없음
	//플레이리스트 추가
	@PostMapping("/addPlaylist")
	@ResponseBody
	public List<MyjukeDTO> addPlaylist(@RequestParam("mu_code") String mu_code){
		//아이디 세션 가져오기
		//String m_id = session.getId();
		String m_id = "dd";  //임시
		dao.addPlay(m_id, mu_code);
		System.out.println(dao.getMyjuke(m_id));
		return dao.getMyjuke(m_id);
	}
	//플레이리스트 제거
	@PostMapping("/subPlaylist")
	@ResponseBody
	public List<MyjukeDTO> subPlaylist(@RequestParam("mu_code") String mu_code){
		//아이디 세션 가져오기
		//String m_id = session.getId();
		String m_id = "dd";  //임시
		dao.subPlay(m_id, mu_code);
		System.out.println(dao.getMyjuke(m_id));
		return dao.getMyjuke(m_id);
	}
	
}
