<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
  <style>
    /* 토스트 창 스타일 */
    .toast {
      position: fixed;
      bottom: 30px;
      right: -100px;
      transform: translateX(-50%);
      background-color: #333;
      color: #fff;
      padding: 15px;
      border-radius: 5px;
      opacity: 0;
      transition: opacity 0.3s;
      z-index: 9999;
    }

    /* 토스트 창 애니메이션 */
    .toast.show {
      opacity: 1;
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
	}

	function tlscjd() {
	  socket.send("abc"+","+"yun");
      var toast = document.createElement('div');
      toast.className = 'toast';
      toast.innerHTML = '예쁜 토스트 창입니다!';

      document.body.appendChild(toast);

      setTimeout(function() {
        toast.classList.add('show');
        setTimeout(function() {
          toast.classList.remove('show');
          setTimeout(function() {
            document.body.removeChild(toast);
          }, 300);
        }, 3000);
      }, 100);
	}
</script>
</head>
<body>
	<button onclick="tlscjd()">친구신청</button>
</body>
</html>