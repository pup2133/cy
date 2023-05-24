<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://kit.fontawesome.com/4ec79785b5.js"
	crossorigin="anonymous"></script>
<link rel="stylesheet" href="resources/css/header_nav.css">
<link rel="stylesheet" href="resources/css/gallery.css">
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<script>
	$(document).ready(function() {
				$('.gallery_comment').click(function() {
					let $galleryText = $(this).siblings('.gallery_text');
					let $comment = $(this).siblings('.comment_wrap');
					let $reg = $(this).siblings('.comment_reg');
					$comment.empty();

					$galleryText.hide();
					$comment.slideDown(700);
					$reg.show();
					$(this).hide();
					$(this).siblings('.gallery_comment2').show();
					
					let g_num = $galleryText.find('input[name="g_num"]').val();

					console.log(g_num);
					
 					$.ajax({
						url : "commentList", // 요청을 보낼 URL
						method : "POST",
						dataType : "json",
						data : {
							"g_num" : g_num,
						},
						success : function(data) {
							for(let i=0; i<data.length; i++){
								// 새로운 comment 요소 생성
								let newComment = $('<div>').addClass('comment');
								let commentProfile = $('<div>').addClass('comment_profile');
								let commentInfo = $('<div>').addClass('comment_info');
								let innerDiv1 = $('<div>');
								let innerDiv2 = $('<div>');
								let span1 = $('<span>').html('<b>' + data[i].m_nick + '</b>');
								let span2 = $('<span>').text('수정 | 삭제');
								let span3 = $('<span>').text(data[i].gc_text);
								let span4 = $('<span>').text(data[i].good_count);
								let span5 = $('<span>').text(data[i].g_time);
								let span6 = $('<span>').text('♥');

								// 요소들을 조립하여 새로운 요소에 추가
								innerDiv1.append(span1);
								innerDiv1.append(span2);
								innerDiv2.append(span3);
								innerDiv2.append(span4);
								innerDiv2.append(span5);
								innerDiv2.append(span6);
								commentProfile.append($('<img>').attr('src', data[i].g_pic));
								commentInfo.append(innerDiv1);
								commentInfo.append(innerDiv2);
								newComment.append(commentProfile);
								newComment.append(commentInfo);

								// 새로운 comment 요소를 원하는 위치에 추가
								$comment.append(newComment);
							}
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
				$('.gallery_good').click(
						function() {
							let g_num = $(this).closest('.gallery_text').find('input[name="g_num"]').val();
							let m_id = $(this).closest('.gallery_text').find('input[name="m_id"]').val();
							let good = $(this).closest('.gallery_text').find('.good').val();
							let good2 = $(this).closest('.gallery_text').find('.good');

							$.ajax({
								url : "good", // 요청을 보낼 URL
								method : "POST",
								dataType : "text",
								data : {
									"g_num" : g_num,
									"m_id" : m_id
								},
								success : function(data) {
									console.log(data);
									data === "minus" ? good2.val(--good) : good2.val(++good);
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
						url : "gallery_comment", // 요청을 보낼 URL
						method : "POST",
						dataType : "json",
						data : {
							"g_num" : g_num,
							"gc_text" : gc_text
						},
						success : function(data) {
							// 새로운 comment 요소 생성
							let newComment = $('<div>').addClass('comment');
							let commentProfile = $('<div>').addClass('comment_profile');
							let commentInfo = $('<div>').addClass('comment_info');
							let innerDiv1 = $('<div>');
							let innerDiv2 = $('<div>');
							let span1 = $('<span>').html('<b>' + data.m_nick + '</b>');
							let span2 = $('<span>').text('수정 | 삭제');
							let span3 = $('<span>').text(data.gc_text);
							let span4 = $('<span>').text('0');
							let span5 = $('<span>').text(data.g_time);
							let span6 = $('<span>').text('♥');

							// 요소들을 조립하여 새로운 요소에 추가
							innerDiv1.append(span1);
							innerDiv1.append(span2);
							innerDiv2.append(span3);
							innerDiv2.append(span4);
							innerDiv2.append(span5);
							innerDiv2.append(span6);
							commentProfile.append($('<img>').attr('src', data.g_pic));
							commentInfo.append(innerDiv1);
							commentInfo.append(innerDiv2);
							newComment.append(commentProfile);
							newComment.append(commentInfo);

							// 새로운 comment 요소를 원하는 위치에 추가
							$commentWrap.append(newComment);
							
							text.val('');
							$commentWrap.animate({ scrollTop: $commentWrap[0].scrollHeight }, 'slow');

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
								<div class="title">
									<h1>${list.g_title }</h1>
									<h4>수정 | 삭제</h4>
								</div>
								<div class="gallery_img">
									<img src="./resources/file/${list.g_pic}">
								</div>
							</div>
							<div class="gallery_right">
								<h3>${list.g_time}</h3>
								<div class="gallery_box">
									<div class="comment_wrap">
<%-- 									<div class="comment">
											<div class="comment_profile">
												<img src="${comment.g_pic}" />
											</div>
											<div class="comment_info">
												<div>
													<span><b>${comment.m_nick}</b></span>
													<span>수정 | 삭제</span>
												</div>s
												<div>
													<span>${comment.gc_text}</span>
													<span>${comment.good_count }</span> 
													<span>${comment.g_time }</span>
													<span>♥</span>
												</div>
											</div>
										</div> --%>
									</div>
									<div class="gallery_text">
										<input type="hidden" name="g_num" value="${list.g_num}">
										<input type="hidden" name="m_id" value="${sessionId}">
										<p>${list.g_text}</p>
										<div>
											<input type="text" class="good" value="${list.good_count }"
												disabled> <span class="gallery_good">♥</span>
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