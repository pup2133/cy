<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>홈</title>
    <script src="https://kit.fontawesome.com/4ec79785b5.js" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="./resources/css/header_nav.css"> 
    <link rel="stylesheet" href="./resources/css/home.css"> 
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.7.5/dist/sweetalert2.min.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.7.5/dist/sweetalert2.min.js"></script>
<script src="https://code.jquery.com/jquery-3.7.0.js" integrity="sha256-JlqSTELeR4TLqP0OG9dxM7yDPqX1ox/HfgiSLBj8+kM=" crossorigin="anonymous"></script>
    
</head> 
<script>	
	//헤더기능
	$(document).ready(function() {
	    $('.header_info').click(function() {
	        $('.dropdown').slideToggle(200);
	    });
	    
	});

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
    
    //파도타기
    $(document).ready(function name() {
    	$("#wave_list").change(function name() {
    		let m_id = $("#wave_list :selected").val();
    		location.href = "home?id=" + m_id;
		});
    	
    	//랜덤
    	$("#wave_random").click(function name() {
    		location.href = "home?id=${r_id}";
		});
    	
    	//검색 리스트
    	$.ajax({
    	      url: "searchList",
    	      method: "get",
    	      success: function(list){
    	    	  $.each(JSON.parse(list), function(key, m){ 
    	    		    let tmp = "<option value='"+m.m_id+"'>"+m.m_nick+"</option>";
    	    		    $("#ids").append(tmp);
    	    		});
    	      },
    	      error:function(err){
    	        console.log(err);
    	      }    
    	    });
    	
    	//아이디 검색
    	$("#searchbtn").click(function name() {
    		let s_id = $("#search_text").val();
    		location.href = "home?id=" + s_id;
		})
	});
    
</script>
<body>
	<header>
        <div class="icon">
            <img src="./resources/images/racon.png" alt="">
        </div>
        <div class="header_info">
            <i class="fa-regular fa-bell"></i>
            <img class="header_profile" src="./resources/images/ng.png" alt="">
            <div class="profile_drop">
                <span>너굴</span>
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
                        <input type="text" id="search_text" list="ids" autocomplete="off">
                        <datalist id="ids">
                        </datalist>
                        <i class="fa-solid fa-magnifying-glass" id="searchbtn"></i>
                    </div>
                </div>
                <div class="menu">
                    <a href="home?id=${hostId}"><div class="menu_box">홈</div></a>
                    <a href="profile?id=${hostId}"><div class="menu_box">프로필</div></a>
                    <a href=""><div class="menu_box">주크박스</div></a>
                    <a href="diary?id=${hostId}&days=${today}"><div class="menu_box">다이어리</div></a>
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
                                <li><span class="list_content">이것은 내용</span></li>
                                <li><span class="list_content">내요요요요용</span></li>
                                <li><span class="list_content">내용내 용내용 내용내용내용내 용내용내용용내용내용내용내용내용내용내용내용내용내용내용</span></li>
                                <li><span class="list_content">내용내 용내용 내용 내용내용내용내용내 용용내용내용내용내용내용내용내용내용내용내용내용</span></li>
                                <li><span class="list_content">길어지면 말줄임표</span></li>
                                <li><span class="list_content">6개가 최대</span></li>

                            </ul>
                        </div>
                    </div>
                    <div class="visit_box preview_list_wrap">
                        <div class="box_title">방명록</div>
                        <div>
                            <ul class="preview_list">
                                <li><span class="list_content">방명록 남김</span><span class="list_nick">닉네임입니다</span></li>
                                <li><span class="list_content">호이호이</span><span class="list_nick">닉네임입니다</span></li>
                                <li><span class="list_content">내용내용내용내용내용내용내용내용내용용내용내용내용내용내용내용내용내용내용내용내용</span><span class="list_nick">닉네임은 열자까지가능?</span></li>
                                <li><span class="list_content">내용내용내용내용내용내용내용내용내용용내용내용내용내용내용내용내용내용내용내용내용</span><span class="list_nick">닉네임입니다</span></li>
                                <li><span class="list_content">내용내용내용내용내용내용내용내용내용용내용내용내용내용내용내용내용내용내용내용내용</span><span class="list_nick">닉네임입니다</span></li>
                                <li><span class="list_content">내용내용내용내용내용내용내용내용내용용내용내용내용내용내용내용내용내용내용내용내용</span><span class="list_nick">닉네임입니다</span></li>
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
                            <img src="./resources/images/a03.jpg" alt="">
                            <img src="./resources/images/ive.jpg" alt="">
                            <img src="./resources/images/new.jpg" alt="">
                            <img src="./resources/images/m06.jpg" alt="">
                            <img src="./resources/images/m05.jpg" alt="">
                            <img src="./resources/images/m02.jpg" alt="">
                            <img src="./resources/images/m01.jpg" alt="">

                        </div>
                    </div>
                </div>
            </div>

            <div class="home_profile_side">
                <div class="home_profile_side_wrap">
                    <div class="today_wrap">
                        <div class="today">
                            <div class="today_num num">230</div>
                            <div>TODAY</div>
                        </div>
                        <!-- 방문자수 가져오기 -->
                        <div class="total">
                            <div class="total_num num">400</div>
                            <div>TOTAL</div>
                        </div>
                    </div>
                    <!-- 프로필 정보 가져오기 -->
                    <div class="home_profile_info_wrap">
                        <div class="home_profile_img"><img src="./resources/images/ng.png" alt=""></div>
                        <div class="home_profile_text">
                            안녕하세요 너구리입니다.아하하하하하하하하하
                            솜사탕사탕사탕아아아앙아ㅏ아아아아아ㅏ아ㅏ앙
                        </div>
                    </div>
                    <!-- 친구목록, 파도타기 기능 -->
                    <div class="wave_wrap">
                        <div>
							<select id="wave_list">
								<option>친구목록</option>
								<c:forEach var="f" items="${friends}">
									<option value="${f.m_id}">${f.m_nick}</option>
								</c:forEach>
							</select>
							<button id="wave_random">Random</button>
						</div>
                    </div>
                    <!-- 프리뷰 가져오기 -->
                    <div class="preview_wrap">
                        <div class="preview_diary preview">
                            <i class="fa-solid fa-book preview_icon"></i>
                            <div class="preview_content">
                                <div>11</div>
                                <div>다이어리</div>
                            </div>
                        </div>
                        <div class="preview_gallery preview">
                            <i class="fa-solid fa-image preview_icon"></i>
                            <div class="preview_content">
                                <div>112</div>
                                <div>갤러리&nbsp;</div>
                            </div>
                        </div>
                        <div class="preview_friends preview">
                            <i class="fa-solid fa-user-group preview_icon"></i>
                            <div class="preview_content">
                                <div>55<span>&nbsp;&nbsp;</span></div>
                                <div>일촌<sapn>&nbsp;&nbsp;&nbsp;</sapn></div>
                            </div>
                        </div>
                        <div class="preview_visit preview">
                            <i class="fa-solid fa-pen-nib preview_icon"></i>
                            <div class="preview_content">
                                <div>121</div>
                                <div>방명록&nbsp;</div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>

        </section>
    </div>
</body>
</html>