<%@page import="javax.swing.text.Document"%>
<%@page import="com.project.cy.model.dto.DiaryCommentDTO"%>
<%@page import="com.project.cy.model.dto.DiaryDTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>다이어리</title>
<script src="https://code.jquery.com/jquery-3.7.0.js" integrity="sha256-JlqSTELeR4TLqP0OG9dxM7yDPqX1ox/HfgiSLBj8+kM=" crossorigin="anonymous"></script>
<script src="https://kit.fontawesome.com/4ec79785b5.js" crossorigin="anonymous"></script>
<script src="resources/js/diary.js"></script>
<link rel="stylesheet" href="resources/css/header_nav.css" />
<link rel="stylesheet" href="resources/css/diary.css" />
<script type="text/javascript">
<%ArrayList<DiaryDTO> list;
	ArrayList<DiaryCommentDTO> listC;%>
	
function d_text_sel() {
	<%list = (ArrayList<DiaryDTO>) request.getAttribute("list");
	listC = (ArrayList<DiaryCommentDTO>) request.getAttribute("listC");
	System.out.println("삭제후 크기: "+listC.size());%>
	let wrap = document.getElementById('comment_all');
	
	//초기화
	$("textarea[name=d_text]").text("");
	wrap.innerHTML="";
	$("h4").text("댓글(0)");
	
	<%

for (DiaryDTO d : list) {%>
		
		if(choicedays == <%=d.getD_date()%>){
			$("textarea[name=d_text]").text("<%=d.getD_text()%>");
			<%int cnt=0;
			for (DiaryCommentDTO dc : listC) {%>
	<%if (d.getD_num().equals(dc.getD_num())) {
	System.out.println(dc.getDc_text());%>	
	temp='<div class="comment_list">';
	temp+='<div class="com_profile" style="background-image: url(<%=dc.getH_pic()%>)"></div>';
	temp+='<div class="com_text">';
	temp+='<div class="com_nick_up_del">';
	temp+='<div class="com_nick">';
	temp+='<b><%=dc.getM_nick()%></b>';
	temp+='<span><%=dc.getDc_time()%></span>';
	temp+='</div>';
	temp+='<div class="com_up_del">';
	temp+='<a href="javascript:void(0);" class="com_under" onclick="update_comment(this, <%=dc.getDc_num()%>)">수정</a> | ';
	temp+='<a href="javascript:void(0);" class="com_under" onclick="delete_comment(this, <%=dc.getDc_num()%>)">삭제</a>';
	temp+='</div>';
	temp+='</div>';
	temp+='<textarea name="" id="" class="comment_" maxlength="100" onkeydown="resize(this)" onkeyup="resize(this)" readonly><%=dc.getDc_text()%></textarea>';
	temp+='</div>';
	wrap.innerHTML+=temp;
<%cnt++;
}
}%>
$("h4").text("댓글(<%=cnt%>)");
		}
<%}%>
	}
	
	
	
//댓글 삭제
function delete_comment(obj, dc_num) {
  let tf = confirm("댓글을 삭제하시겠습니까??");
  let com = obj.parentElement.parentElement.parentElement.parentElement;
  
  if (tf) {
    $.ajax({
      url: "diary/commentDelete",
      method: "POST",
      data: {
        dc_num: dc_num,
      },
      success: function(data){
      	alert("삭제 완료");
      	com.remove();
      	
      },
      error:function(err){
        console.log(err);
      }    
    });
  }
  
  com.remove();
}

</script>
</head>
<body>
	<header>
		<div class="icon">
			<img src="resources/images/racon.png" alt="" />
		</div>
		<div class="header_info">
			<i class="fa-regular fa-bell"></i>
			<img class="header_profile" src="resources/images/p.png" alt="" /> <span>너굴</span>
			<i class="fa-sharp fa-solid fa-chevron-down"></i>
		</div>
	</header>
	<div class="nav_section">
		<nav>
			<div class="nav_wrap">
				<div class="music_player">
					<div class="music_name">
						<span>I AM - IVE</span>
						<i class="fa-solid fa-music"></i>
					</div>
					<div class="music_icon">
						<i class="fa-solid fa-backward-step"></i>
						<i class="fa-solid fa-play"></i>
						<i class="fa-solid fa-forward-step"></i>
					</div>
				</div>

				<div class="search">
					<span><b>아이디검색</b></span>
					<div class="search_bar">
						<input type="text" name="" id="" />
						<i class="fa-solid fa-magnifying-glass"></i>
					</div>
				</div>
				<div class="menu">
					<a href="">
						<div class="menu_box">홈</div>
					</a>
					<a href="">
						<div class="menu_box">프로필</div>
					</a>
					<a href="">
						<div class="menu_box">주크박스</div>
					</a>
					<a href="">
						<div class="menu_box">다이어리</div>
					</a>
					<a href="">
						<div>갤러리</div>
					</a>
					<a href="">
						<div>방명록</div>
					</a>
				</div>
			</div>
		</nav>
		<section>
			<div class="section_wrap">
				<div class="section_title">다이어리</div>
			</div>
			<div class="diary_cal">
				<div class="diary">
					<h1 id="diary_date">오늘의 일기 or 날짜?</h1>
					<textarea name="d_text" id="" class="diary_text" readonly></textarea>
					<div class="text_up_del">
						<a href="diary_update.html">수정</a>
						|
						<a href="">삭제</a>
					</div>

					<div class="comment_wrap" id="comment_wrap">
						<h4 id="com_cnt">댓글(count)</h4>
						<div class="comment">
							<textarea name="" id="" class="coment_text"></textarea>
							<input type="button" value="등록" id="com_sub" />
						</div>
						<div id="comment_all"></div>
					</div>
				</div>

				<!-- 캘린더 -->
				<div class="calendar_wrap">
					<table class="calendar">
						<thead>
							<tr>
								<td onClick="prevCalendar();" style="cursor: pointer">&#60;</td>
								<td colspan="5"><span id="calYear"></span> <span id="calMonth"></span></td>
								<td onClick="nextCalendar();" style="cursor: pointer">&#62;</td>
							</tr>
							<tr>
								<td>SU</td>
								<td>MO</td>
								<td>TU</td>
								<td>WE</td>
								<td>TH</td>
								<td>FR</td>
								<td>ST</td>
							</tr>
						</thead>
						<tbody></tbody>
					</table>
					<a href="diary_reg.html" class="diary_reg">
						<i class="fa-solid fa-pen"> 일기쓰기</i>
					</a>
				</div>
			</div>
		</section>
	</div>
</body>
</html>