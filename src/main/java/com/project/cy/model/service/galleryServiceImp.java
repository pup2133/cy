package com.project.cy.model.service;

import java.util.List;

import com.project.cy.model.dto.gallery;

public interface galleryServiceImp {

	public int add(gallery g);
	
	public List<gallery> getGalleryList();

	public String getMemberId(gallery g);

	public int plusGood(gallery g);
	
	public int minusGood(gallery g);
	
	public int insertGood(gallery g);
	
	public int getGood(gallery g);

	public List<gallery> getCommentList(String g_num);
	
	public int regComment(gallery g);
	
	public gallery getNickname(String m_id);

	public int editComment(String gc_text, int g_num);
	
	public gallery getComment(int g_num);

	public int deleteComment(int g_num);
	
}
