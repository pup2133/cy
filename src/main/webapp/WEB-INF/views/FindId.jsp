<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
 <title>Insert title here</title>
    <link rel="stylesheet" href="./resources/css/Find.css" />
  </head>
  <body>
    <div class="container">
      <h1>아이디 찾기</h1>
      <hr />
      <p>회원가입시 입력했던 이름과 이메일을 입력해주세요</p>

      <form action="FindId" method="post">
        <h3>이름</h3>
        <input type="text" placeholder="이름을 입력해주세요" required />
        <h3>이메일</h3>
        <input type="text" placeholder="예) mouson@gmail.com" required />
        <button type="submit">아이디 찾기</button>
      </form>
    </div>
  </body>
</html>
