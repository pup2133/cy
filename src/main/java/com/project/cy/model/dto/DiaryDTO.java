package com.project.cy.model.dto;

public class DiaryDTO {
	String d_num;
	String m_id;
	String m_nick;
	String d_date;
	String d_text;

	public String getD_num() {
		return d_num;
	}

	public void setD_num(String d_num) {
		this.d_num = d_num;
	}

	public String getM_id() {
		return m_id;
	}

	public void setM_id(String m_id) {
		this.m_id = m_id;
	}

	public String getM_nick() {
		return m_nick;
	}

	public void setM_nick(String m_nick) {
		this.m_nick = m_nick;
	}

	public String getD_date() {
		return d_date;
	}

	public void setD_date(String d_date) {
		this.d_date = d_date;
	}

	public String getD_text() {
		return d_text;
	}

	public void setD_text(String d_text) {
		this.d_text = d_text;
	}

	public DiaryDTO(String d_num, String m_id, String m_nick, String d_date, String d_text) {
		super();
		this.d_num = d_num;
		this.m_id = m_id;
		this.m_nick = m_nick;
		this.d_date = d_date;
		this.d_text = d_text;
	}

	public DiaryDTO(String m_id, String d_text) {
		super();
		this.m_id = m_id;
		this.d_text = d_text;
	}


	public DiaryDTO() {
		// TODO Auto-generated constructor stub
	}

}
