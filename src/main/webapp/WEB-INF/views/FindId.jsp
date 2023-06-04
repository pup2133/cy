<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="./resources/css/findid.css" />
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script>

function findId(){
  let name = $('input[name=m_name]').val();
  let email = $('input[name=m_email]').val();
  
  if(name===""){
		swal.fire('아이디 찾기','이름을 입력해주세요','error');
		return;
  }else if(email===""){
		swal.fire('아이디 찾기','이메일을 입력해주세요','error');
 	 	return;
  }
  
  $.ajax({
	  	type : "post",
	  	dataType : "text",
	  	url : "FindId",
	  	data : {
	  		"m_name" : name,
	  		"m_email" : email
	  	},
	  	success : function(data, status){
	  		if (data === "1") {
	  	      swal.fire('아이디 찾기', '입력한 정보와 일치하는 아이디가 없습니다', 'error');
	  	    } else {
	  	      swal.fire('아이디 찾기', '아이디는 ' + data + '입니다', 'success');
	  	    }
	  	  },
	  	error : function(err){
	  		console.log(err);
	  	}
  });
 }
  
function redirectToFindPwPage() {
	 window.location.href = "./findpw";
}
function redirectToLoginPage() {
	 window.location.href = "./login";
}
  
</script>
</head>
<body>
    <div class="container">
      <h1>아이디 찾기</h1>
      <hr />
      <p>회원가입시 입력했던 이름과 이메일을 입력해주세요</p>

      <form name="frm" action="FindId" method="post">
        <h3>이름</h3>
        <input type="text" name="m_name" placeholder="이름을 입력해주세요" />
        <h3>이메일</h3>
        <input type="text" name="m_email" placeholder="이메일을 입력해주세요 예) racon@gmail.com" required />
        <button type="button" onclick="findId()">아이디 찾기</button>
        <button type="button" onclick="redirectToFindPwPage()">비밀번호 찾기</button>
        <button type="button" onclick="redirectToLoginPage()">로그인 하기</button>
      </form>
    </div>
  </body>
</html>