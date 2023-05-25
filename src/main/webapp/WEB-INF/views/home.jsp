<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <script src="https://kit.fontawesome.com/4ec79785b5.js" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="./resources/css/header_nav2.css"> 
    <link rel="stylesheet" href="./resources/css/home.css"> 

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.7.5/dist/sweetalert2.min.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.7.5/dist/sweetalert2.min.js"></script>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script> 
    
</head> 
<script>	
	//헤더기능
	$(document).ready(function() {
	    $('.header_info').click(function() {
	        $('.dropdown').slideToggle(200);
	    });

	});
	
	$(document).ready(function(){
		const host = $('#hostId').val();
		const session = $('#sessionId').val();
	})

    //말줄임표 기능
    $(document).ready(function() {
        let  maxLength = 20; // 최대 글자 수

        $(".list_content").each(function() {
            let content = $(this).text();
            if (content.length > maxLength) {
                let trimmedContent = content.substr(0, maxLength);
                $(this).text(trimmedContent + "..."); // 말줄임표 추가
            }
        });
    });
</script>
<body>
	<header>
		<input id="hostId" type="text" value="${hostId}" class="hidden">
    	<input id="sessionId" type="text" value="${sessionId}" class="hidden">
        <div class="icon">
            <img src="./resources/images/racon.png" alt="">
        </div>
        <div class="header_info">
            <i class="fa-regular fa-bell"></i>
            <img class="header_profile" src="./resources/images/${homeProfile.h_pic}" alt="">
            <div class="profile_drop">
                <span>${homeProfile.m_nick}</span>
                <i class="fa-sharp fa-solid fa-chevron-down"></i>
            </div>
            <div class="dropdown">
                <!-- 이동경로 입력 -->
                <a href="#"><div class="dropdown-item"><i class="fa-solid fa-gear"></i>&nbsp&nbsp회원설정</div></a>
                <a href="#"><div class="dropdown-item"><i class="fa-solid fa-house-lock"></i>공개설정</div></a>
                <a href="#"><div class="dropdown-item"><i class="fa-solid fa-right-from-bracket"></i>&nbsp&nbsp로그아웃</div></a>
            </div>
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
            <div class="main_section">
                <div class="diary_visit_wrap">
                    <div class="diary_box preview_list_wrap">
                        <!-- 최대6개 가져오기 -->
                        <div class="box_title">다이어리</div>
                        <div>
                            <ul class="preview_list">
							    <c:forEach var="item" items="${diaryList}" varStatus="status" end="5">
							        <li><span class="hidden">${item.d_num}</span><span class="list_content">${item.d_text}</span></li>
							    </c:forEach>
							</ul>
                        </div>
                    </div>
                    <div class="visit_box preview_list_wrap">
                        <div class="box_title">방명록</div>
                        <div>
                            <ul class="preview_list">
                            	<c:forEach var="item" items="${visitList}" varStatus="status" end="5">
                                <li><span class="list_content">${item.v_text }</span><span class="list_nick">${item.m_nick }</span></li>
                                </c:forEach>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="gallery_box">
                    <div class="gallery_img_wrap">
                        <div class="gallery_back">
                            <div class="back"></div>
                            <div class="back"></div>
                            <div class="back"></div>
                            <div class="back"></div>
                            <div class="back"></div>
                            <div class="back"></div>
                            <div class="back"></div>
                            <div class="back"></div>
                            <div class="back"></div>
                            <div class="back"></div>
                        </div>
                        <div class="gallery_img_box">
                            <!-- 이미지 10개만 불러오기 -->
                            <!-- 이미지 10개 이하인 경우 background보임 -->
                            <c:forEach var="item" items="${galleryList}" varStatus="status" end="9">
                            	<img src="./resources/images/${item.g_pic}" alt="">
							</c:forEach>
                        </div>
                    </div>
                </div>
            </div>
				${diary }
            <div class="home_profile_side">
                <div class="home_profile_side_wrap">
                    <div class="today_wrap">
                        <div class="today">
                            <div class="today_num num">${homeProfile.m_today}</div>
                            <div>TODAY</div>
                        </div>
                        <!-- 방문자수 가져오기 -->
                        <div class="total">
                            <div class="total_num num">${homeProfile.m_totaltoday}</div>
                            <div>TOTAL</div>
                        </div>
                    </div>
                    <!-- 프로필 정보 가져오기 -->
                    <div class="home_profile_info_wrap">
                        <div class="home_profile_img"><img src="./resources/images/${homeProfile.h_pic}" alt=""></div>
                        <div class="home_profile_text">
                            ${homeProfile.h_msg}
                        </div>
                    </div>
                    <!-- 친구목록, 파도타기 기능 -->
                    <div class="wave_wrap">
                        <div>파도타기 드롭박스 들어감</div>
                    </div>
                    <!-- 프리뷰 가져오기 -->
                    <div class="preview_wrap">
                        <a href="/cy/diary?id=${hostId}" class="preview_diary preview">
                            <i class="fa-solid fa-book preview_icon"></i>
                            <div class="preview_content">
                                <div>${previewNum.get(0)}</div>
                                <div>다이어리</div>
                            </div>
                        </a>
                        <a href="/cy/gallery?id=${hostId}" class="preview_gallery preview">
                            <i class="fa-solid fa-image preview_icon"></i>
                            <div class="preview_content">
                                <div>${previewNum.get(1)}</div>
                                <div>갤러리&nbsp;</div>
                            </div>
                        </a>
                        <a href="/cy/friends?id=${hostId}" class="preview_friends preview">
                            <i class="fa-solid fa-user-group preview_icon"></i>
                            <div class="preview_content">
                                <div>${previewNum.get(2)}<span>&nbsp;&nbsp;</span></div>
                                <div>일촌<sapn>&nbsp;&nbsp;&nbsp;</sapn></div>
                            </div>
                        </a>
                        <a href="/cy/visit?id=${hostId}" class="preview_visit preview">
                            <i class="fa-solid fa-pen-nib preview_icon"></i>
                            <div class="preview_content">
                                <div>${previewNum.get(3)}</div>
                                <div>방명록&nbsp;</div>
                            </div>
                        </a>
                    </div>
                </div>

            </div>

        </section>
    </div>
</body>
</html>
