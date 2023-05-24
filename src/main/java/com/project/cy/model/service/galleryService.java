package com.project.cy.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.cy.model.dao.galleryRepository;
import com.project.cy.model.dto.gallery;

@Service
public class galleryService implements galleryServiceImp {
	
	galleryRepository dao;
	
	@Autowired
	public galleryService(galleryRepository dao) {
		this.dao = dao;
	}
	
	@Override
	public int add(gallery g) {
		return dao.add(g);
	}
	
	@Override
	public List<gallery> getGalleryList() {
		return dao.getGalleryList();
	}
	
	@Override
	public String getMemberId(gallery g) {
		return dao.getMemberId(g);
	}
	
	@Override
	public int plusGood(gallery g) {
		return dao.plusGood(g);
	}
	
	@Override
	public int minusGood(gallery g) {
		return dao.minusGood(g);
	}
	
	@Override
	public int insertGood(gallery g) {
		return dao.insertGood(g);
	}
	
	@Override
	public int getGood(gallery g) {
		return dao.getGood(g);
	}
	
	@Override
	public List<gallery> getCommentList(String g_num) {
		return dao.getCommentList(g_num);
	}
	
	@Override
	public int regComment(gallery g) {
		return dao.regComment(g);
	}
	
	@Override
	public gallery getNickname(String m_id) {
		return dao.getNickname(m_id);
	}

}
