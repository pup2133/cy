<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="false"%>
<%@ page import=" java.util.HashMap"%>
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
	<script src="https://kit.fontawesome.com/4ec79785b5.js" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
</head> 
<script>
	//---네비게이션 기능
	//배너공개비공개
	$(document).ready(function() {
		
	  $(".menu_box").click(function(event) {
	    event.preventDefault(); // 기본 이벤트(페이지 이동) 막기
	    let value = $(this).prev("input").val(); // menu_box 앞에 있는 input 요소의 값을 가져옴
	    if($('#hostId').val()===$('#sessionId').val()){
	    	let href = $(this).parent("a").attr("href"); // a 태그의 href 속성 값 가져옴
		    window.location.href = href; // 페이지 이동
	    }else if(value === "0") {
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
	  
	  
	  //오디오관련
	  const id= $('#hostId').val();
		const session = $('#sessionId').val();
	    let audio = document.getElementById('audioPlayer');
	    let playbackTimeKey = id+'Time'; //여기에 sessionId넣기
	    let playbackIndexKey = id+'Index'; //여기에 sessionId넣기
	    let playIngKey = id+'Ing';
	    
	    //db에서 목록 불러와서 playlist만들기
	    let playlist_text = $("#myplayList").val();
	    let titlelist_text = $("#titleList").val();
		console.log(playlist_text);
		console.log(titlelist_text);
		let regexForPlay = /([a-zA-Z0-9]+\.mp3)/g;
		let regexForTitle = /[\w가-힣]+/g;
		let playlist = $.map(playlist_text.match(regexForPlay), function(value) {
		  return value;
		});
		let titlelist = $.map(titlelist_text.match(regexForTitle), function(value) {
			  return value;
		});
		console.log(playlist);
		console.log(titlelist);
	    
	    let currentIndex = 0;
	    let currentIng = 0;
	    audio.src = './resources/mp3/'+playlist[currentIndex];
	    let storedPlayIng = localStorage.getItem(playIngKey);
	    console.log("저장된ing:"+storedPlayIng);
	    let storedPlaybackIndex = localStorage.getItem(playbackIndexKey);
	    if(storedPlaybackIndex){
	    	currentIndex = storedPlaybackIndex;
	    	$('.songTitle').text(titlelist[currentIndex]);
	    }
	    if(storedPlayIng){
	    	currentIng = storedPlayIng;
	    }
	    console.log(currentIng);
	    if(currentIng==1){
	    	playAudio();
	    }
	    chageIcon();
	    
	  	//재생아이콘 변경
	    function chageIcon(){
		    if(!audio.paused){
		        $(".play_btn").html('<i class="fa-solid fa-pause"></i>');
		    }else if(audio.paused){
		        $(".play_btn").html('<i class="fa-solid fa-play"></i>');
		    }
		}
	    // 오디오 재생
	    function playAudio() {
	        let storedPlaybackTime = localStorage.getItem(playbackTimeKey);
	        let storedPlaybackIndex = localStorage.getItem(playbackIndexKey);
	        let storedPlayIng = localStorage.getItem(playIngKey);
	        if (storedPlaybackTime) {
	            if(storedPlaybackIndex){
	                currentIndex = storedPlaybackIndex;
	        	    audio.src = './resources/mp3/'+playlist[currentIndex];   
	            }
	            audio.currentTime = parseFloat(storedPlaybackTime);
	        }
      	audio.play();
      	localStorage.setItem(playIngKey,"1");
      	currentIng="1";
	        $('.songTitle').text(titlelist[currentIndex]);
	    }
	
	    // 현재 재생 중인 오디오가 끝났을 때 호출되는 이벤트 리스너
	    audio.addEventListener('ended', function() {    
	    currentIndex++;
	    if (currentIndex >= playlist.length) {
	      currentIndex = 0; // 재생목록의 끝에 도달하면 처음으로 돌아감
	      clearPlaybackTime();
	    }
	    audio.src = './resources/mp3/'+playlist[currentIndex];   
	    playAudio();
	    });
	    
	    /*
	    // 오디오 일시 정지
	    function pauseAudio() {
	        audio.pause();
	        savePlaybackTime();
	        savePlaybackIndex();
	        localStorage.setItem(playIngKey,"0");
	    }
		
	    //페이지 로드 시 저장된 재생 시간 확인
	    window.addEventListener('load', function() {
	        let storedPlaybackTime = localStorage.getItem(playbackTimeKey);
	        let storedPlaybackIndex = localStorage.getItem(playbackIndexKey);
	        let storedPlayIng = localStorage.getItem(playIngKey);
	        if (storedPlaybackTime) {
	            playAudio();
	        }
	    });
		*/
	
	    // 페이지 이동 또는 리로드 시 재생 시간 저장
	    window.addEventListener('beforeunload', function() {
	        savePlaybackTime();
	        savePlaybackIndex();
	        savePlayIng();
	    });
	
	    // 재생 시간 저장
	    function savePlaybackTime() {
	    localStorage.setItem(playbackTimeKey, audio.currentTime.toString());
	    }
	    //재생 순서 저장
	    function savePlaybackIndex(){
	        localStorage.setItem(playbackIndexKey,currentIndex.toString());
	    }

	
	    // 재생 시간 초기화
	    function clearPlaybackTime() {
	    localStorage.removeItem(playbackTimeKey);
	    }
	    
	    //일시정지 및 재생
	    $(".play_btn").click(function(){
	        if (!audio.paused){
	            audio.pause();
	            savePlaybackTime();
	            savePlaybackIndex();
	            localStorage.setItem(playIngKey,"0");
	            currentIng="0";
	            $(".play_btn").html('<i class="fa-solid fa-play"></i>');
	        }else if(audio.paused){
	            playAudio();
	            $(".play_btn").html('<i class="fa-solid fa-pause"></i>');
	        }
	    })
	
	
	    //이전곡
	    $(".fa-backward-step").click(function(){
	        currentIndex--;
	        if (currentIndex < 0) {
	            currentIndex = playlist.length-1;
	        }
	        clearPlaybackTime();
		    audio.src = './resources/mp3/'+playlist[currentIndex];  
		    $('.songTitle').text(titlelist[currentIndex]);
		    playAudio();
		    chageIcon();
	    })
	
	    //다음곡
	    $(".fa-forward-step").click(function(){
	        currentIndex++;
	        if (currentIndex >= playlist.length) {
	            currentIndex = 0;
	        }
	        clearPlaybackTime();
		    audio.src = './resources/mp3/'+playlist[currentIndex];
		    $('.songTitle').text(titlelist[currentIndex]);
		    playAudio();
		    chageIcon();
	    })
	});
	
	

	
	//---홈 메인 기능
	$(document).ready(function(){
		const id= $('#hostId').val();
		const session = $('#sessionId').val();
		
		//말줄입표 기능
		let  maxLength = 20; // 최대 글자 수
        $(".list_content").each(function() {
            let content = $(this).text();
            if (content.length > maxLength) {
                let trimmedContent = content.substr(0, maxLength);
                $(this).text(trimmedContent + "..."); // 말줄임표 추가
            }
        });
	
		//일촌신청
		$.ajax({
			type:"POST",
			url:"isFriend",
			data:{id:id},
			success:function(data){
				if(data!==1 && id!==session){
					$(".send_friend").css({"display":"block"});
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
		})
		//프로필 메시지 수정, 버튼 숨기기
		if(id!==session){
			$(".edit_button").hide();
		}
		let ingEdit=0;
        $(".edit_button").click(function(){
        	alert(ingEdit);
            if(ingEdit===0){
                $(".edit_msg").css("display","inline-block");
                let h_msg = $(".home_profile_text").text();
                $(".edit_msg").val(h_msg);
                ingEdit=1;
            }else if(ingEdit===1){
                $(".edit_msg").css("display","none");
                let h_msg=$(".edit_msg").val();
                //요 메시지를 ajax로 전달하여db에서 수정
                $.ajax({
                	type:"POST",
                	url:"editMsg",
                	dataType:"json",
                	data:{
                		id:id,
                		h_msg:h_msg
                	},
                	success:function(data){
                		console.log(data);
                	},
                	error:function(err){
                		console.log(err);
                	}
                })
                $(".home_profile_text").html(h_msg);
                ingEdit=0;
            }
        })
	})
    
    //파도타기
    $(document).ready(function name() {
    	$("#wave_list").change(function name() {
    		let m_id = $("#wave_list :selected").val();
    		location.href = "myhome?id=" + m_id;
		});
    	
    	//랜덤
    	$("#wave_random").click(function name() {
    		location.href = "myhome?id=${r_id}";
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
    		location.href = "myhome?id=" + s_id;
		})
	});

	
</script>
<script src="./resources/js/header.js"></script>
<body>
		<%@ include file="header_nav.jsp"%>
		<section>
			<div class="main_section">
				<div class="diary_visit_wrap">
					<div class="diary_box preview_list_wrap">
						<!-- 최대6개 가져오기 -->
						<div class="box_title">다이어리</div>
						<div>
							<ul class="preview_list">
								<c:forEach var="item" items="${diaryList}" varStatus="status"
									end="5">
									<li><span class="hidden">${item.d_num}</span><span
										class="list_content">${item.d_text}</span></li>
								</c:forEach>
							</ul>
						</div>
					</div>
					<div class="visit_box preview_list_wrap">
						<div class="box_title">방명록</div>
						<div>
							<ul class="preview_list">
								<c:forEach var="item" items="${visitList}" varStatus="status"
									end="5">
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
						<div class="home_profile_img">
							<img src="./resources/images/${homeProfile.h_pic}" alt="">
						</div>
						<div class="home_profile_text_wrap">
							<div class="home_profile_text">${homeProfile.h_msg}</div>
							<button class="edit_button">
								<i class="fa-solid fa-pen-to-square"></i>
							</button>
						</div>
						<textarea rows="4" cols="15"
							class="edit_msg home_profile_text_wrap"></textarea>
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
						</a> <a href="/cy/gallery?id=${hostId}"
							class="preview_gallery preview"> <i
							class="fa-solid fa-image preview_icon"></i>
							<div class="preview_content">
								<div>${previewNum.get(1)}</div>
								<div>갤러리&nbsp;</div>
							</div>
						</a> <a href="/cy/friends?id=${hostId}"
							class="preview_friends preview"> <i
							class="fa-solid fa-user-group preview_icon"></i>
							<div class="preview_content">
								<div class="friends_count">${previewNum.get(2)}</div>
								<div>
									일촌
									<sapn>&nbsp;&nbsp;&nbsp;</sapn>
								</div>
							</div>
						</a> <a href="/cy/visit?id=${hostId}" class="preview_visit preview">
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