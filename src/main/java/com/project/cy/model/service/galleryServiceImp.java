package com.project.cy.model.service;

import java.util.List;

import com.project.cy.model.dto.gallery;

public interface galleryServiceImp {

	public int add(gallery g);
	
	public List<gallery> getGalleryList();


}
