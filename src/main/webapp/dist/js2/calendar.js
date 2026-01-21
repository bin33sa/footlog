
var currentYear = new Date().getFullYear();
var currentMonth = new Date().getMonth();
var serverEvents = {};
var currentEditId = null;

$(function() {
    loadEvents(currentYear, currentMonth);
});

function loadEvents(year, month) {
    const lastDay = new Date(year, month + 1, 0).getDate();
    const start = year + "-" + String(month + 1).padStart(2, '0') + "-01T00:00:00";
    const end = year + "-" + String(month + 1).padStart(2, '0') + "-" + String(lastDay).padStart(2, '0') + "T23:59:59";

    let url = contextPath + "/myteam/schedule_load";
    let query = "teamCode=" + teamCode + "&start=" + start + "&end=" + end;

    const fn = function(data) {
        serverEvents = {};

        let list = data.list || data; 

        if(list && Array.isArray(list)) {
            list.forEach(item => {
                let rawDate = item.start || item.start_date || item.START_DATE; 
                
                if (rawDate) {
                    const dayKey = rawDate.substring(0, 10);
                    if (!serverEvents[dayKey]) serverEvents[dayKey] = [];
                    serverEvents[dayKey].push(item);
                }
            });
        }
        renderCalendar(year, month);
    };

    ajaxRequest(url, "GET", query, "json", fn);
}

function renderCalendar(year, month) {
    const firstDay = new Date(year, month, 1).getDay();
    const lastDate = new Date(year, month + 1, 0).getDate();
    const prevLastDate = new Date(year, month, 0).getDate();
    
    let startDayIndex = firstDay; 

    $("#currentYearMonth").text(year + "." + String(month + 1).padStart(2, '0'));

    let html = "";
    let cellCount = 0;

    for (let i = startDayIndex; i > 0; i--) {
        html += '<div class="day-cell other-month"><span class="date-num">' + (prevLastDate - i + 1) + '</span></div>';
        cellCount++;
    }

    for (let i = 1; i <= lastDate; i++) {
        const now = new Date();
        const isToday = (i === now.getDate() && month === now.getMonth() && year === now.getFullYear());
        const dateKey = year + "-" + String(month+1).padStart(2,'0') + "-" + String(i).padStart(2,'0');
        
        let eventHtml = "";
        if (serverEvents[dateKey]) {
            serverEvents[dateKey].forEach((event, index) => {
                let badgeClass = (event.match_code && event.match_code > 0) ? "badge-match" : "badge-recruit";
                
                eventHtml += '<span class="event-badge ' + badgeClass + '" ' +
                             'onclick="openDetailModal(event, \'' + dateKey + '\', ' + index + ')">' + 
                             event.title + '</span>';
            });
        }

        html += '<div class="day-cell ' + (isToday ? "today" : "") + '" onclick="openAddModal(\'' + dateKey + '\')">' +
                '   <span class="date-num">' + i + '</span>' +
                '   <div>' + eventHtml + '</div>' +
                '</div>';
        cellCount++;
    }

    let nextMonthDay = 1;
    while (cellCount % 7 !== 0 || cellCount < 35) {
        html += '<div class="day-cell other-month"><span class="date-num">' + (nextMonthDay++) + '</span></div>';
        cellCount++;
    }
    
    $("#calendarBody").html(html);
}

function openAddModal(date) {
    currentEditId = null;
    $("#calendarModalLabel").text("새 일정 등록");
    $("#calendarForm")[0].reset();
    $("#btnSave").text("저장하기");
    $("#btnDelete").hide();
    
    if(date) {
        $("#modal_start_date").val(date);
        $("#modal_end_date").val(date);
    }
    
    new bootstrap.Modal(document.getElementById('calendarModal')).show();
}

function openDetailModal(e, dateKey, index) {
    if(e) {
        e.preventDefault();
        e.stopPropagation(); 
    }

    const event = serverEvents[dateKey][index];
    currentEditId = event.board_cal_code;

    $("#calendarModalLabel").text("일정 상세 정보");
    $("#calendarForm [name=title]").val(event.title);
    $("#calendarForm [name=content]").val(event.content);
    
    let sDate = event.start || event.start_date;
    let eDate = event.end || event.end_date;
    $("#modal_start_date").val(sDate.substring(0, 10));
    $("#modal_end_date").val(eDate.substring(0, 10));
    
    $("#btnSave").text("수정하기");
    $("#btnDelete").show();

    new bootstrap.Modal(document.getElementById('calendarModal')).show();
}

function saveCalendar() {
    const f = document.getElementById("calendarForm");
    if(!f.title.value) return alert("제목을 입력하세요.");

    const url = currentEditId ? contextPath + "/myteam/schedule_update" : contextPath + "/myteam/schedule_insert";
    
    let query = "team_code=" + teamCode 
              + "&title=" + encodeURIComponent(f.title.value)
              + "&content=" + encodeURIComponent(f.content.value)
              + "&start_date=" + f.start_date.value + " 00:00:00"
              + "&end_date=" + f.end_date.value + " 23:59:59";
    
    if(currentEditId) {
        query += "&board_cal_code=" + currentEditId;
    }

    const fn = function(data) {
        if (data.state === "true") {
            bootstrap.Modal.getInstance(document.getElementById('calendarModal')).hide();
            loadEvents(currentYear, currentMonth);
        } else if (data.state === "login_required") {
            alert("로그인이 필요합니다.");
        } else {
            alert("처리에 실패했습니다.");
        }
    };

    ajaxRequest(url, "POST", query, "json", fn);
}

function deleteCalendar() {
    if(!currentEditId) return;
    if(!confirm("일정을 정말 삭제하시겠습니까?")) return;

    let url = contextPath + "/myteam/schedule_delete";
    let query = "board_cal_code=" + currentEditId + "&team_code=" + teamCode;

    const fn = function(data) {
        if (data.state === "true") {
            bootstrap.Modal.getInstance(document.getElementById('calendarModal')).hide();
            loadEvents(currentYear, currentMonth);
        } else {
            alert("삭제에 실패했습니다.");
        }
    };

    ajaxRequest(url, "POST", query, "json", fn);
}

function changeMonth(step) {
    currentMonth += step;
    if (currentMonth < 0) { currentMonth = 11; currentYear--; }
    else if (currentMonth > 11) { currentMonth = 0; currentYear++; }
    loadEvents(currentYear, currentMonth);
}

function goToday() {
    const now = new Date();
    currentYear = now.getFullYear();
    currentMonth = now.getMonth();
    loadEvents(currentYear, currentMonth);
}