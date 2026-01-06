<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>Footlog - Soccer Community</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@9/swiper-bundle.min.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/style.css">
</head>

<body>

    <jsp:include page="/WEB-INF/views/layout/header.jsp" />


    <div class="container-fluid px-lg-5 mt-4">
        <div class="row">
            
            <div class="col-lg-8 col-12 offset-lg-2">
                
                <div class="modern-card p-0">
                    <div class="swiper main-swiper">
                        <div class="swiper-wrapper">
                            <div class="swiper-slide bg-dark d-flex align-items-center justify-content-center text-white">
                                <div class="text-center">
                                    <h2>FOOTLOG SEASON OPEN</h2>
                                    <p>당신의 축구 기록을 시작하세요</p>
                                </div>
                            </div>
                            <div class="swiper-slide bg-primary d-flex align-items-center justify-content-center text-dark">
                                <h2>MATCH DAY</h2>
                            </div>
                            <div class="swiper-slide bg-secondary d-flex align-items-center justify-content-center text-dark">
                                <h2>TEAM RECRUIT</h2>
                            </div>
                        </div>
                        <div class="swiper-pagination"></div>
                    </div>
                </div>

                <div class="modern-card p-4 d-flex justify-content-between align-items-center">
                    <div>
                        <h5 class="fw-bold mb-1">FC 슛돌이</h5>
                        <p class="text-muted mb-0 small">나의 소속 구단으로 바로 이동하세요.</p>
                    </div>
                    <div class="d-flex gap-2">
                        <button class="btn btn-outline-secondary rounded-pill">구단 생성</button>
                        <button class="btn btn-dark rounded-pill">내 구단 이동 &rarr;</button>
                    </div>
                </div>

                <div class="modern-card p-4">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h5 class="fw-bold m-0">이번 주 매치 일정</h5>
                        <a href="${pageContext.request.contextPath}/calendar/match_calendar" class="text-decoration-none small text-muted">전체보기 ></a>
                    </div>
                    <div class="row g-2" id="week-calendar">
                        <div class="col"><div class="calendar-day" id="day-0"><h6>MON</h6><span class="fw-bold date-num"></span></div></div>
                        <div class="col"><div class="calendar-day" id="day-1"><h6>TUE</h6><span class="fw-bold date-num"></span></div></div>
                        <div class="col"><div class="calendar-day" id="day-2"><h6>WED</h6><span class="fw-bold date-num"></span></div></div>
                        <div class="col"><div class="calendar-day" id="day-3"><h6>THU</h6><span class="fw-bold date-num"></span></div></div>
                        <div class="col"><div class="calendar-day" id="day-4"><h6>FRI</h6><span class="fw-bold date-num"></span></div></div>
                        <div class="col"><div class="calendar-day text-primary" id="day-5"><h6>SAT</h6><span class="fw-bold date-num"></span></div></div>
                        <div class="col"><div class="calendar-day text-danger" id="day-6"><h6>SUN</h6><span class="fw-bold date-num"></span></div></div>
                    </div>
                </div>

                <div class="modern-card mercenary-section p-5">
                    <div>
                        <h3 class="fw-bold mb-3">이번 주말, 뛸 사람이 부족한가요?</h3>
                        <p class="mb-4 text-muted">풋로그에서 실력 있는 용병을 모집하거나, 경기에 참여해보세요.</p>
                        <button class="btn btn-primary btn-lg rounded-pill px-5 shadow-sm">용병 모집 / 신청하기</button>
                    </div>
                </div>

            </div>

            <div class="col-lg-2 d-none d-lg-block">
                <div class="sidebar-menu sticky-top" style="top: 100px;">
                    <div class="mb-4">
                        <p class="sidebar-title">Community</p>
                        <div class="list-group">
                            <a href="#" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">
                                게시판 <span class="badge bg-danger rounded-pill">N</span>
                            </a>
                            <a href="${pageContext.request.contextPath}/notice/list" class="list-group-item list-group-item-action">공지사항</a>
                            <a href="${pageContext.request.contextPath}/bbs/list" class="list-group-item list-group-item-action">자유 게시판</a>
                            <a href="${pageContext.request.contextPath}/photo/list" class="list-group-item list-group-item-action">갤러리</a>
                            <a href="#" class="list-group-item list-group-item-action">이벤트 / 뉴스</a>
                        </div>
                    </div>

                    <div>
                        <p class="sidebar-title">My Account</p>
                        <div class="list-group">
                            <a href="${pageContext.request.contextPath}/member/mypage" class="list-group-item list-group-item-action bg-dark text-white rounded-3 mb-1">마이페이지</a>
                            <a href="${pageContext.request.contextPath}/member/updateInfo" class="list-group-item list-group-item-action">회원정보 수정</a>
                            <a href="${pageContext.request.contextPath}/member/logout" class="list-group-item list-group-item-action text-muted small">로그아웃</a>
                        </div>
                    </div>
                </div>
            </div>

        </div> 
    </div> 

    <jsp:include page="/WEB-INF/views/layout/footer.jsp" />


    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/swiper@9/swiper-bundle.min.js"></script>
    
    <script>
        // 메인 슬라이더 및 캘린더 스크립트
        var swiper = new Swiper(".main-swiper", {
            loop: true,
            autoplay: { delay: 3000, disableOnInteraction: false },
            pagination: { el: ".swiper-pagination", clickable: true },
        });

        function updateCalendar() {
            const today = new Date();
            const currentDay = today.getDay(); 
            const diff = today.getDate() - currentDay + (currentDay === 0 ? -6 : 1);
            const monday = new Date(today.setDate(diff));

            for (let i = 0; i < 7; i++) {
                let tempDate = new Date(monday);
                tempDate.setDate(monday.getDate() + i);
                let dateNum = tempDate.getDate(); 
                
                let dayBox = document.getElementById("day-" + i);
                if(dayBox) {
                    let dateSpan = dayBox.querySelector(".date-num");
                    if(dateSpan) dateSpan.innerText = dateNum;

                    let realToday = new Date();
                    if (tempDate.getDate() === realToday.getDate() && 
                        tempDate.getMonth() === realToday.getMonth()) {
                        dayBox.classList.add("active");
                    } else {
                        dayBox.classList.remove("active");
                    }
                }
            }
        }
        updateCalendar();
    </script>
</body>
</html>