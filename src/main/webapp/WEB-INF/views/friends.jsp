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
<link rel="stylesheet" href="./resources/css/friends.css"> 
<!-- sweet alert -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.7.5/dist/sweetalert2.min.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.7.5/dist/sweetalert2.min.js"></script>

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script> 
<script type="text/javascript">
    
$(document).ready(function(){
	//host, session 아이디 확인
	const host = $("#hostId").val();
	const session = $("#sessionId").val();
	
	//손님일 경우 기능 제한
	if(host!==session){
		$(".fa-x").hide();
	}
	
    $(".hidden").hide();
    $(".fa-x").on("click", function(){
        let f_num = $(this).parent().find(".f_num").text();
        let m_nick =$(this).parent().find(".f_nick").text();
        console.log("삭제하려는 행번호:" + f_num);
        
        Swal.fire({
            title: '일촌 삭제하시겠습니까?',
            text: m_nick + " 님",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: '확인',
            cancelButtonText: '취소',
            reverseButtons: true, // 버튼 순서 거꾸로
        }).then((result) => {
        	
        		if(result.isConfirmed){
                $.ajax({
                    type: "POST",
                    url: "deleteFriend",
                    data: {f_num: f_num},
                    success: function(data) {
                        // 삭제 성공 시에만 새로고침
                        console.log(data);
                    	window.location.reload();
                    },
                    error: function(err) {
                        console.log(err)
                    }
                });
        		
        		}
        });
    });
});
    </script>
</head>
<body>	
	<%@ include file="header_nav.jsp"%>
        <section>
        <input type="text" id="hostId" class="hidden" value="${hostId}">
        <input type="text" id="sessionId" class="hidden" value="${sessionId}">
            <div class="section_title">
                <span>일촌관리</span>
            </div>
            <div class="friend_list style-2">
                <div class="friend_list_wrap">
                
                    <!-- 반복시작 -->
                    
                    <c:forEach var="item" items="${friendsList}">
                    <div class="friend">
                        <i class="fa-regular fa-x"></i>
                        <div class="friend_info">
                            <div class="img_wrap">
                                <img src="./resources/images/${item.h_pic }" alt="">
                            </div>
                            <p class="f_nick">${item.m_nick }</p>
                            <p>${item.m_id }</p>
                            <p class="hidden f_num">${item.f_num }</p>
                        </div>
                    </div>
                    </c:forEach>
                    <!-- 반복종료 -->
                </div>


            </div>
        </section>
    </div>
</body>
</html>