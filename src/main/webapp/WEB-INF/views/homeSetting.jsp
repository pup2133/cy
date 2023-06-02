<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<title>Document</title>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<script src="https://kit.fontawesome.com/4ec79785b5.js" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link rel="stylesheet" href="./resources/css/header_nav.css">
<link rel="stylesheet" href="./resources/css/homeSetting.css" />
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
<script src="./resources/js/header.js"></script>
<script>
	
	$(document).ready(function(){
		
	    let originalProfile = $('#profile').val();
	    let originalMusic = $('#music').val();
	    let originalDiary = $('#diary').val();
	    let originalGallery = $('#gallery').val();

	    $('input[name="b_hide_profile"]').filter('[value="' + originalProfile + '"]').prop('checked', true);
	    $('input[name="b_hide_music"]').filter('[value="' + originalMusic + '"]').prop('checked', true);
	    $('input[name="b_hide_diary"]').filter('[value="' + originalDiary + '"]').prop('checked', true);
	    $('input[name="b_hide_gallery"]').filter('[value="' + originalGallery + '"]').prop('checked', true);
	});

	function check(){
		
	    // 초기 값 저장
		let originalProfile = $('#profile').val();
		let originalMusic = $('#music').val();
		let originalDiary = $('#diary').val();
		let originalGallery = $('#gallery').val();

		// 변경 값 저장
		let profile = $('input[name="b_hide_profile"]:checked').val();
		let music = $('input[name="b_hide_music"]:checked').val();
		let diary = $('input[name="b_hide_diary"]:checked').val();
		let gallery = $('input[name="b_hide_gallery"]:checked').val();
	    
	    if (profile != originalProfile || music != originalMusic || diary != originalDiary || gallery != originalGallery) {
	        Swal.fire({
	            title: '변경사항이 있습니다',
	            text: '변경사항을 저장하시겠습니까?',
	            icon: 'warning',
	            showCancelButton: true,
	            confirmButtonText: '저장',
	            cancelButtonText: '취소'
	        }).then((result) => {
	            if (result.isConfirmed) {
	                // 저장 로직을 여기에 추가
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
			
				<form name="frm" action="savesetting" method="post">
		        <h3>프로필</h3>
		        <div class="radiobox">
			        <label for="b_hide_profile">
			        	<input type="radio" name="b_hide_profile" value="1" /><span>공개</span>
			        </label>
			        <label for="b_hide_profile"> 
			        	<input type="radio" name="b_hide_profile" value="0" /><span>비공개</span>
			        </label>
		        </div>
		        <hr/>
		        <h3>쥬크박스</h3>
		        <div class="radiobox">
		        	<label for="b_hide_music">
		          		<input type="radio" name="b_hide_music" value="1"  /><span>공개</span>
		          	</label>
			        <label for="b_hide_music">
			        	<input type="radio" name="b_hide_music" value="0" /><span>비공개</span>
			        </label>
		        </div>
		  		<hr/>
		        <h3>다이어리</h3>
		        <div class="radiobox">
			        <label for="b_hide_diary">
			        	<input type="radio" name="b_hide_diary" value="1" /><span>공개</span>
			        </label>
			        <label for="b_hide_diary">
			        	<input type="radio" name="b_hide_diary" value="0" /><span>비공개</span>
			        </label>
		        </div>
		         <hr/>
		        <h3>갤러리</h3>
		        <div class="radiobox">
			        <label for="b_hide_gallery">
			        	<input type="radio" name="b_hide_gallery" value="1" /><span>공개</span>
			        </label>
			        <label for="b_hide_gallery">
			        	<input type="radio" name="b_hide_gallery" value="0" /><span>비공개</span>
			        </label >
		        </div>
		        <hr/>
		        	<input type="hidden" name="m_id" value="${sessionId}">
		        	<button type="button" onclick="check()">저장</button>
		      </form>
		     
		</div>
		<input type="hidden" id="profile" value="${setting.b_hide_profile}">
		<input type="hidden" id="music" value="${setting.b_hide_music}">
		<input type="hidden" id="diary" value="${setting.b_hide_diary}">
		<input type="hidden" id="gallery" value="${setting.b_hide_gallery}">
	</section>    
</div>
</body>
</html>