package com.project.cy.util;

import java.util.HashMap;
import java.util.Map;

public class DiaryCommentPage {
	public Map<String, Integer> pagination(int totalCount, int page, int itemsPerPage) {

		Map<String, Integer> pagination = new HashMap<>();

		// itemsPerPage -> 방명록 페이지당 보여줄 개수
		int totalPages = (int) Math.ceil((double) totalCount / itemsPerPage); // 방명록 총 페이지 수
		int startItem = (page - 1) * itemsPerPage; // 조회 시작 위치
		int maxPaginationLinks = 5; // 보여줄 페이지 제한 최대 5개까지만
		int startPage = Math.max(1, page - maxPaginationLinks / 2); // 시작 페이지
		int endPage = Math.min(startPage + maxPaginationLinks - 1, totalPages); // 끝 페이지

		pagination.put("itemsPerPage", itemsPerPage);
		pagination.put("totalPages", totalPages);
		pagination.put("startItem", startItem);
		pagination.put("startPage", startPage);
		pagination.put("endPage", endPage);

		return pagination;

	}
}
