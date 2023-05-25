package com.project.cy.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.cy.model.dto.HomeProfileDTO;
import com.project.cy.model.dto.gallery;
import com.project.cy.model.dto.visit;

@Repository
public class HomeRepository {
	@Autowired
    private SqlSession session;
    private static String namespace = "com.project.cy.HomeMapper.";

    public String getMemberId(String id) {
    	return session.selectOne(namespace+"getMemberId",id);
    }
    
    public HomeProfileDTO getHomeProfile(String m_id) {
    	return session.selectOne(namespace+"getHomeProfile",m_id);
    }
    public List<HashMap<String,Object>> getHomeDiary(String m_id){
		return session.selectList(namespace+"getHomeDiaryList",m_id);
    }
    public List<visit> getHomeVisit(String m_id){
    	return session.selectList(namespace+"getHomeVisit",m_id);
    }
    public List<gallery> getHomeGallery (String m_id){
    	return session.selectList(namespace+"getHomeGallery",m_id);
    }
    public List<Object> getPreview (String m_id) {
    	return session.selectList(namespace+"getPreview",m_id);
    }
}
