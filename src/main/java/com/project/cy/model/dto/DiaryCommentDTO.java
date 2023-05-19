package com.project.cy.model.dto;

public class DiaryCommentDTO {
	String d_num;
	String m_nick;
	String dc_time;
	String dc_text;
	String h_pic;

	public String getD_num() {
		return d_num;
	}

	public void setD_num(String d_num) {
		this.d_num = d_num;
	}

	public String getM_nick() {
		return m_nick;
	}

	public void setM_nick(String m_nick) {
		this.m_nick = m_nick;
	}

	public String getDc_time() {
		return dc_time;
	}

	public void setDc_time(String dc_time) {
		this.dc_time = dc_time;
	}

	public String getDc_text() {
		return dc_text;
	}

	public void setDc_text(String dc_text) {
		this.dc_text = dc_text;
	}

	public String getH_pic() {
		return h_pic;
	}

	public void setH_pic(String h_pic) {
		this.h_pic = h_pic;
	}

	public DiaryCommentDTO(String d_num, String m_nick, String dc_time, String dc_text, String h_pic) {
		super();
		this.d_num = d_num;
		this.m_nick = m_nick;
		this.dc_time = dc_time;
		this.dc_text = dc_text;
		this.h_pic = h_pic;
	}

	public DiaryCommentDTO() {
		// TODO Auto-generated constructor stub
	}

}
