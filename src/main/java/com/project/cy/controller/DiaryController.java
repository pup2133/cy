package com.project.cy.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
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
			
			session.setAttribute("hostId", id);
			session.setAttribute("selectDay", days);

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
		DiaryCommentDTO dc = new DiaryCommentDTO(d_num, m_id, dc_text);

		service.insertDiaryComment(dc);

		return "redirect:/diary?id="+m_id+"&days=" + d_date;
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
	@PostMapping("diary_reg")
	public void post_diary_reg(HttpSession session, @RequestParam("d_text") String d_text, HttpServletResponse response) {
		String m_id = (String) session.getAttribute("sessionId");
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		Calendar c1 = Calendar.getInstance();
		String strToday = sdf.format(c1.getTime());
	
		DiaryDTO d = new DiaryDTO(m_id, d_text);

		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}

		try {
			service.insertDiary(d);
		} catch (Exception e) {
			out.write("<script>alert('이미 등록되어 있습니다.'); location.href='diary?id=" + m_id + "&days=" + strToday + "';</script>");
			out.flush();
			out.close();
		}
		System.out.println(strToday);
		out.write("<script>location.href='diary?id=" + m_id + "&days=" + strToday + "';</script>");
		out.flush();
		out.close();
	}

	// 다이어리 수정
	@PostMapping("diary/textUpdate")
	public void textUpdate(@RequestParam("d_num") String d_num, @RequestParam("d_text") String d_text, String id) {

		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("d_num", d_num);
		map.put("d_text", d_text);

		service.updateText(map);

	}

	@PostMapping("diary/textDelete")
	public void textUpdate(@RequestParam("d_num") String d_num) {

		service.deleteText(d_num);
	}
}
