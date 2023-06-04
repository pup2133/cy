package com.project.cy.model.service;

import java.util.ArrayList;
import java.util.List;

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
    
    @Override
    public ArrayList<FriendsDTO> waveList(String m_id, String id) {
		ArrayList<FriendsDTO> friends = (ArrayList<FriendsDTO>) dao.getRecieve2(m_id);
		friends.addAll(dao.getSend2(m_id));
		
		for(FriendsDTO f : friends) {
			System.out.println(f);
		}
	
    	System.out.println("service : waveList");
		
		for(int i=0; i<friends.size(); i++) {
			FriendsDTO recieve = (FriendsDTO) dao.getRecieve3(id,friends.get(i).getM_id());
			FriendsDTO send = (FriendsDTO) dao.getSend3(friends.get(i).getM_id(),id);
			System.out.println(recieve);
			System.out.println(send);
			
			if(friends.get(i).getM_wave().equals("1") && recieve == null && send == null) {
				System.out.println(friends.get(i));
				friends.remove(i);
			}
		}
    	return friends;
    }
}
