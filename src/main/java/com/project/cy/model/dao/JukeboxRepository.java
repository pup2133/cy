package com.project.cy.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.cy.model.dto.JukeboxDTO;
import com.project.cy.model.dto.JukeboxStoreDTO;
import com.project.cy.model.dto.MyjukeDTO;

@Repository
public class JukeboxRepository implements JukeboxRepositoryImp{
	//
	@Autowired
    private SqlSession session;
    private static String namespace = "com.project.cy.JukeboxStoreMapper.";
    
    @Override
    public String getMemberId(String id) {
    	return session.selectOne(namespace+"getMemberId",id);
    }
    @Override
    public List<JukeboxStoreDTO> All() {
		return session.selectList(namespace+"All");
    }
    @Override
    public List<JukeboxStoreDTO> AllSearch(String search_select,String search_word) {
    	Map<String,Object> parameters = new HashMap<>();
    	parameters.put("search_select", search_select);
    	parameters.put("search_word", search_word);
    	System.out.println("이건 파라미터:"+parameters);
    	System.out.println(session.selectList(namespace+"AllSearch",parameters));
		return session.selectList(namespace+"AllSearch",parameters);
    }
    @Override
    public int insert(JukeboxDTO dto){
    	return session.insert(namespace+"insert",dto);
    }
    @Override
    public List<MyjukeDTO> getMyjuke(String m_id){
		return session.selectList(namespace+"Myjuke",m_id);
    }
    @Override
    public List<MyjukeDTO> getMyplay(String m_id){
		return session.selectList(namespace+"Myplay",m_id);
    }
    @Override
    public int addPlay(String m_id,String mu_code) {
    	Map<String, Object> parameters = new HashMap<>();
        parameters.put("m_id", m_id);
        parameters.put("mu_code", mu_code);
        return session.update(namespace + "addPlay", parameters);
    }
    @Override
    public int subPlay(String m_id,int pl_code) {
    	Map<String, Object> parameters = new HashMap<>();
        parameters.put("m_id", m_id);
        parameters.put("pl_code", pl_code);
        return session.update(namespace + "subPlay", parameters);
    }
	
}
