package com.project.cy.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.cy.model.dao.LoginRepository;
import com.project.cy.model.dto.LoginDTO;

@Service
public class LoginService implements LoginServiceImp{

	
	LoginRepository dao;

	@Autowired
	public LoginService(LoginRepository dao) {
		super();
		this.dao = dao;
	}

	@Override
	public LoginDTO login(String id) {
		return dao.login(id);
	}

	@Override
	public int register(LoginDTO dto) {
		return dao.register(dto);
	}

	@Override
	public int createBanner(String id) {
		return dao.createBanner(id);
	}

	@Override
	public int createP_text(String id) {
		return dao.createP_text(id);
	}

	@Override
	public LoginDTO getInformation(String id) {
		return dao.getInformation(id);
	}

	@Override
	public int modify(LoginDTO dto) {
		return dao.modify(dto);
	}

	@Override
	public String duplication(String id) {
		return dao.duplication(id);
	}

	@Override
	public String findId(String name, String email) {
		return dao.findId(name, email);
	}

	@Override
	public String findPw(String id, String name, String email) {
		return dao.findPw(id, name, email);
	}
	
	@Override
	public int createHome(String m_id) {
		return dao.createHome(m_id);
	}
	
	
}
