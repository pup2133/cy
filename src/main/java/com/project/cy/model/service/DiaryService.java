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
	public DiaryDTO selectDiary(HashMap<String, Object> map) throws Exception {
		return dao.selectDiary(map);
	}

	@Override
	public List<DiaryCommentDTO> selectDiaryComment(HashMap<String, Object> map) throws Exception {
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
	public int updateText(HashMap<String, Object> map) {
		return dao.updateText(map);
	}

	@Override
	public int deleteText(String d_num) {
		return dao.deleteText(d_num);
	}

	@Override
	public int selectDiaryCommentCount(HashMap<String, Object> map) {
		return dao.selectDiaryCommentCount(map);
	}
}
