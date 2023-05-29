package com.project.cy.model.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.cy.model.dto.FriendsDTO;
import com.project.cy.model.dto.HomeProfileDTO;
import com.project.cy.model.dto.MyjukeDTO;
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
    public HashMap getBanner (String m_id) {
    	return session.selectOne(namespace+"getBanner",m_id);
    }
    public List<FriendsDTO> getRecieveFriends (String m_id){
    	return session.selectList(namespace+"getRecieveFriends",m_id);
    }
    public int acceptFriends(int f_num) {
    	return session.update(namespace+"acceptFriends",f_num);
    }
    public int rejectFriends(int f_num) {
    	return session.delete(namespace+"rejectFriends",f_num);
    }
    public List<FriendsDTO> getRecieve(String m_id) {
		return session.selectList(namespace+"getRecieve",m_id);
    }
    public List<FriendsDTO> getSend(String m_id) {
		return session.selectList(namespace+"getSend",m_id);
    }
    public int sendFriend(String send_id,String recieve_id) {
    	HashMap<String,Object> param = new HashMap<>();
    	param.put("recieve_id", recieve_id);
    	param.put("send_id", send_id);
		return session.insert(namespace+"sendFriend",param);
    }
    public int editMsg(String h_msg,String m_id) {
    	HashMap<String,Object> param = new HashMap<>();
    	System.out.println(h_msg);
    	System.out.println(m_id);
    	param.put("h_msg", h_msg);
    	param.put("m_id", m_id);
		return session.update(namespace+"editMsg",param);
    }
    public List<MyjukeDTO> getPlay(String m_id){
		return session.selectList(namespace+"getPlay",m_id);
    	
    }
    
}