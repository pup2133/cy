package com.project.cy.model.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.cy.model.dto.HomeSettingDTO;

@Repository
public class HomeSettingRepository {
	
	@Autowired
	private SqlSession session;
	private String namespace = "com.project.cy.homesettingMapper.";
	
	// 홈 배너 공개,비공개 설정 가져오기
	public HomeSettingDTO getsetting(String id){
		return session.selectOne(namespace+"getsetting", id);
	}
	
	
	// 홈 배너 공개,비공개 설정 업데이트
	public int updatesetting(HomeSettingDTO dto) {
		return session.update(namespace+"updatesetting", dto);
	}
	
	
}
