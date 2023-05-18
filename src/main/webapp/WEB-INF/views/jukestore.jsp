<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <script src="https://kit.fontawesome.com/4ec79785b5.js" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="./resources/css/header_nav.css"> 
    <link rel="stylesheet" href="./resources/css/jukestore.css"> 
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script> 
    <script type="text/javascript">
	    $(document).ready(function(){
	        $('.btn').on('click',function(){
	        	alert("해당 음악을 구매하시겠습니까?");
	        	alert(this);
	        });
	    });
    </script>
</head>
<body>
    <header>
        <div class="icon">
            <img src="./resources/images/racon.png" alt="">
        </div>
        <div class="header_info">
            <i class="fa-regular fa-bell"></i>
            <img class="header_profile" src="./resources/images/ng.png" alt="">
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
            <div class="section_title">
                <span>음악상점</span>
                <div class="music_search">
                    <input type="text" placeholder="음악검색">
                    <i class="fa-solid fa-magnifying-glass"></i>
                </div>
            </div>
            <div class="albums style-2">
                <!-- 반복구간 -->
                <c:forEach var="item" items="${musiclist}">
                <div class="album">
                    <div class="img_container">
                        <div class="cover">
                            <div class="album_info">
                                <p class="hidden mu_code">${item.mu_code}</p>
                                <p>${item.mu_title}</p>
                                <p>${item.mu_artist}</p>
                                <a class="btn"><button>구매</button></a>
                            </div>
                        </div>
                        <img src="./resources/images/${item.mu_img}.jpg" alt="">
                    </div>
                    <span>${item.mu_artist}</span>
                </div>
                </c:forEach>
                
                <!-- 반복구간 -->
                
                
                
            </div>
        </section>
    </div>
</body>
</html>