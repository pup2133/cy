package com.project.cy.model.dao;

import java.util.HashMap;
import java.util.List;

import com.project.cy.model.dto.DiaryCommentDTO;
import com.project.cy.model.dto.DiaryDTO;

public interface DiaryRepositoryImp {
	public DiaryDTO selectDiary(HashMap<String, Object> map) throws Exception;

	public List<DiaryCommentDTO> selectDiaryComment(HashMap<String, Object> map) throws Exception;
	
	public int insertDiaryComment(DiaryCommentDTO dc);

	public int updateComment(DiaryCommentDTO dc);

	public int deleteComment(String dc_num);
	
	public int insertDiary(DiaryDTO d);
	
	public int updateText(HashMap<String, Object> map);
	
	public int deleteText(String d_num);
	
	public int selectDiaryCommentCount(HashMap<String, Object> map);
	
	public List<DiaryDTO> selectDiary2(String id);

}
