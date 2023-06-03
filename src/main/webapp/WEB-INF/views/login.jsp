<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
 <link rel="stylesheet" href="./resources/css/login.css" />
 <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
 <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
 
 <script>
function check(){
	
	let id = $('input[name="id"]').val();
	let pw = $('input[name="pw"]').val();
	
    let m_id = $('#m_id').val();
    let m_pw = $('#m_pw').val();
    console.log(id);
    console.log(pw);
    console.log(m_id);
    console.log(m_pw);
    
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
    
    <input type="hidden" id="m_id" value="${member.m_id}">
  	<input type="hidden" id="m_pw" value="${member.m_pw}">
  </body>
</html>