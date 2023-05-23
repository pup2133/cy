<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>오늘의 다이어리 쓰기</title>
    <script
      src="https://kit.fontawesome.com/4ec79785b5.js"
      crossorigin="anonymous"
    ></script>
    <link rel="stylesheet" href="resources/css/header_nav.css" />
    <link rel="stylesheet" href="resources/css/diary_reg.css" />
    
    <script type="text/javascript">
    	function diary_sub() {
			frm.submit();
		}
    </script>
  </head>
  <body>
    <header>
		<div class="icon">
			<img src="resources/images/racon.png" alt="" />
		</div>
		<div class="header_info">
			<i class="fa-regular fa-bell"></i>
			<img class="header_profile" src="resources/images/p.png" alt="" /> <span>너굴</span>
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
						<input type="text" name="" id="" />
						<i class="fa-solid fa-magnifying-glass"></i>
					</div>
				</div>
				<div class="menu">
					<a href="">
						<div class="menu_box">홈</div>
					</a>
					<a href="">
						<div class="menu_box">프로필</div>
					</a>
					<a href="">
						<div class="menu_box">주크박스</div>
					</a>
					<a href="">
						<div class="menu_box">다이어리</div>
					</a>
					<a href="">
						<div>갤러리</div>
					</a>
					<a href="">
						<div>방명록</div>
					</a>
				</div>
			</div>
		</nav>

      <section>
        <div class="section_wrap">
          <div class="diary_reg">다이어리 등록</div>
        </div>
        <div class="diary_cal">
          <form class="diary" name="frm" method="post">
            <h1>오늘의 일기</h1>
            <textarea name="d_text" id="" class="diary_text"></textarea>
            <div class="text_btn">
              <a href="javascript:void(0);" onclick="diary_sub()">등록</a> | <a href="javascript:history.back();">돌아가기</a>
            </div>
          </form>
         </div>
      </section>
    </div>
  </body>
</html>