<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://kit.fontawesome.com/4ec79785b5.js" crossorigin="anonymous"></script>
<link rel="stylesheet" href="resources/css/header_nav.css">
<link rel="stylesheet" href="resources/css/gallery.css">
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<script>
	$(document).ready(function() {
		
		const host = $("#host").val();
		const sessionId = $("#sessionId").val();

		if (host != sessionId) {
			$('.editGallery').hide();
			$('.deleteGallery').hide();
		}
		
		function comment(data, commentWrap){
			for(let i=0; i<data.length; i++){
				// 새로운 comment 요소 생성
				let edit_comment;
				let edit_comment2;
				let delete_comment;
				
				let newComment = $('<div>').addClass('comment');
				let commentProfile = $('<div>').addClass('comment_profile');
				let commentInfo = $('<div>').addClass('comment_info');
				let innerDiv1 = $('<div>');
				let innerDiv2 = $('<div>').addClass('comment_text');
				let innerDiv3 = $('<div>');
				let innerDiv4 = $('<div>');
				let span1 = $('<b>').text(data[i].m_nick);
				let span2 = $('<span>').text(data[i].g_time);
				let span3 = $('<span>').addClass('gc_text').text(data[i].gc_text);
				let span4 = $('<span>').addClass('gc_good').text(data[i].good_count);
				let span5 = $('<span>').addClass('comment_good').text('♥');
				let textarea = $('<textarea>').addClass('edit').text(data[i].gc_text).css('display','none');
				if(host == sessionId && sessionId != data[i].m_id){
					delete_comment = $('<button>').addClass('delete_comment').text('삭제');
				}else if(data[i].m_id == sessionId){
					edit_comment = $('<button>').addClass('edit_comment').attr('type','button').text('수정');
					edit_comment2 = $('<button>').addClass('edit_comment2').attr('type','button').text('수정2').css('display', 'none');
					delete_comment = $('<button>').addClass('delete_comment').text('삭제');
				}
				let gc_num = $('<input>').attr({'type' : 'hidden', 'name' : 'gc_num'}).val(data[i].gc_num);
				
				// 요소들을 조립하여 새로운 요소에 추가
				innerDiv1.append(span1);
				innerDiv1.append(span2);
				innerDiv1.append(gc_num);
				innerDiv2.append(span3);
				innerDiv2.append(textarea);
				innerDiv3.append(edit_comment);
				innerDiv3.append(edit_comment2);
				innerDiv3.append(delete_comment);
				innerDiv4.append(span4);
				innerDiv4.append(span5);
				innerDiv2.append(innerDiv4);
				commentProfile.append($('<img>').attr('src', data[i].g_pic));
				commentInfo.append(innerDiv1);
				commentInfo.append(innerDiv2);
				commentInfo.append(innerDiv3);
				newComment.append(commentProfile);
				newComment.append(commentInfo);
				
				// 새로운 comment 요소를 원하는 위치에 추가
				commentWrap.append(newComment);

			}
		}
		
		$('.gallery_comment').click(function() {
			let $galleryText = $(this).siblings('.gallery_text');
			let $comment = $(this).siblings('.comment_wrap');
			let $reg = $(this).siblings('.comment_reg');
			let g_num = $galleryText.find('input[name="g_num"]').val();
			
			console.log(g_num);

			$comment.empty();
			$galleryText.hide();
			$comment.slideDown(700);
			$reg.show();
			$(this).hide();
			$(this).siblings('.gallery_comment2').show();
					
 			$.ajax({
				url : "commentList", // 요청을 보낼 URL
				method : "POST",
				dataType : "json",
				data : {
					"g_num" : g_num,
				},
				success : function(data) {
					console.log(data);
					comment(data,$comment);
				},
				error : function(error) {
				
				}
			}); 
		});
				
		$('.gallery_comment2').click(function() {
			let $galleryText = $(this).siblings('.gallery_text');
			let $comment = $(this).siblings('.comment_wrap');
			let $reg = $(this).siblings('.comment_reg');
			$comment.empty();

			$galleryText.show();
			$comment.hide();
			$reg.hide();
			$(this).hide();
			$(this).siblings('.gallery_comment').show();
						
		});
				
		$('.gallery_good').click(function() {
			let g_num = $(this).closest('.gallery_text').find('input[name="g_num"]').val();
			let m_id = $(this).closest('.gallery_text').find('input[name="m_id"]').val();
			let good = $(this).closest('.gallery_text').find('.good').val();
			let good2 = $(this).closest('.gallery_text').find('.good');

			$.ajax({
				url : "galleryGood", // 요청을 보낼 URL
				method : "POST",
				dataType : "text",
				data : {
					"g_num" : g_num,
					"m_id" : m_id
				},
				success : function(data) {
					data == 6 ? good2.val(--good) : good2.val(++good);
				},
				error : function(error) {
							
				}
			});
		});
				
		$('.d_reg').click(function() {
			let g_num = $(this).siblings('input[name="g_num2"]').val();
			let gc_text = $(this).siblings('textarea[name="gc_text"]').val();
			let text = $(this).siblings('textarea[name="gc_text"]');
			let $commentWrap = $(this).closest('.comment_reg').siblings('.comment_wrap');

			$.ajax({
				url : "comment", // 요청을 보낼 URL
				method : "POST",
				dataType : "json",
				data : {
					"g_num" : g_num,
					"gc_text" : gc_text
				},
				success : function(data) {				
					comment(data,$commentWrap);
					text.val('');
					$commentWrap.animate({ scrollTop: $commentWrap[0].scrollHeight }, 'slow');
				},
				error : function(error) {

				}
			});
		});
		
		$('.deleteGallery').click(function() {
			let g_num = $(this).closest('.gallery').find('input[name="g_num"]').val();
			let gallery = $(this).closest('.gallery');
			let fileName = $(this).siblings('input[name="g_pic"]').val();
			
			$.ajax({
				url : "deleteGallery",
				method : "POST",
				dataType : "text",
				data : {
					"g_num" : g_num,
					"fileName" : fileName
				},
				success : function(data) {
					gallery.remove();
				},
				error : function(error) {

				}
			});
			
		});
	
		$(document).on('click', '.edit_comment', function() {
			  $(this).hide();
			  $(this).siblings('.edit_comment2').show();
			  $(this).parent().siblings('.comment_text').children('span').hide();
			  $(this).parent().siblings('.comment_text').find('.edit').show();
			  			  
		});
		
		$(document).on('click', '.edit_comment2', function() {
			  $(this).hide();
			  $(this).siblings('.edit_comment').show();
			  let textarea = $(this).parent().siblings('.comment_text').find('.edit');
			  let textSpan = $(this).parent().siblings('.comment_text').find('.gc_text');
			  textSpan.text('');

			  let gc_num = $(this).closest('.comment_info').find('input[name="gc_num"]').val();
			  let gc_text = textarea.val();

				$.ajax({
					url : "editComment", // 요청을 보낼 URL
					method : "POST",
					contentType: "application/x-www-form-urlencoded; charset=UTF-8",
					dataType : "text",
					data : {
						"gc_num" : gc_num,
						"gc_text" : gc_text
					},
					success : function(data) {
						textarea.hide();
						textSpan.show();
						textSpan.text(gc_text);
					},
					error : function(error) {

					}
			});
		});
		
		$(document).on('click', '.delete_comment', function() {
			let gc_num = $(this).closest('.comment_info').find('input[name="gc_num"]').val();
			let comment = $(this).parent().parent().parent();
			$.ajax({
				url : "deleteComment", // 요청을 보낼 URL
			 	method : "POST",
				dataType:"text",
				data : { "gc_num" : gc_num },
				success : function(data) {
					comment.remove();
				},
				error : function(error) {
					  
				}
			});
		});
		
		$(document).on('click', '.comment_good', function() {
			let gc_num = $(this).closest('.comment_info').find('input[name="gc_num"]').val();
			let m_id = $(this).closest('.comment_wrap').siblings('.gallery_text').find('input[name="m_id"]').val();
			let good = $(this).siblings('.gc_good');
			let good2 = $(this).siblings('.gc_good').text();
			
			$.ajax({
				url : "commentGood", // 요청을 보낼 URL
				method : "POST",
				dataType:"text",
				data : {
					"gc_num" : gc_num,
					"m_id" : m_id
				},
				success : function(data) {
					data == 6 ? good.text(--good2) : good.text(++good2);
				},
				error : function(error) {
					
				}
			});
		});
	});
</script>
</head>
<body>
	<header>
		<input type="hidden" id="host" value="${hostId}">
		<input type="hidden" id="sessionId" value="${sessionId}">
		<div class="icon">
			<img src="resources/images/racon.png" alt="">
		</div>
		<div class="header_info">
			<i class="fa-regular fa-bell"></i> <img class="header_profile"
				src="resources/images/p.png" alt=""> <span>너굴</span> <i
				class="fa-sharp fa-solid fa-chevron-down"></i>
		</div>
	</header>
	<div class="nav_section">
		<nav>
			<div class="nav_wrap">
				<div class="music_player">
					<div class="music_name">
						<span>I AM - IVE</span> <i class="fa-solid fa-music"></i>
					</div>
					<div class="music_icon">
						<i class="fa-solid fa-backward-step"></i> <i
							class="fa-solid fa-play"></i> <i class="fa-solid fa-forward-step"></i>
					</div>
				</div>

				<div class="search">
					<span><b>아이디검색</b></span>
					<div class="search_bar">
						<input type="text" name="" id=""> <i
							class="fa-solid fa-magnifying-glass"></i>
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
				<div class="gallery_title">
					<h1>갤러리</h1>
					<div>
						<a><i class="fa-solid fa-pen"></i></a> <a><i
							class="fa-solid fa-list"></i></a>
					</div>
				</div>
				<!-- 갤러리 wrap 오버플로우 시 스크롤 -->
				<div class="gallery_wrap">
					<c:forEach var="list" items="${list }">
						<div class="gallery">
							<div class="gallery_left">
								<form action="editGallery" method="get">
									<div class="title">
										<input type="hidden" name="g_title" value="${list.g_title}">
										<input type="hidden" name="g_pic" value="${list.g_pic}">
										<input type="hidden" name="g_text" value="${list.g_text}">
										<input type="hidden" name="g_num" value="${list.g_num}">
										<h1>${list.g_title }</h1>
										<button class="editGallery">수정</button>
										<button type="button" class="deleteGallery">삭제</button>
									</div>
								</form>
								<div class="gallery_img">
									<img src="./resources/file/${list.g_pic}">
								</div>
							</div>
							<div class="gallery_right">
								<h3>${list.g_time}</h3>
								<div class="gallery_box">
									<div class="comment_wrap">
									</div>
									<div class="gallery_text">
										<input type="hidden" name="g_num" value="${list.g_num}">
										<input type="hidden" name="m_id" value="${sessionId}">
										<p>${list.g_text}</p>
										<div>
											<input type="text" class="good" value="${list.good_count }" disabled>
											<span class="gallery_good">♥</span>
										</div>
									</div>
									<div class="comment_reg">
										<h4>댓글 쓰기</h4>
										<div>
											<input type="hidden" name="g_num2" value="${list.g_num}">
											<textarea name="gc_text" placeholder="댓글을 입력해주세요"></textarea>
											<button class="d_reg">등록</button>
											<div></div>
										</div>
									</div>
									<div class="gallery_comment">
										<h3>댓글 보기</h3>
									</div>
									<div class="gallery_comment2">
										<h3>댓글 닫기</h3>
									</div>
								</div>
							</div>
						</div>
					</c:forEach>
				</div>
			</div>
		</section>
	</div>
</body>
</html>