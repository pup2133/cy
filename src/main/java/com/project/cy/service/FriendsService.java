package com.project.cy.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.cy.model.dao.FriendsRepository;
import com.project.cy.model.dto.FriendsDTO;

@Service
public class FriendsService implements FriendsServiceImp{
	
	
	FriendsRepository dao;

	@Autowired
    public void setDao(FriendsRepository dao) {
		this.dao = dao;
	}
    
    @Override
    public String getMemberId(String id) {
    	return dao.getMemberId(id);
    }
    //친구목록 받아오기
    @Override
    public List<FriendsDTO> getRecieve(String m_id) {
		return dao.getRecieve(m_id);
    }
    @Override
    public List<FriendsDTO> getSend(String m_id) {
		return dao.getSend(m_id);
    }
    @Override
    public int delete(int f_num) {
    	return dao.delete(f_num);
    }
    
    @Override
    public List<FriendsDTO> getSearchList(String m_id) {
		return dao.getSearchList(m_id);
    }
}
