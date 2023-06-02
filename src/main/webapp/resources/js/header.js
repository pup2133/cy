$(document).ready(function() {

	const host = $('#hostId').val();
	const session = $('#sessionId').val();
	
	/* 헤더기능 */
	
	checkAlert();
	
	//드롭다운
	$('.profile_drop').click(function() {
		$('.dropdown_profile').slideToggle(200);
    });

    $('.fa-bell').click(function() {
		$('.dropdown_friends').slideToggle(200);
    });

	//친구알림, 수락
	let alert_count = parseInt($('#alert_count').val());
	$(".friends_alert").click(function(){
		let recieve_id = $(this).prevAll(".recieve_id").val();
		let send_id = $(this).prevAll(".send_id").val();
		let f_num = $(this).prev("input").val();
		let f_name=$(this).find(".friends_name").text();
		let $this = $(this);
		Swal.fire({
			title: '일촌신청 수락 하시겠습니까?',
            text: f_name+"님의 일촌신청",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: '수락',
            cancelButtonText: '거절',
            reverseButtons: true, // 버튼 순서 거꾸로
		}).then((result)=>{
			if(result.isConfirmed){
				$.ajax({
					type:"POST",
					url:"accept",
					data:{f_num:f_num},
					success:function(data){
						Swal.fire({
							icon: 'success',
	                        title: '일촌맺기 완료',
	                        text: f_name+'님과 일촌이 되었습니다',
	                    });
						if(host===recieve_id || host===send_id){
							let friends_count = parseInt($(".friends_count").text())+1;  //일촌증가(임시)
							$(".friends_count").text(friends_count);
						}
					},
					error:function(err){
						console.log(err);
					}
				});
				}else if(!result.isConfrmed){
					$.ajax({
						type:"POST",
						url:"reject",
						data:{f_num:f_num},
						success:function(data){
							Swal.fire({
	                            title: '일촌신청 거절',
	                            text: f_name+'님의 일촌신청을 거절했습니다',
	                        });
						},
						error:function(err){
							console.log(err);
						}
					});
				}
				$this.remove(); //알람삭제
				alert_count=alert_count-1;
				$('#alert_count').val(alert_count);
				checkAlert();
			});
		});
		
		/* 네비게이션 기능 */
		
		//배너 공개 or 비공개
		$(".menu_box").click(function(event) {
	    	event.preventDefault(); // 기본 이벤트(페이지 이동) 막기
	    	let value = $(this).prev("input").val(); // menu_box 앞에 있는 input 요소의 값을 가져옴
	    	if(host==session){
	    		let href = $(this).parent("a").attr("href"); // a 태그의 href 속성 값 가져옴
		    	window.location.href = href; // 페이지 이동
	    	}else if(value === "0") {
	     		// 이동할 필요 없는 경우에 수행할 동작
	      		// 예: 경고창 띄우기 또는 다른 작업 수행
	    		Swal.fire({
	            	icon: 'warning',
	            	title: '비공개',
	            	text: '비공개 페이지입니다',
	        	});
	    	} else {
	      		// 이동해야 할 경우에 수행할 동작
	      		// 예: 페이지 이동
	      		let href = $(this).parent("a").attr("href"); // a 태그의 href 속성 값 가져옴
	      		window.location.href = href; // 페이지 이동
	      	}
	   });
		
	  	//오디오관련
	    let audio = document.getElementById('audioPlayer');
	    let playbackTimeKey = session+'Time'; //여기에 sessionId넣기
	    let playbackIndexKey = session+'Index'; //여기에 sessionId넣기
	    let playIngKey = session+'Ing';
	    
	    //db에서 목록 불러와서 playlist만들기
	    let playlist_text = $("#myplayList").val();
	    console.log(playlist_text);
	    let titlelist_text = $("#titleList").val();
		let regexForPlay = /([a-zA-Z0-9]+\.mp3)/g;
		let regexForTitle = /[\w가-힣]+/g;
		
		let playlist = $.map(playlist_text.match(regexForPlay), function(value) {
			return value;
		});
		let titlelist = $.map(titlelist_text.match(regexForTitle), function(value) {
			return value;
		});
		
	    let currentIndex = 0;
	    let currentIng = 0;
	    audio.src = './resources/mp3/'+playlist[currentIndex];
	    let storedPlayIng = localStorage.getItem(playIngKey);
	    let storedPlaybackIndex = localStorage.getItem(playbackIndexKey);
	    if(storedPlaybackIndex){
	    	currentIndex = storedPlaybackIndex;
	    	$('.songTitle').text(titlelist[currentIndex]);
	    }
	    if(storedPlayIng){
	    	currentIng = storedPlayIng;
	    }
	    if(currentIng==1){
	    	playAudio();
	    }
	    chageIcon();
	    	
	    // 현재 재생 중인 오디오가 끝났을 때 호출되는 이벤트 리스너
	    audio.addEventListener('ended', function() {    
	    	currentIndex++;
	    	if (currentIndex >= playlist.length) {
	    		currentIndex = 0; // 재생목록의 끝에 도달하면 처음으로 돌아감
	      		clearPlaybackTime();
	    	}
	    	audio.src = './resources/mp3/'+playlist[currentIndex];   
	    	playAudio();
	    });
	    	
	    // 페이지 이동 또는 리로드 시 재생 시간 저장
	    window.addEventListener('beforeunload', function() {
	        savePlaybackTime();
	        savePlaybackIndex();
	        savePlayIng();
	    });
	
	    //일시정지 및 재생
	    $(".play_btn").click(function(){
	        if (!audio.paused){
	            audio.pause();
	            savePlaybackTime();
	            savePlaybackIndex();
	            localStorage.setItem(playIngKey,"0");
	            currentIng="0";
	            $(".play_btn").html('<i class="fa-solid fa-play"></i>');
	        }else if(audio.paused){
	            playAudio();
	            $(".play_btn").html('<i class="fa-solid fa-pause"></i>');
	        }
	    });
	
	    //이전곡
	    $(".fa-backward-step").click(function(){
	        currentIndex--;
	        if (currentIndex < 0) {
	            currentIndex = playlist.length-1;
	        }
	        clearPlaybackTime();
		    audio.src = './resources/mp3/'+playlist[currentIndex];  
		    $('.songTitle').text(titlelist[currentIndex]);
		    playAudio();
		    chageIcon();
	    });
	
	    //다음곡
	    $(".fa-forward-step").click(function(){
	        currentIndex++;
	        if (currentIndex >= playlist.length) {
	            currentIndex = 0;
	        }
	        clearPlaybackTime();
		    audio.src = './resources/mp3/'+playlist[currentIndex];
		    $('.songTitle').text(titlelist[currentIndex]);
		    playAudio();
		    chageIcon();
	    });
	    
		//친구알림체크
		function checkAlert(){
			if(parseInt($('#alert_count').val())===0){
				$('.dropdown_friends').text("새로운 일촌신청이 없습니다.");
				$('.dropdown_friends').css("text-align","center");
				$('.new_alert').hide();
			}
		}
		
		//재생아이콘 변경
		function chageIcon(){
			if(!audio.paused){
				$(".play_btn").html('<i class="fa-solid fa-pause"></i>');
			}else if(audio.paused){
				$(".play_btn").html('<i class="fa-solid fa-play"></i>');
			}
		}
			    
		// 오디오 재생
		function playAudio() {
			let storedPlaybackTime = localStorage.getItem(playbackTimeKey);
			let storedPlaybackIndex = localStorage.getItem(playbackIndexKey);
			let storedPlayIng = localStorage.getItem(playIngKey);
			if (storedPlaybackTime) {
				if(storedPlaybackIndex){
					currentIndex = storedPlaybackIndex;
			        audio.src = './resources/mp3/'+playlist[currentIndex];   
			    }
			    audio.currentTime = parseFloat(storedPlaybackTime);
			 }
		     audio.play();
		     localStorage.setItem(playIngKey,"1");
		     currentIng="1";
			 $('.songTitle').text(titlelist[currentIndex]);
		}
	    
	    /* 아이디 검색 */
	    
	    //검색 리스트
    	$.ajax({
    		url: "searchList",
    	    method: "get",
    	    success: function(list){
    	    	$.each(JSON.parse(list), function(key, m){ 
    	    		let tmp = "<option value='"+m.m_id+"'>"+m.m_nick+"</option>";
    	    		$("#ids").append(tmp);
    	    	});
    	    },
    	    error:function(err){
    	    	console.log(err);
    	    }    
    	});
    	
    	//아이디 검색
    	$("#searchbtn").click(function name() {
    		let s_id = $("#search_text").val();
    		location.href = "myhome?id=" + s_id;
		});
		
	    // 웹소켓 연결
	    const sock = new SockJS('/cy/alram');

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
	  
	  // 재생 시간 저장
		function savePlaybackTime() {
			localStorage.setItem(playbackTimeKey, audio.currentTime.toString());
		}
			    
		//재생 순서 저장
		function savePlaybackIndex(){
			localStorage.setItem(playbackIndexKey,currentIndex.toString());
		}
		
		// 재생 시간 초기화
		function clearPlaybackTime() {
			localStorage.removeItem(playbackTimeKey);
		}
});