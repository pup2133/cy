package com.project.cy.model.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.cy.model.dto.Login;

@Repository
public class LoginRepository {

	@Autowired
	private SqlSession session;
	private static String namespace = "com.project.cy.LoginMapper.";
	
	public Login findMember(String id) {
		System.out.println(id);
		return session.selectOne(namespace + "login",id);
	}
	
	public Login FindId() {
		return session.selectOne(namespace+"FindId");
	}
	
	public Login FindPw() {
		return session.selectOne(namespace+"FindPw");
	}
	
}
