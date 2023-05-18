<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://kit.fontawesome.com/4ec79785b5.js" crossorigin="anonymous"></script>
<link rel="stylesheet" href="./css/header_nav.css"> 
<link rel="stylesheet" href="./css/visit.css">
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
</head>
<body>
    <header>
        <div class="icon">
            <img src="/racon.png" alt="">
        </div>
        <div class="header_info">
            <i class="fa-regular fa-bell"></i>
            <img class="header_profile" src="/p.png" alt="">
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
                <div class="guest_title">
                    <h1>방명록</h1>
                </div>
                <div class="guest_reg">
                    <img src="/커비.png">
                    <textarea></textarea>
                    <div class="reg_btn">
                        <button>등록</button>
                    </div>
                </div>
                <div class="comment_list">
                    <div class="geust_box">
                        <img src="/커비.png">
                        <div class="guest_comment">
                            <span>2023.05.17</span>
                            <div class="comment">
                                <p>방명록<br>방명록<br>방명록<br>방명록<br>방명록<br>방명록<br>방명록<br>방명록</p>
                            </div>
                            <span>수정 | 삭제</span>
                        </div>
                    </div>

                    <div class="geust_box">
                        <img src="/커비.png">
                        <div class="guest_comment">
                            <span>2023.05.17</span>
                            <div class="comment">
                                <p>방명록<br>방명록<br>방명록<br>방명록<br>방명록<br>방명록<br>방명록<br>방명록</p>
                            </div>
                            <span>수정 | 삭제</span>
                        </div>
                    </div>

                    <div class="geust_box">
                        <img src="/커비.png">
                        <div class="guest_comment">
                            <span>2023.05.17</span>
                            <div class="comment">
                                <p>방명록<br>방명록<br>방명록<br>방명록<br>방명록<br>방명록<br>방명록<br>방명록</p>
                            </div>
                            <span>수정 | 삭제</span>
                        </div>
                    </div>

                    <div class="geust_box">
                        <img src="/커비.png">
                        <div class="guest_comment">
                            <span>2023.05.17</span>
                            <div class="comment">
                                <p>방명록<br>방명록<br>방명록<br>방명록<br>방명록<br>방명록<br>방명록<br>방명록</p>
                            </div>
                            <span>수정 | 삭제</span>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </div>
</body>
</html>