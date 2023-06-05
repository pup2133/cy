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
public class HomeRepository implements HomeRepositoryImp {
	@Autowired
	private SqlSession session;
	private static String namespace = "com.project.cy.HomeMapper.";

	@Override
	public String getMemberId(String id) {
		return session.selectOne(namespace + "getMemberId", id);
	}

	@Override
	public HomeProfileDTO getHomeProfile(String m_id) {
		return session.selectOne(namespace + "getHomeProfile", m_id);
	}

	@Override
	public List<HashMap<String, Object>> getHomeDiary(String m_id) {
		return session.selectList(namespace + "getHomeDiaryList", m_id);
	}

	@Override
	public List<visit> getHomeVisit(String m_id) {
		return session.selectList(namespace + "getHomeVisit", m_id);
	}

	@Override
	public List<gallery> getHomeGallery(String m_id) {
		return session.selectList(namespace + "getHomeGallery", m_id);
	}

	@Override
	public List<Object> getPreview(String m_id) {
		return session.selectList(namespace + "getPreview", m_id);
	}

	@Override
	public HashMap getBanner(String m_id) {
		return session.selectOne(namespace + "getBanner", m_id);
	}

	@Override
	public List<FriendsDTO> getRecieveFriends(String m_id) {
		return session.selectList(namespace + "getRecieveFriends", m_id);
	}

	@Override
	public int acceptFriends(int f_num) {
		return session.update(namespace + "acceptFriends", f_num);
	}

	@Override
	public int rejectFriends(int f_num) {
		return session.delete(namespace + "rejectFriends", f_num);
	}

	@Override
	public List<FriendsDTO> getRecieve(String m_id) {
		return session.selectList(namespace + "getRecieve", m_id);
	}

	@Override
	public List<FriendsDTO> getSend(String m_id) {
		return session.selectList(namespace + "getSend", m_id);
	}

	@Override
	public int sendFriend(String send_id, String recieve_id) {
		HashMap<String, Object> param = new HashMap<>();
		param.put("recieve_id", recieve_id);
		param.put("send_id", send_id);
		return session.insert(namespace + "sendFriend", param);
	}

	@Override
	public int editMsg(String h_msg, String m_id) {
		HashMap<String, Object> param = new HashMap<>();
		param.put("h_msg", h_msg);
		param.put("m_id", m_id);
		return session.update(namespace + "editMsg", param);
	}

	@Override
	public List<MyjukeDTO> getPlay(String m_id) {
		return session.selectList(namespace + "getPlay", m_id);

	}
	
	@Override
	public int clearToday() {
		return session.update(namespace+"clearToday");
	}

	@Override
	public HomeProfileDTO getToday(String m_id) {
		return session.selectOne(namespace+"getToday",m_id);
	}
	
	@Override
	public int updateToday(String m_id) {
		return session.update(namespace+"updateToday",m_id);
	}
}