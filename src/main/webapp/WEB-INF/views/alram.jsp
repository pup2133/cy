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
      right: 0px;
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
    const sock = new SockJS('/cy/alram');

    sock.onopen = function() {
      console.log('open');
    };

    // 데이터를 전달 받았을 때
    sock.onmessage = onMessage; // toast 생성

    function onMessage(evt) {
      let data = evt.data;
      let toast = $('<div>', { class: 'toast', text: data });
      $('body').append(toast);

      setTimeout(function() {
        toast.addClass('show');
        setTimeout(function() {
          toast.removeClass('show');
          setTimeout(function() {
            toast.remove();
          }, 300);
        }, 3000);
      }, 100);
    }

    $('#toastButton').click(function() {
      sock.send('abc' + ',' + 'yun');
    });
    
});
</script>
</head>
<body>
	<button id="toastButton">친구신청</button>
</body>
</html>