<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://kit.fontawesome.com/4ec79785b5.js" crossorigin="anonymous"></script>
<link rel="stylesheet" href="./resources/css/header_nav.css"> 
<link rel="stylesheet" href="./resources/css/visit.css">
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<script>
	$(document).ready(function() {
		let host = $('#host').val();
		let host_id = $('#host_id').val();
		let guest_id = $('#guest_id').val();
		console.log(host);
		console.log(host_id);
		console.log(guest_id);
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
        	<input id="host" type="hidden" value="${host }">
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
	                   	<input type="hidden" name="v_hostId" value="yun">
						<input type="hidden" name="v_guestId" value="yun">
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
	                    		<p>ㅇㅇ${list.v_guestId }</p>
	                		</div>
	                        <div class="guest_comment">
	                            <span>${list.v_time}</span>
	                            <div class="comment">
	                                <p>${list.v_text}</p>
	                            </div>
	                            <span>수정 | 삭제</span>
	                        </div>
	                    </div>
	                </c:forEach>
                </div>
            </div>
        </section>
    </div>
</body>
</html>