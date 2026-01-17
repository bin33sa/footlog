<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>마이페이지 - Footlog</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/style.css">
    
    <style>
        body { background-color: #f8f9fa; font-family: 'Pretendard', sans-serif; }
        
        .modern-card {
            background: #fff;
            border-radius: 20px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.03);
            border: 1px solid rgba(0,0,0,0.03);
            overflow: hidden;
        }

        /* 매치 리스트 카드 디자인 */
        .match-card {
            display: flex;
            align-items: center;
            justify-content: space-between;
            background: #fff;
            border-radius: 16px;
            padding: 20px 25px;
            margin-bottom: 15px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.02);
            border: 1px solid #eee;
            transition: all 0.2s;
            border-left: 6px solid transparent; /* 상태 표시줄 */
        }
        .match-card:hover { transform: translateY(-3px); box-shadow: 0 8px 15px rgba(0,0,0,0.05); }

        /* 상태별 스타일 */
        .match-card.status-active { border-left-color: #D4F63F; } /* 라임색 (모집중) */
        .match-card.status-end { border-left-color: #6c757d; background-color: #fcfcfc; opacity: 0.85; } /* 종료 */

        /* 배지 */
        .badge-custom {
            font-size: 0.75rem; font-weight: 700; padding: 6px 12px; border-radius: 20px;
        }
        .badge-lime { background-color: #111; color: #D4F63F; }
        .badge-gray { background-color: #eee; color: #555; }

        /* 프로필 이미지 */
        .profile-img-lg {
            width: 100px; height: 100px; object-fit: cover; border-radius: 50%;
            border: 3px solid #fff; box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        }
    </style>
</head>
<body>

    <header>
       <jsp:include page="/WEB-INF/views/layout/header.jsp"/>
    </header>
    
    <div class="container mt-5 mb-5" style="max-width: 1100px;">
        <div class="row g-4">
            
            <div class="col-lg-3">
                <div class="modern-card p-4 text-center mb-3">
                    <div class="mb-3 position-relative d-inline-block">
                        <c:choose>
                            <c:when test="${not empty dto.profile_image && dto.profile_image != 'avatar.png'}">
                                <img src="${pageContext.request.contextPath}/uploads/member/${dto.profile_image}" class="profile-img-lg" onerror="this.src='${pageContext.request.contextPath}/dist/images/avatar.png'">
                            </c:when>
                            <c:otherwise>
                                <img src="${pageContext.request.contextPath}/dist/images/avatar.png" class="profile-img-lg">
                            </c:otherwise>
                        </c:choose>
                        <span class="position-absolute bottom-0 end-0 badge bg-dark rounded-circle border border-white p-2">
                            ${empty dto.preferred_position ? 'FW' : dto.preferred_position}
                        </span>
                    </div>
                    <h5 class="fw-bold mb-1">${dto.member_name}</h5>
                    <p class="text-secondary small mb-4"><i class="bi bi-geo-alt-fill"></i> ${empty dto.region ? '서울' : dto.region}</p>
                    <a href="${pageContext.request.contextPath}/member/updateInfo" class="btn btn-dark w-100 rounded-pill py-2 fw-bold">회원정보 수정</a>
                </div>

                <div class="list-group modern-card border-0">
                    <a href="#" class="list-group-item list-group-item-action py-3 fw-bold bg-light border-0"><i class="bi bi-speedometer2 me-2"></i> 대시보드</a>
                    <a href="#" class="list-group-item list-group-item-action py-3 border-0" onclick="openMyPageTeamModal(event)"><i class="bi bi-shield-shaded me-2"></i> 내 구단 이동</a>
                    <a href="${pageContext.request.contextPath}/member/history" class="list-group-item list-group-item-action py-3 border-0"><i class="bi bi-clock-history me-2"></i> 신청 내역</a>
                    <a href="${pageContext.request.contextPath}/calendar/match_calendar" class="list-group-item list-group-item-action py-3 border-0"><i class="bi bi-calendar-week me-2"></i> 매치 캘린더</a>
                    <a href="${pageContext.request.contextPath}/member/logout" class="list-group-item list-group-item-action py-3 border-0 text-danger fw-bold"><i class="bi bi-box-arrow-right me-2"></i> 로그아웃</a>
                </div>
            </div>

            <div class="col-lg-9">
                
                <div class="row g-3 mb-4">
                    <div class="col-md-4">
                        <div class="modern-card p-4 bg-dark text-white h-100 position-relative overflow-hidden">
                            <p class="text-white-50 small fw-bold mb-1">NEXT MATCH</p>
                            <div class="d-flex justify-content-between align-items-end position-relative" style="z-index: 2;">
                                <div>
                                    <c:choose>
                                        <c:when test="${not empty stats.next_match_dday}">
                                            <h2 class="fw-bold m-0 text-warning" style="color: #D4F63F !important;">D-${stats.next_match_dday}</h2>
                                            <div class="small mt-1 text-white-50">${not empty stats.next_match_date ? fn:substring(stats.next_match_date, 0, 10) : ''}</div>
                                        </c:when>
                                        <c:otherwise>
                                            <h4 class="fw-bold m-0 text-secondary">일정 없음</h4>
                                            <div class="small mt-1 text-secondary">예정된 경기가 없습니다.</div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                            <i class="bi bi-calendar-check position-absolute text-white opacity-10" style="font-size: 6rem; right: -20px; top: -10px;"></i>
                        </div>
                    </div>
                    
                    <div class="col-md-4">
                        <div class="modern-card p-4 h-100 d-flex flex-column justify-content-center text-center">
                            <span class="text-muted small fw-bold mb-1">이번 달 경기</span>
                            <h2 class="fw-bold m-0">${stats.month_match_count} <span class="fs-6 text-muted fw-normal">matches</span></h2>
                        </div>
                    </div>
                    
                    <div class="col-md-4">
                        <div class="modern-card p-4 h-100 d-flex flex-column justify-content-center text-center">
                            <span class="text-muted small fw-bold mb-1">공격 포인트</span>
                            <h2 class="fw-bold m-0">${stats.total_point} <span class="fs-6 text-muted fw-normal">points</span></h2>
                        </div>
                    </div>
                </div>
                
                <h5 class="fw-bold mb-3 ms-1"><i class="bi bi-calendar-event me-2"></i>나의 매치 일정</h5>
                
                <c:choose>
                    <c:when test="${empty matchList}">
                         <div class="modern-card p-5 text-center">
                            <div class="mb-3 text-muted"><i class="bi bi-emoji-frown fs-1 display-4"></i></div>
                            <h6 class="text-muted fw-bold mb-2">아직 참여한 매치 내역이 없습니다.</h6>
                            <a href="${pageContext.request.contextPath}/match/list" class="btn btn-dark rounded-pill px-4 mt-3">매치 둘러보기</a>
                         </div>
                    </c:when>
                        <c:otherwise>
                        <div class="mb-5">
                            <c:forEach var="match" items="${matchList}">
                                
                                <%-- [상태 1] 진행중/예정 매치 (라임색 테두리) --%>
                                <c:if test="${match.status != '완료' && match.status != 'END'}">
                                    <div class="match-card status-active">
                                        <div>
                                            <span class="badge badge-custom badge-lime mb-2">
                                                ${match.status == '확정' ? '매치확정' : '모집중'}
                                            </span>
                                            
                                            <h5 class="fw-bold mb-1 text-dark" style="font-size: 1.1rem;">
                                                ${match.home_team_name} 
                                                <span class="text-danger small mx-1">vs</span> 
                                                ${match.away_team_name}
                                            </h5>
                                            
                                            <div class="text-muted small mt-2">
                                                <i class="bi bi-geo-alt me-1"></i>${match.region} 
                                                <span class="mx-2">|</span> 
                                                <i class="bi bi-clock me-1"></i>${match.match_date}
                                            </div>
                                        </div>
                                        
                                        <a href="${pageContext.request.contextPath}/match/article?matchNum=${match.match_code}" class="btn btn-outline-dark btn-sm rounded-pill px-3">상세보기</a>
                                    </div>
                                </c:if>

                                <%-- [상태 2] 종료된 매치 (회색 테두리) --%>
                                <c:if test="${match.status == '완료' || match.status == 'END'}">
                                    <div class="match-card status-end">
                                        <div>
                                            <span class="badge badge-custom badge-gray mb-2">종료됨</span>
                                            
                                            <h6 class="fw-bold mb-1 text-secondary text-decoration-line-through">
                                                ${match.home_team_name} vs ${match.away_team_name}
                                            </h6>
                                            
                                            <div class="text-muted small mt-2 fw-bold">
                                                결과: <span class="text-dark">${match.home_score} : ${match.away_score}</span>
                                                <span class="mx-2">|</span>
                                                ${fn:substring(match.match_date, 0, 10)}
                                            </div>
                                        </div>
                                        <a href="${pageContext.request.contextPath}/match/article?matchNum=${match.match_code}" class="btn btn-outline-secondary btn-sm rounded-pill px-3">상세보기</a>
                                    </div>
                                </c:if>
                                
                            </c:forEach>
                        </div>
                    </c:otherwise>
                </c:choose>

            </div> 
        </div> 
    </div> 
            
    <footer><jsp:include page="/WEB-INF/views/layout/footer.jsp"/></footer>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    
    <div class="modal fade" id="myPageTeamModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content rounded-4 border-0 shadow-lg">
                <div class="modal-header border-0 pb-0 pt-4 px-4">
                    <h1 class="modal-title fs-5 fw-bold">내 구단 선택</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body p-4" id="myPageTeamListArea"></div>
            </div>
        </div>
    </div>

    <script>
    function openMyPageTeamModal(e) {
        e.preventDefault();
        const modalEl = document.getElementById('myPageTeamModal');
        const modal = new bootstrap.Modal(modalEl);
        modal.show();
        
        $('#myPageTeamListArea').html('<div class="text-center py-4"><div class="spinner-border text-secondary"></div></div>');
        
        $.ajax({
            url: '${pageContext.request.contextPath}/team/myList',
            type: 'get',
            dataType: 'json',
            success: function(list) {
                let html = '';
                if (list && list.length > 0) {
                    html += '<div class="list-group list-group-flush">';
                    $.each(list, function(index, team) {
                        let imgSrc = '${pageContext.request.contextPath}/dist/images/emblem.png';
                        if(team.emblem_image) imgSrc = '${pageContext.request.contextPath}/uploads/team/' + team.emblem_image;
                        html += '<a href="${pageContext.request.contextPath}/myteam/main?teamCode=' + team.team_code + '" class="list-group-item list-group-item-action d-flex align-items-center py-3 px-2 border-0 rounded-3 mb-1"><div class="rounded-circle border me-3 overflow-hidden bg-light d-flex justify-content-center align-items-center" style="width: 48px; height: 48px;"><img src="' + imgSrc + '" class="w-100 h-100 object-fit-cover" onerror="this.src=\'${pageContext.request.contextPath}/dist/images/emblem.png\'"></div><div><div class="fw-bold text-dark">' + team.team_name + '</div><div class="small text-secondary mt-1"><i class="bi bi-geo-alt me-1"></i>' + (team.region ? team.region : '지역미정') + '</div></div><i class="bi bi-chevron-right ms-auto text-muted opacity-50"></i></a>';
                    });
                    html += '</div>';
                } else {
                    html += '<div class="text-center pt-5 pb-0"><i class="bi bi-exclamation-circle text-secondary fs-1 mb-3 d-block opacity-25"></i><p class="text-secondary mb-4">가입된 구단이 없습니다.</p><a href="${pageContext.request.contextPath}/team/write" class="btn btn-dark rounded-pill w-100 py-2">새 구단 만들기</a></div>';
                }
                $('#myPageTeamListArea').html(html);
            },
            error: function() { $('#myPageTeamListArea').html('<div class="text-center text-danger">목록 로드 실패</div>'); }
        });
    }
    </script>
</body>
</html>