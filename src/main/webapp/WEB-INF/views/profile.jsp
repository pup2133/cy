<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>프로필</title>
    <script src="https://code.jquery.com/jquery-3.7.0.js" integrity="sha256-JlqSTELeR4TLqP0OG9dxM7yDPqX1ox/HfgiSLBj8+kM=" crossorigin="anonymous"></script>
    <script src="https://kit.fontawesome.com/4ec79785b5.js" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="resources/css/header_nav.css" />
	<link rel="stylesheet" href="resources/css/profile.css" />
    <script>
      let updateText = 0;
      function update_profile() {
        let area = document.querySelectorAll(".update_profile");
        
        let m_name = $("#m_name").val();
        let m_birth = $("#m_birth").val();
        let m_email = $("#m_email").val();
        let m_tel = $("#m_tel").val();
        let p_text = $("#p_text").val();
        
        if (updateText == 0) {
          $(area).removeAttr("readonly", false);
          $(area).css("cursor", "text");
          $("#m_name").focus();
          updateText = 1;
        } else if (updateText == 1) {
          $(area).attr("readonly", true);
          $.ajax({
            url: "profile/profileUpdate",
            method: "POST",
            data: {
              m_id: "${profile.m_id}",
              m_name: m_name,
              m_birth: m_birth,
              m_email: m_email,
              m_tel: m_tel,
              p_text: p_text
            },
            success: function (data) {},
            error: function (err) {
              console.log(err);
            },
          });
          $(area).css("cursor", "default");
          updateText = 0;
        }
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
          <div class="section_title">
            <p style="width: 150px">프로필</p>
            <div><a href="javascript:void(0);" onclick="update_profile()">수정</a></div>
          </div>
        </div>
        <div class="profile">
          <div class="info_wrap">
            <div class="info m_name">
              <h2>이름</h2>
              <input type="text" class="update_profile" id="m_name" value="${profile.m_name}" maxlength="10" readonly/>
            </div>
            <div class="info m_birth">
              <h2>생년월일</h2>
              <input type="text" class="update_profile" id="m_birth" value="${profile.m_birth}" maxlength="10" readonly />
            </div>
            <div class="info m_email">
              <h2>이메일</h2>
              <input type="text" class="update_profile" id="m_email" value="${profile.m_email}" maxlength="50" readonly />
            </div>
            <div class="info m_tel">
              <h2>전화번호</h2>
              <input type="text" class="update_profile" id="m_tel" value="${profile.m_tel}" maxlength="13" readonly />
            </div>
          </div>
          <div class="pic" style="background-image: url(${profile.p_pic});"></div>
          <div class="p_text">
            <h2>소개글</h2>
            <textarea name="" id="p_text" class="update_profile" readonly>${profile.p_text}</textarea>
          </div>
        </div>
      </section>
    </div>
  </body>
</html>