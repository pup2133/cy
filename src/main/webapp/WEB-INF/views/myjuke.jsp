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
<script src="https://kit.fontawesome.com/4ec79785b5.js"
	crossorigin="anonymous"></script>
<link rel="stylesheet" href="./resources/css/header_nav.css">
<link rel="stylesheet" href="./resources/css/myjuke.css">
<!-- sweet alert -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/sweetalert2@11.7.5/dist/sweetalert2.min.css">
<script
	src="https://cdn.jsdelivr.net/npm/sweetalert2@11.7.5/dist/sweetalert2.min.js"></script>

<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"
	integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ=="
	crossorigin="anonymous" referrerpolicy="no-referrer"></script>
</head>
<script type="text/javascript">
	//---네비게이션 기능
	//배너공개비공개
	$(document).ready(function() {
		$(".menu_box").click(function(event) {
			event.preventDefault(); // 기본 이벤트(페이지 이동) 막기
			let value = $(this).prev("input").val(); // menu_box 앞에 있는 input 요소의 값을 가져옴
			if ($('#hostId').val() === $('#sessionId').val()) {
				let href = $(this).parent("a").attr("href"); // a 태그의 href 속성 값 가져옴
				window.location.href = href; // 페이지 이동
			} else if (value === "1") {
				// 이동할 필요 없는 경우에 수행할 동작
				// 예: 경고창 띄우기 또는 다른 작업 수행
				Swal.fire({
					icon : 'warning',
					title : '비공개',
					text : '비공개 페이지입니다',
				});
			} else {
				// 이동해야 할 경우에 수행할 동작
				// 예: 페이지 이동
				let href = $(this).parent("a").attr("href"); // a 태그의 href 속성 값 가져옴
				window.location.href = href; // 페이지 이동
			}
		});
	});

	//오디오 관련
	$(document).ready(
			function() {
				const id = $('#hostId').val();
				const session = $('#sessionId').val();
				let audio = document.getElementById('audioPlayer');
				let playbackTimeKey = id + 'Time'; //여기에 sessionId넣기
				let playbackIndexKey = id + 'Index'; //여기에 sessionId넣기
				//db에서 목록 불러와서 playlist만들기
				let playlist = [ './resources/mp3/a02.mp3',
						'./resources/mp3/a03.mp3', './resources/mp3/a04.mp3' ];
				let currentIndex = 0;
				audio.src = playlist[currentIndex];
				playAudio();

				if (!audio.paused) {
					$(".play_btn").html('<i class="fa-solid fa-pause"></i>');
				} else if (audio.paused) {
					$(".play_btn").html('<i class="fa-solid fa-play"></i>');
				}

				// 오디오 재생
				function playAudio() {
					let storedPlaybackTime = localStorage
							.getItem(playbackTimeKey);
					let storedPlaybackIndex = localStorage
							.getItem(playbackIndexKey);
					if (storedPlaybackTime) {
						if (storedPlaybackIndex) {
							currentIndex = storedPlaybackIndex;
							audio.src = playlist[currentIndex];
						}
						audio.currentTime = parseFloat(storedPlaybackTime);
					}
					audio.play();
					$('.songTitle').text(playlist[currentIndex]);
				}

				// 현재 재생 중인 오디오가 끝났을 때 호출되는 이벤트 리스너
				audio.addEventListener('ended', function() {
					currentIndex++;
					if (currentIndex >= playlist.length) {
						currentIndex = 0; // 재생목록의 끝에 도달하면 처음으로 돌아감
						clearPlaybackTime();
					}
					audio.src = playlist[currentIndex];
					playAudio();
				});

				// 오디오 일시 정지
				function pauseAudio() {
					audio.pause();
					savePlaybackTime();
					savePlaybackIndex();
				}

				// // 오디오 정지 및 재생 시간 초기화
				// function stopAudio() {
				//     audio.pause();
				//     audio.currentTime = 0;
				//     clearPlaybackTime();
				// }

				//페이지 로드 시 저장된 재생 시간 확인
				window.addEventListener('load', function() {
					var storedPlaybackTime = localStorage
							.getItem(playbackTimeKey);
					let storedPlaybackIndex = localStorage
							.getItem(playbackIndexKey);
					if (storedPlaybackTime) {
						playAudio();
					}
				});

				// 페이지 이동 또는 리로드 시 재생 시간 저장
				window.addEventListener('beforeunload', function() {
					savePlaybackTime();
					savePlaybackIndex();
				});

				// 재생 시간 저장
				function savePlaybackTime() {
					localStorage.setItem(playbackTimeKey, audio.currentTime
							.toString());
				}
				//재생 순서 저장
				function savePlaybackIndex() {
					localStorage.setItem(playbackIndexKey, currentIndex
							.toString());
				}

				// 재생 시간 초기화
				function clearPlaybackTime() {
					localStorage.removeItem(playbackTimeKey);
				}

				//일시정지 및 재생

				$(".play_btn").click(
						function() {
							if (!audio.paused) {
								audio.pause();
								savePlaybackTime();
								savePlaybackIndex();
								$(".play_btn").html(
										'<i class="fa-solid fa-play"></i>');
							} else if (audio.paused) {
								playAudio();
								$(".play_btn").html(
										'<i class="fa-solid fa-pause"></i>');
							}
						})

				//이전곡
				$(".fa-backward-step").click(function() {
					currentIndex--;
					if (currentIndex < 0) {
						currentIndex = playlist.length - 1;
					}
					clearPlaybackTime();
					audio.src = playlist[currentIndex];
					playAudio();
				})

				//다음곡
				$(".fa-forward-step").click(function() {
					currentIndex++;
					if (currentIndex >= playlist.length) {
						currentIndex = 0;
					}
					clearPlaybackTime();
					audio.src = playlist[currentIndex];
					playAudio();
				})

			})

	//주크기능
	$(document).ready(
			function() {
				//host, session 아이디 확인
				const host = $("#hostId").val();
				const session = $("#sessionId").val();

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

				//플레이리스트 필터
				/*
				$(".play_music").each(function(){
				    let mm_in = $(this).find(".play_music_info p:nth-child(4)").text();
				    if(mm_in === "0"){
				        $(this).hide();
				    }
				});
				 */

				//플레이리스트 추가기능
				$(document).on(
						"click",
						".cover",
						function() {
							let mu_code = $(this).siblings(".music_info").find(
									".hidden").text();
							$.ajax({
								type : "POST",
								url : "addPlaylist",
								data : {
									mu_code : mu_code
								},
								success : function(data) {
									playlistItem(data);
								},
								error : function(err) {
								}
							})
						})

				//플레이리스트 제거기능
				$(document).on(
						"click",
						".fa-x",
						function() {
							let pl_code = $(this).siblings(
									".play_music_info_wrap").find(".code")
									.text();
							$.ajax({
								type : "POST",
								url : "subPlaylist",
								data : {
									pl_code : pl_code
								},
								success : function(data) {
									playlistItem(data);
								},
								error : function(err) {
								}
							})
						})

			});
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
		;
		$(".play_list").html(htmls);

		//숨기기
		$(".hidden").hide();
		//플레이리스트 필터
		/*
		$(".play_music").each(function(){
		    let mm_in = $(this).find(".play_music_info p:nth-child(4)").text();
		    if(mm_in === "0"){
		        $(this).hide();
		    }
		});
		 */

	}

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
</script>


<body>
	<header>
		<div class="icon">
			<img src="./resources/images/racon.png" alt="">
		</div>
		<div class="header_info">
			<i class="fa-regular fa-bell"></i> <img class="header_profile"
				src="./resources/images/ng.png" alt=""> <span>너굴</span> <i
				class="fa-sharp fa-solid fa-chevron-down"></i>
		</div>
	</header>
	<div class="nav_section">
		<nav>
			<div class="nav_wrap">
				<div class="music_player">
					<audio id="audioPlayer" controls onloadstart="this.volume=0.5"
						autoplay>
						<source id="audioSource" src="./resources/mp3/a01.mp3"
							type="audio/mp3">
						Your browser does not support the audio element.
					</audio>
					<div class="music_name">
						<span class="songTitle">I AM - IVE</span> <i
							class="fa-solid fa-music"></i>
					</div>
					<div class="music_icon">
						<i class="fa-solid fa-backward-step"></i>
						<div class="play_btn" style="display: inline-block;">
							<i class="fa-solid fa-play"></i>
						</div>
						<i class="fa-solid fa-forward-step"></i>
					</div>
				</div>

				<div class="search">
					<span><b>아이디검색</b></span>
					<div class="search_bar">
						<input type="text" name="" id=""> <i
							class="fa-solid fa-magnifying-glass"></i>
					</div>
				</div>
				<div class="menu">
					<a href="/cy/myhome?id=${hostId }"><input type="text" value="0"
						class="hidden">
					<div class="menu_box">홈</div></a> <a href="/cy/profile?id=${hostId }"><input
						type="text" value="${banner.B_HIDE_PROFILE}" class="hidden">
					<div class="menu_box">프로필</div></a> <a href="/cy/myjuke?id=${hostId }"><input
						type="text" value="${banner.B_HIDE_MUSIC }" class="hidden">
					<div class="menu_box">주크박스</div></a> <a href="/cy/diary?id=${hostId }"><input
						type="text" value="${banner.B_HIDE_DIARY }" class="hidden">
					<div class="menu_box">다이어리</div></a> <a
						href="/cy/gallery?id=${hostId }"><input type="text"
						value="${banner.B_HIDE_GALLERY }" class="hidden">
					<div class="menu_box">갤러리</div></a> <a href="/cy/visit?id=${hostId }"><input
						type="text" value="0" class="hidden">
					<div class="menu_box">방명록</div></a>
				</div>
			</div>
		</nav>

		<section>
			<div class="section_title">
				<span>주크박스</span> <a href="jukestore"><button
						class="btn-15 custom-btn">상점가기</button></a>
			</div>
			<div class="music_section">
				<div class="music_wrap style-2">
					<div class="music_list_wrap">
						<input type="text" id="hostId" class="hidden" value="${hostId}">
						<input type="text" id="sessionId" class="hidden"
							value="${sessionId}">
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