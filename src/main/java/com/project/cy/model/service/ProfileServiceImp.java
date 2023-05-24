package com.project.cy.model.service;

import java.util.Map;

import com.project.cy.model.dto.ProfileDTO;

public interface ProfileServiceImp {
	public ProfileDTO selectProfile(String m_id) throws Exception;

	public int updateProfile1(Map<String, String> map);
	
	public int updateProfile2(Map<String, String> map);
}
