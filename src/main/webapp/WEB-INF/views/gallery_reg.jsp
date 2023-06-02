<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://kit.fontawesome.com/4ec79785b5.js" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<link rel="stylesheet" href="./resources/css/header_nav.css">
<link rel="stylesheet" href="./resources/css/gallery_reg.css">
<script src="./resources/js/galleryRegEdit.js"></script>
<script src="./resources/js/header.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
</head>
<body>
	<%@ include file="header_nav.jsp"%>
	<section>
		<div class="section_wrap">
			<div class="gallery_title">
				<h1>갤러리</h1>
				<div>
					<c:if test="${hostId == sessionId}">
						<a href="galleryReg"><i class="fa-solid fa-pen"></i></a>
					</c:if>
					<a href="gallery?id=${hostId }"><i class="fa-solid fa-list"></i></a>
				</div>
			</div>
			<div class="gallery_wrap">
				<form action="gallery/reg" method="post"
					enctype="multipart/form-data">
					<div class="gallery">
						<div class="gallery_left">
							<div class="gallery_img">
								<h1>사진 첨부</h1>
								<input name="file" type="file" id="file" accept="image/*">
							</div>
						</div>
						<div class="gallery_right">
							<div>
								<input type="text" name="g_title">
								<select name="g_secret">
									<option value="0">공개</option>
									<option value="1">비공개</option>
								</select>
							</div>
							<div class="gallery_box">
								<textarea name="g_text"></textarea>
							</div>
							<button>저장</button>
						</div>
					</div>
				</form>
			</div>
		</div>
	</section>
	</div>
</body>
</html>