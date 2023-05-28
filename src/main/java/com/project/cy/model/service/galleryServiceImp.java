package com.project.cy.model.service;

import java.util.List;

import com.project.cy.model.dto.gallery;

public interface galleryServiceImp {

	public int add(gallery g);
	public List<gallery> getGalleryList(String hostId, String sessionId, int startItem, int itemsPerPage);
	public String getMemberId(gallery g);
	public int galleryGood(gallery g, String m_id);
	public List<gallery> getCommentList(int g_num);
	public int regComment(gallery g);
	public gallery getNickname(String m_id);
	public int editComment(String gc_text, int gc_num);
	public int deleteComment(int gc_num);
	public int CommentGood(int gc_num, String m_id, String id);
	public String getMemberId2(int gc_num, String m_id);
	public int deleteGallery(int g_num);
	public int editGallery(gallery g);
	public int getTotalCount(String m_id, String sessionId);
	public int updateToday(String m_id);
	public int clearToday();

}
