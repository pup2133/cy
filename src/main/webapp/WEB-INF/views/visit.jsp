<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${host }님의 홈페이지</title>
<script src="https://kit.fontawesome.com/4ec79785b5.js" crossorigin="anonymous"></script>
<link rel="stylesheet" href="./resources/css/header_nav.css"> 
<link rel="stylesheet" href="./resources/css/visit.css">
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<script>
	$(document).ready(function() {
		
		let host = $("#host").val();
        let sessionId = $("#sessionId").val();
                
        if(host==sessionId){
        	$(".guest_reg").css("display", "none");
        	$(".comment_list").css("height","700px");
        	$('input[name="hOr"]').val(sessionId);
        }else{
        	$('input[name="hOr"]').val(host);
        }
		        
	    $(".geust_box").each(function() {
	        let hostId = $(this).find("#host_id").val();
	        let guestId = $(this).find("#guest_id").val();
	        
	        
	        if(guestId!=sessionId&&host!=sessionId){
	        	$(this).find("#edit").css("display", "none");
	        	$(this).find("#delete").css("display", "none");
	        }else if(host==sessionId){
	        	$(this).find("#edit").css("display", "none");
	        	$(this).find("#line").css("display", "none");
	        }

	    });
	    $(".geust_box").on("click", "#edit", function() {
	        let $comment_update = $(this).closest(".geust_box").find(".comment_update");
	        let $comment = $(this).closest(".geust_box").find(".comment");
	        let $comment2 = $(this).closest(".geust_box").find(".comment").children('p').text();
	        
	        $comment_update.css("display", "block");
	        $comment_update.children('textarea').val($comment2);
	        $comment.css("display", "none");
	       	
	        $(this).css('display','none');
	        $(this).closest(".geust_box").find("#edit2").css('display','block');
	        
	    });
	});

</script>
</head>
<body>
    <header>
        <div class="icon">
            <img src="/racon.png" alt="">
        </div>
        <div class="header_info">
            <i class="fa-regular fa-bell"></i>
            <img class="header_profile" src="/p.png" alt="">
            <span>너굴</span>
            <i class="fa-sharp fa-solid fa-chevron-down"></i>
        </div>
    </header>
    <div class="nav_section">
        <nav>
            <div class="nav_wrap">
                <div class="music_player">
                    <div class="music_name">
                        <span>I AM - IVE</span>
                        <i class="fa-solid fa-music"></i>
                    </div>
                    <div class="music_icon">
                        <i class="fa-solid fa-backward-step"></i>
                        <i class="fa-solid fa-play"></i>
                        <i class="fa-solid fa-forward-step"></i>
                    </div>
                </div>

                <div class="search">
                    <span><b>아이디검색</b></span>
                    <div class="search_bar">
                        <input type="text" name="" id="">
                        <i class="fa-solid fa-magnifying-glass"></i>
                    </div>
                </div>
                <div class="menu">
                    <a href=""><div class="menu_box">홈</div></a>
                    <a href=""><div class="menu_box">프로필</div></a>
                    <a href=""><div class="menu_box">주크박스</div></a>
                    <a href=""><div class="menu_box">다이어리</div></a>
                    <a href=""><div>갤러리</div></a>
                    <a href=""><div>방명록</div></a>
                </div>
            </div>
        </nav>
        <section>
            <div class="section_wrap">
                <div class="guest_title">
                    <h1>방명록</h1>
                </div>
                <form name="frm" action="./visit/Reg" method="post">
	                <div class="guest_reg">
	                	<div class="pic_nickname">
	                		<img src="${member.h_pic}">
	                   		<p>${member.m_nick}</p>
	                	</div>
	                    <textarea name="v_text"></textarea>
	                   	<input id="host" type="hidden" name="v_hostId" value="${host}">
						<input id="sessionId" type="hidden" name="v_guestId" value="${sessionId}">
	                    <div class="reg_btn">
	                        <button>등록</button>
	                    </div>
	                </div>
                </form>
                <div class="comment_list">
	                <c:forEach var="list" items="${list }">
	                	<div class="geust_box">
	                		<input id="host_id" type="hidden" value="${list.v_hostId }">
							<input id="guest_id" type="hidden" value="${list.v_guestId }">
	                		<div class="guest_pic_nick">
	                			<img src="${list.h_pic }">
	                    		<p>${list.m_nick }</p>
	                		</div>
	                		<form action="visit/commentUpdate" method="post">
		                        <div class="guest_comment">
		                        	<input type="hidden" name="v_num" value="${list.v_num }">
									<input type="hidden" name="v_time" value="${list.v_time }">
		                        	<input type="hidden" name="v_hostId" value="${list.v_hostId }">
		                        	<input type="hidden" name="v_guestId" value="${list.v_guestId }">
		                            <span>${list.v_time}</span>
		                            <div class="comment">
		                                <p>${list.v_text}</p>
		                            </div>
		                            <div class="comment_update">
		                            	<textarea name="v_text"></textarea>
		                            </div>
		                            <div>
		                            	<button id="edit" type="button">수정</button>
		                            	<button id="edit2">수정</button>
		                            </div>
		                        </div>
	                       	</form>
	                       	<span id="line">|</span>
	                       	<form action="visit/delete" method="post">
	                       		<input type="hidden" name="v_num" value="${list.v_num }">
	                       		<input type="hidden" name="hOr" value="">
	                       		<button id="delete">삭제</button>
	                       	</form>
	                    </div>
	                </c:forEach>
                </div>
            </div>
        </section>
    </div>
</body>
</html>