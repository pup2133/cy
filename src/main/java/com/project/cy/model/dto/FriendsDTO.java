package com.project.cy.model.dto;

public class FriendsDTO {
	int f_num;
	String h_pic;
	String m_id;
	String m_nick;
	
	public FriendsDTO() {
		// TODO Auto-generated constructor stub
	}
	public FriendsDTO(int f_num, String h_pic, String m_id, String m_nick) {
		super();
		this.f_num = f_num;
		this.h_pic = h_pic;
		this.m_id = m_id;
		this.m_nick = m_nick;
	}
	
	public int getF_num() {
		return f_num;
	}
	public void setF_num(int f_num) {
		this.f_num = f_num;
	}
	public String getH_pic() {
		return h_pic;
	}
	public void setH_pic(String h_pic) {
		this.h_pic = h_pic;
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
	
	public FriendsDTO(String m_id, String m_nick) {
		super();
		this.m_id = m_id;
		this.m_nick = m_nick;
	}
	@Override
	public String toString() {
		return "friendDTO [f_num=" + f_num + ", h_pic=" + h_pic + ", m_id=" + m_id + ", m_nick=" + m_nick + "]";
	}
}
