<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<title>회원가입</title>
<link rel="stylesheet" href="./resources/css/register.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<script src="https://kit.fontawesome.com/4ec79785b5.js" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.7.0.js" integrity="sha256-JlqSTELeR4TLqP0OG9dxM7yDPqX1ox/HfgiSLBj8+kM=" crossorigin="anonymous"></script>
<script>

let cnt = 0;

	
//중복확인
function dup(){
	
	const id = $('input[name=m_id]').val();
	
	if(id==""){
		Swal.fire('아이디 중복 체크', '아이디를 입력해주세요', 'error');	
		return;
	}else if(!/^[A-Za-z0-9]+$/.test(id)){
		 Swal.fire('회원가입', '아이디는 영문 또는 숫자만 입력해주세요', 'error');
		return;
	}else if(id.length > 15 || id.length < 4){
		Swal.fire('아이디 체크', '아이디는 4자 이상 15자 이하로 입력해주세요', 'error');
		return;
	}
	
	$.ajax({
			type : "post",
			dataType : "text",
			url : "dup",
			data : {
				"m_id" : id
			},
			success : function(data, status) {
				if (data === "true") {
					Swal.fire('아이디 중복 체크', '사용 가능한 아이디 입니다', 'success');
					cnt=1;
				    $('input[name=m_id]').prop('readonly', true);
				    $('input[name=m_id]').css('outline', 'none');

				} else if (data === "false") {
					Swal.fire('아이디 중복 체크', '이미 존재하는 아이디 입니다', 'error');
				}
			},
			error : function(err) {
			}
		});
		
}
function validateForm() {
	  let m_id = $('input[name=m_id]').val();
	  let m_pw = $('input[name=m_pw]').val();
	  let m_name = $('input[name=m_name]').val();
	  let m_nick = $('input[name=m_nick]').val();
	  let m_birth = $('input[name=m_birth]').val();
	  let m_email = $('input[name=m_email]').val();
	  let m_tel = $('input[name=m_tel]').val();

	  // 정규식 패턴 선언
	  let idPattern = /^[A-Za-z0-9]+$/;
	  let pwPattern = /^.{6,20}$/;
	  let namePattern = /^.{2,10}$/;
	  let nickPattern = /^.{2,10}$/;
	  let birthPattern = /^\d{4}-\d{2}-\d{2}$/;
	  let emailPattern = /^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$/;
	  let telPattern = /^\d{3}-\d{4}-\d{4}$/;

	  if (m_id == "" || m_pw == "" || m_name == "" || m_nick == "" || m_birth == "" || m_email == "" || m_tel == "") {
	    Swal.fire('회원가입', '비어있는 항목이 있는지 확인해주세요', 'error');
	    return;
	  } else if (cnt != 1) {
	    Swal.fire('회원가입', '중복확인을 체크해주세요', 'error');
	    return;
	  } else if (!pwPattern.test(m_pw)) {
	    Swal.fire('회원가입', '비밀번호는 6자 이상 20자 이하로 입력해주세요 ', 'error');
	    return;
	  } else if (!namePattern.test(m_name)) {
	    Swal.fire('회원가입', '이름은 2자 이상 10자 이하로 입력해주세요 ', 'error');
	    return;
	  } else if (!nickPattern.test(m_nick)) {
	    Swal.fire('회원가입', '닉네임은 2자 이상 10자 이하로 입력해주세요 ', 'error');
	    return;
	  } else if (!birthPattern.test(m_birth)) {
	    Swal.fire('회원가입', '생년월일 형식을 확인해주세요', 'error');
	    return;
	  } else if (!emailPattern.test(m_email)) {
	    Swal.fire('회원가입', '이메일 형식을 확인해주세요', 'error');
	    return;
	  } else if (!telPattern.test(m_tel)) {
	    Swal.fire('회원가입', '전화번호 형식을 확인해주세요', 'error');
	    return;
	  } else if (cnt == 1) {
	    Swal.fire({
	      title: '회원가입',
	      text: '회원 가입이 완료되었습니다.',
	      icon: 'success',
	      showCancelButton: false,
	      confirmButtonText: '확인',
	    }).then(() => {
	      document.frm.submit();
	    });
	    return;
	  }
	}

//비밀번호 보기 안보기
function togglePasswordVisibility() {
	  const passwordInput = document.getElementById("m_pw_input");
	  const eyeIcon = document.querySelector(".password-label i.fa-eye");

	  if (passwordInput.classList.contains("active")) {
	    passwordInput.classList.remove("active");
	    passwordInput.type = "password";
	    eyeIcon.classList.remove("fa-eye-slash");
	  } else {
	    passwordInput.classList.add("active");
	    passwordInput.type = "text";
	    eyeIcon.classList.add("fa-eye-slash");
	  }
}	
</script>
</head>
  <body>
    <div class="container">
      <h1>회원가입</h1>
      <hr />
      <form name="frm" action="register" method="post">
      
       <label for="m_id">
                <h5>아이디</h5>
                <div class="id-container">
                <input type="text" name="m_id" placeholder="아이디를 입력해주세요" />
                <input type="button" value="중복확인" class="doublecheck" onclick="dup()">   
                </div>
        </label>
              
	    <label for="m_pw" class="password-label">
		    <h5>비밀번호</h5>
		    <input type="password" name="m_pw" placeholder="비밀번호를 입력해주세요" id="m_pw_input"/>
	       	<i class="fa fa-eye fa-lg" onclick="togglePasswordVisibility()"></i>
	    </label>
	        
        <label for="m_name">
	        <h5>이름</h5>
	        <input type="text" name="m_name" placeholder="이름을 입력해주세요" />
        </label>
        
	    <label for="m_nick">
	    	<h5>닉네임</h5>
	        <input type="text" name="m_nick" placeholder="닉네임을 입력해주세요" />
        </label>
	        <label for="m_birth"><h5>생년월일</h5>
	        <input type="text" name="m_birth" placeholder="생년월일을 입력해주세요 예) 2023-06-05" />
        </label>
        	
        <label for="m_email">
	        <h5>이메일</h5>
	        <input type="text" name="m_email" placeholder="이메일을 입력해주세요 예) racon@gmail.com" />
        </label>
        	
        <label for="m_tel">
	        <h5>전화번호</h5>
	        <input type="text" name="m_tel" placeholder="전화번호를 입력해주세요 예) 010-0000-0000" />
        </label>
        	
        <button type="button" onclick="validateForm()">회원가입</button>
      </form>
    </div>
  </body>
</html>