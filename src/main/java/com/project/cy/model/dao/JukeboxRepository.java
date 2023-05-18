package com.project.cy.model.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.cy.model.dto.JukeboxDTO;
import com.project.cy.model.dto.JukeboxStoreDTO;

@Repository
public class JukeboxRepository {
	
	@Autowired
    private SqlSession session;
    private static String namespace = "com.project.cy.JukeboxMapper.";
	
    public int insert(JukeboxDTO dto){
    	return session.insert(namespace+"insert"+dto);
    }
	
}
