<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
 <link rel="stylesheet" type="text/css" href="./resources/css/login.css" />
</head>
  <body>
    <div class="container">
      <a href="#"><img src="./resources/images/logo.png"></a>
      <h1>RACON</h1>
      <form action="./login" method="post">
        <input type="text" name="id" placeholder="사용자 아이디 입력" required />
        <input type="password" name="pw" placeholder="비밀번호 입력" required />
        <button type="submit">로그인</button>
      </form>
        <div class="container2">
        <a href="./findid">아이디 찾기</a>
        <a href="./findpw">비밀번호 찾기</a>
        <a href="./register">회원가입</a>
        </div>
        
    </div>
  </body>
</html>