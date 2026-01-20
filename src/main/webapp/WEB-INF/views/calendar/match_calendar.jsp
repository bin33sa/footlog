<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>월간 매치 일정 - Footlog</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/style.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">

    <style>
        body { background-color: #f8f9fa; }
        .calendar-header { display: flex; justify-content: space-between; align-items: center; padding-bottom: 25px; border-bottom: 1px solid #eee; margin-bottom: 20px; }
        .calendar-controls button.nav-btn { border: 1px solid #eee; background: #fff; width: 40px; height: 40px; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-size: 1.2rem; color: #333; transition: 0.2s; box-shadow: 0 2px 5px rgba(0,0,0,0.05); }
        .calendar-controls button.nav-btn:hover { background: #111; color: #D4F63F; border-color: #111; }
        .btn-today { background: #fff; border: 1px solid #e9ecef; color: #111; font-weight: 800; font-size: 0.8rem; padding: 8px 18px; border-radius: 30px; transition: all 0.2s; letter-spacing: 0.5px; box-shadow: 0 2px 5px rgba(0,0,0,0.03); display: flex; align-items: center; gap: 6px; }
        .btn-today:hover { background: #111; color: #D4F63F; border-color: #111; transform: translateY(-2px); box-shadow: 0 5px 15px rgba(0,0,0,0.15); }
        .calendar-grid { display: grid; grid-template-columns: repeat(7, 1fr); gap: 12px; }
        .week-day { text-align: center; font-weight: 800; color: #aaa; font-size: 0.85rem; letter-spacing: 1px; margin-bottom: 10px; }
        .week-day.sun { color: #ff6b6b; }
        .week-day.sat { color: #4dabf7; }
        .day-cell { background-color: #fff; border: 1px solid #f1f3f5; border-radius: 16px; min-height: 130px; padding: 12px; position: relative; transition: all 0.2s ease; cursor: pointer; display: flex; flex-direction: column; overflow: hidden; }
        .day-cell:hover { transform: translateY(-3px); box-shadow: 0 10px 20px rgba(0,0,0,0.08); border-color: #D4F63F; z-index: 5; }
        .day-cell.other-month { background-color: #f8f9fa; opacity: 0.6; }
        .date-num { font-size: 1.1rem; font-weight: 700; color: #333; margin-bottom: 8px; }
        .day-cell.today { background-color: #111; border: 1px solid #111; color: #fff; transform: translateY(-2px); box-shadow: 0 8px 20px rgba(0,0,0,0.3); }
        .day-cell.today .date-num { color: #D4F63F; font-size: 1.4rem; font-weight: 900; }
        .event-badge { display: block; font-size: 0.75rem; padding: 5px 8px; border-radius: 6px; margin-bottom: 4px; font-weight: 600; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; text-align: left; cursor: pointer; border-left: 4px solid #333; }
        .badge-match { background-color: #e7f5ff; color: #1971c2; border-color: #1971c2; } /* 매치 일정 컬러 강조 */
        .badge-recruit { background-color: #f1f3f5; color: #333; border-color: #333; }
    </style>
</head>
<jsp:include page="/WEB-INF/views/layout/headerResources.jsp"/>
<body>
    <header><jsp:include page="/WEB-INF/views/layout/header.jsp"/></header>

    <div class="container px-lg-5 mt-5 mb-5">
        <div class="d-flex justify-content-between align-items-end mb-4">
            <div>
                <h2 class="fw-bold m-0">MATCH SCHEDULE</h2>
                <p class="text-muted small mb-0 mt-1">Footlog 공식 매치 및 개인 일정 관리</p>
            </div>
            <div>
                <button class="btn btn-dark rounded-pill px-4 fw-bold shadow-sm" onclick="openAddModal('')" style="color: #D4F63F;">+ 일정 등록</button>
            </div>
        </div>

        <div class="modern-card p-4 p-md-5 shadow-sm bg-white" style="border-radius: 24px;">
            <div class="calendar-header">
                <div class="calendar-controls d-flex align-items-center gap-3">
                    <button class="nav-btn" onclick="changeMonth(-1)"><i class="bi bi-chevron-left"></i></button>
                    <h2 class="fw-bold m-0" id="currentYearMonth" style="min-width: 140px; text-align: center;"></h2>
                    <button class="nav-btn" onclick="changeMonth(1)"><i class="bi bi-chevron-right"></i></button>
                    <button class="btn-today ms-3" onclick="goToday()"><i class="bi bi-arrow-counterclockwise"></i> Today</button>
                </div>
            </div>

            <div class="calendar-grid mb-2">
                <div class="week-day">MON</div><div class="week-day">TUE</div><div class="week-day">WED</div>
                <div class="week-day">THU</div><div class="week-day">FRI</div><div class="week-day sat">SAT</div><div class="week-day sun">SUN</div>
            </div>
            <div id="calendarBody" class="calendar-grid"></div>
        </div>
    </div>

    <div class="modal fade" id="calendarModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content border-0 shadow" style="border-radius: 20px;">
                <div class="modal-header border-0 pt-4 px-4">
                    <h5 class="fw-bold" id="calendarModalLabel">새 일정 등록</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <form id="calendarForm">
                    <div class="modal-body p-4">
                        <div class="mb-3">
                            <label class="form-label small fw-bold">일정 제목</label>
                            <input type="text" name="title" class="form-control" placeholder="일정 제목을 입력하세요" required>
                        </div>
                        <div class="row mb-3">
                            <div class="col">
                                <label class="form-label small fw-bold">시작일</label>
                                <input type="date" name="start_date" id="modal_start_date" class="form-control" required>
                            </div>
                            <div class="col">
                                <label class="form-label small fw-bold">종료일</label>
                                <input type="date" name="end_date" id="modal_end_date" class="form-control" required>
                            </div>
                        </div>
                        <div class="mb-3">
                            <label class="form-label small fw-bold">내용</label>
                            <textarea name="content" class="form-control" rows="3" placeholder="일정 상세 내용을 입력하세요"></textarea>
                        </div>
                    </div>
                    <div class="modal-footer border-0 pb-4 px-4 d-flex justify-content-between">
                        <div>
                            <button type="button" class="btn btn-danger rounded-pill px-4" id="btnDelete" onclick="deleteCalendar()" style="display: none;">삭제</button>
                        </div>
                        <div class="d-flex gap-2">
                            <button type="button" class="btn btn-primary rounded-pill px-4" id="btnGoMatch" style="display: none; background-color: #D4F63F; border: none; color: #111; font-weight: bold;">매치 상세보기</button>
                            <button type="button" class="btn btn-dark rounded-pill px-4" id="btnSave" onclick="saveCalendar()">저장하기</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <footer><jsp:include page="/WEB-INF/views/layout/footer.jsp"/></footer>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        if (typeof contextPath === "undefined") {
            var contextPath = "${pageContext.request.contextPath}";
        }

        var currentYear = new Date().getFullYear();
        var currentMonth = new Date().getMonth();
        var serverEvents = {};
        var currentEditId = null;

        $(function() {
            loadEvents(currentYear, currentMonth);
        });

        function loadEvents(year, month) {
            const lastDay = new Date(year, month + 1, 0).getDate();
            // MyBatis 쿼리 대응을 위한 T 형식 포맷
            const start = year + "-" + String(month + 1).padStart(2, '0') + "-01T00:00:00";
            const end = year + "-" + String(month + 1).padStart(2, '0') + "-" + String(lastDay).padStart(2, '0') + "T23:59:59";

            $.ajax({
                url: contextPath + "/calendar/load",
                type: "get",
                data: { start: start, end: end },
                dataType: "json",
                success: function(data) {
                    serverEvents = {};
                    if(data && Array.isArray(data)) {
                        data.forEach(item => {
                            let rawDate = item.start || item.start_date; 
                            if (rawDate) {
                                const dayKey = rawDate.substring(0, 10);
                                if (!serverEvents[dayKey]) serverEvents[dayKey] = [];
                                serverEvents[dayKey].push(item);
                            }
                        });
                    }
                    renderCalendar(year, month);
                }
            });
        }

        function renderCalendar(year, month) {
            const firstDay = new Date(year, month, 1).getDay();
            const lastDate = new Date(year, month + 1, 0).getDate();
            const prevLastDate = new Date(year, month, 0).getDate();
            let startDayIndex = (firstDay === 0 ? 6 : firstDay - 1);

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
                        // match_code가 있으면 강조된 뱃지 사용
                        let badgeClass = (event.match_code > 0) ? "badge-match" : "badge-recruit";
                        eventHtml += '<span class="event-badge ' + badgeClass + '" ' +
                                     'onclick="openDetailModal(event, \'' + dateKey + '\', ' + index + ')">' + 
                                     (event.match_code > 0 ? "⚽ " : "") + event.title + '</span>';
                    });
                }

                html += '<div class="day-cell ' + (isToday ? "today" : "") + '" onclick="openAddModal(\'' + dateKey + '\')">' +
                        '   <span class="date-num">' + i + '</span>' +
                        '   <div>' + eventHtml + '</div>' +
                        '</div>';
                cellCount++;
            }

            while (cellCount % 7 !== 0 || cellCount < 35) {
                html += '<div class="day-cell other-month"><span class="date-num">' + (cellCount % 7 + 1) + '</span></div>';
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
            $("#btnGoMatch").hide(); // 등록 시엔 매치 버튼 숨김
            
            if(date) {
                $("#modal_start_date").val(date);
                $("#modal_end_date").val(date);
            }
            new bootstrap.Modal(document.getElementById('calendarModal')).show();
        }

        function openDetailModal(e, dateKey, index) {
            e.stopPropagation();
            const event = serverEvents[dateKey][index];
            currentEditId = event.board_cal_code || event.id; 

            $("#calendarModalLabel").text("일정 상세 정보");
            $("#calendarForm [name=title]").val(event.title);
            $("#calendarForm [name=content]").val(event.description || event.content || "");
            $("#modal_start_date").val(event.start.substring(0, 10));
            $("#modal_end_date").val(event.end.substring(0, 10));
            
            $("#btnSave").text("수정하기");
            $("#btnDelete").show();

            // [발표 핵심 포인트] 매치 코드가 있으면 상세 페이지 버튼 노출
            if(event.match_code > 0) {
    $("#btnGoMatch").show().off('click').on('click', function() {
        // 따옴표와 + 연산자를 사용하여 JSP의 EL 표현식과 분리합니다.
        location.href = contextPath + "/match/article?match_code=" + event.match_code;
    });
            } else {
                $("#btnGoMatch").hide();
            }

            new bootstrap.Modal(document.getElementById('calendarModal')).show();
        }

        function saveCalendar() {
            const f = document.getElementById("calendarForm");
            if(!f.title.value) return alert("제목을 입력하세요.");

            const url = currentEditId ? contextPath + "/calendar/update" : contextPath + "/calendar/insert";
            
            
            const formData = {
                title: f.title.value,
                content: f.content.value,
                start_date: f.start_date.value + "T00:00:00",
                end_date: f.end_date.value + "T23:59:59"
            };

            if(currentEditId) formData.id = currentEditId;

            $.ajax({
                url: url,
                type: "post",
                data: formData,
                dataType: "json",
                success: function(data) {
                    if (data.state === "true") {
                        bootstrap.Modal.getInstance(document.getElementById('calendarModal')).hide();
                        loadEvents(currentYear, currentMonth);
                    } else if (data.state === "loginFail") {
                        alert("로그인이 필요합니다.");
                    } else {
                        alert("처리에 실패했습니다.");
                    }
                }
            });
        }

        function deleteCalendar() {
            if(!currentEditId) return;
            if(!confirm("일정을 정말 삭제하시겠습니까?")) return;

            $.ajax({
                url: contextPath + "/calendar/delete",
                type: "post",
                data: { board_cal_code: currentEditId },
                dataType: "json",
                success: function(data) {
                    if (data.state === "true") {
                        bootstrap.Modal.getInstance(document.getElementById('calendarModal')).hide();
                        loadEvents(currentYear, currentMonth);
                    } else {
                        alert("삭제에 실패했습니다.");
                    }
                }
            });
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
        
        $.fn.center = function () {
            this.css("position", "absolute");
            this.css("top", Math.max(0, (($(window).height() - $(this).outerHeight()) / 2) + $(window).scrollTop()) + "px");
            this.css("left", Math.max(0, (($(window).width() - $(this).outerWidth()) / 2) + $(window).scrollLeft()) + "px");
            return this;
        }
    </script>
</body>
</html>