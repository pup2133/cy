package com.project.cy.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.cy.model.dao.JukeboxRepository;
import com.project.cy.model.dto.FriendsDTO;
import com.project.cy.model.dto.JukeboxDTO;
import com.project.cy.model.dto.JukeboxStoreDTO;
import com.project.cy.model.dto.MyjukeDTO;

@Service
public class JukeboxService implements JukeboxServiceImp{
	
	@Autowired
	JukeboxRepository dao;
	
	@Override
	public String getMemberId(String id) {
		return dao.getMemberId(id);
	}
	@Override
	public List<JukeboxStoreDTO> All(){
		return dao.All();
	}
	@Override
	public List<JukeboxStoreDTO> AllSearch(String search_select,String search_word){
		return dao.AllSearch(search_select, search_word);
	}
	@Override
	public int insert(JukeboxDTO dto) {
		return dao.insert(dto);
	}
	@Override
	public List<MyjukeDTO> getMyjuke(String m_id){
		return dao.getMyjuke(m_id);
	}
	@Override
	public List<MyjukeDTO> getMyplay(String m_id){
		return dao.getMyplay(m_id);
    }
	@Override
	public int addPlay(String m_id,String mu_code) {
		return dao.addPlay(m_id, mu_code);
	}
	@Override
	public int subPlay(String m_id,int pl_code) {
		return dao.subPlay(m_id, pl_code);
	}
	
}
