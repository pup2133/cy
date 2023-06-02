package com.project.cy.model.dto;

public class LoginDTO {
	
	private String m_id;
	private String m_pw;
	private String m_name;
	private String m_nick;
	private String m_birth;
	private String m_email;
	private String m_tel;
	private String m_wave;
	
	public LoginDTO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public LoginDTO(String m_id) {
		super();
		this.m_id = m_id;
	}

	public String getM_id() {
		return m_id;
	}

	public void setM_id(String m_id) {
		this.m_id = m_id;
	}

	public String getM_pw() {
		return m_pw;
	}

	public void setM_pw(String m_pw) {
		this.m_pw = m_pw;
	}

	public String getM_name() {
		return m_name;
	}

	public void setM_name(String m_name) {
		this.m_name = m_name;
	}

	public String getM_nick() {
		return m_nick;
	}

	public void setM_nick(String m_nick) {
		this.m_nick = m_nick;
	}

	public String getM_birth() {
		return m_birth;
	}

	public void setM_birth(String m_birth) {
		this.m_birth = m_birth;
	}

	public String getM_email() {
		return m_email;
	}

	public void setM_email(String m_email) {
		this.m_email = m_email;
	}

	public String getM_tel() {
		return m_tel;
	}

	public void setM_tel(String m_tel) {
		this.m_tel = m_tel;
	}
	
	public String getM_wave() {
		return m_wave;
	}

	public void setM_wave(String m_wave) {
		this.m_wave = m_wave;
	}
	
	

	public LoginDTO(String m_id, String m_pw, String m_name, String m_nick, String m_birth, String m_email, String m_tel) {
		super();
		this.m_id = m_id;
		this.m_pw = m_pw;
		this.m_name = m_name;
		this.m_nick = m_nick;
		this.m_birth = m_birth;
		this.m_email = m_email;
		this.m_tel = m_tel;
	}
	
	

	public LoginDTO(String m_id, String m_pw, String m_name, String m_nick, String m_birth, String m_email,
			String m_tel, String m_wave) {
		super();
		this.m_id = m_id;
		this.m_pw = m_pw;
		this.m_name = m_name;
		this.m_nick = m_nick;
		this.m_birth = m_birth;
		this.m_email = m_email;
		this.m_tel = m_tel;
		this.m_wave = m_wave;
	}

	@Override
	public String toString() {
		return "Login [m_id=" + m_id + ", m_pw=" + m_pw + ", m_name=" + m_name + ", m_nick=" + m_nick + ", m_birth="
				+ m_birth + ", m_email=" + m_email + ", m_tel=" + m_tel + "]";
	}
	
}