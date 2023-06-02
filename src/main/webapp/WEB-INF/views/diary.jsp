<%@page import="javax.swing.text.Document"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>다이어리</title>
<script src="https://code.jquery.com/jquery-3.7.0.js" integrity="sha256-JlqSTELeR4TLqP0OG9dxM7yDPqX1ox/HfgiSLBj8+kM=" crossorigin="anonymous"></script>
<script src="https://kit.fontawesome.com/4ec79785b5.js" crossorigin="anonymous"></script>
<link rel="stylesheet" href="resources/css/header_nav.css" />
<link rel="stylesheet" href="resources/css/diary.css" />
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
<script type="text/javascript">
	let days = "${param.days}";
	let choiceYear2 = days.substr(0, 4);
	let choiceMonth2 = days.substring(4, 6);
  	let choiceDay2 = days.substring(6, 8);
  
window.onload = function () {
  buildCalendar();
  // 웹 페이지가 로드되면 buildCalendar 실행

  // 첫 로딩시 댓글 자동 줄바꿈
  let coms = document.querySelectorAll(".comment_");
  let comsl = coms.length;
  for (let i = 0; i < comsl; i++) {
    resize(coms[i]);
  }
  
  let d_id = document.getElementById(days);
  //오늘 날짜 출력
  choiceDate(d_id);
  
  change_diarydate(choiceYear2, choiceMonth2, choiceDay2);
  
  if($("#d_num").val() == "")
	  $("#hide_com").css("display", "none");
	  
};


let nowMonth = new Date(choiceYear2, choiceMonth2-1, choiceDay2); // 현재 달을 페이지를 로드한 날의 달로 초기화
let today = new Date(); // 페이지를 로드한 날짜를 저장
today.setHours(0, 0, 0, 0); // 비교 편의를 위해 today의 시간을 초기화

let choiceYear = nowMonth.getFullYear().toString();
let choiceMonth = (nowMonth.getMonth() + 1).toString();
if (choiceMonth.length == 1) {
  choiceMonth = "0" + choiceMonth;
}
let choiceDay = nowMonth.getDate().toString();
if (choiceDay.length == 1) {
  choiceDay = "0" + choiceDay;
}

let choicedays = choiceYear + choiceMonth + choiceDay;
console.log(choicedays);




// 달력 생성 : 해당 달에 맞춰 테이블을 만들고, 날짜를 채워 넣는다.
function buildCalendar() {
  let firstDate = new Date(nowMonth.getFullYear(), nowMonth.getMonth(), 1); // 이번달 1일
  let lastDate = new Date(nowMonth.getFullYear(), nowMonth.getMonth() + 1, 0); // 이번달 마지막날

  let tbody_Calendar = document.querySelector(".calendar > tbody");
  document.getElementById("calYear").innerText = nowMonth.getFullYear(); // 연도 숫자 갱신
  //   document.getElementById("calMonth").innerText = leftPad(
  //     nowMonth.getMonth() + 1
  let month = document.getElementById("calMonth"); // 월 숫자 갱신
  switch (nowMonth.getMonth() + 1) {
    case 1:
      month.innerHTML = "Jan";
      break;
    case 2:
      month.innerHTML = "Feb";
      break;
    case 3:
      month.innerHTML = "Mar";
      break;
    case 4:
      month.innerHTML = "Apr";
      break;
    case 5:
      month.innerHTML = "May";
      break;
    case 6:
      month.innerHTML = "Jun";
      break;
    case 7:
      month.innerHTML = "Jul";
      break;
    case 8:
      month.innerHTML = "Aug";
      break;
    case 9:
      month.innerHTML = "Sep";
      break;
    case 10:
      month.innerHTML = "Oct";
      break;
    case 11:
      month.innerHTML = "Nov";
      break;
    case 12:
      month.innerHTML = "Dec";
      break;
  }

  while (tbody_Calendar.rows.length > 0) {
    // 이전 출력결과가 남아있는 경우 초기화
    tbody_Calendar.deleteRow(tbody_Calendar.rows.length - 1);
  }

  let nowRow = tbody_Calendar.insertRow(); // 첫번째 행 추가

  for (let j = 0; j < firstDate.getDay(); j++) {
    // 이번달 1일의 요일만큼
    let nowColumn = nowRow.insertCell(); // 열 추가
  }

  for (
    let nowDay = firstDate;
    nowDay <= lastDate;
    nowDay.setDate(nowDay.getDate() + 1)
  ) {
    // day는 날짜를 저장하는 변수, 이번달 마지막날까지 증가시키며 반복

    let nowColumn = nowRow.insertCell(); // 새 열을 추가하고
    nowColumn.innerText = leftPad(nowDay.getDate()); // 추가한 열에 날짜 입력

    let getYear = nowDay.getFullYear().toString();
    let getMonth = (nowDay.getMonth() + 1).toString();
    let getDay = nowColumn.innerText;
    if (getMonth.length == 1) {
      getMonth = "0" + getMonth;
    }
    nowColumn.id = getYear + getMonth + getDay;

    if (nowDay.getDay() == 0) {
      // 일요일인 경우 글자색 빨강으로
      nowColumn.style.color = "#DC143C";
    }
    if (nowDay.getDay() == 6) {
      // 토요일인 경우 글자색 파랑으로 하고
      nowColumn.style.color = "#0000CD";
      nowRow = tbody_Calendar.insertRow(); // 새로운 행 추가
    }

    if (nowDay < today) {
      // 지난날인 경우
      nowColumn.className = "pastDay";
      nowColumn.onclick = function () {
        choiceDate(this);
        location.href = "diary?id=${hostId}&days=" + choicedays;
      };
    } else if (
      nowDay.getFullYear() == today.getFullYear() &&
      nowDay.getMonth() == today.getMonth() &&
      nowDay.getDate() == today.getDate()
    ) {
      // 오늘인 경우
      nowColumn.className = "today";
      nowColumn.onclick = function () {
        choiceDate(this);
        location.href = "diary?id=${hostId}&days=" + choicedays;
      };
    } else {
      // 미래인 경우
      nowColumn.className = "futureDay";
      nowColumn.onclick = function () {
        choiceDate(this);
        location.href = "diary?id=${hostId}&days=" + choicedays;
      };
    }
  }
}

// 날짜 선택
function choiceDate(nowColumn) {
  if (document.getElementsByClassName("choiceDay")[0]) {
    // 기존에 선택한 날짜가 있으면
    document
      .getElementsByClassName("choiceDay")[0]
      .classList.remove("choiceDay"); // 해당 날짜의 "choiceDay" class 제거
  }
  nowColumn.classList.add("choiceDay"); // 선택된 날짜에 "choiceDay" class 추가

  //선택한 날짜 값 담기
  choiceDay = nowColumn.innerText;
  choiceYear = nowMonth.getFullYear().toString();
  choiceMonth = (nowMonth.getMonth() + 1).toString();
  if (choiceMonth.length == 1) {
    choiceMonth = "0" + choiceMonth;
  }
  choicedays = choiceYear + choiceMonth + choiceDay;
  console.log(choicedays);  
}

// 이전달 버튼 클릭
function prevCalendar() {
  nowMonth = new Date(
    nowMonth.getFullYear(),
    nowMonth.getMonth() - 1,
    nowMonth.getDate()
  ); // 현재 달을 1 감소
  buildCalendar(); // 달력 다시 생성
}
// 다음달 버튼 클릭
function nextCalendar() {
  nowMonth = new Date(
    nowMonth.getFullYear(),
    nowMonth.getMonth() + 1,
    nowMonth.getDate()
  ); // 현재 달을 1 증가
  buildCalendar(); // 달력 다시 생성
}

// input값이 한자리 숫자인 경우 앞에 '0' 붙혀주는 함수
function leftPad(value) {
  if (value < 10) {
    value = "0" + value;
    return value;
  }
  return value;
}

// 요기까지 달력

//댓글 줄바꿈
function resize(obj) {
  obj.style.height = "1px";
  obj.style.height = 16 + obj.scrollHeight + "px";
}

//댓글 수정 readonly 풀기
let update = 0;
function update_comment(obj, dc_num) {
  var area = obj.parentElement.parentElement.nextElementSibling;

  if (update == 0) {
    $(area).removeAttr("readonly", false);
    $(area).css("background", "white");
    update = 1;
  } else if (update == 1) {
    $(area).attr("readonly", true);
    $(area).css("background", "none");
    
    $.ajax({
      url: "diary/commentUpdate",
      method: "POST",
      data: {
        dc_num: dc_num,
        dc_text: $(area).val()
      },
      success: function(data){
      	location.reload();
      },
      error:function(err){
        console.log(err);
      }    
    });
    
    update = 0;
  }
}


function change_diarydate(y, m, d) {
  let diary_date = document.getElementById("diary_date");
  diary_date.innerHTML = y + " - " + m + " - " + d;
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
      },
      error:function(err){
        console.log(err);
      }    
    });
  }
  
  com.remove();
}

//다이어리 수정 readonly 풀기
let updateText = 0;
function update_Text() {
  let area = document.getElementById("d_text");
  let d_num_ = d_num.value;
  
  if (updateText == 0) {
    $(area).removeAttr("readonly", false);
    $(area).focus();
    updateText = 1;
  } else if (updateText == 1) {
    $(area).attr("readonly", true);
    
    $.ajax({
      url: "diary/textUpdate",
      method: "POST",
      data: {
        d_num: d_num_,
        d_text: $(area).val()
      },
      success: function(data){
      },
      error:function(err){
        console.log(err);
      }    
    });
    
    updateText = 0;
    }
}

// 다이어리 삭제
function delete_text() {
  let tf = confirm("다이어리를 삭제하시겠습니까??");
  let d_num = document.getElementById("d_num").value;
  
  if (tf) {
    $.ajax({
      url: "diary/textDelete",
      method: "POST",
      data: {
        d_num: d_num,
      },
      success: function(){
      },
      error:function(err){
        console.log(err);
      }    
    });
      $("#hide_com").css("display", "none");
	  $("textarea[name=d_text]").text("");
	  document.getElementById('comment_all').innerHTML="";
	  $("h4").text("댓글(0)");
  }
}
</script>
<script src="./resources/js/header.js"></script>
</head>
<body>
	<%@ include file="header_nav.jsp"%>
		<section>
			<div class="section_wrap">
				<div class="section_title">다이어리</div>
			</div>
			<div class="diary_cal">
				<div class="diary">
					<h1 id="diary_date"></h1>
					<textarea name="d_text" id="d_text" class="diary_text" readonly>${diary.d_text}</textarea>
					<input type="hidden" name="d_num" id="d_num" value="${diary.d_num}">
					<div class="text_up_del">
						<c:if test="${sessionId == hostId}">
							<a href="javascript:void(0);" onclick="update_Text()">수정</a> | 
							<a href="javascript:void(0);" onclick="delete_text()">삭제</a>
						</c:if>
					</div>

					<div class="comment_wrap" id="comment_wrap">
						<h4 id="com_cnt">댓글(${totalCount})</h4>
						<form class="comment" method="post" name="frm" action="diary/commentReg" id="hide_com">
							<input type="hidden" name="d_num" id="d_num2" value="${diary.d_num}"> 
							<input type="hidden" name="d_date" id="d_date" value="${diary.d_date}">
							<textarea name="dc_text" id="dc_text" class="coment_text" maxlength="100"></textarea>
							<input type="submit" value="등록" id="com_sub" />
						</form>
						<div id="comment_all">
							<c:forEach var="cm" items="${diaryComment}">
								<div class="comment_list">
									<div class="com_profile" style="background-image: url(resources/file/profile/${cm.h_pic})"></div>
									<div class="com_text">
										<div class="com_nick_up_del">
											<div class="com_nick">
												<b>${cm.m_nick}</b> <span>${cm.dc_time}</span>
											</div>
											<div class="com_up_del" id="com_up_del${cm.dc_num}">
												<c:if test="${sessionId == cm.m_id}">
													<a href="javascript:void(0);" class="com_under" onclick="update_comment(this, ${cm.dc_num})">수정</a> | 
													<a href="javascript:void(0);" class="com_under" onclick="delete_comment(this, ${cm.dc_num})">삭제</a>
												</c:if>
											</div>
										</div>
										<textarea class="comment_" maxlength="100" onkeydown="resize(this)" onkeyup="resize(this)" readonly>${cm.dc_text}</textarea>
									</div>
								</div>
							</c:forEach>
						</div>
						<div class="page">
							<ul class="pagination">
								<li class="page-item page_side"><a class="page-link" href="diary?id=${hostId}&days=${selectDay}&page=1"><</a></li>
								<c:forEach var="pageNumber" begin="${startPage}" end="${endPage}">
									<li class="page-item"><a class="page-link" href="diary?id=${hostId}&days=${selectDay}&page=${pageNumber}">${pageNumber}</a></li>
								</c:forEach>
								<li class="page-item page_side"><a class="page-link" href="diary?id=${hostId}&days=${selectDay}&page=${totalPages}">></a></li>
							</ul>
						</div>
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
					<a href="diary_reg" class="diary_reg">
						<c:if test="${sessionId == hostId}">
							<i class="fa-solid fa-pen"> 일기쓰기</i>
						</c:if>
					</a>
				</div>
			</div>
		</section>
	</div>
</body>
</html>