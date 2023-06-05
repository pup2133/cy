package com.project.cy.model.service;

import com.project.cy.model.dto.LoginDTO;

public interface LoginServiceImp {

	// 로그인
	public LoginDTO login(String id);
	
	// 회원가입
	public int register(LoginDTO dto);
	
	// 회원가입시 배너 테이블 자동 생성
	public int createBanner(String id);
	
	// 회원가입시 cy_profile 테이블 자동 생성
	public int createP_text(String id);
	
	//회원정보 가져오기
	public LoginDTO getInformation(String id);
	
	// 회원정보 수정 업데이트
	public int modify(LoginDTO dto);
	
	// 아이디 중복확인 
	public String duplication(String m_id);
	
	// 아이디 찾기
	public String findId(String m_name, String m_email);
		
	// 비밀번호 찾기
	public String findPw(String m_id,String m_name,String m_email);
	
	//회원가입시 홈테이블 자동생성
	public int createHome(String m_id);
		
}
