package com.project.cy.model.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.cy.model.dao.ProfileRepository;
import com.project.cy.model.dto.ProfileDTO;

@Service
public class ProfileService implements ProfileServiceImp{
	
	ProfileRepository dao;
	
	@Autowired
	public void setDao(ProfileRepository dao) {
		this.dao = dao;
	}

	@Override
	public ProfileDTO selectProfile(String m_id) throws Exception {
		return dao.selectProfile(m_id);
	}
	
	@Override
	public int updateProfile1(Map<String, String> map) {
		return dao.updateProfile1(map);
	}
	
	@Override
	public int updateProfile2(Map<String, String> map) {
		return dao.updateProfile2(map);
	}
	
	@Override
	public int updateProfile3(Map<String, String> map) {
		return dao.updateProfile3(map);
	}
}
