<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import=" java.util.HashMap" %>
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
	//---헤더기능
	//드롭다운
	$(document).ready(function() {
        $('.profile_drop').click(function() {
            $('.dropdown_profile').slideToggle(200);
        });

        $('.fa-bell').click(function() {
            $('.dropdown_friends').slideToggle(200);
        });
    });;
	//유효성 (필요하면 사용)
	$(document).ready(function(){
		const host = $('#hostId').val();
		const session = $('#sessionId').val();
	})
	//친구알림체크
	function checkAlert(){
		if(parseInt($('#alert_count').val())===0){
			$('.dropdown_friends').text("새로운 일촌신청이 없습니다.");
			$('.dropdown_friends').css("text-align","center");
			$('.new_alert').hide();
		}
	}
	//친구알림,수락
	$(document).ready(function(){
		const host = $('#hostId').val();
		const session = $('#sessionId').val();
		checkAlert();
		let alert_count = parseInt($('#alert_count').val());
		$(".friends_alert").click(function(){
			let recieve_id = $(this).prevAll(".recieve_id").val();
			let send_id = $(this).prevAll(".send_id").val();
			let f_num = $(this).prev("input").val();
			let f_name=$(this).find(".friends_name").text();
			let $this = $(this);
			Swal.fire({
				title: '일촌신청 수락 하시겠습니까?',
                text: f_name+"님의 일촌신청",
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: '수락',
                cancelButtonText: '거절',
                reverseButtons: true, // 버튼 순서 거꾸로
			}).then((result)=>{
				if(result.isConfirmed){
					$.ajax({
						type:"POST",
						url:"accept",
						data:{f_num:f_num},
						success:function(data){
							console.log("수락됨");
							Swal.fire({
	                            icon: 'success',
	                            title: '일촌맺기 완료',
	                            text: f_name+'님과 일촌이 되었습니다',
	                        });
							if(host===recieve_id || host===send_id){
								let friends_count = parseInt($(".friends_count").text())+1;  //일촌증가(임시)
								$(".friends_count").text(friends_count);
							}
						},
						error:function(err){
							console.log(err);
						}
					})
				}else if(!result.isConfrmed){
					$.ajax({
						type:"POST",
						url:"reject",
						data:{f_num:f_num},
						success:function(data){
							Swal.fire({
	                            title: '일촌신청 거절',
	                            text: f_name+'님의 일촌신청을 거절했습니다',
	                        });
						},
						error:function(err){
							console.log(err);
						}
					})
				}
				$this.remove();  //알람삭제(임시)
				alert_count=alert_count-1;
				$('#alert_count').val(alert_count);
				checkAlert();
			})
		})
	})
	//---네비게이션 기능
	//배너공개비공개
	$(document).ready(function() {
	  $(".menu_box").click(function(event) {
	    event.preventDefault(); // 기본 이벤트(페이지 이동) 막기
	    let value = $(this).prev("input").val(); // menu_box 앞에 있는 input 요소의 값을 가져옴
	    if($('#hostId').val()===$('#sessionId').val()){
	    	let href = $(this).parent("a").attr("href"); // a 태그의 href 속성 값 가져옴
		    window.location.href = href; // 페이지 이동
	    }else if(value === "1") {
	      // 이동할 필요 없는 경우에 수행할 동작
	      // 예: 경고창 띄우기 또는 다른 작업 수행
	    	Swal.fire({
                icon: 'warning',
                title: '비공개',
                text: '비공개 페이지입니다',
            });
	    } else {
	      // 이동해야 할 경우에 수행할 동작
	      // 예: 페이지 이동
	      let href = $(this).parent("a").attr("href"); // a 태그의 href 속성 값 가져옴
	      window.location.href = href; // 페이지 이동
	    }
	  });
	});

	//---홈 메인 기능
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
	
	$(document).ready(function(){
		const id= $('#hostId').val();
		const session = $('#sessionId').val();
		//일촌신청 버튼 숨기기
		$.ajax({
			type:"POST",
			url:"isFriend",
			data:{id:id},
			success:function(data){
				if(data===1 || id===session){
					$(".send_friend").hide();
				}
			},
			error:function(err){
				console.log(err);
			}
		})
		//일촌신청하기
		$(".send_friend").click(function(){
			Swal.fire({
				title: '일촌신청 하시겠습니까?',
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: '신청',
                cancelButtonText: '취소',
                reverseButtons: true, // 버튼 순서 거꾸로
			}).then((result)=>{
				if(result.isConfirmed){
					$.ajax({
						type:"POST",
						url:"sendFriend",
						data:{id:id},
						success:function(data){
							Swal.fire({
	                            icon: 'success',
	                            title: '신청완료',
	                        });
                            $(".send_friend").hide();
						},
						error:function(err){
							console.log(err);
						}
					})
					
				}
			})
			/*
			$.ajax({
				type:"POST",
				url:"sendFriend",
				data:{id:id},
				success:function(data){
					alert(data);
				},
				error:function(err){
					console.log(err);
				}
			})
			*/
		})
	})
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
            <div class="new_alert">N</div>
            <input type="text" value="${alertCount}" id="alert_count" class="hidden">
            <div class="dropdown_friends dropdown">
                <!-- 이동경로 입력 -->
                <c:forEach var="item" items="${recieveFriends}">
                	<input type="text" class="recieve_id hidden" value="${item.recieve_id}">
            		<input type="text" class="send_id hidden" value="${item.send_id}">
	                <input type="text" value="${item.f_num}" class="f_num hidden"><div class="friends_alert dropdown-item"><span class="friends_name">${item.m_name}</span>님 으로부터의 일촌신청</div>
                </c:forEach>
            </div>
            <img class="header_profile" src="./resources/images/${headerProfile.h_pic}" alt="">
            <div class="profile_drop">
                <span>${headerProfile.m_nick}</span>
                <i class="fa-sharp fa-solid fa-chevron-down"></i>
            </div>
            <div class="dropdown_profile dropdown">
                <!-- 이동경로 입력 -->
                <a href="#"><div class="dropdown-item"><i class="fa-solid fa-gear"></i>&nbsp회원설정</div></a>
                <a href="#"><div class="dropdown-item"><i class="fa-solid fa-house-lock"></i>&nbsp공개설정</div></a>
                <a href="/cy/logout"><div class="dropdown-item"><i class="fa-solid fa-right-from-bracket"></i>&nbsp로그아웃</div></a>
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
                    <a href="/cy/myhome?id=${hostId }"><input type="text" value="0" class="hidden"><div class="menu_box">홈</div></a>
                    <a href="/cy/profile?id=${hostId }"><input type="text" value="${banner.B_HIDE_PROFILE}" class="hidden"><div class="menu_box">프로필</div></a>
                    <a href="/cy/myjuke?id=${hostId }"><input type="text" value="${banner.B_HIDE_MUSIC }" class="hidden"><div class="menu_box">주크박스</div></a>
                    <a href="/cy/diary?id=${hostId }"><input type="text" value="${banner.B_HIDE_DIARY }" class="hidden"><div class="menu_box">다이어리</div></a>
                    <a href="/cy/gallery?id=${hostId }"><input type="text" value="${banner.B_HIDE_GALLERY }" class="hidden"><div class="menu_box">갤러리</div></a>
                    <a href="/cy/visit?id=${hostId }"><input type="text" value="0" class="hidden"><div class="menu_box">방명록</div></a>
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
                    <div>
                        <button class="send_friend">일촌신청하기</button>
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
                                <div class="friends_count">${previewNum.get(2)}</div>
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
