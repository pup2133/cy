package com.project.cy.model.service;

import java.util.List;
import com.project.cy.model.dto.visit;

public interface visitServiceImp {
	
    public visit getMember(String id) throws Exception;
    
    public int addVisit(visit dto) throws Exception;
    
    public List<visit> getVisit(int startItem, int itemsPerPage, String id) throws Exception;

    public String getMemberId(String id) throws Exception;
    
    public int getTotalCount(String id) throws Exception;
    
    public int editVisit(visit v) throws Exception;
    
    public int deleteVisit(String v_num) throws Exception;
    
}
