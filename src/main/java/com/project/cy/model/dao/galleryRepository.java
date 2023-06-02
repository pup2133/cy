package com.project.cy.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.cy.model.dto.gallery;

@Repository
public class galleryRepository implements galleryRepositoryImp {
	
	@Autowired
	private SqlSession session;
	private static String namespace = "com.project.galleryMapper.";
	
	@Override
	public int add(gallery g) {
		return session.insert(namespace+"insertGallery",g);
	}
	
	@Override
	public List<gallery> getGalleryList(String m_id, int startItem, int itemsPerPage) {
		Map<String, Object> params = new HashMap<>();
		params.put("m_id", m_id);
		params.put("startItem", startItem);
		params.put("itemsPerPage", itemsPerPage);
		return session.selectList(namespace+"getGalleryList", params);
	}
	
	@Override
	public List<gallery> getGallerySecretList(String m_id, int startItem, int itemsPerPage) {
		Map<String, Object> params = new HashMap<>();
		params.put("m_id", m_id);
		params.put("startItem", startItem);
		params.put("itemsPerPage", itemsPerPage);
		return session.selectList(namespace+"getGallerySecretList", params);
	}
	
	@Override
	public String getMemberId(gallery g) {
		return session.selectOne(namespace+"getMemberId", g);
	}

	@Override
	public int plusGood(gallery g) {
		return session.update(namespace+"plusGood",g);
	}
	
	@Override
	public int minusGood(gallery g) {
		return session.update(namespace+"minusGood",g);
	}
	
	@Override
	public int insertGood(gallery g) {
		return session.insert(namespace+"insertGood",g);
	}
	
	@Override
	public int getGood(gallery g) {
		return session.selectOne(namespace+"getGood",g);
	}
	
	@Override
	public List<gallery> getCommentList(int g_num) {
		return session.selectList(namespace+"commentList",g_num);
	}
	
	@Override
	public int regComment(gallery g) {
		return session.insert(namespace+"regComment",g);
	}
	
	@Override
	public gallery getNickname(String m_id) {
		return session.selectOne(namespace+"getNickname",m_id);
	}
	
	@Override
	public int editComment(String gc_text, int gc_num) {
		Map<String, Object> params = new HashMap<>();
		params.put("gc_text", gc_text);
		params.put("gc_num", gc_num);
		return session.update(namespace+"editComment",params);
	}
	
	@Override
	public int deleteComment(int gc_num) {
		return session.delete(namespace+"deleteComment",gc_num);
	}
	
	@Override
	public int getCommentGood(int gc_num, String m_id) {
		Map<String, Object> params = new HashMap<>();
		params.put("gc_num", gc_num);
		params.put("m_id", m_id);
		return session.selectOne(namespace+"getCommentGood",params);
	}
	
	@Override
	public int insertCommentGood(int gc_num, String m_id) {
		Map<String, Object> params = new HashMap<>();
		params.put("gc_num", gc_num);
		params.put("m_id", m_id);
		return session.insert(namespace+"insertCommentGood",params);
	}
	
	@Override
	public int minusCommentGood(int gc_num, String m_id) {
		Map<String, Object> params = new HashMap<>();
		params.put("gc_num", gc_num);
		params.put("m_id", m_id);
		return session.update(namespace+"minusCommentGood",params);
	}
	
	@Override
	public int plusCommentGood(int gc_num, String m_id) {
		Map<String, Object> params = new HashMap<>();
		params.put("gc_num", gc_num);
		params.put("m_id", m_id);
		return session.update(namespace+"plusCommentGood",params);
	}
	
	@Override
	public String getMemberId2(int gc_num, String m_id) {
		Map<String, Object> params = new HashMap<>();
		params.put("gc_num", gc_num);
		params.put("m_id", m_id);
		return session.selectOne(namespace+"getMemberId2", params);
	}
	
	@Override
	public int deleteGallery(int g_num) {
		return session.delete(namespace+"deleteGallery",g_num);
	}
	
	@Override
	public int editGallery(gallery g) {
		return session.update(namespace+"editGallery",g);
	}
	
	@Override
	public int getTotalCount(String m_id) {
		return session.selectOne(namespace+"getTotalCount",m_id);
	}
	
	@Override
	public int getSecretTotalCount(String m_id) {
		return session.selectOne(namespace+"getSecretTotalCount",m_id);
	}

}
