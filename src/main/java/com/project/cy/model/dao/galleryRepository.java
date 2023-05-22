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

}
