package com.project.cy.controller;

import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.cy.model.dto.DiaryCommentDTO;
import com.project.cy.model.dto.DiaryDTO;
import com.project.cy.model.service.DiaryService;
import com.project.cy.util.pagination;

@Controller
public class DiaryController {

	DiaryService service;

	@Autowired
	public void setService(DiaryService service) {
		this.service = service;
	}

	@GetMapping("diary")
	public String diary(Model model, String id, String days, HttpSession session, @RequestParam(defaultValue = "1") int page) {
		try {

			
			DiaryDTO diary = (DiaryDTO) service.selectDiary(id,days);

			pagination p = new pagination();
			int totalCount = service.selectDiaryCommentCount(id,days);

			Map<String, Integer> pagination = p.pagination(totalCount, page, 10);
			ArrayList<DiaryCommentDTO> diaryComment = (ArrayList<DiaryCommentDTO>) service.selectDiaryComment(id,days,pagination.get("startItem"),pagination.get("itemsPerPage"));

			model.addAttribute("totalPages", pagination.get("totalPages"));
			model.addAttribute("currentPage", page);
			model.addAttribute("startPage", pagination.get("startPage"));
			model.addAttribute("endPage", pagination.get("endPage"));
			model.addAttribute("diary", diary);
			model.addAttribute("diaryComment", diaryComment);
			model.addAttribute("totalCount", totalCount);
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}

		return "diary";
	}

	// 댓글 등록
	@PostMapping("diary/commentReg")
	public String commentReg(String d_num, String d_date, String dc_text, HttpSession session) {
		
		String m_id = (String) session.getAttribute("sessionId");
		String id = (String) session.getAttribute("hostId");
		DiaryCommentDTO dc = new DiaryCommentDTO(d_num, m_id, dc_text);
		service.insertDiaryComment(dc);

		return "redirect:/diary?id="+id+"&days=" + d_date;
	}

	// 댓글 수정
	@PostMapping("diary/commentUpdate")
	public void commentUpdate(@RequestParam("dc_num") String dc_num, @RequestParam("dc_text") String dc_text, Model model, String id) {

		DiaryCommentDTO dc = new DiaryCommentDTO(dc_num, dc_text);
		service.updateComment(dc);

	}

	// 댓글 삭제
	@PostMapping("diary/commentDelete")
	public void commentDelete(Model model, @RequestParam("dc_num") String dc_num, String id) {

		service.deleteComment(dc_num);
	}

	// 다이어리 등록 페이지 이동
	@GetMapping("diary_reg")
	public String diary_reg() {
		return "diary_reg";
	}

	// 다이어리 등록
	@RequestMapping(value = "diary_reg", method = RequestMethod.POST, produces = "application/text; charset=UTF-8")
	public String post_diary_reg(HttpSession session, @RequestParam("d_text") String d_text, HttpServletResponse response) {
		String m_id = (String) session.getAttribute("sessionId");
		String strToday = (String) session.getAttribute("days");
	
		DiaryDTO d = new DiaryDTO(m_id, d_text);

		service.insertDiary(d);

		return "redirect:/diary?id="+m_id+"&days="+strToday;
		
	}

	// 다이어리 수정
	@PostMapping("diary/textUpdate")
	public void textUpdate(@RequestParam("d_num") String d_num, @RequestParam("d_text") String d_text, String id) {
		service.updateText(d_num,d_text);
	}

	@PostMapping("diary/textDelete")
	public void textUpdate(@RequestParam("d_num") String d_num) {
		service.deleteText(d_num);
	}
}
