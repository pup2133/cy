package com.project.cy.model.service;

import java.util.List;

import com.project.cy.model.dto.DiaryCommentDTO;
import com.project.cy.model.dto.DiaryDTO;

public interface DiaryServiceImp {
	public DiaryDTO selectDiary(String id, String days) throws Exception;

	public List<DiaryCommentDTO> selectDiaryComment(String id, String days, int startItem, int itemsPerPage) throws Exception;
	
	public int insertDiaryComment(DiaryCommentDTO dc);

	public int updateComment(DiaryCommentDTO dc);

	public int deleteComment(String dc_num);
	
	public int insertDiary(DiaryDTO d);
	
	public int updateText(String d_num, String d_text);
	
	public int deleteText(String d_num);
	
	public int selectDiaryCommentCount(String id, String days);
	
	public List<DiaryDTO> selectDiary2(String id);

}
