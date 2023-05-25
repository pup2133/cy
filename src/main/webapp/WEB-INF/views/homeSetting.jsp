<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Document</title>
    <script src="https://kit.fontawesome.com/4ec79785b5.js"
	crossorigin="anonymous"></script>
    <link rel="stylesheet" href="resources/css/header_nav2.css">
    <link rel="stylesheet" href="./resources/css/homeSetting.css" />
  </head>
<body>
	<header>
		<div class="icon">
			<img src="resources/images/racon.png" alt="">
		</div>
		<div class="header_info">
			<i class="fa-regular fa-bell"></i> 
			<img class="header_profile"	src="resources/images/p.png" alt=""> 
			<span>너굴</span> 
			<i class="fa-sharp fa-solid fa-chevron-down"></i>
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

  <div class="container">
    <h1>홈피 설정</h1>
    <hr />
	</div>
	
  <div class="container2">
      <div class="block"></div>
      <form>
        <h3>프로필</h3>
        <div class="radio">
        <label>
          <input type="radio" name="contact" checked /><span>공개</span>
        </label>
        <label> <input type="radio" name="contact" /><span>비공개</span>
        </label>
        </div>

        <h3>쥬크박스</h3>
        <div class="radio">
        <label>
          <input type="radio" name="contact2" checked /><span>공개</span>
          </label>
        <label>
          <input type="radio" name="contact2" /><span>비공개</span>
        </label>
        </div>

        <h3>다이어리</h3>
        <div class="radio">
          <label>
            <input type="radio" name="contact3" checked /><span>공개</span>
            </label>
          <label>
            <input type="radio" name="contact3" /><span>비공개</span>
        </label>
        </div>
        <h3>갤러리</h3>
        <div class="radio">
        <label>
          <input type="radio" name="contact4" checked /><span>공개</span>
        </label>
        <label>
          <input type="radio" name="contact4" /><span>비공개</span>
        </label>
        </div>
        <button type="submit">저장</button>
      </form>
      
      
      <div class="block"></div>
      
    </div>
</section>    
</div>

    
</body>
</html>
