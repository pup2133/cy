package com.project.cy.model.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.cy.model.dto.DiaryCommentDTO;
import com.project.cy.model.dto.DiaryDTO;

@Repository
public class DiaryRepository {

	@Autowired
	private SqlSession session;
	
	private static String namespace = "com.project.diaryMapper.";

	public List<DiaryDTO> selectDiary(String m_id) throws Exception {
		return session.selectList(namespace + "selectDiary", m_id);
	}

	public List<DiaryCommentDTO> selectDiaryComment() throws Exception {
		return session.selectList(namespace + "selectDiaryComment");
	}
	
	public int insertDiaryComment(DiaryCommentDTO dc) {
		return session.insert(namespace + "insertDiaryComment", dc);
	}

	public int updateComment(DiaryCommentDTO dc) {
		return session.update(namespace + "updateDiaryComment", dc);
	}

	public int deleteComment(String dc_num) {
		return session.delete(namespace + "deleteDiaryComment", dc_num);
	}
	
	public int insertDiary(DiaryDTO d) {
		return session.insert(namespace + "insertDiary", d);
	}
	
	public int updateText(HashMap<String, Object> map) {
		return session.update(namespace + "updateDiaryText", map);
	}
	
	public int deleteText(String d_num) {
		return session.delete(namespace + "deleteDiaryText", d_num);
	}
}