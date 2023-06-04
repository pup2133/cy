<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${host }님의 홈페이지</title>
<script src="https://kit.fontawesome.com/4ec79785b5.js" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.7.0.js" integrity="sha256-JlqSTELeR4TLqP0OG9dxM7yDPqX1ox/HfgiSLBj8+kM=" crossorigin="anonymous"></script>
<!-- CSS only -->
<link rel="stylesheet" href="./resources/css/header_nav.css"> 
<link rel="stylesheet" href="./resources/css/visit.css">
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.7.5/dist/sweetalert2.min.js"></script>
<script>
$(document).ready(function() {
	
    // 웹소켓 연결
    const sock = new SockJS('/cy/alram');

    // 데이터를 전달 받았을 때
    sock.onmessage = onMessage; // toast 생성
    
	$('.page-item.active').removeClass('active');
	const host = $("#hostId").val();
	const sessionId = $("#sessionId").val();

	if (host == sessionId) {
		$(".guest_reg").hide();
	    $(".comment_list").css("height", "700px");
	    $('input[name="userType"]').val(sessionId);
	} else {
	    $('input[name="userType"]').val(host);
	}
	
	$(".geust_box").each(function() {
		const guestId = $(this).find("#guest_id").val();

	    if (guestId != sessionId && host != sessionId) {
	    	$(this).find("#edit, #delete, #line").hide();
	    } else if (host == sessionId) {
	    	$(this).find("#edit, #line").hide();
	    }
	});

	$(".geust_box").on("click", "#edit", function() {
		
		const $comment_update = $(this).closest(".geust_box").find(".comment_update");
	    const $comment = $(this).closest(".geust_box").find(".comment");
	    const $commentText = $comment.children("p").text();

	    $comment_update.show();
	    $comment_update.children("textarea").val($commentText);
	    $comment.hide();

	    $(this).hide();
	    $(this).closest(".geust_box").find("#edit2").show();
		
	});
	
	$(".geust_box").on("click", "#edit2", function() {
		
		const $comment_update = $(this).closest(".geust_box").find(".comment_update");
	    const $comment = $(this).closest(".geust_box").find(".comment");
	    const text = $(this).closest(".geust_box").find(".comment_update").children("textarea").val();
	 
		const v_num = $(this).closest("form[name='frmUpdate']").find("input[name='v_num']").val();
		const v_text = text;
		const v_time = $(this).closest("form[name='frmUpdate']").find("input[name='v_time']").val();
		const v_hostId = $(this).closest("form[name='frmUpdate']").find("input[name='v_hostId']").val();
		const v_guestId = $(this).closest("form[name='frmUpdate']").find("input[name='v_guestId']").val();
		
		const edit = $(this).closest(".geust_box").find("#edit");
		const edit2 = $(this);
	    
	    
		$.ajax({
			url: "visit/edit", // 요청을 보낼 URL
			method: "POST",
			dataType: "text",
			data: { 
				"v_num" : v_num,
				"v_text" : v_text,
				"v_time" : v_time,
				"v_hostId" : v_hostId,
				"v_guestId" : v_guestId
			},
			success: function(response) {
				$comment_update.hide();
				$comment.show();
				$comment.children("p").text(text);
				
			    edit2.hide();
			   	edit.show();

			},
			error: function(xhr, status, error) {
				console.log(error);
			}
		});
		
	  });	
});
</script>
<script src="./resources/js/header.js"></script>
</head>
<body>
	<%@ include file="header_nav.jsp"%>
        <section>
            <div class="section_wrap">
                <div class="guest_title">
                    <h1>방명록</h1>
                </div>
                <form name="frm" action="visit/reg" method="post">
	                <div class="guest_reg">
	                	<div class="pic_nickname">
	                		<img src="./resources/file/profile/${member.h_pic}">
	                   		<p>${member.m_nick}</p>
	                	</div>
	                    <textarea name="v_text"></textarea>
	                   	<input id="host" type="hidden" name="v_hostId" value="${sessionScope.hostId}">
						<input id="sessionId" type="hidden" name="v_guestId" value="${sessionScope.sessionId}">
	                    <div class="reg_btn">
	                        <button>등록</button>
	                    </div>
	                </div>
                </form>
                <div class="comment_list">
	                <c:forEach var="list" items="${list }">
	                	<div class="geust_box">
	                		<div class="guest_pic_nick">
	                			<img src="./resources/file/profile/${list.h_pic }">
	                    		<p>${list.m_nick }</p>
	                		</div>
	                		<form name="frmUpdate" action="visit/edit" method="post">
		                        <div class="guest_comment">
		                        	<input type="hidden" name="v_num" value="${list.v_num }">
									<input type="hidden" name="v_time" value="${list.v_time }">
		                        	<input id="host_id" type="hidden" name="v_hostId" value="${list.v_hostId }">
		                        	<input id="guest_id" type="hidden" name="v_guestId" value="${list.v_guestId }">
		                            <span>${list.v_time}</span>
		                            <div class="comment">
		                                <p>${list.v_text}</p>
		                            </div>
		                            <div class="comment_update">
		                            	<textarea name="v_text"></textarea>
		                            </div>
		                            <div>
		                            	<button id="edit" type="button">수정</button>
		                            	<button id="edit2" type="button">수정</button>
		                            </div>
		                        </div>
	                       	</form>
	                       	<span id="line">|</span>
	                       	<form name="frmDelete" action="visit/delete" method="post">
	                       		<input type="hidden" name="v_num" value="${list.v_num }">
	                       		<input type="hidden" name="userType" value="">
	                       		<button id="delete">삭제</button>
	                       	</form>
	                    </div>
	                </c:forEach>
	                
					<div class ="page">
						<ul class="pagination">
					    	<li class="page-item"><a class="page-link" href="./visit?id=${hostId}&page=1"><</a></li>
					    	<c:forEach var="pageNumber" begin="${startPage}" end="${endPage}">
					    		<li class="page-item"><a class="page-link" href="./visit?id=${hostId}&page=${pageNumber}">${pageNumber}</a></li>
					 		</c:forEach>
					    	<li class="page-item"><a class="page-link" href="./visit?id=${hostId}&page=${totalPages}">></a></li>
					  	</ul>
					</div>
                </div>
            </div>
        </section>
    </div>
</body>
</html>