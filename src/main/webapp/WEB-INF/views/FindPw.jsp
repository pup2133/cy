<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset=UTF-8>
    <title>Insert title here</title>
    <link rel="stylesheet" href="./resources/css/Find.css" />
</head>
  <body>
    <div class="container">
      <h1>비밀번호 찾기</h1>
      <hr />
      <p>회원가입시 입력했던 아이디와 이메일을 입력해주세요</p>

      <form action="FindPw" method="post">
        <h3>아이디</h3>
        <input type="text" placeholder="아이디를 입력해주세요" required />
        <h3>이메일</h3>
        <input type="text" placeholder="예) mouson@gmail.com" required />
        <button type="submit">비밀번호 찾기</button>
      </form>
    </div>
  </body>
</html>
