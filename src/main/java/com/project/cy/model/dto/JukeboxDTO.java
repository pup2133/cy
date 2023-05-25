package com.project.cy.model.dto;

public class JukeboxDTO {
	String pl_code;
	String mu_code;
	String m_id;
	
	public JukeboxDTO() {
		// TODO Auto-generated constructor stub
	}

	public JukeboxDTO(String pl_code, String mu_code, String m_id) {
		super();
		this.pl_code = pl_code;
		this.mu_code = mu_code;
		this.m_id = m_id;
	}

	public String getPl_code() {
		return pl_code;
	}

	public void setPl_code(String pl_code) {
		this.pl_code = pl_code;
	}

	public String getMu_code() {
		return mu_code;
	}

	public void setMu_code(String mu_code) {
		this.mu_code = mu_code;
	}

	public String getM_id() {
		return m_id;
	}

	public void setM_id(String m_id) {
		this.m_id = m_id;
	}

	@Override
	public String toString() {
		return "JukeboxDTO [pl_code=" + pl_code + ", mu_code=" + mu_code + ", m_id=" + m_id + "]";
	}
	
	
	
}
