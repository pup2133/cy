package com.project.cy.model.dto;

public class ProfileDTO {
	String m_id;
	String m_name;
	String m_birth;
	String m_email;
	String m_tel;
	String p_pic;
	String p_text;

	public String getM_id() {
		return m_id;
	}

	public void setM_id(String m_id) {
		this.m_id = m_id;
	}

	public String getM_name() {
		return m_name;
	}

	public void setM_name(String m_name) {
		this.m_name = m_name;
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

	public String getP_pic() {
		return p_pic;
	}

	public void setP_pic(String p_pic) {
		this.p_pic = p_pic;
	}

	public String getP_text() {
		return p_text;
	}

	public void setP_text(String p_text) {
		this.p_text = p_text;
	}

	public ProfileDTO(String m_id, String m_name, String m_birth, String m_email, String m_tel, String p_pic, String p_text) {
		super();
		this.m_id = m_id;
		this.m_name = m_name;
		this.m_birth = m_birth;
		this.m_email = m_email;
		this.m_tel = m_tel;
		this.p_pic = p_pic;
		this.p_text = p_text;
	}

	
}
