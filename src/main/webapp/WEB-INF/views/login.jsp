<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="./resources/css/login.css" />
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<script src="https://code.jquery.com/jquery-3.7.0.js" integrity="sha256-JlqSTELeR4TLqP0OG9dxM7yDPqX1ox/HfgiSLBj8+kM=" crossorigin="anonymous"></script>
<script>
function check(){
	
	const id = $('input[name="id"]').val();
	const pw = $('input[name="pw"]').val();
	
	if(id==""){
		swal.fire('아이디 입력','입력해주세요','error');
		return;
	}else if(pw==""){
		swal.fire('비밀번호 입력','입력해주세요','error');
		return;
	}else{
		$.ajax({
			type:"POST",
			url:"login",
			data:{
				id : id,
				pw : pw
			},
			success:function(data){
				if(data==1){
					swal.fire('로그인','아이디 없음','error');
				}else if(data==2){
					swal.fire('로그인','비번 틀림','error');	
				}else{
					swal.fire('로그인','성공','success');
					location.href="./myhome?id="+id;
				}
			},
			error:function(err){
				console.log(err);
			}
		});
	}
    
}
 </script>
</head>
  <body>
    <div class="container">
      <a href="#"><img src="./resources/images/logo.png"></a>
      <h1>RACON</h1>
      <form name="frm" action="/login" method="post">
        <input type="text" name="id" placeholder="사용자 아이디 입력" />
        <input type="password" name="pw" placeholder="비밀번호 입력" />
        <button type="button" onclick="check()">로그인</button>
      </form>
        <div class="container2">
        <a href="./findid">아이디 찾기</a>
        <a href="./findpw">비밀번호 찾기</a>
        <a href="./register">회원가입</a>
        </div>   
    </div>
  </body>
</html>
