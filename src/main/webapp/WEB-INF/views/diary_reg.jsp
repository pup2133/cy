<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>오늘의 다이어리 쓰기</title>
<script src="https://kit.fontawesome.com/4ec79785b5.js" crossorigin="anonymous"></script>
<link rel="stylesheet" href="resources/css/header_nav.css" />
<link rel="stylesheet" href="resources/css/diary_reg.css" />
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.7.5/dist/sweetalert2.min.js"></script>
<script type="text/javascript">
function diary_sub() {
	frm.submit();
}
// 웹소켓 연결
const sock = new SockJS('/cy/alram');

// 데이터를 전달 받았을 때
sock.onmessage = onMessage; // toast 생성
</script>
<script src="./resources/js/header.js"></script>
</head>
<body>
	<%@ include file="header_nav.jsp"%>
	<section>
		<div class="section_wrap">
			<div class="diary_reg">다이어리 등록</div>
		</div>
		<div class="diary_cal">
			<form class="diary" name="frm" method="post">
				<h1>오늘의 일기</h1>
				<textarea name="d_text" id="" class="diary_text"></textarea>
				<div class="text_btn">
					<a href="javascript:void(0);" onclick="diary_sub()">등록</a> | 
					<a href="javascript:history.back();">돌아가기</a>
				</div>
			</form>
		</div>
	</section>
	</div>
</body>
</html>