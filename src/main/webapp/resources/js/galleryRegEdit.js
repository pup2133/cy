$(document).ready(function() {
	$('#file').change(function(event) {
		let file = event.target.files[0];
		let reader = new FileReader();

		reader.onload = function(e) {
			$('.gallery_img').css('background-image', 'url(' + e.target.result + ')');
			$('#pic_text').text('');
		};
		reader.readAsDataURL(file);
	});
	
	// 웹소켓 연결
    const sock = new SockJS('./alram');

    // 데이터를 전달 받았을 때
    sock.onmessage = onMessage; // toast 생성
});