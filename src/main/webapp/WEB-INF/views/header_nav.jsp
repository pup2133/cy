<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<header>
		<input type="hidden" id="host" value="${hostId}">
		<input type="hidden" id="sessionId" value="${sessionId}">
		<div class="icon">
			<img src="resources/images/racon.png" alt="">
		</div>
		<div class="header_info">
			<i class="fa-regular fa-bell"></i> 
			<img class="header_profile" src="resources/images/p.png" alt="">
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