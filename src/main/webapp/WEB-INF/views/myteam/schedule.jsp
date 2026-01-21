<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
    <title>Footlog - 팀 일정</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <jsp:include page="/WEB-INF/views/layout/headerResources.jsp"/>
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/style.css?ver=2">
    
    <style>
        body { background-color: #f8f9fa; }
        
        /* 캘린더 스타일 정의 */
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
		    cursor: pointer;  
		    position: relative; 
		    z-index: 100; 
		}
        .badge-match { background-color: #f1f3f5; color: #333; border-left: 3px solid #333; }
        .badge-recruit { background-color: #e7f5ff; color: #1971c2; border-left: 3px solid #1971c2; }
    </style>
</head>

<body>

    <header>
       <jsp:include page="/WEB-INF/views/layout/teamheader.jsp"/>
    </header>

    <div class="container-fluid px-lg-5 mt-4">
        <div class="row">
            
            <div class="col-lg-2 d-none d-lg-block">
                <div class="sidebar-menu sticky-top" style="top: 100px;">
                    <div class="mb-4">
                        <p class="sidebar-title mb-3 fw-bold text-muted small">구단 커뮤니티</p>
                        <div class="list-group">
                            <a href="${pageContext.request.contextPath}/myteam/board?teamCode=${teamCode}" class="list-group-item list-group-item-action border-0">팀 게시판</a>
                            <a href="${pageContext.request.contextPath}/myteam/schedule?teamCode=${teamCode}" class="list-group-item list-group-item-action border-0 active fw-bold bg-light text-primary"><i class="bi bi-calendar-check me-1"></i> 전체 일정</a>
                            <a href="${pageContext.request.contextPath}/myteam/attendance?teamCode=${teamCode}" class="list-group-item list-group-item-action border-0">참석 여부</a>
                            <a href="${pageContext.request.contextPath}/myteam/gallery?teamCode=${teamCode}" class="list-group-item list-group-item-action border-0">팀 갤러리</a>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-lg-10 col-12">
                
                <div class="d-flex justify-content-between align-items-end mb-4">
                    <div>
                        <h2 class="fw-bold m-0">TEAM SCHEDULE</h2>
                        <p class="text-muted small mb-0 mt-1">우리 팀의 경기 및 훈련 일정 관리</p>
                    </div>
                    <div>
                        <button class="btn btn-dark rounded-pill px-4 fw-bold shadow-sm" onclick="openAddModal('')">+ 일정 등록</button>
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
					    <div class="week-day sun">SUN</div>
					    <div class="week-day">MON</div>
					    <div class="week-day">TUE</div>
					    <div class="week-day">WED</div>
					    <div class="week-day">THU</div>
					    <div class="week-day">FRI</div>
					    <div class="week-day sat">SAT</div>
					</div>
                    <div id="calendarBody" class="calendar-grid"></div>
                </div>

            </div>
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
                    <div class="modal-footer border-0 pb-4 px-4">
                        <button type="button" class="btn btn-danger rounded-pill px-4 me-auto" id="btnDelete" onclick="deleteCalendar()" style="display: none;">삭제하기</button>
                        <button type="button" class="btn btn-light rounded-pill px-4" data-bs-dismiss="modal">취소</button>
                        <button type="button" class="btn btn-dark rounded-pill px-4" id="btnSave" onclick="saveCalendar()">저장하기</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    
    <footer>
    	<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
    </footer>
    <jsp:include page="/WEB-INF/views/layout/footerResources.jsp"/>

    <script>
        const contextPath = "${pageContext.request.contextPath}";
        const teamCode = "${teamCode}";
    </script>

    <script src="${pageContext.request.contextPath}/dist/js2/calendar.js"></script>

</body>
</html>