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
	
	public int register(Login member){
		System.out.println("실행");
		return session.insert(namespace+"register",member);
	}
	
	public String duplication(String m_id) {
		System.out.println("실행");
		return session.selectOne(namespace+"duplication",m_id);
	}
	
	public Login FindId() {
		return session.selectOne(namespace+"findId");
	}
	
	public Login FindPw() {
		return session.selectOne(namespace+"findPw");
	}
	
	
}
