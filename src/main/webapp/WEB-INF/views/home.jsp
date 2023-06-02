<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
<script src="./resources/js/header.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
<script>

//---홈 메인 기능
$(document).ready(function(){
	
	const host = $('#hostId').val();
	const session = $('#sessionId').val();
			
	//상메
	let h_msg2 = $(".home_profile_text").text();
 	let abc = h_msg2.replace(/\n/g,"<br>");
	$(".home_profile_text").html(abc);

		
	//말줄입표 기능
	const  maxLength = 20; // 최대 글자 수
    $(".list_content").each(function() {
    	let content = $(this).text();
        if (content.length > maxLength) {
        	let trimmedContent = content.substr(0, maxLength);
            $(this).text(trimmedContent + "..."); // 말줄임표 추가
        }
    });
	
	console.log(host+"<<<");
	
	//일촌신청
	$.ajax({
		type:"POST",
		url:"isFriend",
		data:{id:host},
		success:function(data){
			if(data===1 || host===session){
				$(".send_friend").hide();
			}
		},
		error:function(err){
			console.log(err);
		}
	});
		
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
					data:{id:host},
					success:function(data){
                        sock.send(session + ',' + host);
						Swal.fire({
                            icon: 'success',
                            title: '신청완료',
                        });
                        $(".send_friend").hide();
					},
					error:function(err){
						console.log(err);
					}
				});
			}
		});
	});
		
	//프로필 메시지 수정, 버튼 숨기기
	if(host!==session){
		$(".edit_button").hide();
	}
	
	let ingEdit = 0;
	$(".edit_button").click(function(){
        if(ingEdit===0){
            $(".edit_msg").css("display","inline-block");
            let h_msg = $(".home_profile_text").html();
           	h_msg = h_msg.replace(/<br>/g,"\n");
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
            		id:host,
            		h_msg:h_msg
            	},
            	success:function(data){
            		console.log(data);
            	},
            	error:function(err){
            		console.log(err);
            	}
            });
           	h_msg = h_msg.replace(/\n/g,"<br>");
            $(".home_profile_text").html(h_msg);
            
            ingEdit=0;
        }
    });
    
    //파도타기
	$("#wave_list").change(function() {
		let m_id = $("#wave_list :selected").val();
		location.href = "myhome?id=" + m_id;
	});
	
	//랜덤
	$("#wave_random").click(function() {
		location.href = "myhome?id=${r_id}";
	});
    
});
</script>
</head> 
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
							<img src="./resources/file/profile/${homeProfile.h_pic}" alt="">
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
						<a href="/cy/diary?id=${hostId }&days=${sessionScope.days}" class="preview_diary preview">
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