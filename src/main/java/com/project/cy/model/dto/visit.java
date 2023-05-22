package com.project.cy.model.dto;

public class visit {

	private String id;
	private String m_nick;
	private String h_pic;
	private String v_num;
	private String v_text;
	private String v_time;
	private String v_hostId;
	private String v_guestId;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
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

	public String getV_num() {
		return v_num;
	}

	public void setV_num(String v_num) {
		this.v_num = v_num;
	}

	public String getV_time() {
		return v_time;
	}

	public void setV_time(String v_time) {
		this.v_time = v_time;
	}

	public String getV_text() {
		return v_text;
	}

	public void setV_text(String v_text) {
		this.v_text = v_text;
	}

	public String getV_hostId() {
		return v_hostId;
	}

	public void setV_hostId(String v_hostId) {
		this.v_hostId = v_hostId;
	}

	public String getV_guestId() {
		return v_guestId;
	}

	public void setV_guestId(String v_guestId) {
		this.v_guestId = v_guestId;
	}

	public visit() {
	}

	public visit(String m_nick, String h_pic) {
		super();
		this.m_nick = m_nick;
		this.h_pic = h_pic;
	}

	public visit(String v_text, String v_hostId, String v_guestId) {
		super();
		this.v_text = v_text;
		this.v_hostId = v_hostId;
		this.v_guestId = v_guestId;
	}

	public visit(String m_nick, String h_pic, String v_num, String v_text, String v_time, String v_hostId,
			String v_guestId) {
		super();
		this.m_nick = m_nick;
		this.h_pic = h_pic;
		this.v_num = v_num;
		this.v_text = v_text;
		this.v_time = v_time;
		this.v_hostId = v_hostId;
		this.v_guestId = v_guestId;

	}

	public visit(String v_num, String v_text, String v_time, String v_hostId, String v_guestId) {
		super();
		this.v_num = v_num;
		this.v_text = v_text;
		this.v_time = v_time;
		this.v_hostId = v_hostId;
		this.v_guestId = v_guestId;
	}

}
