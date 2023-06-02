package com.project.cy.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.cy.model.dto.visit;

@Repository
public class visitRepository implements visitRepositoryImp {

	@Autowired
	private SqlSession session;
	private static String namespace = "com.project.visitMapper.";

	@Override
	public visit getMember(String id) throws Exception {
		return session.selectOne(namespace + "selectMember", id);
	}

	@Override
	public int addVisit(visit dto) throws Exception {
		return session.insert(namespace + "insertVisit", dto);
	}

	@Override
	public List<visit> getVisit(int startItem, int itemsPerPage, String id) throws Exception {
		Map<String, Object> params = new HashMap<>();
		params.put("id", id);
		params.put("startItem", startItem);
		params.put("itemsPerPage", itemsPerPage);
		return session.selectList(namespace + "selectVisit", params);
	}

	@Override
	public String getMemberId(String id) throws Exception {
		return session.selectOne(namespace + "selectMemberId", id);
	}

	@Override
	public int getTotalCount(String id) throws Exception {
		return session.selectOne(namespace + "countVisit",id);
	}

	@Override
	public int editVisit(visit dto) throws Exception {
		return session.update(namespace + "editVisit", dto);
	}

	@Override
	public int deleteVisit(String v_num) throws Exception {
		return session.delete(namespace + "deleteVisit", v_num);
	}

}
