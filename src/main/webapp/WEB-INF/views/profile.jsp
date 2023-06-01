<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>프로필</title>
<script src="https://code.jquery.com/jquery-3.7.0.js" integrity="sha256-JlqSTELeR4TLqP0OG9dxM7yDPqX1ox/HfgiSLBj8+kM=" crossorigin="anonymous"></script>
<script src="https://kit.fontawesome.com/4ec79785b5.js" crossorigin="anonymous"></script>
<link rel="stylesheet" href="resources/css/header_nav.css" />
<link rel="stylesheet" href="resources/css/profile.css" />
<script>
	$(document).ready(
			function() {
				$('#file').change(
						function(event) {
							let file = event.target.files[0];
							let reader = new FileReader();

							reader.onload = function(e) {
								$("#pic_com").css("display", "none");
								$('#p_pic').css('background-image',
										'url(' + e.target.result + ')');
							};
							reader.readAsDataURL(file);
						});
			});

	let updateText = 0;
	function update_profile() {
		let area = document.querySelectorAll(".update_profile");

		let m_name = $("#m_name").val();
		let m_birth = $("#m_birth").val();
		let m_email = $("#m_email").val();
		let m_tel = $("#m_tel").val();
		let p_text = $("#p_text").val();
		let p_pic = "${profile.p_pic}";

		if (updateText == 0) {
			$(area).removeAttr("readonly", false);
			$(area).css("cursor", "text");
			$("#file").css("display", "block");
			$("#m_name").focus();
			$("#up_btn").css("color", "red");
			updateText = 1;
		} else if (updateText == 1) {
			const file = $("#file")[0];
			console.log("imageInput: ", file.files);
			
			const formData = new FormData();
			formData.append("file", file.files[0]);
			
			$.ajax({
			    type:"POST",
			    url: "fileSet",
			    processData: false,
			    contentType: false,
			    async:false,
			    data: formData,
			    success: function(d){
			    	p_pic = d;
			    },
			    err: function(err){
			      console.log(err)
			    }
			  });
			
			$.ajax({
				url : "profile/profileUpdate",
				method : "POST",
				data : {
					m_id : "${profile.m_id}",
					m_name : m_name,
					m_birth : m_birth,
					m_email : m_email,
					m_tel : m_tel,
					p_text : p_text,
					p_pic : p_pic
				},
				success : function() {
				},
				error : function(err) {
					console.log(err);
				},
			});
			
			$(area).css("cursor", "default");
			$("#file").css("display", "none");
			$("#up_btn").css("color", "black");
			$(area).attr("readonly", true);
			updateText = 0;
		}
	}
</script>
<script src="./resources/js/header.js"></script>
</head>
<body>
	<%@ include file="header_nav.jsp"%>

		<section>
			<div class="section_wrap">
				<div class="section_title">
					<p style="width: 150px">프로필</p>
					<div>
						<c:if test="${sessionId == hostId}">
							<a href="javascript:void(0);" onclick="update_profile()" id="up_btn"><i class="fa-solid fa-gear"></i></a>
						</c:if>
					</div>
				</div>
			</div>
			<div class="profile">
				<div class="info_wrap">
					<div class="info m_name">
						<h2>이름</h2>
						<input type="text" class="update_profile" id="m_name" value="${profile.m_name}" maxlength="10" readonly />
					</div>
					<div class="info m_birth">
						<h2>생년월일</h2>
						<input type="text" class="update_profile" id="m_birth" value="${profile.m_birth}" maxlength="10" readonly />
					</div>
					<div class="info m_email">
						<h2>이메일</h2>
						<input type="text" class="update_profile" id="m_email" value="${profile.m_email}" maxlength="50" readonly />
					</div>
					<div class="info m_tel">
						<h2>전화번호</h2>
						<input type="text" class="update_profile" id="m_tel" value="${profile.m_tel}" maxlength="13" readonly />
					</div>
				</div>
				<div class="pic" id="p_pic" style="background-image: url(resources/file/profile/${profile.p_pic});">
					<c:if test="${empty profile.p_pic}">
						<h1 id="pic_com">사진 등록</h1>
					</c:if>
					<form id="upload" enctype="multipart/form-data">
						<input type="file" id="file" accept="image/*">
					</form>
				</div>
				<div class="p_text">
					<h2>소개글</h2>
					<textarea name="" id="p_text" class="update_profile" readonly>${profile.p_text}</textarea>
				</div>
			</div>
		</section>
	</div>
</body>
</html>