<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>나의 매치 일정 - Footlog</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/style.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
</head>

<body>
	<header>
   		<jsp:include page="/WEB-INF/views/layout/teamheader.jsp"/>
	</header>

    <div class="container px-lg-5 mt-5 mb-5">
        
        <div class="row">
            <div class="col-lg-2 d-none d-lg-block">
                <div class="sidebar-menu sticky-top" style="top: 100px;">
                    <div class="mb-4">
                        <p class="sidebar-title fw-bold fs-5 mb-3">매치</p>
                        <div class="list-group">
                            <a href="${pageContext.request.contextPath}/match/myMatch" class="list-group-item list-group-item-action active-menu">내 매치 일정</a>
                            <a href="${pageContext.request.contextPath}/match/list" class="list-group-item list-group-item-action">전체 매치 리스트</a>
                            <a href="${pageContext.request.contextPath}/match/write" class="list-group-item list-group-item-action">매치 개설하기</a>
                            <a href="${pageContext.request.contextPath}/mercenary/list" class="list-group-item list-group-item-action">용병 구하기</a>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-lg-10 col-12">
            
                <div class="d-flex justify-content-between align-items-end mb-4">
                    <div>
                        <h2 class="fw-bold m-0" style="font-family: 'Pretendard', sans-serif;">MATCH SCHEDULE</h2>
                        <p class="text-muted small mb-0 mt-1">Footlog 공식 매치 및 용병 모집 일정</p>
                    </div>
                    <div class="d-none d-md-block">
                        <button class="btn btn-dark rounded-pill px-4 fw-bold shadow-sm" onclick="alert('준비중입니다.')">+ 일정 등록</button>
                    </div>
                </div>

                <div class="modern-card p-4 p-md-5 shadow-sm bg-white" style="border-radius: 24px;">
                    
                    <div class="calendar-header">
                        <div class="calendar-controls d-flex align-items-center gap-3">
                            <button class="nav-btn" onclick="changeMonth(-1)"><i class="bi bi-chevron-left"></i></button>
                            <h2 class="fw-bold m-0" id="currentYearMonth" style="min-width: 140px; text-align: center;">2026.01</h2>
                            <button class="nav-btn" onclick="changeMonth(1)"><i class="bi bi-chevron-right"></i></button>
                            
                            <button class="btn-today ms-3" onclick="goToday()">
                                <i class="bi bi-arrow-counterclockwise"></i> Today
                            </button>
                        </div>
                        
                        <div class="d-flex gap-3 small fw-bold">
                            <span class="d-flex align-items-center gap-2 text-muted"><span class="rounded-circle bg-dark" style="width:8px; height:8px;"></span>매치</span>
                            <span class="d-flex align-items-center gap-2 text-muted"><span class="rounded-circle bg-danger" style="width:8px; height:8px;"></span>휴일</span>
                            <span class="d-flex align-items-center gap-2 text-muted"><span class="rounded-circle bg-primary" style="width:8px; height:8px;"></span>모집</span>
                        </div>
                    </div>

                    <div class="calendar-grid mb-2">
                        <div class="week-day">MON</div>
                        <div class="week-day">TUE</div>
                        <div class="week-day">WED</div>
                        <div class="week-day">THU</div>
                        <div class="week-day">FRI</div>
                        <div class="week-day sat">SAT</div>
                        <div class="week-day sun">SUN</div>
                    </div>

                    <div class="calendar-grid" id="calendarBody">
                        </div>

                </div> </div> </div> </div> <footer>
   		<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
	</footer>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        let date = new Date(); 
        let currentYear = date.getFullYear();
        let currentMonth = date.getMonth(); 

        const mockEvents = {
            "2026-1-1": [{title: "신정 (휴일)", type: "holiday"}],
            "2026-1-3": [{title: "VS FC슛돌이", type: "match"}],
            "2026-1-10": [{title: "자체 청백전", type: "match"}, {title: "용병 2명 급구", type: "recruit"}],
            "2026-1-15": [{title: "야간 경기", type: "match"}],
            "2026-1-24": [{title: "리그 개막전", type: "match"}],
            "2026-1-27": [{title: "설날 연휴", type: "holiday"}],
            "2026-1-28": [{title: "설날", type: "holiday"}],
            "2026-1-29": [{title: "설날 연휴", type: "holiday"}]
        };

        function renderCalendar(year, month) {
            const firstDay = new Date(year, month, 1).getDay(); 
            const lastDate = new Date(year, month + 1, 0).getDate(); 
            const prevLastDate = new Date(year, month, 0).getDate(); 
            let startDayIndex = (firstDay === 0 ? 6 : firstDay - 1); 

            $("#currentYearMonth").text(year + "." + String(month + 1).padStart(2, '0'));

            let html = "";
            let totalCells = 42; 
            let cellCount = 0;

            for (let i = startDayIndex; i > 0; i--) {
                let prevDate = prevLastDate - i + 1;
                html += '<div class="day-cell other-month"><span class="date-num">' + prevDate + '</span></div>';
                cellCount++;
            }

            for (let i = 1; i <= lastDate; i++) {
                const todayObj = new Date();
                const isToday = (i === todayObj.getDate() && month === todayObj.getMonth() && year === todayObj.getFullYear());
                const todayClass = isToday ? "today" : "";

                let dayColorClass = "";
                if (cellCount % 7 === 5) dayColorClass = "text-primary";
                else if (cellCount % 7 === 6) dayColorClass = "text-danger";

                const dateKey = year + "-" + (month + 1) + "-" + i;
                let eventHtml = "";
                if (mockEvents[dateKey]) {
                    mockEvents[dateKey].forEach(function(event) {
                        let badgeClass = "badge-match";
                        if(event.type === 'holiday') badgeClass = "badge-holiday";
                        if(event.type === 'recruit') badgeClass = "badge-recruit";
                        eventHtml += '<span class="event-badge ' + badgeClass + '">' + event.title + '</span>';
                    });
                }

                html += '<div class="day-cell ' + todayClass + '" onclick="alert(\'' + i + '일 일정을 선택했습니다.\')">' +
                        '   <span class="date-num ' + dayColorClass + '">' + i + '</span>' +
                        '   <div>' + eventHtml + '</div>' +
                        '</div>';
                cellCount++;
            }

            let nextDay = 1;
            while (cellCount < totalCells) {
                html += '<div class="day-cell other-month"><span class="date-num">' + (nextDay++) + '</span></div>';
                cellCount++;
            }

            $("#calendarBody").html(html);
        }

        function changeMonth(step) {
            currentMonth += step;
            if (currentMonth < 0) { currentMonth = 11; currentYear--; } 
            else if (currentMonth > 11) { currentMonth = 0; currentYear++; }
            renderCalendar(currentYear, currentMonth);
        }

        function goToday() {
            date = new Date();
            currentYear = date.getFullYear();
            currentMonth = date.getMonth();
            renderCalendar(currentYear, currentMonth);
        }

        renderCalendar(currentYear, currentMonth);
    </script>
</body>
</html>