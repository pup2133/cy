package com.project.cy.model.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.cy.model.dto.DiaryCommentDTO;
import com.project.cy.model.dto.DiaryDTO;

@Repository
public class DiaryRepository implements DiaryRepositoryImp{

	@Autowired
	private SqlSession session;
	
	private static String namespace = "com.project.diaryMapper.";
	
	@Override
	public List<DiaryDTO> selectDiary(HashMap<String, String> map) throws Exception {
		return session.selectList(namespace + "selectDiary", map);
	}

	@Override
	public List<DiaryCommentDTO> selectDiaryComment(HashMap<String, String> map) throws Exception {
		return session.selectList(namespace + "selectDiaryComment", map);
	}

	@Override
	public int insertDiaryComment(DiaryCommentDTO dc) {
		return session.insert(namespace + "insertDiaryComment", dc);
	}

	@Override
	public int updateComment(DiaryCommentDTO dc) {
		return session.update(namespace + "updateDiaryComment", dc);
	}

	@Override
	public int deleteComment(String dc_num) {
		return session.delete(namespace + "deleteDiaryComment", dc_num);
	}

	@Override
	public int insertDiary(DiaryDTO d) {
		return session.insert(namespace + "insertDiary", d);
	}

	@Override
	public int updateText(HashMap<String, Object> map) {
		return session.update(namespace + "updateDiaryText", map);
	}

	@Override
	public int deleteText(String d_num) {
		return session.delete(namespace + "deleteDiaryText", d_num);
	}
}