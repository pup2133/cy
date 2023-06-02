package com.project.cy.model.service;

import java.util.List;

import com.project.cy.model.dto.JukeboxDTO;
import com.project.cy.model.dto.JukeboxStoreDTO;
import com.project.cy.model.dto.MyjukeDTO;

public interface JukeboxServiceImp {
	
	
	public String getMemberId(String id);
	
	public List<JukeboxStoreDTO> All();
	
	public List<JukeboxStoreDTO> AllSearch(String search_select,String search_word);
	
	public int insert(JukeboxDTO dto);
	
	public List<MyjukeDTO> getMyjuke(String m_id);
	
	public List<MyjukeDTO> getMyplay(String m_id);
	
	public int addPlay(String m_id,String mu_code);
	
	public int subPlay(String m_id,int pl_code);
}
