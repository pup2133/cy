package com.project.cy.model.dto;

public class HomeProfileDTO {
	String m_id;
	String m_nick;
	String h_pic;
	int m_today;
	int m_totaltoday;
	String h_msg;
	
	public HomeProfileDTO() {
		// TODO Auto-generated constructor stub
	}
	public HomeProfileDTO(String m_id, String m_nick, String h_pic, int m_today, int m_totaltoday, String h_msg) {
		super();
		this.m_id = m_id;
		this.m_nick = m_nick;
		this.h_pic = h_pic;
		this.m_today = m_today;
		this.m_totaltoday = m_totaltoday;
		this.h_msg = h_msg;
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
	public String getH_pic() {
		return h_pic;
	}
	public void setH_pic(String h_pic) {
		this.h_pic = h_pic;
	}
	public int getM_today() {
		return m_today;
	}
	public void setM_today(int m_today) {
		this.m_today = m_today;
	}
	public int getM_totaltoday() {
		return m_totaltoday;
	}
	public void setM_totaltoday(int m_totaltoday) {
		this.m_totaltoday = m_totaltoday;
	}
	public String getH_msg() {
		return h_msg;
	}
	public void setH_msg(String h_msg) {
		this.h_msg = h_msg;
	}
	@Override
	public String toString() {
		return "HomeProfileDTO [m_id=" + m_id + ", m_nick=" + m_nick + ", h_pic=" + h_pic + ", m_today=" + m_today
				+ ", m_totaltoday=" + m_totaltoday + ", h_msg=" + h_msg + "]";
	}

}
