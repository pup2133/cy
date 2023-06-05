package com.project.cy.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.cy.model.dao.HomeRepository;
import com.project.cy.model.dto.JukeboxDTO;
import com.project.cy.model.dto.JukeboxStoreDTO;
import com.project.cy.model.dto.MyjukeDTO;
import com.project.cy.model.service.JukeboxService;

@Controller
public class JukeboxController{
	
	JukeboxService service;
	
	HomeRepository homedao;
	
	@Autowired
	public JukeboxController(JukeboxService service, HomeRepository homedao) {
		super();
		this.service = service;
		this.homedao = homedao;
	}
	
	//--주크박스 상점--
	@GetMapping("/jukestore")
	public String getMusicList(Model model) {
		model.addAttribute("musiclist",service.All());
		return "jukestore";
	}
	//음악검색
	@PostMapping("/jukesearch")
	@ResponseBody
	public List<JukeboxStoreDTO> getMusicList(Model model, String search_word, String search_select) {
		return service.AllSearch(search_select ,search_word);
	}
	//음악구매
	@PostMapping("/buymusic")
	public void buyMusic(@RequestParam("mu_code") String mu_code, HttpSession session) {		
		//세션 아이디
		String sessionId = (String) session.getAttribute("sessionId");
		
		JukeboxDTO dto = new JukeboxDTO();
		dto.setMu_code(mu_code);
		dto.setM_id(sessionId);
		service.insert(dto);
	}
	
	@PostMapping("/checkDuplicatePurchase")
	@ResponseBody
	public String checkDuplicatePurchase(@RequestParam("mu_code") String mu_code, HttpSession session) {
		// 세션 아이디
		String sessionId = (String) session.getAttribute("sessionId");
		String isDu = "false";
		ArrayList<MyjukeDTO> mylist = (ArrayList<MyjukeDTO>) service.getMyjuke(sessionId);
		
		for(Object item:mylist) {
			if(((MyjukeDTO)item).getMu_code().equals(mu_code)) {
				isDu="true";
			}
		}
		return isDu;
	}

	//--마이 주크박스--
	@GetMapping("/myjuke")
	public String getMyjuke(Model model,String id, HttpSession session) {
		
		if(id!=null) {
			model.addAttribute("mylist",service.getMyjuke(id));
			model.addAttribute("myplay",service.getMyplay(id));

		}else {
			return "redirect:/error";
		}
		
		return "myjuke";
	}
	
	//sessionId와 hostId가 같아야 보이는 기능들 /host따로 받을 필요없음
	//플레이리스트 추가
	@PostMapping("/addPlaylist")
	@ResponseBody
	public List<MyjukeDTO> addPlaylist(@RequestParam("mu_code") String mu_code, HttpSession session){
		//세션 아이디
		String sessionId = (String) session.getAttribute("sessionId");
		
		service.addPlay(sessionId, mu_code);
		return service.getMyplay(sessionId);
	}
	//플레이리스트 제거
	@PostMapping("/subPlaylist")
	@ResponseBody
	public List<MyjukeDTO> subPlaylist(@RequestParam("pl_code") int pl_code, HttpSession session){
		//세션 아이디
		String sessionId = (String) session.getAttribute("sessionId");
		
		service.subPlay(sessionId, pl_code);
		return service.getMyplay(sessionId);
	}
	
}
