package com.project.cy.model.dto;

public class FriendsDTO {
	int f_num;
	String h_pic;
	String m_id;
	String m_nick;
	String m_name;
	String send_id;
	String recieve_id;
	String m_wave;
	
	public FriendsDTO() {
		// TODO Auto-generated constructor stub
	}

	public FriendsDTO(int f_num, String h_pic, String m_id, String m_nick, String m_name, String send_id,
			String recieve_id) {
		super();
		this.f_num = f_num;
		this.h_pic = h_pic;
		this.m_id = m_id;
		this.m_nick = m_nick;
		this.m_name = m_name;
		this.send_id = send_id;
		this.recieve_id = recieve_id;
	}

	public String getM_wave() {
		return m_wave;
	}

	public void setM_wave(String m_wave) {
		this.m_wave = m_wave;
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

	public String getM_name() {
		return m_name;
	}

	public void setM_name(String m_name) {
		this.m_name = m_name;
	}

	public String getSend_id() {
		return send_id;
	}

	public void setSend_id(String send_id) {
		this.send_id = send_id;
	}

	public String getRecieve_id() {
		return recieve_id;
	}

	public void setRecieve_id(String recieve_id) {
		this.recieve_id = recieve_id;
	}

	@Override
	public String toString() {
		return "FriendsDTO [f_num=" + f_num + ", h_pic=" + h_pic + ", m_id=" + m_id + ", m_nick=" + m_nick + ", m_name="
				+ m_name + ", send_id=" + send_id + ", recieve_id=" + recieve_id + ", m_wave=" + m_wave + "]";
	}
	
	
	
}
