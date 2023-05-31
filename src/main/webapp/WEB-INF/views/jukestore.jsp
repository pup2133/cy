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
<!-- sweet alert -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.7.5/dist/sweetalert2.min.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.7.5/dist/sweetalert2.min.js"></script>

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script> 
<script type="text/javascript">
    
    $(document).ready(function(){
    	//구매기능
    	$(document).on('click','.btn',function(){
    		let mu_code =  $(this).data('mu-code');
    		Swal.fire({
                title: '해당 곡을 구매하시겠습니까?',
                text: "sdfsf",
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: '구매',
                cancelButtonText: '취소',
                reverseButtons: true, // 버튼 순서 거꾸로
            }).then((result) => {
            	if(result.isConfirmed){
    			//중복유효성 검사
	    		$.ajax({
	    			type: "POST",
	    			dataType:"text",
	                url: "checkDuplicatePurchase",
	                data: {"mu_code": mu_code},
	                success: function(data) {
	                    console.log(data);
	                    if(data==="true"){
	                    	Swal.fire({
		                        icon: 'warning',
		                        title: '중복구매',
		                        text: '이미 구매한 곡입니다.',
	                        });
	                    }else{
	                    	Swal.fire({
	                            icon: 'success',
	                            title: '구매완료',
	                            text: '구매가 완료되었습니다.',
	                        });
	                    	$.ajax({
	                            type: "POST",
	                            url: "buymusic",
	                            data: {mu_code: mu_code},
	                            success: function(data) {
	                            },
	                            error: function(err) {
	                                console.log(err)
	                            }
	                        });
	                    }
	                },
	                error: function(err) {
	                    console.log(err)
	                }
	    		})
    			//
            	}
            })
    	})

        //검색기능 (새로고침 없이 제이쿼리)
        $('#musicInput').on('keypress',function(){
        	if (event.keyCode === 13) {
                let search_word = $(this).val().trim();
                let search_select = $(".searchbox .searchSelect").val();
                //alert(mu_artist);
                  // AJAX request to the controller
                  $.ajax({
                      type: "POST",
                      //dataType:"text",
                      url: "jukesearch",
                      data: { 
                    	  "search_word": search_word,
                    	  "search_select": search_select
                    	  },
                      success: function(data) {
                      	let albumsHTML = '';
                          for (let i = 0; i < data.length; i++) {
                              let item = data[i];
                              let albumHTML = '<div class="album">';
                              albumHTML += '<div class="img_container">';
                              albumHTML += '<div class="cover">';
                              albumHTML += '<div class="album_info">';
                              albumHTML += '<p class="hidden mu_code">' + item.mu_code + '</p>';
                              albumHTML += '<p>' + item.mu_title + '</p>';
                              albumHTML += '<p>' + item.mu_artist + '</p>';
                              albumHTML += '<a class="btn" data-mu-code="' + item.mu_code + '"><button>구매</button></a>';
                              albumHTML += '</div>';
                              albumHTML += '</div>';
                              albumHTML += '<img src="./resources/images/' + item.mu_img + '.jpg" alt="">';
                              albumHTML += '</div>';
                              albumHTML += '<span>' + item.mu_artist + '</span>';
                              albumHTML += '</div>';

                              albumsHTML += albumHTML;
                          }
                          // 생성된 HTML을 DOM에 추가
                          $('.albums').html(albumsHTML);
                      },
                      error: function(err) {
                          // Handle errors
                          console.log(err);
                      }
                  });
            }
        })
        
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
                    <audio id="audioPlayer" controls onloadstart="this.volume=0.5" autoplay>
                        <source  id="audioSource"  src="./resources/mp3/a01.mp3" type="audio/mp3">
                        Your browser does not support the audio element.
                    </audio>
                    <div class="music_name">
                        <span class="songTitle">I AM - IVE</span>
                        <i class="fa-solid fa-music"></i>
                    </div>
                    <div class="music_icon">
                        <i class="fa-solid fa-backward-step"></i>
                        <div class="play_btn" style="display: inline-block;"><i class="fa-solid fa-play"></i></div>
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
                <div class="searchbox">
                    <select class="searchSelect">
                        <option value="mu_artist">아티스트</option>
                        <option value="mu_title">타이틀</option>
                    </select>
                    <div class="music_search">
                        <input type="text" id="musicInput" placeholder="음악검색">
                        <i class="fa-solid fa-magnifying-glass"></i>
                    </div>
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
                                <a class="btn" data-mu-code="${item.mu_code}"><button>구매</button></a>
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