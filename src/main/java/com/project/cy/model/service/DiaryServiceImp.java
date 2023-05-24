package com.project.cy.model.service;

import java.util.HashMap;
import java.util.List;

import com.project.cy.model.dto.DiaryCommentDTO;
import com.project.cy.model.dto.DiaryDTO;

public interface DiaryServiceImp {
	public List<DiaryDTO> selectDiary(String m_id) throws Exception;

	public List<DiaryCommentDTO> selectDiaryComment() throws Exception;
	
	public int insertDiaryComment(DiaryCommentDTO dc);

	public int updateComment(DiaryCommentDTO dc);

	public int deleteComment(String dc_num);
	
	public int insertDiary(DiaryDTO d);
	
	public int updateText(HashMap<String, Object> map);
	
	public int deleteText(String d_num);
}
