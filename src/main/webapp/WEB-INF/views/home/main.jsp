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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/style.css">
    <style>
        /* 일정 텍스트 스타일 */ 
        .small-title:hover { text-decoration: underline; color: #0056b3 !important; }
        .calendar-day.active { background-color: #111111 !important; border: 2px solid #333; border-radius: 12px; }
        .calendar-day { min-height: 100px; padding: 10px; border: 1px solid #eee; border-radius: 8px; background: #fff; }
        .date-num { font-size: 1.1rem; display: block; margin-bottom: 5px; }
        
        /* 스와이퍼 링크 전체 영역 클릭 스타일 */
        .swiper-slide a { display: flex; width: 100%; height: 200px; text-decoration: none; cursor: pointer; }
    </style>
</head>
<jsp:include page="/WEB-INF/views/layout/headerResources.jsp"/>
<body>

    <header>
        <jsp:include page="/WEB-INF/views/layout/header.jsp"/>
    </header>
   
    <div class="container-fluid px-lg-5 mt-4">
        <div class="row">
            <div class="col-lg-8 col-12 offset-lg-2">
                
                <div class="modern-card p-0">
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

                <div class="modern-card p-4 d-flex justify-content-between align-items-center">
                    <div>
                        <h5 class="fw-bold mb-1">${not empty sessionScope.member ? '나의 구단' : 'FC 슛돌이'}</h5>
                        <p class="text-muted mb-0 small">나의 소속 구단으로 바로 이동하세요.</p>
                    </div>
                    <div class="d-flex gap-2">
                        <button class="btn btn-outline-secondary rounded-pill" onclick="location.href='${pageContext.request.contextPath}/team/write'">구단 생성</button>
                        <button class="btn btn-dark rounded-pill" onclick="location.href='${pageContext.request.contextPath}/myteam/main'">내 구단 이동 &rarr;</button>
                    </div>
                </div>

                <div class="modern-card p-4">
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

                <div class="modern-card mercenary-section p-5">
                    <div>
                        <h3 class="fw-bold mb-3">이번 주말, 뛸 사람이 부족한가요?</h3>
                        <p class="mb-4 text-muted">풋로그에서 실력 있는 용병을 모집하거나, 경기에 참여해보세요.</p>
                        <button class="btn btn-primary btn-lg rounded-pill px-5 shadow-sm" onclick="location.href='${pageContext.request.contextPath}/mercenary/list'">용병 모집 / 신청하기</button>
                    </div>
                </div>

            </div>
        </div> 
    </div> 

    <div class="modal fade" id="eventModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content border-0 shadow-lg">
                <div class="modal-header bg-light">
                    <h5 class="modal-title fw-bold" id="modalTitle">일정 상세</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body p-4">
                    <p class="mb-2 text-muted small"><strong>일시:</strong> <span id="modalDate"></span></p>
                    <hr>
                    <div id="modalContent" class="py-2" style="white-space: pre-wrap;"></div>
                </div>
                <div class="modal-footer border-0">
                    <button type="button" class="btn btn-secondary rounded-pill" data-bs-dismiss="modal">닫기</button>
                    <button type="button" class="btn btn-primary rounded-pill" id="btnGoDetail">상세페이지 이동</button>
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
    
    <script>
        // 에러 방지용 jQuery 확장
        (function($) {
            $.fn.center = function () {
                this.css("position", "absolute");
                this.css("top", Math.max(0, (($(window).height() - $(this).outerHeight()) / 2) + $(window).scrollTop()) + "px");
                this.css("left", Math.max(0, (($(window).width() - $(this).outerWidth()) / 2) + $(window).scrollLeft()) + "px");
                return this;
            };
        })(jQuery);

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

        function loadWeeklyEvents() {
            setTimeout(function() {
                const today = new Date();
                const currentDay = today.getDay();
                const diff = today.getDate() - currentDay + (currentDay === 0 ? -6 : 1);
                const monday = new Date(new Date().setDate(diff));
                const sunday = new Date(new Date().setDate(diff + 6));
                
                const startStr = monday.toISOString().split('T')[0] + "T00:00:00";
                const endStr = sunday.toISOString().split('T')[0] + "T23:59:59";

                $.ajax({
                    url: "${pageContext.request.contextPath}/calendar/load",
                    type: "GET",
                    cache: false,
                    dataType: "json",
                    data: { start: startStr, end: endStr },
                    success: function(data) {
                        $(".calendar-day .small-title").remove();
                        if (!data || !Array.isArray(data)) return;

                        data.forEach(event => {
                            const eventDate = new Date(event.start);
                            const eventDay = eventDate.getDay();
                            const dayIndex = (eventDay === 0) ? 6 : eventDay - 1;
                            const $targetDay = $("#day-" + dayIndex);

                            if ($targetDay.length > 0) {
                                const $item = $('<div class="small-title mt-1">● ' + event.title + '</div>').css({
                                    "font-size": "11px", "color": "#007bff", "cursor": "pointer",
                                    "overflow": "hidden", "text-overflow": "ellipsis", "white-space": "nowrap",
                                    "text-align": "left", "padding": "2px"
                                });
                                $item.data("info", event).on("click", function() {
                                    showEventModal($(this).data("info"));
                                });
                                $targetDay.append($item);
                            }
                        });
                    }
                });
            }, 200);
        }

        function showEventModal(info) {
            $("#modalTitle").text(info.title);
            $("#modalDate").text(info.start.replace('T', ' '));
            $("#modalContent").text(info.content || "내용이 없습니다.");
            const $btn = $("#btnGoDetail");
            const matchCode = parseInt(info.match_code);
            if (matchCode > 0) {
                $btn.text("상세페이지 이동").removeClass("disabled btn-secondary").addClass("btn-primary")
                    .off('click').on('click', function() {
                        location.href = "${pageContext.request.contextPath}/match/article?match_code=" + matchCode;
                    });
            } else {
                $btn.text("개인 일정").removeClass("btn-primary").addClass("btn-secondary disabled").off('click');
            }
            new bootstrap.Modal(document.getElementById('eventModal')).show();
        }

        $(document).ready(function() {
            let isLogin = '${not empty sessionScope.member}' === 'true';
            updateCalendar();
            
            new Swiper(".main-swiper", {
                loop: true,
                autoplay: { delay: 3000, disableOnInteraction: false },
                pagination: { el: ".swiper-pagination", clickable: true },
            });

            if(isLogin) {
                loadWeeklyEvents();
            }
        });
    </script>
</body>
</html>