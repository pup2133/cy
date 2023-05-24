package com.project.cy.model.dto;

import org.springframework.web.multipart.MultipartFile;

public class gallery {

	private int g_num;
	private String g_title;
	private MultipartFile file;
	private String g_pic;
	private String g_text;
	private String g_time;
	private String m_id;
	private int g_secret;
	private int good_count;
	private String gc_text;
	private String m_nick;
	
	public int getG_num() {
		return g_num;
	}

	public void setG_num(int g_num) {
		this.g_num = g_num;
	}

	public String getG_title() {
		return g_title;
	}

	public void setG_title(String g_title) {
		this.g_title = g_title;
	}
	

	public MultipartFile getFile() {
		return file;
	}

	public void setFile(MultipartFile file) {
		this.file = file;
	}
	

	public String getG_pic() {
		return g_pic;
	}

	public void setG_pic(String g_pic) {
		this.g_pic = g_pic;
	}

	public String getG_text() {
		return g_text;
	}

	public void setG_text(String g_text) {
		this.g_text = g_text;
	}

	public String getG_time() {
		return g_time;
	}

	public void setG_time(String g_time) {
		this.g_time = g_time;
	}

	public String getM_id() {
		return m_id;
	}

	public void setM_id(String m_id) {
		this.m_id = m_id;
	}

	public int getG_secret() {
		return g_secret;
	}

	public void setG_secret(int g_secret) {
		this.g_secret = g_secret;
	}
	
	public int getGood_count() {
		return good_count;
	}

	public void setGood_count(int good_count) {
		this.good_count = good_count;
	}
	

	public String getGc_text() {
		return gc_text;
	}

	public void setGc_text(String gc_text) {
		this.gc_text = gc_text;
	}
	
	public String getM_nick() {
		return m_nick;
	}

	public void setM_nick(String m_nick) {
		this.m_nick = m_nick;
	}

	public gallery() {
	}
	
	public gallery(String g_title, String g_pic, String g_text, String m_id, int g_secret) {
		super();
		this.g_title = g_title;
		this.g_pic = g_pic;
		this.g_text = g_text;
		this.m_id = m_id;
		this.g_secret = g_secret;
	}

	public gallery(int g_num, String m_id) {
		super();
		this.g_num = g_num;
		this.m_id = m_id;
	}

	public gallery(String gc_text, int g_num, String m_id) {
		super();
		this.gc_text = gc_text;
		this.g_num = g_num;
		this.m_id = m_id;

	}

	public gallery(String g_pic, String m_nick, String g_time, String gc_text) {
		super();
		this.g_pic = g_pic;
		this.m_nick = m_nick;
		this.g_time = g_time;
		this.gc_text = gc_text;
	}
	
	
	

}
