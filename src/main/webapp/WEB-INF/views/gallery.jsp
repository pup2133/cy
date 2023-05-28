<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://kit.fontawesome.com/4ec79785b5.js" crossorigin="anonymous"></script>
<link rel="stylesheet" href="resources/css/header_nav.css">
<link rel="stylesheet" href="resources/css/gallery.css">
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<script src="./resources/js/gallery.js"></script>
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
					<a href="gallery?hostId=${hostId }"><i class="fa-solid fa-list"></i></a>
				</div>
			</div>
			<!-- 갤러리 wrap 오버플로우 시 스크롤 -->
			<div class="gallery_wrap">
				<c:forEach var="list" items="${list }">
					<div class="gallery">
						<div class="gallery_left">
							<form action="editGallery" method="get">
								<div class="title">
									<input type="hidden" name="g_title" value="${list.g_title}">
									<input type="hidden" name="g_pic" value="${list.g_pic}">
									<input type="hidden" name="g_text" value="${list.g_text}">
									<input type="hidden" name="g_num" value="${list.g_num}">
									<input type="hidden" name="secret" value="${list.g_secret}">
									<h1>${list.g_title }
										<c:if test="${list.g_secret == 1}">
											<i class="fa-solid fa-lock"></i>
										</c:if>
									</h1>
									<div>
										<button class="editGallery">수정 |</button>
										<button type="button" class="deleteGallery">삭제</button>
									</div>
								</div>
							</form>
							<div class="gallery_img">
								<img src="./resources/file/${list.g_pic}">
							</div>
						</div>
						<div class="gallery_right">
							<h3>${list.g_time}</h3>
							<div class="gallery_box">
								<div class="comment_wrap"></div>
								<div class="gallery_text">
									<input type="hidden" name="g_num" value="${list.g_num}">
									<input type="hidden" name="m_id" value="${sessionId}">
									<p>${list.g_text}</p>
									<div>
										<input type="text" class="good" value="${list.good_count }" disabled>
										<span class="gallery_good">♥</span>
									</div>
								</div>
								<div class="comment_reg">
									<h4>댓글 쓰기</h4>
									<div>
										<input type="hidden" name="g_num2" value="${list.g_num}">
										<textarea name="gc_text" placeholder="댓글을 입력해주세요"></textarea>
										<button class="d_reg">등록</button>
										<div></div>
									</div>
								</div>
								<div class="gallery_comment">
									<h3>댓글 보기</h3>
								</div>
								<div class="gallery_comment2">
									<h3>댓글 닫기</h3>
								</div>
							</div>
						</div>
					</div>
				</c:forEach>
				<div class="page">
					<ul class="pagination">
						<li class="page-item"><a class="page-link" href="./gallery?hostId=${hostId}&page=1"><</a></li>
						<c:forEach var="pageNumber" begin="${startPage}" end="${endPage}">
							<li class="page-item"><a class="page-link" href="./gallery?hostId=${hostId}&page=${pageNumber}">${pageNumber}</a></li>
						</c:forEach>
						<li class="page-item"><a class="page-link" href="./gallery?hostId=${hostId}&page=${totalPages}">></a></li>
					</ul>
				</div>
			</div>
		</div>
	</section>
	</div>
</body>
</html>