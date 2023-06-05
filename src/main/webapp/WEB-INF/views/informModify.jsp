<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<title>회원정보 수정</title>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<script src="https://kit.fontawesome.com/4ec79785b5.js" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.7.0.js" integrity="sha256-JlqSTELeR4TLqP0OG9dxM7yDPqX1ox/HfgiSLBj8+kM=" crossorigin="anonymous"></script>
<link rel="stylesheet" href="./resources/css/header_nav.css">
<link rel="stylesheet" href="./resources/css/informModify.css">
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
<script>
	$(document).ready(function(){
		
	    // 웹소켓 연결
	    const sock = new SockJS('/cy/alram');

	    // 데이터를 전달 받았을 때
	    sock.onmessage = onMessage; // toast 생성
		
		let m_pw = $('#m_pw').val();
		let m_name = $('#m_name').val();
		let m_nick = $('#m_nick').val();
		let m_birth = $('#m_birth').val();
		let m_email = $('#m_email').val();
		let m_tel = $('#m_tel').val();
		let m_wave = $('#m_wave').val();
	
		$('input[name="m_pw"]').val(m_pw);
		$('input[name="m_name"]').val(m_name);
		$('input[name="m_nick"]').val(m_nick);
		$('input[name="m_birth"]').val(m_birth);
		$('input[name="m_email"]').val(m_email);
		$('input[name="m_tel"]').val(m_tel);
		$('input[name="m_wave"]').filter('[value="' + m_wave + '"]').prop('checked',true);
		
	});
	
	
	//회원정보 수정
	function update(){
		
		let m_pw = $('#m_pw').val();
		let m_name = $('#m_name').val();
		let m_nick = $('#m_nick').val();
		let m_birth = $('#m_birth').val();
		let m_email = $('#m_email').val();
		let m_tel = $('#m_tel').val();
		let m_wave = $('#m_wave').val();
	
		let NEWm_pw = $('input[name="m_pw"]').val();
		let NEWm_name = $('input[name="m_name"]').val();
		let NEWm_nick = $('input[name="m_nick"]').val();
		let NEWm_birth = $('input[name="m_birth"]').val();
		let NEWm_email = $('input[name="m_email"]').val();
		let NEWm_tel = $('input[name="m_tel"]').val();
		let NEWm_wave = $('input[name="m_wave"]:checked').val();
		
		// 각 필드의 정규식 패턴을 설정
		let passwordPattern = /^.{6,20}$/; // 비밀번호 자리수를 6~20자로 제한
		let birthPattern = /^\d{4}-\d{2}-\d{2}$/; //YYYY-MM-DD로 제한
		let emailPattern = /^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$/; // 이메일 형식 제한
		let telPattern = /^\d{3}-\d{4}-\d{4}$/; // 010-0000-0000 로 제한
		
		 // 각 필드에 대해 유효성 검사

		if (!passwordPattern.test(NEWm_pw)) {
        Swal.fire('회원정보수정', '비밀번호는 6~20자로 입력해주세요', 'error');
        return;
   		}
	    if (!birthPattern.test(NEWm_birth)) {
	        Swal.fire('회원정보수정', '생년월일 형식을 확인해주세요', 'error');
	        return;
	    }
	    if (!emailPattern.test(NEWm_email)) {
	        Swal.fire('회원정보수정', '이메일 형식을 확인해주세요', 'error');
	        return;
	    }
	    if (!telPattern.test(NEWm_tel)) {
	        Swal.fire('회원정보수정', '전화번호 형식을 확인해주세요', 'error');
	        return;
	    }
		
		if (m_pw != NEWm_pw || m_name != NEWm_name || m_nick != NEWm_nick 
				|| m_birth != NEWm_birth || m_email != NEWm_email 
				|| m_tel != NEWm_tel || m_wave != NEWm_wave) {
	        Swal.fire({
	            title: '변경사항이 있습니다',
	            text: '변경사항을 저장하시겠습니까?',
	            icon: 'warning',
	            showCancelButton: true,
	            confirmButtonText: '저장',
	            cancelButtonText: '취소'
	        }).then((result) => {
	            if (result.isConfirmed) {
	                // 저장되었음을 알리는 알림창 표시 후 폼 제출
	                Swal.fire({
	                    title: '저장되었습니다',
	                    icon: 'success',
	                    showConfirmButton: true
	                }).then(() => {
	                    document.frm.submit();
	                });
	            } else {
	                // 취소되었음을 알리는 알림창 표시
	                Swal.fire('취소되었습니다', '', 'info');
	             
	            }
	        });
	    } else {
	        // 변경된 값이 없을 경우 알림창 표시
	        Swal.fire('변경사항이 없습니다', '', 'info');
	      
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
<script src="./resources/js/header.js"></script>
</head>
  <body>
	<%@ include file="header_nav.jsp"%>	
    <section>
    <div class="container">
      <h1>회원정보 수정</h1>
      <hr />
    </div>
    <div class="container2">
  
      <form name="frm" action="updateInform" method="post">
        <label for="m_id" class="idbox">
        <h3>아이디</h3>
        <input type="text" name="m_id" value="${sessionId}" readonly/>
        </label>
       
        <label for="m_pw" class="password-label">
        <h3>비밀번호</h3>
        <input type="password" name="m_pw" id="m_pw_input"/>
        	<i class="fa fa-eye fa-lg" onclick="togglePasswordVisibility()"></i>
        </label>
       
        <label for="m_name">
        <h3>이름</h3>
        <input type="text" name="m_name" />
      </label>

      <label for="m_nick">
        <h3>닉네임</h3>
        <input type="text" name="m_nick" />
      </label>
     
      <label for="m_birth">
        <h3>생일</h3>
        <input type="text" name="m_birth" />
      </label>
    
      <label for="m_email">
        <h3>이메일</h3>
        <input type="text" name="m_email" />
      </label>

      <label for="m_tel">
        <h3>전화번호</h3>
        <input type="text" name="m_tel" />
      </label>

        
          <h3>파도타기</h3>
          <div class="radiobox">
            <label for="m_wave" class="radiobox2"> 
              <input type="radio" name="m_wave" value="2" /><span>공개</span>
            </label>
            <label for="m_wave" class="radiobox2">  
              <input type="radio" name="m_wave" value="1" /><span>친구만</span>
            </label> 
            <label for="m_wave" class="radiobox2"> 
              <input type="radio" name="m_wave" value="0" /><span>비공개</span>
          </label> 
        </div>

        <button type="button" onclick = "update()">저장</button>
      </form>
      
    </div>
          
      <input type="hidden" id="m_pw" value="${member.m_pw}">
      <input type="hidden" id="m_name" value="${member.m_name}">
      <input type="hidden" id="m_nick" value="${member.m_nick}">
      <input type="hidden" id="m_birth" value="${member.m_birth}">
      <input type="hidden" id="m_email" value="${member.m_email}">
      <input type="hidden" id="m_tel" value="${member.m_tel}">
      <input type="hidden" id="m_wave" value="${member.m_wave}">
      
    </section>
</div>
</body>
</html>