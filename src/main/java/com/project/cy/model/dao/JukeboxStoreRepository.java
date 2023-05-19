package com.project.cy.model.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.cy.model.dto.JukeboxDTO;
import com.project.cy.model.dto.JukeboxStoreDTO;
import com.project.cy.model.dto.MyjukeDTO;

@Repository
public class JukeboxStoreRepository {
	
	@Autowired
    private SqlSession session;
    private static String namespace = "com.project.cy.JukeboxStoreMapper.";
	
    public List<JukeboxStoreDTO> All() {
		return session.selectList(namespace+"All");
    }
    
    public List<JukeboxStoreDTO> AllSearch(String mu_title) {
		return session.selectList(namespace+"AllSearch",mu_title);
    }
    
    public int insert(JukeboxDTO dto){
    	return session.insert(namespace+"insert",dto);
    }
    
    public List<MyjukeDTO> getMyjuke(String m_id){
		return session.selectList(namespace+"Myjuke",m_id);
    	
    }
    

	
}
