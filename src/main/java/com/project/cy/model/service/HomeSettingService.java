package com.project.cy.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.cy.model.dao.HomeSettingRepository;
import com.project.cy.model.dto.HomeSettingDTO;

@Service
public class HomeSettingService implements HomeSettingServiceImp{

	
	HomeSettingRepository dao;
	
	@Autowired
	public HomeSettingService(HomeSettingRepository dao) {
		super();
		this.dao = dao;
	}
	
	// 홈 배너 공개,비공개 설정 가져오기
	@Override
	public HomeSettingDTO getsetting(String id) {
		return dao.getsetting(id);
	}

	// 홈 배너 공개,비공개 설정 업데이트
	@Override
	public int updatesetting(HomeSettingDTO dto) {
		return dao.updatesetting(dto);
	}


}
