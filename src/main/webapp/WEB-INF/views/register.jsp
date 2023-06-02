<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<title>Insert title here</title>
<link rel="stylesheet" href="./resources/css/register.css" />
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script>

let cnt = 0;

	
//중복확인
function dup(){
	
	let id = $('input[name=m_id]').val();
	
	if(id==""){
		Swal.fire('아이디 중복 체크', '아이디를 입력해주세요', 'error');	
		return;
		
	}else if(id.length>15 || id.length<4){
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
					Swal.fire('아이디 중복 체크', '사용가능한 아이디 입니다', 'success');
					cnt=1;
				
					
				} else if (data === "false") {
					Swal.fire('아이디 중복 체크', '이미 존재하는 아이디 입니다', 'error');
				}
			},
			error : function(err) {
				console.log(err);
			}
		});
		
}
//형식검사 회원가입
function validateForm() {
	
	  let m_id = $('input[name=m_id]').val();
	  let m_pw = $('input[name=m_pw]').val();
	  let m_name = $('input[name=m_name]').val();
	  let m_nick = $('input[name=m_nick]').val();
	  let m_birth = $('input[name=m_birth]').val();
	  let m_email = $('input[name=m_email]').val();
	  let m_tel = $('input[name=m_tel]').val();
	 
	  if (m_id == "" || m_pw == "" || m_name == "" || m_nick == "" || m_birth == "" || m_email == "" || m_tel == "") {
	    Swal.fire('회원가입', '비어있는 항목이 있는지 확인해주세요', 'error');
	    return;
	  } else if (!/^[A-Za-z0-9]+$/.test(m_id)) 
	  	{Swal.fire('회원가입', '아이디는 영문 또는 숫자만 입력해주세요', 'error');
		return;
	  } else if (!/^\d{4}-\d{2}-\d{2}$/.test(m_birth)) 
	    {Swal.fire('회원가입', '생년월일 형식을 확인해주세요', 'error');
	    return;
	  } else if (!/^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$/.test(m_email)) {
	    Swal.fire('회원가입', '이메일 형식을 확인해주세요', 'error');
	    return;
	  } else if (!/^\d{3}-\d{4}-\d{4}$/.test(m_tel)) {
	    Swal.fire('회원가입', '전화번호 형식을 확인해주세요', 'error');
	    return;
	  } else if(cnt!=1){
	    Swal.fire('회원가입', '중복확인을 체크해주세요', 'error');
	  } else if(cnt===1){    // 1 ==  "1"    1 === 1
		  Swal.fire({
	      title: '회원가입',
	      text: '회원 가입이 완료되었습니다.',
	      icon: 'success',
	      showCancelButton: false,
	      confirmButtonText: '확인',
	    }).then( () => {document.frm.submit();} );
	    return;
	  }   
}
</script>
</head>
  <body>
    <div class="container">
      <h1>회원가입</h1>
      <hr />
      <form name="frm" action="register" method="post">
        <h5>아이디</h5>
        <div class="input-container">
            
          <input type="text" name="m_id" placeholder="아이디 입력" />
          <input type="button" value="중복확인" class="doublecheck" onclick="dup()">
          
        </div>
	        <label for="m_pw"><h5>비밀번호</h5></label>
	        <input type="password" name="m_pw" placeholder="비밀번호 입력" />
         	<label for="m_name"><h5>이름</h5></label>
        	<input type="text" name="m_name" placeholder="이름 입력" />
        	<label for="m_nick"><h5>닉네임</h5></label>
        	<input type="text" name="m_nick" placeholder="닉네임 입력" />
        	<label for="m_birth"><h5>생년월일</h5></label>
        	<input type="text" name="m_birth" placeholder="예) 2023-05-22" />
        	<label for="m_email"><h5>이메일</h5></label>
        	<input type="text" name="m_email" placeholder="예) racon@gmail.com" />
        	<label for="m_tel"><h5>전화번호</h5></label>
        	<input type="text" name="m_tel" placeholder="예) 010-0000-0000" />
        	<button type="button" onclick="validateForm()">회원가입</button>
      </form>
    </div>
  </body>
</html>