<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="./resources/css/register.css" />
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script>
function dup(){
	
	let id = $('input[name=m_id]').val();
	
	console.log(id);
	
	if(id==""){
		Swal.fire('아이디 중복 체크', '아이디를 입력해주세요', 'error')
		return;
	}
	
	$.ajax({
			type : "post",
			dataType : "text",
			url : "dup",
			data : {
				"m_id" : id,
			},
			success : function(data, status) {
				console.log(data);
				if (data == 1) {
					Swal.fire('아이디 중복 체크', '사용가능한 아이디 입니다', 'success').then(function() {
					})
				} else if (data == 2) {
					Swal.fire('아이디 중복 체크', '이미 존재하는 아이디 입니다', 'error')
				}
			},
			error : function(err) {
				console.log(err);
			}
		})
}
</script>
</head>
  <body>
    <div class="container">
      <h1>회원가입</h1>
      <hr />
      <form>
        <h5>아이디</h5>  
        <div class="input-container">
          <input type="text" name="m_id" placeholder="아이디 입력" required />
          <input type="button" value="중복확인" class="doublecheck" onclick="dup()">
        </div>
        <h5>비밀번호</h5>
        <input type="password" name="m_pw" placeholder="비밀번호 입력" required />
        <h5>이름</h5>
        <input type="text" name="m_name" placeholder="이름 입력" required />
        <h5>닉네임</h5>
        <input type="text" name="m_nick" placeholder="닉네임 입력" required />
        <h5>생년월일</h5>
        <input type="text" name="m_birth" placeholder="예) 2023-05-22" required />
        <h5>이메일</h5>
        <input type="text" name="m_email" placeholder="예) racon@gmail.com" required />
        <h5>전화번호</h5>
        <input type="text" name="m_tel" placeholder="기호없이 번호만 입력" required />
        <button type="submit">회원가입</button>
      </form>
    </div>
  </body>
</html>