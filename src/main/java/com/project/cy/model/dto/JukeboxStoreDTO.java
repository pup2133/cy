package com.project.cy.model.dto;

public class JukeboxStoreDTO {
	String mu_code;
	String mu_title;
	String mu_artist;
	String mu_img;
	//
	public JukeboxStoreDTO() {
		// TODO Auto-generated constructor stub
	}

	public JukeboxStoreDTO(String mu_code, String mu_title, String mu_artist, String mu_img) {
		super();
		this.mu_code = mu_code;
		this.mu_title = mu_title;
		this.mu_artist = mu_artist;
		this.mu_img = mu_img;
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

	public String getMu_img() {
		return mu_img;
	}

	public void setMu_img(String mu_img) {
		this.mu_img = mu_img;
	}

	@Override
	public String toString() {
		return "JukeboxStoreDTO [mu_code=" + mu_code + ", mu_title=" + mu_title + ", mu_artist=" + mu_artist
				+ ", mu_img=" + mu_img + "]";
	}
	
	
}
