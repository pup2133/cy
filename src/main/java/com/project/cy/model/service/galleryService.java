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

}
