<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<link rel="stylesheet" href="./resources/css/register.css" />
</head>
  <body>
    <div class="container">
      <h1>회원가입</h1>
      <hr />
      <form>
        <h5>아이디</h5>
        <input type="text" placeholder="아이디 입력" required />
        <h5>비밀번호</h5>
        <input type="password" placeholder="비밀번호 입력" required />
        <h5>이름</h5>
        <input type="text" placeholder="이름 입력" required />
        <h5>닉네임</h5>
        <input type="text" placeholder="닉네임 입력" required />
        <h5>생년월일</h5>
        <input type="text" placeholder="예) 200118" required />
        <h5>이메일</h5>
        <input type="text" placeholder="예) mouson@gmail.com" required />
        <h5>전화번호</h5>
        <input type="text" placeholder="기호없이 번호만 입력" required />
        <h5>공개여부 선택</h5>
        <div class="radio">
          <label>
          <input type="radio" name="contact" checked />
          <span>공개</span>
          </label>
          <label>
            <input type="radio" name="contact" />
            <span>비공개</span>
          </label>
        </div>
        <button type="submit">회원가입</button>
      </form>
    </div>
  </body>
</html>