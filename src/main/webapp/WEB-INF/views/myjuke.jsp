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
    <link rel="stylesheet" href="./resources/css/myjuke.css"> 
    <!-- sweet alert -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.7.5/dist/sweetalert2.min.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.7.5/dist/sweetalert2.min.js"></script>
    
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script> 
    <script type="text/javascript">
    
    
    $(document).ready(function(){
    	
    	$(".play_music_info p:nth-child(1), .play_music_info p:nth-child(4)").hide();
    	$(".play_music").each(function(){
            var mm_in = $(this).find(".play_music_info p.mm_in").text();
            if(mm_in === "0"){
                $(this).hide();
            }
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
                <span>주크박스</span>
                <a href="juke_store.html"><button class="btn-15 custom-btn">상점가기</button></a>
            </div>
            <div class="music_section">
                <div class="music_wrap style-2">
                    <div class="music_list_wrap">
                        <!-- 반복시작 -->
                        <c:forEach var="item" items="${mylist}">
                        <div class="music_list"> 
                            <a class="cover" href="">
                                <div>
                                    +
                                </div>
                            </a>
                            <img src="./resources/images/${item.mu_img}.jpg" alt="">
                            <div class="music_info">
                                <p>${item.mu_title }</p>
                                <p>${item.mu_artist }</p>
                                <p>${item.mu_date }</p>
                                <p>${item.mu_genre }</p>
                            </div>
                        </div>
                        </c:forEach>
                        <!-- 반복종료 -->
                        

                    </div>
                </div>
                <div class="line">
                </div>
                <div>
                    <div class="play_list style-2">
                    	<c:forEach var="item" items="${mylist}">
                        <div class="play_music">
                            <div class="play_music_info_wrap">
                                <img src="./resources/images//ive.jpg">
                                <div class="play_music_info"> 
                                	<p>${item.mu_code}</p>
                                    <p>${item.mu_title }</p>
                                    <p>${item.mu_artist }</p>
                                    <p>${item.mm_in}</p>
                                </div>
                            </div>
                                <i class="fa-regular fa-x"></i>
                        </div>
                        </c:forEach>
                    </div>
                    <button class="save_btn">저장</button>
                </div>
            </div>
        </section>
    </div>
</body>
</html>