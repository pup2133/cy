package com.project.cy.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.cy.model.dto.ProfileDTO;

@Repository
public class ProfileRepository {

	@Autowired
	private SqlSession session;

	private static String namespace = "com.project.profileMapper.";
	
	public ProfileDTO selectProfile(String m_id) throws Exception {
		return session.selectOne(namespace + "selectProfile", m_id);
	}
	
	public int updateProfile1(Map<String, String> map) {
		return session.update(namespace + "updateProfile1", map);
	}
	
	public int updateProfile2(Map<String, String> map) {
		return session.update(namespace + "updateProfile2", map);
	}
}
