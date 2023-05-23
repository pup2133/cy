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
    </head>
    <script type="text/javascript">
    
    
    $(document).ready(function(){
    	
    	const host = $("#hostId").val();
    	const session = $("#sessionId").val();
		
		if(host!==session){
			$(".cover").hide();
			$(".line").hide();
			$(".playlists").hide();
			
			$('.music_wrap').css('width', '1200px');
			$('.music_list').css('width', '25%');
		}
	
    	//날짜 형식 변경
    	$(".music_info p:nth-child(3)").each(function() {
            let date = $(this).text();
            let formattedDate = formatDate(date);
            $(this).text(formattedDate);
        });
    	//숨기기
    	$(".hidden").hide();
    	
    	//플레이리스트 필터
    	$(".play_music").each(function(){
            let mm_in = $(this).find(".play_music_info p:nth-child(4)").text();
            if(mm_in === "0"){
                $(this).hide();
            }
        });
    	
    	//플레이리스트 추가기능
    	$(document).on("click",".cover",function(){
    		let mu_code = $(this).siblings(".music_info").find(".hidden").text();
    	   	$.ajax({
    	   		type:"POST",
    	   		url:"addPlaylist",
    	   		data:{mu_code:mu_code},
    	   		success:function(data){
    	   			playlistItem(data);
    	   		},
    	   		error:function(err){	
    	   		}
    	   	})
    	})
    	
    	//플레이리스트 제거기능
    	$(document).on("click",".fa-x",function(){
    		let mu_code = $(this).siblings(".play_music_info_wrap").find(".code").text();
    	   	$.ajax({
    	   		type:"POST",
    	   		url:"subPlaylist",
    	   		data:{mu_code:mu_code},
    	   		success:function(data){
    	   			playlistItem(data);
    	   		},
    	   		error:function(err){	
    	   		}
    	   	})
    	})
    	
    });
    //ajax로 플레이리스트 html변경 함수
    function playlistItem(data){
    	let htmls="";
	   	for(let i = 0; i < data.length; i++){
	   		let item = data[i]
	   	    let html = '<div class="play_music">' ;
	   	    html+= '<div class="play_music_info_wrap">' ;
	   	    html+= '<img src="./resources/images/' + item.mu_img + '.jpg">' ;
		   	html+= '<div class="play_music_info">' ;
		   	html+= '<p class="hidden code">' + item.mu_code + '</p>' ;
		   	html+= '<p>' + item.mu_title + '</p>' ;
		   	html+= '<p>' + item.mu_artist + '</p>' ;
		   	html+= '<p class="hidden">' + item.mm_in + '</p>' ;
		   	html+= '</div>' ;
		   	html+= '</div>' ;
		   	html+= '<i class="fa-regular fa-x"></i>' ;
		   	html+= '</div>';
	   	      
		   	htmls += html;
	   	  };
	   	  $(".play_list").html(htmls);
	   	  
   		//숨기기
    	$(".hidden").hide();
    	//플레이리스트 필터
    	$(".play_music").each(function(){
            let mm_in = $(this).find(".play_music_info p:nth-child(4)").text();
            if(mm_in === "0"){
                $(this).hide();
            }
        });
	   	  
    }
    
  	//날짜형식 변경 함수
	function formatDate(dateString) {
        let date = new Date(dateString);
        let year = date.getFullYear();
        let month = date.getMonth() + 1;
        let day = date.getDate();

        // 원하는 날짜 형식으로 조합
        let formattedDate = year + "." + padZero(month) + "." + padZero(day);
        return formattedDate;
	}
	function padZero(number) {
    	return (number < 10 ? "0" : "") + number;
	}
    </script>


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
                <a href="jukestore"><button class="btn-15 custom-btn">상점가기</button></a>
            </div>
            <div class="music_section">
                <div class="music_wrap style-2">
                    <div class="music_list_wrap">
						<input type="text" id="hostId" class="hidden" value="${hostId}">
						<input type="text" id="sessionId" class="hidden" value="${sessionId}">
                        <c:forEach var="item" items="${mylist}">
                        <div class="music_list"> 
                            <div class="cover" href="">
                                <div>
                                    +
                                </div>
                            </div>
                            <img src="./resources/images/${item.mu_img}.jpg" alt="">
                            <div class="music_info">
                                <p>${item.mu_title }</p>
                                <p>${item.mu_artist }</p>
                                <p>${item.mu_date }</p>
                                <p>${item.mu_genre }</p>
                            	<p class="hidden">${item.mu_code }</p>
                            </div>
                        </div>
                        </c:forEach>
                        
                    </div>
                </div>
                <div class="line">
                </div>
                <div class="playlists">
                	<div class="playlist_title">PLAYLIST</div>
                    <div class="play_list style-2">
                    
                    	<c:forEach var="item" items="${mylist}">
                        <div class="play_music">
                            <div class="play_music_info_wrap">
                                <img src="./resources/images/${item.mu_img }.jpg">
                                <div class="play_music_info"> 
                                	<p class="hidden code">${item.mu_code}</p>
                                    <p>${item.mu_title }</p>
                                    <p>${item.mu_artist }</p>
                                    <p class="hidden">${item.mm_in}</p>
                                </div>
                            </div>
                                <i class="fa-regular fa-x"></i>
                        </div>
                        </c:forEach>
                        
                    </div>
                </div>
            </div>
        </section>
    </div>
</body>
</html>