<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Document</title>
<script src="https://kit.fontawesome.com/4ec79785b5.js" crossorigin="anonymous"></script>
<link rel="stylesheet" href="./resources/css/header_nav.css">
<link rel="stylesheet" href="./resources/css/myjuke.css">
<!-- sweet alert -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.7.5/dist/sweetalert2.min.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.7.5/dist/sweetalert2.min.js"></script>
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
<script type="text/javascript">
//ajax로 플레이리스트 html변경 함수
function playlistItem(data) {
	let htmls = "";
	for (let i = 0; i < data.length; i++) {
		let item = data[i]
		let html = '<div class="play_music">';
		html += '<div class="play_music_info_wrap">';
		html += '<img src="./resources/images/' + item.mu_img + '.jpg">';
		html += '<div class="play_music_info">';
		html += '<p class="hidden code">' + item.pl_code + '</p>';
		html += '<p>' + item.mu_title + '</p>';
		html += '<p>' + item.mu_artist + '</p>';
		html += '<p class="hidden">' + item.pl_code + '</p>';
		html += '</div>';
		html += '</div>';
		html += '<i class="fa-regular fa-x"></i>';
		html += '</div>';

		htmls += html;
	}
	$(".play_list").html(htmls);
	//숨기기
	$(".hidden").hide();
}

//주크기능
$(document).ready(function() {
	
	const host = $('#hostId').val();
	const session = $('#sessionId').val();
	
	//손님일 경우 기능 제한
	if (host !== session) {
		$(".cover").hide();
		$(".line").hide();
		$(".playlists").hide();
		$('.music_wrap').css('width', '1200px');
		$('.music_list').css('width', '25%');
	}
	
	//날짜 형식 변경
	$(".music_info p:nth-child(3)").each(function() {
		let date = $(this).text();
		let formattedDate = formatDate(date);
		$(this).text(formattedDate);
	});
	
	//숨기기
	$(".hidden").hide();
	
	//플레이리스트 추가기능
	$(document).on("click", ".cover", function() {
		let mu_code = $(this).siblings(".music_info").find(".hidden").text();
		$.ajax({
			type : "POST",
			url : "addPlaylist",
			data : { mu_code : mu_code },
			success : function(data) {
				playlistItem(data);
			},
			error : function(err) {
			}
		});
	});
	
	//플레이리스트 제거기능
	$(document).on("click", ".fa-x", function() {
		let pl_code = $(this).siblings(".play_music_info_wrap").find(".code").text();
		$.ajax({
			type : "POST",
			url : "subPlaylist",
			data :{ pl_code : pl_code },
			success : function(data) {
				playlistItem(data);
			},
			error : function(err) {
			}
		});
	});
	
	//날짜형식 변경 함수
	function formatDate(dateString) {
		let date = new Date(dateString);
		let year = date.getFullYear();
		let month = date.getMonth() + 1;
		let day = date.getDate();

		// 원하는 날짜 형식으로 조합
		let formattedDate = year + "." + padZero(month) + "." + padZero(day);
		return formattedDate;
	}
	
	function padZero(number) {
		return (number < 10 ? "0" : "") + number;
	}
});
</script>
<script src="./resources/js/header.js"></script>
</head>
<body>
	<%@ include file="header_nav.jsp"%>
		<section>
			<div class="section_title">
				<span>주크박스</span> <a href="jukestore"><button
						class="btn-15 custom-btn">상점가기</button></a>
			</div>
			<div class="music_section">
				<div class="music_wrap style-2">
					<div class="music_list_wrap">
						<c:forEach var="item" items="${mylist}">
							<div class="music_list">
								<div class="cover" href="">
									<div>+</div>
								</div>
								<img src="./resources/images/${item.mu_img}.jpg" alt="">
								<div class="music_info">
									<p>${item.mu_title }</p>
									<p>${item.mu_artist }</p>
									<p>${item.mu_date }</p>
									<p>${item.mu_genre }</p>
									<p class="hidden">${item.mu_code }</p>
								</div>
							</div>
						</c:forEach>

					</div>
				</div>
				<div class="line"></div>
				<div class="playlists">
					<div class="playlist_title">PLAYLIST</div>
					<div class="play_list style-2">

						<c:forEach var="item" items="${myplay}">
							<div class="play_music">
								<div class="play_music_info_wrap">
									<img src="./resources/images/${item.mu_img }.jpg">
									<div class="play_music_info">
										<p class="hidden code">${item.pl_code}</p>
										<p>${item.mu_title }</p>
										<p>${item.mu_artist }</p>
									</div>
								</div>
								<i class="fa-regular fa-x"></i>
							</div>
						</c:forEach>

					</div>
				</div>
			</div>
		</section>
	</div>
</body>
</html>