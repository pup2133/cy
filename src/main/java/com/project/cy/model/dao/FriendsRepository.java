package com.project.cy.model.dao;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.cy.model.dto.FriendsDTO;

@Repository
public class FriendsRepository implements FriendsRepositoryImp{
	//
	@Autowired
    private SqlSession session;
    private static String namespace = "com.project.cy.FriendsMapper.";
    
    @Override
    public String getMemberId(String id) {
    	return session.selectOne(namespace+"getMemberId",id);
    }
    //친구목록 받아오기
    @Override
    public List<FriendsDTO> getRecieve(String m_id) {
		return session.selectList(namespace+"getRecieve",m_id);
    }
    @Override
    public List<FriendsDTO> getSend(String m_id) {
		return session.selectList(namespace+"getSend",m_id);
    }
    @Override
    public int delete(int f_num) {
    	return session.delete(namespace+"delete",f_num);
    }
    
    @Override
    public List<FriendsDTO> getSearchList(String m_id) {
		return session.selectList(namespace+"getSearchList", m_id);
    }
    
    @Override
    public List<FriendsDTO> getRecieve2(String m_id) {
		return session.selectList(namespace+"getRecieve2", m_id);
    }
    
    @Override
    public List<FriendsDTO> getSend2(String m_id) {
		return session.selectList(namespace+"getSend2",m_id);
    }
    
    @Override
    public FriendsDTO getRecieve3(String m_id, String id) {
    	Map<String, String> params = new HashMap<>();
    	params.put("m_id",m_id);
    	params.put("id",id);
		return session.selectOne(namespace+"getRecieve3",params);
    }
    
    @Override
    public FriendsDTO getSend3(String id, String m_id) {
    	Map<String, String> params = new HashMap<>();
    	params.put("id",id);
    	params.put("m_id",m_id);
		return session.selectOne(namespace+"getSend3",params);
    }
}
