package com.project.cy.model.service;

import com.project.cy.model.dto.HomeSettingDTO;

public interface HomeSettingServiceImp {

	HomeSettingDTO getsetting(String id);
	
	int updatesetting(HomeSettingDTO dto);
	
}
