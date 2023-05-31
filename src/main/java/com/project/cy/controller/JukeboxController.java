package com.project.cy.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
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

import com.project.cy.model.dao.HomeRepository;
import com.project.cy.model.dao.JukeboxRepository;
import com.project.cy.model.dto.JukeboxDTO;
import com.project.cy.model.dto.JukeboxStoreDTO;
import com.project.cy.model.dto.MyjukeDTO;
import com.project.cy.service.JukeboxService;

@Controller
public class JukeboxController{
	
	@Autowired
	JukeboxService service;
	
	@Autowired
	HomeRepository homedao;

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
		System.out.println("찾는 단어:"+search_word+" 찾는 범위:"+search_select);
		System.out.println(service.AllSearch(search_select ,search_word));
		return service.AllSearch(search_select ,search_word);
	}
	//음악구매
	@PostMapping("/buymusic")
	public void buyMusic(@RequestParam("mu_code") String mu_code, HttpSession session) {		
		// 임시 세션 아이디
		session.setAttribute("sessionId", "dd");
		String sessionId = (String) session.getAttribute("sessionId");
		//뮤직코드 가져오기
		//String mu_code = "a02";
		
		JukeboxDTO dto = new JukeboxDTO();
		dto.setMu_code(mu_code);
		dto.setM_id(sessionId);
		service.insert(dto);
	}
	
	@PostMapping("/checkDuplicatePurchase")
	@ResponseBody
	public String checkDuplicatePurchase(@RequestParam("mu_code") String mu_code, HttpSession session) {
		System.out.println(mu_code);
		// 임시 세션 아이디
		session.setAttribute("sessionId", "dd");
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
		// 임시 세션 아이디
		session.setAttribute("sessionId", "dd");
		String sessionId = (String) session.getAttribute("sessionId");
		
		//호스트 아이디 검사
		String hostId = service.getMemberId(id);
		
		System.out.println(sessionId);
		System.out.println(id);
		if(hostId!=null) {
			model.addAttribute("hostId",hostId);
			model.addAttribute("sessionId",sessionId);
			model.addAttribute("mylist",service.getMyjuke(hostId));
			model.addAttribute("myplay",service.getMyplay(hostId));
			List<MyjukeDTO> list =  homedao.getPlay(hostId);
			ArrayList<String> urllist = new ArrayList<>();
			ArrayList<String> titlelist = new ArrayList<>();
			for(MyjukeDTO item: list) {
				System.out.println(item.getMu_url());
				urllist.add(item.getMu_url());
				titlelist.add(item.getMu_title());
			}
			model.addAttribute("urllist",urllist);
			model.addAttribute("titlelist",titlelist);
			
		}else {
			return "error";
		}
		
		//System.out.println(model.addAttribute("mylist",dao.getMyjuke(m_id)));
		return "myjuke";
	}
	
	//sessionId와 hostId가 같아야 보이는 기능들 /host따로 받을 필요없음
	//플레이리스트 추가
	@PostMapping("/addPlaylist")
	@ResponseBody
	public List<MyjukeDTO> addPlaylist(@RequestParam("mu_code") String mu_code, HttpSession session){
		// 임시 세션 아이디
		session.setAttribute("sessionId", "dd");
		String sessionId = (String) session.getAttribute("sessionId");
		
		service.addPlay(sessionId, mu_code);
		System.out.println(service.getMyplay(sessionId));
		return service.getMyplay(sessionId);
	}
	//플레이리스트 제거
	@PostMapping("/subPlaylist")
	@ResponseBody
	public List<MyjukeDTO> subPlaylist(@RequestParam("pl_code") int pl_code, HttpSession session){
		// 임시 세션 아이디
		session.setAttribute("sessionId", "dd");
		String sessionId = (String) session.getAttribute("sessionId");
		
		service.subPlay(sessionId, pl_code);
		System.out.println(service.getMyplay(sessionId));
		return service.getMyplay(sessionId);
	}
	
}
