//---헤더기능
	//드롭다운
	$(document).ready(function() {
        $('.profile_drop').click(function() {
            $('.dropdown_profile').slideToggle(200);
        });

        $('.fa-bell').click(function() {
            $('.dropdown_friends').slideToggle(200);
        });
    });;
	//유효성 (필요하면 사용)
	$(document).ready(function(){
		const host = $('#hostId').val();
		const session = $('#sessionId').val();
	})
	//친구알림체크
	function checkAlert(){
		if(parseInt($('#alert_count').val())===0){
			$('.dropdown_friends').text("새로운 일촌신청이 없습니다.");
			$('.dropdown_friends').css("text-align","center");
			$('.new_alert').hide();
		}
	}
	//친구알림,수락
	$(document).ready(function(){
		const host = $('#hostId').val();
		const session = $('#sessionId').val();
		checkAlert();
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
							console.log("수락됨");
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
					})
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
					})
				}
				$this.remove();  //알람삭제(임시)
				alert_count=alert_count-1;
				$('#alert_count').val(alert_count);
				checkAlert();
			})
		})
	})