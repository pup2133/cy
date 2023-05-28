<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
<style>
.toast{
	display:none;
}
</style>
<script>
$(document).ready(function() {
	  // 웹소켓 연결
	  var sock = new SockJS('/cy/alram');
	  
	  sock.onopen = function() {
	    console.log('open');
	  };
	  
	  // 데이터를 전달 받았을때
	  sock.onmessage = onMessage; // toast 생성
	  
	  socket = sock;
	});

	function onMessage(evt) {
	  let data = evt.data;
	  console.log(data);
	  $(".toast").text(data);
	  $('.toast').show();
	}

	function tlscjd() {
	  socket.send("abc"+","+"yun");
	}
</script>
</head>
<body>
	
	
	<button onclick="tlscjd()">친구신청</button>
	<div class="toast"></div>
</body>
</html>