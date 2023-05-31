package com.project.cy.model.dto;

public class HomeSettingDTO {
	
	private String m_id;
	private String b_hide_profile;
	private String b_hide_music;
	private String b_hide_diary;
	private String b_hide_gallery;
	
	
	public String getM_id() {
		return m_id;
	}
	public void setM_id(String m_id) {
		this.m_id = m_id;
	}
	public String getB_hide_profile() {
		return b_hide_profile;
	}
	public void setB_hide_profile(String b_hide_profile) {
		this.b_hide_profile = b_hide_profile;
	}
	public String getB_hide_music() {
		return b_hide_music;
	}
	public void setB_hide_music(String b_hide_music) {
		this.b_hide_music = b_hide_music;
	}
	public String getB_hide_diary() {
		return b_hide_diary;
	}
	public void setB_hide_diary(String b_hide_diary) {
		this.b_hide_diary = b_hide_diary;
	}
	public String getB_hide_gallery() {
		return b_hide_gallery;
	}
	public void setB_hide_gallery(String b_hide_gallery) {
		this.b_hide_gallery = b_hide_gallery;
	}
	public HomeSettingDTO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public HomeSettingDTO(String b_hide_profile, String b_hide_music, String b_hide_diary, String b_hide_gallery) {
		super();
		this.b_hide_profile = b_hide_profile;
		this.b_hide_music = b_hide_music;
		this.b_hide_diary = b_hide_diary;
		this.b_hide_gallery = b_hide_gallery;
	}
	
	public HomeSettingDTO(String m_id, String b_hide_profile, String b_hide_music, String b_hide_diary,
			String b_hide_gallery) {
		super();
		this.m_id = m_id;
		this.b_hide_profile = b_hide_profile;
		this.b_hide_music = b_hide_music;
		this.b_hide_diary = b_hide_diary;
		this.b_hide_gallery = b_hide_gallery;
	}
	@Override
	public String toString() {
		return "HomeSettingDTO [b_hide_profile=" + b_hide_profile + ", b_hide_music=" + b_hide_music + ", b_hide_diary="
				+ b_hide_diary + ", b_hide_gallery=" + b_hide_gallery + "]";
	}
	
	

}
