<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
	<header>
		<input id="hostId" type="hidden" value="${hostId}">
		<input id="sessionId" type="hidden" value="${sessionId}">
		<div class="icon">
			<img src="./resources/images/racon.png" alt="">
		</div>
		<div class="header_info">
			<i class="fa-regular fa-bell"></i>
			<div class="new_alert">N</div>
			<input type="hidden" value="${alertCount}" id="alert_count">
			<div class="dropdown_friends dropdown">
				<!-- 이동경로 입력 -->
				<c:forEach var="item" items="${recieveFriends}">
					<input type="text" class="recieve_id hidden"
						value="${item.recieve_id}">
					<input type="text" class="send_id hidden" value="${item.send_id}">
					<input type="text" value="${item.f_num}" class="f_num hidden">
					<div class="friends_alert dropdown-item">
						<span class="friends_name">${item.m_name}</span>님 으로부터의 일촌신청
					</div>
				</c:forEach>
			</div>
			<img class="header_profile"
				src="./resources/images/${headerProfile.h_pic}" alt="">
			<div class="profile_drop">
				<span>${headerProfile.m_nick}</span> <i
					class="fa-sharp fa-solid fa-chevron-down"></i>
			</div>
			<div class="dropdown_profile dropdown">
				<!-- 이동경로 입력 -->
				<a href="#"><div class="dropdown-item">
						<i class="fa-solid fa-gear"></i>&nbsp회원설정
					</div></a> <a href="#"><div class="dropdown-item">
						<i class="fa-solid fa-house-lock"></i>&nbsp공개설정
					</div></a> <a href="/cy/logout"><div class="dropdown-item">
						<i class="fa-solid fa-right-from-bracket"></i>&nbsp로그아웃
					</div></a>
			</div>
		</div>
	</header>
	<div class="nav_section">
		<nav>
			<div class="nav_wrap">
				<div class="music_player">
					<audio id="audioPlayer" controls onloadstart="this.volume=0.5">
						<source id="audioSource" src="./resources/mp3/a01.mp3" type="audio/mp3">
						Your browser does not support the audio element.
					</audio>
					<input type="hidden" value="${urllist}" id="myplayList">
					<input type="hidden" value="${titlelist}" id="titleList">
					<div class="music_name">
						<span class="songTitle">I AM - IVE</span> <i
							class="fa-solid fa-music"></i>
					</div>
					<div class="music_icon">
						<i class="fa-solid fa-backward-step"></i>
						<div class="play_btn" style="display: inline-block;">
							<i class="fa-solid fa-play"></i>
						</div>
						<i class="fa-solid fa-forward-step"></i>
					</div>
				</div>
                <div class="search">
                    <span><b>아이디검색</b></span>
                    <div class="search_bar">
                        <input type="text" id="search_text" list="ids" autocomplete="off">
                        <datalist id="ids">
                        </datalist>
                        <i class="fa-solid fa-magnifying-glass" id="searchbtn"></i>
                    </div>
                </div>
                <div class="menu">
					<a href="/cy/myhome?id=${hostId }">
						<input type="hidden" value="0">
						<div class="menu_box">홈</div>
					</a> 
					<a href="/cy/profile?id=${hostId }">
						<input type="hidden" value="${banner.B_HIDE_PROFILE}">
						<div class="menu_box">프로필</div>
					</a>
					<a href="/cy/myjuke?id=${hostId }">
						<input type="hidden" value="${banner.B_HIDE_MUSIC }">
						<div class="menu_box">주크박스</div>
					</a>
					<a href="/cy/diary?id=${hostId }">
						<input type="hidden" value="${banner.B_HIDE_DIARY }">
						<div class="menu_box">다이어리</div>
					</a>
					<a	href="/cy/gallery?id=${hostId }">
						<input type="hidden"	value="${banner.B_HIDE_GALLERY }">
						<div class="menu_box">갤러리</div>
					</a>
					<a href="/cy/visit?id=${hostId }">
						<input type="hidden" value="0">
						<div class="menu_box">방명록</div>
					</a>
				</div>
            </div>
        </nav>
		</nav>