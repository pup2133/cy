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
<script src="https://code.jquery.com/jquery-3.7.0.js" integrity="sha256-JlqSTELeR4TLqP0OG9dxM7yDPqX1ox/HfgiSLBj8+kM=" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
<script type="text/javascript">
    
    $(document).ready(function(){
    	
        // 웹소켓 연결
        const sock = new SockJS('/cy/alram');

        // 데이터를 전달 받았을 때
        sock.onmessage = onMessage; // toast 생성
        
    	//구매기능
    	$(document).on('click','.btn',function(){
    		let mu_code =  $(this).data('mu-code');
    		Swal.fire({
                title: '해당 곡을 구매하시겠습니까?',
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
<script src="./resources/js/header.js"></script>    
</head>
<body>
	<%@ include file="header_nav.jsp"%>
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
            </div>
        </section>
    </div>
</body>
</html>