package com.project.cy.model.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.cy.model.dao.visitRepository;
import com.project.cy.model.dto.visit;

@Service
public class visitService implements visitServiceImp {

	visitRepository dao;

	@Autowired
	public void setDao(visitRepository dao) {
		this.dao = dao;
	}

	@Override
	public visit getMember(String id) throws Exception {
		return dao.getMember(id);
	}

	@Override
	public int addVisit(visit dto) throws Exception {
		return dao.addVisit(dto);
	}

	@Override
	public List<visit> getVisit(int startItem, int itemsPerPage, String id) throws Exception {
		return dao.getVisit(startItem, itemsPerPage, id);
	}

	@Override
	public String getMemberId(String id) throws Exception {
		if (id == null) {
			return null;
		} else {
			return dao.getMemberId(id);
		}
	}

	@Override
	public int getTotalCount() throws Exception {
		return dao.getTotalCount();
	}

	@Override
	public int editVisit(visit dto) throws Exception {
		return dao.editVisit(dto);
	}

	@Override
	public int deleteVisit(String v_num) throws Exception {
		return dao.deleteVisit(v_num);
	}

}
