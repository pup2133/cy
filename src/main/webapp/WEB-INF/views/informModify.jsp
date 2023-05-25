<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>Document</title>
    <link rel="stylesheet" href="./resources/css/informModify.css">
  </head>
  <body>
    <div class="container">
      <h1>회원정보 수정</h1>
      <hr />
    </div>
    <div class="container2">
    
    <div class="left"></div>

  <form>
      
      <h3>아이디</h3>
      <input type="text" />
      <hr />
      <h3>비밀번호</h3>
      <input type="password" />
      <hr />
      <h3>이름</h3>
      <input type="text" />
      <hr />
      <h3>닉네임</h3>
      <input type="text" />
      <hr />
      <h3>생일</h3>
      <input type="text" />
      <hr />
      <h3>이메일</h3>
      <input type="text" />
      <hr />
      <h3>전화번호</h3>
      <input type="text" />
      <hr />
      <h3>파도타기</h3>
      <div class="radio">
        <label>
        <input type="radio" name="contact" checked/><span>공개</span> 
        </label>
      <label>
        <input type="radio" name="contact" /><span>친구만</span> 
      </label>
      <label>
        <input type="radio" name="contact" /><span>비공개</span> 
      </label>
      </div>
      <button type="submit">저장</button>
   
  </form>
    
      <div class="left"></div>
</div>
  </body>
</html>
