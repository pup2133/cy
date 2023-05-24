package com.project.cy.model.dao;

import java.util.List;

import com.project.cy.model.dto.gallery;

public interface galleryRepositoryImp {
	
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
}
