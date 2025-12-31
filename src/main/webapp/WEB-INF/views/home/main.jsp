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

    <header id="header" class="site-header bg-white sticky-top border-bottom">
        <nav id="header-nav" class="navbar navbar-expand-lg py-3">
            <div class="container-fluid px-lg-5">
                <a class="navbar-brand fs-3" href="${pageContext.request.contextPath}/main">Footlog</a>
                
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#bdNavbar">
                    <span class="navbar-toggler-icon"></span>
                </button>
                
                <div class="collapse navbar-collapse" id="bdNavbar">
                    <ul class="navbar-nav mx-auto mb-2 mb-lg-0">
                        <li class="nav-item"><a class="nav-link px-4" href="#">사이트소개</a></li>
                        <li class="nav-item"><a class="nav-link px-4" href="#">구단</a></li>
                        <li class="nav-item"><a class="nav-link px-4" href="#">구장</a></li>
                        <li class="nav-item"><a class="nav-link px-4" href="#">매치</a></li>
                        <li class="nav-item"><a class="nav-link px-4" href="#">게시판</a></li>
                    </ul>
                    
                    <div class="d-flex gap-2">
                        <a href="${pageContext.request.contextPath}/login" class="btn btn-outline-dark rounded-pill px-4">로그인</a>
                        <a href="#" class="btn btn-dark rounded-pill px-4">프로필</a>
                    </div>
                </div>
            </div>
        </nav>
    </header>

    <div class="container-fluid px-lg-5 mt-4">
        <div class="row">
            
            <div class="col-lg-2 d-none d-lg-block">
                <div class="sidebar-menu sticky-top" style="top: 100px;">
                    <div class="mb-4">
                        <p class="sidebar-title">Information</p>
                        <div class="list-group">
                            <a href="#" class="list-group-item list-group-item-action">사이트 소개</a>
                            <a href="#" class="list-group-item list-group-item-action">사이트 기능 소개</a>
                            <a href="#" class="list-group-item list-group-item-action">문의 게시판</a>
                            <a href="#" class="list-group-item list-group-item-action">자주 묻는 질문 (Q/A)</a>
                        </div>
                    </div>
                    
                    <div>
                        <p class="sidebar-title">Admin &amp; User</p>
                        <div class="list-group">
                            <a href="#" class="list-group-item list-group-item-action active-menu rounded-3 mb-1">관리페이지</a>
                            <a href="#" class="list-group-item list-group-item-action">회원정보 관리</a>
                            <a href="#" class="list-group-item list-group-item-action">관리창</a>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-lg-8 col-12">
                
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
                        <a href="#" class="text-decoration-none small text-muted">전체보기 ></a>
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
                            <a href="#" class="list-group-item list-group-item-action">공지사항</a>
                            <a href="#" class="list-group-item list-group-item-action">자유 게시판</a>
                            <a href="#" class="list-group-item list-group-item-action">갤러리</a>
                            <a href="#" class="list-group-item list-group-item-action">이벤트 / 뉴스</a>
                        </div>
                    </div>

                    <div>
                        <p class="sidebar-title">My Account</p>
                        <div class="list-group">
                            <a href="#" class="list-group-item list-group-item-action bg-dark text-white rounded-3 mb-1">마이페이지</a>
                            <a href="#" class="list-group-item list-group-item-action">회원정보 수정</a>
                            <a href="#" class="list-group-item list-group-item-action text-muted small">회원 탈퇴</a>
                        </div>
                    </div>
                </div>
            </div>

        </div> </div> <footer class="py-5 mt-5 bg-white border-top">
        <div class="container text-center">
            <p class="mb-1 fw-bold">FOOTLOG</p>
            <p class="text-muted small mb-3">Seoul, Korea | Contact: help@footlog.com</p>
            <p class="text-muted small">&copy; 2025 Footlog Corp. All rights reserved.</p>
        </div>
    </footer>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/swiper@9/swiper-bundle.min.js"></script>
    
    <script>
        // 1. 메인 슬라이더 초기화
        var swiper = new Swiper(".main-swiper", {
            loop: true,
            autoplay: {
                delay: 3000,
                disableOnInteraction: false,
            },
            pagination: {
                el: ".swiper-pagination",
                clickable: true,
            },
        });

        // 2. 이번 주 날짜 자동 계산 로직
        function updateCalendar() {
            const today = new Date();
            const currentDay = today.getDay(); // 0(일) ~ 6(토)
            
            // 이번 주 월요일 날짜 계산
            const diff = today.getDate() - currentDay + (currentDay === 0 ? -6 : 1);
            const monday = new Date(today.setDate(diff));

            // 월(0) ~ 일(6) 까지 7번 반복
            for (let i = 0; i < 7; i++) {
                let tempDate = new Date(monday);
                tempDate.setDate(monday.getDate() + i);
                
                let dateNum = tempDate.getDate(); // 날짜 숫자만 가져오기
                
                // HTML ID(day-0 ~ day-6)에 날짜 넣기
                let dayBox = document.getElementById("day-" + i);
                if(dayBox) {
                    let dateSpan = dayBox.querySelector(".date-num");
                    if(dateSpan) dateSpan.innerText = dateNum;

                    // '오늘' 날짜인지 확인해서 active 클래스 추가 (검은색 배경)
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

        // 페이지가 로드되면 달력 함수 실행
        updateCalendar();
    </script>
</body>
</html>