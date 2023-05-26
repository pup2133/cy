package com.project.cy.model.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.cy.model.dto.HomeSettingDTO;

@Repository
public class HomeSettingRepository {
	
	@Autowired
	private SqlSession session;
	private String namespace = "com.project.cy.homesettingMapper.";
	
	public List<HomeSettingDTO> getsetting(String m_id){
		return session.selectList(namespace+"getsetting", m_id);
	}
	
	// 설정 업데이트
	public int updatesetting(HomeSettingDTO dto) {
		return session.update(namespace+"updatesetting", dto);
	}
	
}
