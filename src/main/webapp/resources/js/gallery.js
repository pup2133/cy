	$(document).ready(function() {
		
		const host = $("#hostId").val();
		const sessionId = $("#sessionId").val();
	
		function comment(data, commentWrap){
			for(let i=0; i<data.length; i++){
				// 새로운 comment 요소 생성
				let edit_comment;
				let edit_comment2;
				let delete_comment;
				let line;
				
				let newComment = $('<div>').addClass('comment');
				let commentProfile = $('<div>').addClass('comment_profile');
				let commentInfo = $('<div>').addClass('comment_info');
				let innerDiv1 = $('<div>');
				let innerDiv2 = $('<div>').addClass('comment_text');
				let innerDiv3 = $('<div>');
				let innerDiv4 = $('<div>').addClass('cgc');
				let spanDiv = $('<div>').addClass('spanDiv');
				let span1 = $('<b>').text(data[i].m_nick);
				let span2 = $('<span>').text(data[i].g_time);
				let span3 = $('<span>').addClass('gc_text').text(data[i].gc_text);
				let span4 = $('<span>').addClass('gc_good').text(data[i].good_count);
				let span5 = $('<span>').addClass('comment_good').text('♥');
				let textarea = $('<textarea>').addClass('edit').text(data[i].gc_text).css('display','none').attr('autofocus', true);
				if(host == sessionId && sessionId != data[i].m_id){
					delete_comment = $('<button>').addClass('delete_comment').text('삭제');
					innerDiv3.append(delete_comment);
				}else if(data[i].m_id == sessionId){
					edit_comment = $('<button>').addClass('edit_comment').attr('type','button').text('수정');
					edit_comment2 = $('<button>').addClass('edit_comment2').attr('type','button').text('수정').css('display', 'none');
					line =$('<span>').text('|');
					delete_comment = $('<button>').addClass('delete_comment').text('삭제');
					innerDiv3.append(edit_comment);
					innerDiv3.append(edit_comment2);
					innerDiv3.append(line);
					innerDiv3.append(delete_comment);
				}
				let gc_num = $('<input>').attr({'type' : 'hidden', 'name' : 'gc_num'}).val(data[i].gc_num);
				
				// 요소들을 조립하여 새로운 요소에 추가
				innerDiv1.append(span1);
				innerDiv1.append(span2);
				innerDiv1.append(gc_num);
				spanDiv.append(span3);
				spanDiv.append(textarea);
				innerDiv2.append(spanDiv);
				innerDiv4.append(span4);
				innerDiv4.append(span5);
				innerDiv2.append(innerDiv4);
				commentProfile.append($('<img>').attr('src', "./resources/file/profile/"+data[i].g_pic));
				commentInfo.append(innerDiv1);
				commentInfo.append(innerDiv2);
				commentInfo.append(innerDiv3);
				newComment.append(commentProfile);
				newComment.append(commentInfo);
				
				// 새로운 comment 요소를 원하는 위치에 추가
				commentWrap.append(newComment);

			}
		}
		
		$('.gallery_comment').click(function() {
			let $galleryText = $(this).siblings('.gallery_text');
			let $comment = $(this).siblings('.comment_wrap');
			let $reg = $(this).siblings('.comment_reg');
			let g_num = $galleryText.find('input[name="g_num"]').val();
			
			console.log(g_num);

			$comment.empty();
			$galleryText.hide();
			$comment.slideDown(700);
			$reg.show();
			$(this).hide();
			$(this).siblings('.gallery_comment2').show();
					
 			$.ajax({
				url : "commentList", // 요청을 보낼 URL
				method : "POST",
				dataType : "json",
				data : {
					"g_num" : g_num,
				},
				success : function(data) {
					console.log(data);
					comment(data,$comment);
				},
				error : function(error) {
				
				}
			}); 
		});
				
		$('.gallery_comment2').click(function() {
			let $galleryText = $(this).siblings('.gallery_text');
			let $comment = $(this).siblings('.comment_wrap');
			let $reg = $(this).siblings('.comment_reg');
			$comment.empty();

			$galleryText.show();
			$comment.hide();
			$reg.hide();
			$(this).hide();
			$(this).siblings('.gallery_comment').show();
						
		});
				
		$('.gallery_good').click(function() {
			let g_num = $(this).closest('.gallery_text').find('input[name="g_num"]').val();
			let m_id = $(this).closest('.gallery_text').find('input[name="m_id"]').val();
			let good = $(this).closest('.gallery_text').find('.good').val();
			let good2 = $(this).closest('.gallery_text').find('.good');

			$.ajax({
				url : "galleryGood", // 요청을 보낼 URL
				method : "POST",
				dataType : "text",
				data : {
					"g_num" : g_num,
					"m_id" : m_id
				},
				success : function(data) {
					data == 6 ? good2.val(--good) : good2.val(++good);
				},
				error : function(error) {
							
				}
			});
		});
				
		$('.d_reg').click(function() {
			let g_num = $(this).siblings('input[name="g_num2"]').val();
			let gc_text = $(this).siblings('textarea[name="gc_text"]').val();
			let text = $(this).siblings('textarea[name="gc_text"]');
			let $commentWrap = $(this).closest('.comment_reg').siblings('.comment_wrap');

			$.ajax({
				url : "comment", // 요청을 보낼 URL
				method : "POST",
				dataType : "json",
				data : {
					"g_num" : g_num,
					"gc_text" : gc_text
				},
				success : function(data) {				
					comment(data,$commentWrap);
					text.val('');
					$commentWrap.animate({ scrollTop: $commentWrap[0].scrollHeight }, 'slow');
				},
				error : function(error) {

				}
			});
		});
		
		$('.deleteGallery').click(function() {
			let g_num = $(this).closest('.gallery').find('input[name="g_num"]').val();
			let gallery = $(this).closest('.gallery');
			let fileName = $(this).siblings('input[name="g_pic"]').val();
			
			$.ajax({
				url : "deleteGallery",
				method : "POST",
				dataType : "text",
				data : {
					"g_num" : g_num,
					"fileName" : fileName
				},
				success : function(data) {
					gallery.remove();
				},
				error : function(error) {

				}
			});
			
		});
	
		$(document).on('click', '.edit_comment', function() {
			  $(this).hide();
			  $(this).siblings('.edit_comment2').show();
			  $(this).parent().siblings('.comment_text').children('.spanDiv').find('span').hide();
			  $(this).parent().siblings('.comment_text').find('.edit').show();
			  			  
		});
		
		$(document).on('click', '.edit_comment2', function() {
			  $(this).hide();
			  $(this).siblings('.edit_comment').show();
			  let textarea = $(this).parent().siblings('.comment_text').find('.edit');
			  let textSpan = $(this).parent().siblings('.comment_text').children('.spanDiv').find('span');
			  textarea.height(textSpan.height());
			  
			  console.log(textSpan.height());
			  textSpan.text('');

			  let gc_num = $(this).closest('.comment_info').find('input[name="gc_num"]').val();
			  let gc_text = textarea.val();

				$.ajax({
					url : "editComment", // 요청을 보낼 URL
					method : "POST",
					contentType: "application/x-www-form-urlencoded; charset=UTF-8",
					dataType : "text",
					data : {
						"gc_num" : gc_num,
						"gc_text" : gc_text
					},
					success : function(data) {
						textarea.hide();
						textSpan.show();
						textSpan.text(gc_text);
					},
					error : function(error) {

					}
			});
		});
		
		$(document).on('click', '.delete_comment', function() {
			let gc_num = $(this).closest('.comment_info').find('input[name="gc_num"]').val();
			let comment = $(this).parent().parent().parent();
			$.ajax({
				url : "deleteComment", // 요청을 보낼 URL
			 	method : "POST",
				dataType:"text",
				data : { "gc_num" : gc_num },
				success : function(data) {
					comment.remove();
				},
				error : function(error) {
					  
				}
			});
		});
		
		$(document).on('click', '.comment_good', function() {
			let gc_num = $(this).closest('.comment_info').find('input[name="gc_num"]').val();
			let m_id = $(this).closest('.comment_wrap').siblings('.gallery_text').find('input[name="m_id"]').val();
			let good = $(this).siblings('.gc_good');
			let good2 = $(this).siblings('.gc_good').text();
			
			$.ajax({
				url : "commentGood", // 요청을 보낼 URL
				method : "POST",
				dataType:"text",
				data : {
					"gc_num" : gc_num,
					"m_id" : m_id
				},
				success : function(data) {
					data == 6 ? good.text(--good2) : good.text(++good2);
				},
				error : function(error) {
					
				}
			});
		});
	// 웹소켓 연결
    const sock = new SockJS('/cy/alram');

    // 데이터를 전달 받았을 때
    sock.onmessage = onMessage; // toast 생성
});