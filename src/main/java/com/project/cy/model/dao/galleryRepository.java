package com.project.cy.model.dao;

import java.util.List;

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
	public List<gallery> getGalleryList() {
		return session.selectList(namespace+"getGalleryList");
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
	public List<gallery> getCommentList(String g_num) {
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
}
