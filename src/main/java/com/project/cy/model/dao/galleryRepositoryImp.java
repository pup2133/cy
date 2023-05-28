package com.project.cy.model.dao;

import java.util.List;

import com.project.cy.model.dto.gallery;

public interface galleryRepositoryImp {
	
	public int add(gallery g);
	public List<gallery> getGalleryList(String m_id, int startItem, int itemsPerPage);
	public List<gallery> getGallerySecretList(String m_id, int startItem, int itemsPerPage);
	public String getMemberId(gallery g);
	public int plusGood(gallery g);
	public int minusGood(gallery g);
	public int insertGood(gallery g);
	public int getGood(gallery g);
	public List<gallery> getCommentList(int g_num);
	public int regComment(gallery g);
	public gallery getNickname(String m_id);	
	public int editComment(String gc_text, int gc_num);
	public int deleteComment(int gc_num);
	public int plusCommentGood(int gc_num, String m_id);
	public int minusCommentGood(int gc_num, String m_id);
	public int insertCommentGood(int gc_num, String m_id);
	public int getCommentGood(int gc_num, String m_id);
	public String getMemberId2(int gc_num, String m_id);
	public int deleteGallery(int g_num);
	public int editGallery(gallery g);
	public int getTotalCount(String m_id);
	public int getSecretTotalCount(String m_id);
	public int updateToday(String m_id);
	public int clearToday();
}
