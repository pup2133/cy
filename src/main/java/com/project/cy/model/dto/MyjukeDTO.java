package com.project.cy.model.dto;

public class MyjukeDTO {
	String mu_code;
	String mu_title;
	String mu_artist;
	String mu_genre;
	String mu_date;
	String mu_img;
	String mu_url;
	String m_id;
	int mm_in;
	//
	public MyjukeDTO() {
		// TODO Auto-generated constructor stub
	}
	public MyjukeDTO(String mu_code, String mu_title, String mu_artist, String mu_genre, String mu_date, String mu_img,
			String mu_url, String m_id, int mm_in) {
		super();
		this.mu_code = mu_code;
		this.mu_title = mu_title;
		this.mu_artist = mu_artist;
		this.mu_genre = mu_genre;
		this.mu_date = mu_date;
		this.mu_img = mu_img;
		this.mu_url = mu_url;
		this.m_id = m_id;
		this.mm_in = mm_in;
	}
	public String getMu_code() {
		return mu_code;
	}
	public void setMu_code(String mu_code) {
		this.mu_code = mu_code;
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
	public String getMu_genre() {
		return mu_genre;
	}
	public void setMu_genre(String mu_genre) {
		this.mu_genre = mu_genre;
	}
	public String getMu_date() {
		return mu_date;
	}
	public void setMu_date(String mu_date) {
		this.mu_date = mu_date;
	}
	public String getMu_img() {
		return mu_img;
	}
	public void setMu_img(String mu_img) {
		this.mu_img = mu_img;
	}
	public String getMu_url() {
		return mu_url;
	}
	public void setMu_url(String mu_url) {
		this.mu_url = mu_url;
	}
	public String getM_id() {
		return m_id;
	}
	public void setM_id(String m_id) {
		this.m_id = m_id;
	}
	public int getMm_in() {
		return mm_in;
	}
	public void setMm_in(int mm_in) {
		this.mm_in = mm_in;
	}
	@Override
	public String toString() {
		return "myjukeDTO [mu_code=" + mu_code + ", mu_title=" + mu_title + ", mu_artist=" + mu_artist + ", mu_genre="
				+ mu_genre + ", mu_date=" + mu_date + ", mu_img=" + mu_img + ", mu_url=" + mu_url + ", m_id=" + m_id
				+ ", mm_in=" + mm_in + "]";
	}
	
}
