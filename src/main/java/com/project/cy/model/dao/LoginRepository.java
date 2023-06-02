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
	public LoginDTO login(String id) {
		System.out.println(id);
		return session.selectOne(namespace + "login",id);
	}
	
	// 회원가입
	public int register(LoginDTO dto){
		return session.insert(namespace+"register",dto);
	}
	
	// 회원가입시 배너 테이블 자동 생성
	public int createBanner(String id) {
		return session.insert(namespace + "createBanner", id);
	}
	
	// 회원가입시 cy_profile 테이블 자동 생성
	public int createP_text(String id) {
		return session.insert(namespace + "createP_text",id);
	}
	
	
	//회원정보 가져오기
	public LoginDTO getInformation(String id) {
		return session.selectOne(namespace+"getInformation", id);
	}
	
	// 회원정보 수정 업데이트
	public int modify(LoginDTO dto) {
		return session.update(namespace + "modify", dto);
	}
	
	// 아이디 중복확인 
	public String duplication(String id) {
		return session.selectOne(namespace+"duplication", id);
	}
	// 아이디 찾기
	public String findId(String m_name, String m_email) {
	    Map<String, Object> parameterMap = new HashMap<>();
	    parameterMap.put("m_name", m_name);
	    parameterMap.put("m_email", m_email);
	    
	    return session.selectOne(namespace + "findId", parameterMap);
	}
	// 비밀번호 찾기
	public String findPw(String m_id,String m_name,String m_email) {
		Map<String, Object> parameterMap = new HashMap<>();
		parameterMap.put("m_id", m_id);
		parameterMap.put("m_name", m_name);
		parameterMap.put("m_email", m_email);
		return session.selectOne(namespace + "findPw", parameterMap);
	}
	
	
}