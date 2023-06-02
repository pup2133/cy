package com.project.cy.model.service;

import java.util.HashMap;
import java.util.List;

import com.project.cy.model.dto.FriendsDTO;
import com.project.cy.model.dto.HomeProfileDTO;
import com.project.cy.model.dto.MyjukeDTO;
import com.project.cy.model.dto.gallery;
import com.project.cy.model.dto.visit;

public interface HomeServiceImp {
	
	public String getMemberId(String id);
	
    public HomeProfileDTO getHomeProfile(String m_id);
    
    public List<HashMap<String,Object>> getHomeDiary(String m_id);
    
    public List<visit> getHomeVisit(String m_id);
    
    public List<gallery> getHomeGallery (String m_id);
    
    public List<Object> getPreview (String m_id);
    
    public HashMap getBanner (String m_id);
    
    public List<FriendsDTO> getRecieveFriends (String m_id);
    
    public int acceptFriends(int f_num);
    
    public int rejectFriends(int f_num);
    
    public List<FriendsDTO> getRecieve(String m_id);
    
    public List<FriendsDTO> getSend(String m_id);
    
    public int sendFriend(String send_id,String recieve_id);
    
    public int editMsg(String h_msg,String m_id);
    
    public List<MyjukeDTO> getPlay(String m_id);
}
