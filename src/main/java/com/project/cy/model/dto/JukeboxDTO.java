package com.project.cy.model.dto;

public class JukeboxDTO {
	String pl_code;
	String mu_code;
	String m_id;
	String mu_title;
	String mu_artist;
	String mu_url;
	
	public JukeboxDTO() {
		// TODO Auto-generated constructor stub
	}
	public JukeboxDTO(String pl_code, String mu_code, String m_id, String mu_title, String mu_artist, String mu_url) {
		super();
		this.pl_code = pl_code;
		this.mu_code = mu_code;
		this.m_id = m_id;
		this.mu_title = mu_title;
		this.mu_artist = mu_artist;
		this.mu_url = mu_url;
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
	public String getMu_title() {
		return mu_title;
	}
	public void setMu_title(String mu_title) {
		this.mu_title = mu_title;
	}
	public String getMu_artist() {
		return mu_artist;
	}
	public void setMu_artist(String mu_artist) {
		this.mu_artist = mu_artist;
	}
	public String getMu_url() {
		return mu_url;
	}
	public void setMu_url(String mu_url) {
		this.mu_url = mu_url;
	}
	@Override
	public String toString() {
		return "JukeboxDTO [pl_code=" + pl_code + ", mu_code=" + mu_code + ", m_id=" + m_id + ", mu_title=" + mu_title
				+ ", mu_artist=" + mu_artist + ", mu_url=" + mu_url + "]";
	}
	

	
}
