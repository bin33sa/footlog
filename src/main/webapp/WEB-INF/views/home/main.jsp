<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>Footlog - Soccer Community</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@9/swiper-bundle.min.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/style.css">
    <style>
        /* [임팩트 섹션] 영상 대신 세련된 다크 그라데이션 배경 */
        .impact-header { 
            background: linear-gradient(135deg, #111111 0%, #222222 100%); 
            padding: 80px 0; 
            margin-bottom: 30px; 
            border-bottom: 4px solid #D4F63F;
        }
        #typing-text { font-size: 4rem; color: #D4F63F; font-weight: 800; min-height: 80px; }
        
        /* [카운트업 스타일] */
        .stat-card { 
            background: #fff; 
            border-radius: 20px; 
            padding: 25px; 
            transition: all 0.3s; 
            border: 1px solid #eee;
        }
        .stat-card:hover { transform: translateY(-5px); box-shadow: 0 10px 20px rgba(0,0,0,0.1); }
        .count-num { font-size: 2.8rem; font-weight: 800; color: #111; display: inline-block; }
        .stat-unit { font-size: 1.5rem; color: #D4F63F; margin-left: 2px; }

        /* 기존 스타일 유지 */ 
        .small-title:hover { text-decoration: underline; color: #0056b3 !important; }
        .calendar-day.active { background-color: #111111 !important; border: 2px solid #333; border-radius: 12px; }
        .calendar-day { min-height: 100px; padding: 10px; border: 1px solid #eee; border-radius: 8px; background: #fff; }
        .date-num { font-size: 1.1rem; display: block; margin-bottom: 5px; }
        .swiper-slide a { display: flex; width: 100%; height: 200px; text-decoration: none; cursor: pointer; }
    </style>
</head>
<jsp:include page="/WEB-INF/views/layout/headerResources.jsp"/>
<body>

    <header>
        <jsp:include page="/WEB-INF/views/layout/header.jsp"/>
    </header>

    <section class="impact-header text-center">
        <div class="container">
            <h1 id="typing-text"></h1>
            <p class="text-white-50 mb-5 animate__animated animate__fadeIn">열정적인 축구인을 위한 데이터 커뮤니티</p>
            
            <div class="row g-4 justify-content-center mt-2">
                <div class="col-6 col-md-3">
                    <div class="stat-card">
                        <div class="text-muted small fw-bold mb-1">TOTAL MATCHES</div>
                        <div><span class="count-num" id="count-matches">0</span><span class="stat-unit">+</span></div>
                    </div>
                </div>
                <div class="col-6 col-md-3">
                    <div class="stat-card">
                        <div class="text-muted small fw-bold mb-1">ACTIVE TEAMS</div>
                        <div><span class="count-num" id="count-teams">0</span><span class="stat-unit">+</span></div>
                    </div>
                </div>
                <div class="col-6 col-md-3">
                    <div class="stat-card">
                        <div class="text-muted small fw-bold mb-1">MEMBERS</div>
                        <div><span class="count-num" id="count-members">0</span><span class="stat-unit">+</span></div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <div class="container-fluid px-lg-5 mt-4">
        <div class="row">
            <div class="col-lg-8 col-12 offset-lg-2">
                
                <div class="modern-card p-0 mb-4">
                    <div class="swiper main-swiper">
                        <div class="swiper-wrapper">
                            <div class="swiper-slide bg-dark d-flex align-items-center justify-content-center text-white">
                                <a href="${pageContext.request.contextPath}/introduction" class="align-items-center justify-content-center text-white">
                                    <div class="text-center">
                                        <h2>FOOTLOG SEASON OPEN</h2>
                                        <p>당신의 축구 기록을 시작하세요</p>
                                    </div>
                                </a>
                            </div>
                             <div class="swiper-slide bg-primary d-flex align-items-center justify-content-center text-dark">
                                <a href="${pageContext.request.contextPath}/match/list" class="align-items-center justify-content-center text-dark">
                                    <h2>MATCH DAY</h2>
                                </a>
                            </div>
                            <div class="swiper-slide bg-secondary d-flex align-items-center justify-content-center text-dark">
                                <a href="${pageContext.request.contextPath}/team/list" class="align-items-center justify-content-center text-dark">
                                    <h2>TEAM RECRUIT</h2>
                                </a>
                            </div>
                        </div>
                        <div class="swiper-pagination"></div>
                    </div>
                </div>

                <div class="modern-card p-4 d-flex justify-content-between align-items-center mb-4">
                    <div>
                        <h5 class="fw-bold mb-1">${not empty sessionScope.member ? '나의 구단' : 'FC 슛돌이'}</h5>
                        <p class="text-muted mb-0 small">나의 소속 구단으로 바로 이동하세요.</p>
                    </div>
                    <div class="d-flex gap-2">
                        <button class="btn btn-outline-secondary rounded-pill" onclick="location.href='${pageContext.request.contextPath}/team/write'">구단 생성</button>
                        <button class="btn btn-dark rounded-pill" onclick="location.href='${pageContext.request.contextPath}/myteam/main'">내 구단 이동 &rarr;</button>
                    </div>
                </div>

                <div class="modern-card p-4 mb-4">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h5 class="fw-bold m-0">이번 주 매치 일정</h5>
                        <a href="${pageContext.request.contextPath}/calendar/match_calendar" class="text-decoration-none small text-muted">전체보기</a>
                    </div>
                    <div class="row g-2 text-center" id="week-calendar">
                        <div class="col"><div class="calendar-day" id="day-0"><h6>MON</h6><span class="fw-bold date-num"></span></div></div>
                        <div class="col"><div class="calendar-day" id="day-1"><h6>TUE</h6><span class="fw-bold date-num"></span></div></div>
                        <div class="col"><div class="calendar-day" id="day-2"><h6>WED</h6><span class="fw-bold date-num"></span></div></div>
                        <div class="col"><div class="calendar-day" id="day-3"><h6>THU</h6><span class="fw-bold date-num"></span></div></div>
                        <div class="col"><div class="calendar-day" id="day-4"><h6>FRI</h6><span class="fw-bold date-num"></span></div></div>
                        <div class="col"><div class="calendar-day text-primary" id="day-5"><h6>SAT</h6><span class="fw-bold date-num"></span></div></div>
                        <div class="col"><div class="calendar-day text-danger" id="day-6"><h6>SUN</h6><span class="fw-bold date-num"></span></div></div>
                    </div>
                </div>

                <div class="modern-card mercenary-section p-5 mb-5">
                    <div>
                        <h3 class="fw-bold mb-3">이번 주말, 뛸 사람이 부족한가요?</h3>
                        <p class="mb-4 text-muted">풋로그에서 실력 있는 용병을 모집하거나, 경기에 참여해보세요.</p>
                        <button class="btn btn-primary btn-lg rounded-pill px-5 shadow-sm" onclick="location.href='${pageContext.request.contextPath}/mercenary/list'">용병 모집 / 신청하기</button>
                    </div>
                </div>

            </div>
        </div> 
    </div> 

    <footer>
        <jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
    </footer>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/swiper@9/swiper-bundle.min.js"></script>
    <script src="https://unpkg.com/typewriter-effect@2.18.2/dist/core.js"></script>
    
    <script>
        // 1. 타이핑 애니메이션
        function initTyping() {
            const app = document.getElementById('typing-text');
            new Typewriter(app, {
                strings: ['FOOTLOG'],
                autoStart: true,
                loop: false,
                cursor: '|'
            });
        }

        // 2. 부드러운 카운트업 함수
        function animateCount(id, endValue, duration) {
            let startValue = 0;
            let startTime = null;

            function step(timestamp) {
                if (!startTime) startTime = timestamp;
                let progress = Math.min((timestamp - startTime) / duration, 1);
                let current = Math.floor(progress * endValue);
                document.getElementById(id).innerHTML = current.toLocaleString();
                if (progress < 1) {
                    window.requestAnimationFrame(step);
                }
            }
            window.requestAnimationFrame(step);
        }

        $(document).ready(function() {
            // 타이핑 시작
            initTyping();

            // 카운트업 수치 설정 (발표 시 보여주고 싶은 숫자를 적으세요)
            setTimeout(() => {
                animateCount("count-matches", 1248, 2000); // 2초간 1248까지
                animateCount("count-teams", 152, 2000);    // 2초간 152까지
                animateCount("count-members", 5430, 2500); // 2.5초간 5430까지
            }, 500); // 타이핑 시작 후 약간의 딜레이

            // 기존 달력 로직
            updateCalendar();
            
            new Swiper(".main-swiper", {
                loop: true,
                autoplay: { delay: 3000, disableOnInteraction: false },
                pagination: { el: ".swiper-pagination", clickable: true },
            });
        });

        // (이하 updateCalendar 등 기존 JS 함수들 그대로 유지)
        function updateCalendar() {
            const today = new Date();
            const currentDay = today.getDay();
            const diff = today.getDate() - currentDay + (currentDay === 0 ? -6 : 1);
            const monday = new Date(new Date().setDate(diff));

            for (let i = 0; i < 7; i++) {
                let tempDate = new Date(monday);
                tempDate.setDate(monday.getDate() + i);
                let dayBox = $("#day-" + i);
                if(dayBox.length) {
                    dayBox.find(".date-num").text(tempDate.getDate());
                    let realToday = new Date();
                    if (tempDate.getDate() === realToday.getDate() && tempDate.getMonth() === realToday.getMonth()) {
                        dayBox.addClass("active");
                    } else {
                        dayBox.removeClass("active");
                    }
                }
            }
        }
    </script>
</body>
</html>