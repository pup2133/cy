<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
		$('.gallery_comment').click(function() {
			let $galleryText = $(this).siblings('.gallery_text');
			let $comment = $(this).siblings('.comment_wrap');
			let $reg = $(this).siblings('.comment_reg');

			if ($comment.css('display') == 'block') {
				$galleryText.css('display', 'block');
				$comment.css('display', 'none');
				$reg.css('display', 'none');
				$(this).children('h3').text('댓글 보기');
			} else {
				$galleryText.css('display', 'none');
				$comment.slideDown(700);
				$reg.css('display', 'block');
				$(this).children('h3').text('댓글 닫기');
			}
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
        <section>
            <div class="section_wrap">
                <div class="gallery_title">
                    <h1>갤러리</h1>
                    <div>
                        <a><i class="fa-solid fa-pen"></i></a>
                        <a><i class="fa-solid fa-list"></i></a>
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
	                                    <div class="comment">
	                                        <div class="comment_profile">
												<img src=""/>
	                                        </div>
	                                        <div class="comment_info">
	                                            <div>
	                                                <span><b>${list.g_pic}</b></span>
	                                                <span>수정 | 삭제</span>
	                                            </div>
	                                            <div>
	                                                <span>ㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇ</span>
	                                                <span>♥</span>
	                                            </div>
	                                        </div>
	                                    </div>
	                                </div>
	                                <div class="gallery_text">
	                                    <p>${list.g_text}</p>
	                                    <span>♥</span>
	                                </div>
	                                <div class="comment_reg">
	                                    <h4>댓글 쓰기</h4>
	                                    <div>
	                                        <textarea placeholder="댓글을 입력해주세요"></textarea>
	                                        <button>등록</button>
	                                        <div></div>
	                                    </div>
	                                </div>
	                                <div class="gallery_comment">
	                                    <h3>댓글 보기</h3>
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