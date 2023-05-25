package com.project.cy.util;

public class isHostOrGuest {
	
	public String determineRole(String hostId, String sessionId) {
		if(sessionId.equals(hostId)) {
			return sessionId;
		}else {
			return hostId;
		}
	}

}
