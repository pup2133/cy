<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Document</title>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
    <script src="https://kit.fontawesome.com/4ec79785b5.js" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="resources/css/header_nav.css">
    <link rel="stylesheet" href="./resources/css/homeSetting.css" />
    <script>
    function() saveSetting{
    	 // 수정: 라디오 버튼 값을 가져옴
/*         var b_hide_profile = document.querySelector('input[name="contact"]:checked').value;
        var b_hide_music = document.querySelector('input[name="contact2"]:checked').value;
        var b_hide_diary = document.querySelector('input[name="contact3"]:checked').value;
        var b_hide_gallery = document.querySelector('input[name="contact4"]:checked').value;
    	
    	$.ajax({
    		url : "savesetting",
    		method : "post",
    		dataType : "text",
    		data: {
    			b_hide_profile : b_hide_profile,
    			b_hide_music : b_hide_music,
    			b_hide_diary : b_hide_diary,
    			b_hide_gallery : b_hide_gallery
    		},
    		success : function(response){
    			 // 수정: 업데이트 성공 시 SweetAlert2로 알림 표시
                Swal.fire({
                    icon: 'success',
                    text: '업데이트가 완료되었습니다.',
                    showConfirmButton: false,
                    timer: 1500
                });
    			
    		},
    		error : function(err){
    			console.log(err);
    		}
    	}); */
    	
        Swal.fire({
            icon: 'success',
            text: '업데이트가 완료되었습니다.',
            showConfirmButton: false,
            timer: 1500
        }).then(){
    		
    	}
    	
    }
    </script>
  </head>
<body>
	<%@ include file="header_nav.jsp"%>	
	<section>
	
		<div class="container">
	    	<h1>홈피 설정</h1>
	    	<hr />
		</div>
		
		<div class="container2">
			<div class="block"></div>
				<form name="frm" method="post" action="savesetting">
		        <h3>프로필</h3>
		        <div class="radio">
		        <label>
		          <input type="radio" name="contact" /><span>공개</span>
		        </label>
		        <label> <input type="radio" name="contact" /><span>비공개</span>
		        </label>
		        </div>
		
		        <h3>쥬크박스</h3>
		        <div class="radio">
		        <label>
		          <input type="radio" name="contact2" /><span>공개</span>
		          </label>
		        <label>
		          <input type="radio" name="contact2" /><span>비공개</span>
		        </label>
		        </div>
		
		        <h3>다이어리</h3>
		        <div class="radio">
		          <label>
		            <input type="radio" name="contact3" /><span>공개</span>
		            </label>
		          <label>
		            <input type="radio" name="contact3" /><span>비공개</span>
		        </label>
		        </div>
		        <h3>갤러리</h3>
		        <div class="radio">
		        <label>
		          <input type="radio" name="contact4" /><span>공개</span>
		        </label>
		        <label>
		          <input type="radio" name="contact4" /><span>비공개</span>
		        </label>
		        </div>
		        <button type="button" onclick="saveSetting()">저장</button>
		      </form>
		      <div class="block"></div>
		      
		    </div>
	</section>    
</div>
</body>
</html>
