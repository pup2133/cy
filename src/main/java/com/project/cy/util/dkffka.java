package com.project.cy.util;

import java.util.Date;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.springframework.context.annotation.ComponentScan;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

public class dkffka extends TextWebSocketHandler{
	
	Map<String, WebSocketSession> users = new ConcurrentHashMap<String, WebSocketSession>();
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		String senderId = getMemberId(session); // 접속한 유저의 http세션을 조회하여 id를 얻는 함수
		System.out.println(senderId);
		if(senderId!=null) {	// 로그인 값이 있는 경우만
			log(senderId + " 연결 됨");
			users.put(senderId, session);   // 로그인중 개별유저 저장
		}
	}
	
	private void log(String logmsg) {
		System.out.println(new Date() + " : " + logmsg);		
	}

	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		String senderId = getMemberId(session);
		if(senderId!=null) {	// 로그인 값이 있는 경우만
			log(senderId + " 연결 종료됨");
			users.remove(senderId);
		}
	}
	
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		// 특정 유저에게 보내기
		String msg = message.getPayload();
		System.out.println(msg);
		if(msg != null) {
			String[] strs = msg.split(",");
			log(strs.toString());
			if(strs != null) {
				String sendId = strs[0];
				String reciveId = strs[1]; // m_id 저장
				System.out.println(sendId);
				System.out.println(reciveId);
				WebSocketSession targetSession = users.get(reciveId);  // 메시지를 받을 세션 조회
				
				// 실시간 접속시
				if(targetSession!=null) {
					TextMessage tmpMsg = new TextMessage(sendId+"님이 친구신청을 보냈습니다");
					targetSession.sendMessage(tmpMsg);
				}
			}
		}
	}
	
	// 웹소켓에 id 가져오기
    // 접속한 유저의 http세션을 조회하여 id를 얻는 함수
	private String getMemberId(WebSocketSession session) {
		Map<String, Object> httpSession = session.getAttributes();
		String m_id = (String) httpSession.get("sessionId"); // 세션에 저장된 m_id 기준 조회
		return m_id==null? null: m_id;
	}
}
