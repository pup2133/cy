package com.project.cy.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.cy.model.dto.visit;

@Repository
public class visitRepository {
	
    @Autowired
    private SqlSession session;
    private static String namespace = "com.project.visitMapper.";
    
    public visit select(String id) throws Exception {
    	return session.selectOne(namespace+"selectOne", id);
    }
	
    public int insert(visit dto) throws Exception {
        return session.insert(namespace+"visitInsert", dto);
    }
    
    public List<visit> selectVisit(int startItem, int itemsPerPage) throws Exception{
        Map<String, Integer> params = new HashMap<>();
        params.put("startItem", startItem);
        params.put("itemsPerPage", itemsPerPage);
    	return session.selectList(namespace+"selectVisit", params);
    }

    public String findMemberId(String id) throws Exception{
    	if(id==null) {
    		return null;
    	}else {
        	return session.selectOne(namespace+"findMemberId", id);
    	}
    }
    
    public int getTotalCount() throws Exception{
    	return session.selectOne(namespace+"visitCount");
    }
    
    public int update(visit v) throws Exception{
    	return session.update(namespace+"update", v);
    }
    
    public int delete(String v_num) throws Exception{
    	return session.delete(namespace+"delete", v_num);
    }
    
    
}
