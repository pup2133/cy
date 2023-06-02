package com.project.cy.model.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import com.project.cy.model.dao.HomeRepository;
import com.project.cy.model.dto.FriendsDTO;
import com.project.cy.model.dto.HomeProfileDTO;
import com.project.cy.model.dto.MyjukeDTO;
import com.project.cy.model.dto.gallery;
import com.project.cy.model.dto.visit;

@Service
public class HomeService implements HomeServiceImp{
	@Autowired
	HomeRepository dao;
	
	@Override
	public String getMemberId(String id) {
		return dao.getMemberId(id);
	};
	
	@Override
    public HomeProfileDTO getHomeProfile(String m_id) {
    	return dao.getHomeProfile(m_id);
    };
    
	@Override
    public List<HashMap<String,Object>> getHomeDiary(String m_id){
    	return dao.getHomeDiary(m_id);
    };
    
	@Override
    public List<visit> getHomeVisit(String m_id){
    	return dao.getHomeVisit(m_id);
    };
    
	@Override
    public List<gallery> getHomeGallery (String m_id){
    	return dao.getHomeGallery(m_id);
    };
    
	@Override
    public List<Object> getPreview (String m_id){
    	return dao.getPreview(m_id);
    };
    
	@Override
    public HashMap getBanner (String m_id) {
    	return dao.getBanner(m_id);
    };
    
	@Override
    public List<FriendsDTO> getRecieveFriends (String m_id){
    	return dao.getRecieveFriends(m_id);
    };
    
	@Override
    public int acceptFriends(int f_num) {
    	return dao.acceptFriends(f_num);
    };
    
	@Override
    public int rejectFriends(int f_num) {
		return dao.rejectFriends(f_num);
    }
	
	@Override
    public List<FriendsDTO> getRecieve(String m_id){
    	return dao.getRecieve(m_id);
    };
    
	@Override
    public List<FriendsDTO> getSend(String m_id){
    	return dao.getSend(m_id);
    };
    
	@Override
    public int sendFriend(String send_id,String recieve_id) {
    	return dao.sendFriend(send_id, recieve_id);
    };
    
	@Override
    public int editMsg(String h_msg,String m_id) {
    	return dao.editMsg(h_msg, m_id);
    };
    
	@Override
    public List<MyjukeDTO> getPlay(String m_id){
    	return dao.getPlay(m_id);
    };
    
	@Scheduled(cron = "0 0 0 * * ?") // 매일 0시 0분에 실행
    @Override
    public int clearToday() {
    	return dao.clearToday();
    }
    
    @Override
    public HomeProfileDTO getToday(String m_id) {
    	return dao.getToday(m_id);
    }
    
    @Override
    public int updateToday(String m_id) {
    	return dao.updateToday(m_id);
    }
    
}