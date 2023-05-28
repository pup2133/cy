package com.project.cy.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import com.project.cy.model.dao.galleryRepository;
import com.project.cy.model.dto.gallery;
import com.project.cy.util.isHostOrGuest;

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
	public List<gallery> getGalleryList(String hostId, String sessionId, int startItem, int itemsPerPage) {
		isHostOrGuest ihog = new isHostOrGuest();
		String m_id = ihog.determineRole(hostId, sessionId);
		if(m_id.equals(sessionId)) {
			return dao.getGalleryList(m_id, startItem, itemsPerPage);
		}else {
			return dao.getGallerySecretList(m_id, startItem, itemsPerPage);
		}
	}
	
	@Override
	public String getMemberId(gallery g) {
		return dao.getMemberId(g);
	}
	
	@Override
	public int galleryGood(gallery g, String m_id) {
		if (m_id == null) {
			return dao.insertGood(g)+1;
		}

		int good = dao.getGood(g);
		if (good == 0) {
			return dao.plusGood(g)+3;
		} else {
			return dao.minusGood(g)+5;
		}
	}
	
	@Override
	public List<gallery> getCommentList(int g_num) {
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

	@Override
	public int editComment(String gc_text, int gc_num) {
		return dao.editComment(gc_text, gc_num);
	}
	
	@Override
	public int deleteComment(int gc_num) {
		return dao.deleteComment(gc_num);
	}
	
	@Override
	public int CommentGood(int gc_num, String m_id, String id) {
		if (id == null) {
			return dao.insertCommentGood(gc_num, m_id)+1;
		}
		
		int good = dao.getCommentGood(gc_num, m_id);
		if (good == 0) {
			return dao.plusCommentGood(gc_num, m_id)+3;
		} else {
			return dao.minusCommentGood(gc_num, m_id)+5;
		}
	}
	
	@Override
	public String getMemberId2(int gc_num, String m_id) {
		return dao.getMemberId2(gc_num,m_id);
	}
	
	@Override
	public int deleteGallery(int g_num) {
		return dao.deleteGallery(g_num);
	}
	
	@Override
	public int editGallery(gallery g) {
		return dao.editGallery(g);
	}

	@Override
	public int getTotalCount(String m_id, String sessionId) {
		if(m_id.equals(sessionId)) {
			return dao.getTotalCount(m_id);
		}else {
			return dao.getSecretTotalCount(m_id);
		}
	}
	
	@Override
    @Scheduled(cron = "0 0 18 * * ?") // 매일 0시 0분에 실행
	public int clearToday() {
		return dao.clearToday();
	}
	
	@Override
	public int updateToday(String m_id) {
		return dao.updateToday(m_id);
	}
}
