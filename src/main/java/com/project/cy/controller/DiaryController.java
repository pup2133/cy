package com.project.cy.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.http.HttpRequest;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.cy.model.dao.DiaryRepository;
import com.project.cy.model.dto.DiaryCommentDTO;
import com.project.cy.model.dto.DiaryDTO;

@Controller
public class DiaryController {

	@Autowired
	DiaryRepository dao;

	ArrayList<DiaryDTO> list;
	ArrayList<DiaryCommentDTO> listC;
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyymmdd");
	Calendar c1 = Calendar.getInstance();
	String strToday = sdf.format(c1.getTime());

	@GetMapping("diary")
	public String diary(Model model, String m_id, HttpSession session) {
		try {
			session.setAttribute("sessionId", "rhkddlf");
			session.setAttribute("today", strToday);

			list = (ArrayList<DiaryDTO>) dao.selectDiary(m_id);

			listC = (ArrayList<DiaryCommentDTO>) dao.selectDiaryComment();

			model.addAttribute("list", list);
			model.addAttribute("listC", listC);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		

		return "diary";
	}

	@PostMapping("diary/commentUpdate")
	public String commentUpdate(@RequestParam("dc_num") String dc_num, @RequestParam("dc_text") String dc_text, Model model, String m_id) {

		DiaryCommentDTO dc = new DiaryCommentDTO(dc_num, dc_text);

		dao.updateComment(dc);

		try {
			listC = (ArrayList<DiaryCommentDTO>) dao.selectDiaryComment();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		model.addAttribute("listC", listC);

		return "redirect:/diary?m_id=rhkddlf";
	}

	@PostMapping("diary/commentDelete")
	public String commentDelete(Model model, @RequestParam("dc_num") String dc_num, String m_id) {

		dao.deleteComment(dc_num);

		ArrayList<DiaryCommentDTO> del_list = new ArrayList<DiaryCommentDTO>();
		for (DiaryCommentDTO l : listC) {
			if (dc_num.equals(l.getD_num())) {
				del_list.add(l);
			}
		}

		try {
			listC = (ArrayList<DiaryCommentDTO>) dao.selectDiaryComment();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		model.addAttribute("listC", listC);

		return "redirect:/diary?m_id=rhkddlf";
	}

	@GetMapping("diary_reg")
	public String diary_reg() {
		return "diary_reg";
	}

	@PostMapping("diary_reg")
	public void post_diary_reg(HttpSession session, @RequestParam("d_text") String d_text, HttpServletResponse response) {
		String m_id = (String) session.getAttribute("sessionId");

		DiaryDTO d = new DiaryDTO(m_id, d_text);

		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}

		try {
			dao.insertDiary(d);
		} catch (Exception e) {
			out.write("<script>alert('이미 등록되어 있습니다.'); location.href='diary?m_id=rhkddlf&days="+strToday+"';</script>");
			out.flush();
			out.close();
		}

		out.write("<script>alert('등록완료!'); location.href='diary?m_id=rhkddlf&days=\"+strToday+\"';</script>");
		out.flush();
		out.close();
	}

	@PostMapping("diary/commentReg")
	public String commentReg(String d_num, String d_date, String dc_text, HttpSession session) {
		String m_id = (String) session.getAttribute("sessionId");
		DiaryCommentDTO dc = new DiaryCommentDTO(d_num, m_id, dc_text);

		dao.insertDiaryComment(dc);

		return "redirect:/diary?m_id=rhkddlf&days=" + d_date;
	}

	// 글 수정
	@PostMapping("diary/textUpdate")
	public void textUpdate(@RequestParam("d_num") String d_num, @RequestParam("d_text") String d_text, String m_id) {

		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("d_num", d_num);
		map.put("d_text", d_text);

		dao.updateText(map);

	}
}
