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

//로그인하기
function check() {
	  const id = $('input[name="id"]').val();
	  const pw = $('input[name="pw"]').val();

	  if (id == "") {
	    swal.fire('로그인 실패', '아이디를 입력해주세요.', 'error');
	    return;
	  } else if (pw == "") {
	    swal.fire('로그인 실패', '비밀번호를 입력해주세요.', 'error');
	    return;
	  } else {
	    $.ajax({
	      type: "POST",
	      url: "login",
	      data: {
	        id: id,
	        pw: pw
	      },
	      success: function (data) {
	        if (data == 1) {
	          swal.fire('로그인 실패', '아이디가 존재하지 않습니다.', 'error');
	        } else if (data == 2) {
	          swal.fire('로그인 실패', '비밀번호가 일치하지 않습니다.', 'error');
	        } else {
	          swal.fire({
	            title: '로그인 성공',
	            text: 'RACON에 오신 것을 환영합니다.',
	            icon: 'success',
	            showCancelButton: false,
	            confirmButtonText: '확인'
	          }).then((result) => {
	            if (result.isConfirmed) {
	              location.href = "./myhome?id=" + id;
	            }
	          });
	        }
	      },
	      error: function (err) {
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
        <input type="text" name="id" placeholder="아이디를 입력해주세요" />
        <input type="password" name="pw" placeholder="비밀번호를 입력해주세요" />
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
