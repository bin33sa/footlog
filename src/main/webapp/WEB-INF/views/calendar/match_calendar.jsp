<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
        /* 폰트 및 기본 스타일 재정의 */
        body { background-color: #f8f9fa; }

        /* 캘린더 헤더 */
        .calendar-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding-bottom: 25px;
            border-bottom: 1px solid #eee;
            margin-bottom: 20px;
        }
        
        /* [기존] 화살표 버튼 스타일 */
        .calendar-controls button.nav-btn {
            border: 1px solid #eee;
            background: #fff;
            width: 40px; height: 40px;
            border-radius: 50%;
            display: flex; align-items: center; justify-content: center;
            font-size: 1.2rem;
            color: #333;
            transition: 0.2s;
            box-shadow: 0 2px 5px rgba(0,0,0,0.05);
        }
        .calendar-controls button.nav-btn:hover {
            background: #111; color: #D4F63F; border-color: #111;
        }

        /* [신규] Today 버튼 커스텀 스타일 */
        .btn-today {
            background: #fff;
            border: 1px solid #e9ecef;
            color: #111;
            font-weight: 800; /* 두꺼운 폰트 */
            font-size: 0.8rem;
            padding: 8px 18px;
            border-radius: 30px; /* 완전 둥근 알약 형태 */
            transition: all 0.2s cubic-bezier(0.4, 0, 0.2, 1);
            letter-spacing: 0.5px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.03);
            display: flex;
            align-items: center;
            gap: 6px; /* 아이콘과 텍스트 사이 간격 */
        }
        .btn-today:hover {
            background: #111;
            color: #D4F63F; /* 형광 라임색 */
            border-color: #111;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.15);
        }
        .btn-today i { font-size: 0.9rem; } /* 아이콘 크기 조절 */

        /* 그리드 레이아웃 */
        .calendar-grid {
            display: grid;
            grid-template-columns: repeat(7, 1fr);
            gap: 12px; 
        }

        /* 요일 헤더 */
        .week-day {
            text-align: center;
            font-weight: 800;
            color: #aaa;
            font-size: 0.85rem;
            letter-spacing: 1px;
            margin-bottom: 10px;
        }
        .week-day.sun { color: #ff6b6b; }
        .week-day.sat { color: #4dabf7; }

        /* 날짜 셀 디자인 */
        .day-cell {
            background-color: #fff; 
            border: 1px solid #f1f3f5;
            border-radius: 16px;
            min-height: 130px;
            padding: 12px;
            position: relative;
            transition: all 0.2s ease;
            cursor: pointer;
            display: flex;
            flex-direction: column;
        }
        .day-cell:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.08);
            border-color: #D4F63F; 
            z-index: 5;
        }
        
        /* 이전/다음 달 날짜 */
        .day-cell.other-month {
            background-color: #f8f9fa;
            opacity: 0.6;
        }
        .day-cell.other-month .date-num { color: #ced4da; }

        /* 날짜 숫자 */
        .date-num {
            font-size: 1.1rem;
            font-weight: 700;
            color: #333;
            margin-bottom: 8px;
        }
        .text-danger { color: #ff6b6b !important; }
        .text-primary { color: #4dabf7 !important; }
        
        /* [중요] 오늘 날짜 스타일 (깔끔한 버전) */
        .day-cell.today {
            background-color: #111; 
            border: 1px solid #111;
            color: #fff;
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(0,0,0,0.3);
        }
        .day-cell.today .date-num {
            color: #D4F63F; 
            font-size: 1.4rem; 
            font-weight: 900;  
            letter-spacing: -1px; 
            margin-bottom: 12px;
            text-decoration: none; 
            display: inline-block;
        }
        /* 숫자 위 작은 점 */
        .day-cell.today .date-num::before {
            content: '';
            display: block;
            width: 6px; height: 6px;
            background-color: #D4F63F;
            border-radius: 50%;
            margin-bottom: 4px; margin-left: 2px;
        }
        .day-cell.today:hover { border-color: #D4F63F; }
        .day-cell.today .badge-match { 
            background-color: rgba(255,255,255,0.1); 
            color: #fff; border: none;
            border-left: 3px solid #D4F63F;
        }

        /* 일정 배지 스타일 */
        .event-badge {
            display: block;
            font-size: 0.75rem;
            padding: 5px 8px;
            border-radius: 6px;
            margin-bottom: 4px;
            font-weight: 600;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            text-align: left;
        }
        .badge-match { background-color: #f1f3f5; color: #333; border-left: 3px solid #333; }
        .badge-holiday { background-color: #fff5f5; color: #e03131; border-left: 3px solid #e03131; }
        .badge-recruit { background-color: #e7f5ff; color: #1971c2; border-left: 3px solid #1971c2; }
        
        @media (max-width: 768px) {
            .day-cell { min-height: 80px; padding: 6px; border-radius: 10px; }
            .date-num { font-size: 0.9rem; }
            .event-badge { font-size: 0.6rem; padding: 2px 4px; border-left-width: 2px; }
            .calendar-grid { gap: 6px; }
        }
    </style>
</head>
	<jsp:include page="/WEB-INF/views/layout/headerResources.jsp"/>
<body>

    <header>
   		<jsp:include page="/WEB-INF/views/layout/header.jsp"/>
	</header>

    <div class="container px-lg-5 mt-5 mb-5">
        
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

        </div>
    </div>

    <footer>
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