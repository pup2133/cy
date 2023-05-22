window.onload = function () {
  buildCalendar();
  // 웹 페이지가 로드되면 buildCalendar 실행

  // 첫 로딩시 댓글 자동 줄바꿈
  let coms = document.querySelectorAll(".comment_");
  let comsl = coms.length;
  for (let i = 0; i < comsl; i++) {
    resize(coms[i]);
  }
  
  //오늘 날짜 출력
  c_day();
  
  d_text_sel();
  choiceDate(days);
  
  choiceYear2 = days_str.substr(0, 4);
  choiceMonth2 = days_str.substring(4, 6);
  choiceDay2 = days_str.substring(6, 8);
  
  change_diarydate(choiceYear2, choiceMonth2, choiceDay2);
  
};


let nowMonth = new Date(); // 현재 달을 페이지를 로드한 날의 달로 초기화
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
        location.href = "diary?m_id=rhkddlf&days=" + choicedays;
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
        location.href = "diary?m_id=rhkddlf&days=" + choicedays;
      };
    } else {
      // 미래인 경우
      nowColumn.className = "futureDay";
      nowColumn.onclick = function () {
        choiceDate(this);
        location.href = "diary?m_id=rhkddlf&days=" + choicedays;
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


//댓글 수정 readonly 풀기
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
