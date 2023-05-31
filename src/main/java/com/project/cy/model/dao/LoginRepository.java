package com.project.cy.model.dao;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.cy.model.dto.LoginDTO;

@Repository
public class LoginRepository {

	@Autowired
	private SqlSession session;
	private static String namespace = "com.project.cy.LoginMapper.";
	
	// 로그인
	public LoginDTO findMember(String id) {
		System.out.println(id);
		return session.selectOne(namespace + "login",id);
	}
	
	// 회원가입
	public int register(LoginDTO member){
		return session.insert(namespace+"register",member);
	}
	
	// 아이디 중복확인 
	public String duplication(String m_id) {
		return session.selectOne(namespace+"duplication",m_id);
	}
	// 아이디 찾기
	public String FindId(String m_name, String m_email) {
	    Map<String, Object> parameterMap = new HashMap<>();
	    parameterMap.put("m_name", m_name);
	    parameterMap.put("m_email", m_email);
	    
	    return session.selectOne(namespace + "findId", parameterMap);
	}
	// 비밀번호 찾기
	public String FindPw(String m_id,String m_name,String m_email) {
		Map<String, Object> parameterMap = new HashMap<>();
		parameterMap.put("m_id", m_id);
		parameterMap.put("m_name", m_name);
		parameterMap.put("m_email", m_email);
		return session.selectOne(namespace + "findPw", parameterMap);
	}
	
	
}
