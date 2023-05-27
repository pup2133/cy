<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://kit.fontawesome.com/4ec79785b5.js" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<link rel="stylesheet" href="./resources/css/header_nav.css">
<link rel="stylesheet" href="./resources/css/gallery_reg.css">
<script>
  $(document).ready(function() {
    $('#file').change(function(event) {
      let file = event.target.files[0];
      let reader = new FileReader();
      
      reader.onload = function(e) {
        $('.gallery_img').css('background-image', 'url(' + e.target.result + ')');
        $('.gallery_img h1').hide();
      };
      
      reader.readAsDataURL(file);
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
				<div class="gallery_wrap">
					<form action="gallery/reg" method="post" enctype="multipart/form-data">
						<div class="gallery">
							<div class="gallery_left">
								<div class="gallery_img">
									<h1>사진 첨부</h1>
									<input name="file" type="file" id="file" accept="image/*">
								</div>
							</div>
							<div class="gallery_right">
								<div>
									<input type="text" name="g_title"> 
									<select name="g_secret">
										<option value="0">공개</option>
										<option value="1">비공개</option>
									</select>
								</div>
								<div class="gallery_box">
									<textarea name="g_text"></textarea>
								</div>
								<button>저장</button>
							</div>
						</div>
					</form>
				</div>
			</div>
		</section>
	</div>
</body>
</html>