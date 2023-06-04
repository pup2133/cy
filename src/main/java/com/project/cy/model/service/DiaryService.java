package com.project.cy.model.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.cy.model.dao.DiaryRepository;
import com.project.cy.model.dto.DiaryCommentDTO;
import com.project.cy.model.dto.DiaryDTO;

@Service
public class DiaryService implements DiaryServiceImp{
	
	DiaryRepository dao;
	
	@Autowired
	public void setDao(DiaryRepository dao) {
		this.dao = dao;
	}

	@Override
	public DiaryDTO selectDiary(String id, String days) throws Exception {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("m_id", id);
		map.put("d_date", days);
		return dao.selectDiary(map);
	}

	@Override
	public List<DiaryCommentDTO> selectDiaryComment(String id, String days, int startItem, int itemsPerPage) throws Exception {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("m_id", id);
		map.put("d_date", days);
		map.put("startItem",startItem);
		map.put("itemsPerPage",itemsPerPage);
		return dao.selectDiaryComment(map);
	}

	@Override
	public int insertDiaryComment(DiaryCommentDTO dc) {
		return dao.insertDiaryComment(dc);
	}

	@Override
	public int updateComment(DiaryCommentDTO dc) {
		return dao.updateComment(dc);
	}

	@Override
	public int deleteComment(String dc_num) {
		return dao.deleteComment(dc_num);
	}

	@Override
	public int insertDiary(DiaryDTO d) {
		return dao.insertDiary(d);
	}

	@Override
	public int updateText(String d_num, String d_text) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("d_num", d_num);
		map.put("d_text", d_text);
		return dao.updateText(map);
	}

	@Override
	public int deleteText(String d_num) {
		return dao.deleteText(d_num);
	}

	@Override
	public int selectDiaryCommentCount(String id, String days) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("m_id", id);
		map.put("d_date", days);
		return dao.selectDiaryCommentCount(map);
	}
	
	@Override
	public List<DiaryDTO> selectDiary2(String id) {
		return dao.selectDiary2(id);
	}
	
}
