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
            border-radius: 24px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.04);
            border: 1px solid rgba(0,0,0,0.02);
            overflow: hidden;
        }

        .dashboard-header { background: #111; color: #fff; padding: 2rem; border-radius: 20px; margin-bottom: 24px; }
        
        /* 매치 카드 스타일 */
        .match-card { border-left: 5px solid #ddd; transition: transform 0.2s, box-shadow 0.2s; }
        .match-card:hover { transform: translateY(-3px); box-shadow: 0 5px 15px rgba(0,0,0,0.05); }
        .match-card.upcoming { border-left-color: #D4F63F; } /* 네온 라임색 */
        .match-card.end { border-left-color: #555; background: #f8f9fa; opacity: 0.8; }
        
        /* 프로필 이미지 스타일 */
        .profile-img-style {
            width: 110px; 
            height: 110px; 
            object-fit: cover; 
            border: 3px solid #fff; 
            background-color: #f8f9fa;
        }

        .btn-mypage {
            background-color: #212529 !important;
            color: #fff !important;
            border: none !important;
            transition: all 0.2s ease-in-out !important;
            display: block !important;
            text-align: center;
            text-decoration: none;
        }

        .btn-mypage:hover {
            background-color: #000 !important;
            transform: scale(1.03); 
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
            color: #fff !important;
        }

        .btn-mypage:active {
            transform: scale(0.97);
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
                    <div class="position-relative d-inline-block mb-3">
                        <c:choose>
                            <c:when test="${not empty dto.profile_image && dto.profile_image != 'avatar.png'}">
                                <img src="${pageContext.request.contextPath}/uploads/member/${dto.profile_image}" 
                                     class="rounded-circle shadow-sm profile-img-style" 
                                     onerror="this.src='${pageContext.request.contextPath}/dist/images/avatar.png'">
                            </c:when>
                            <c:otherwise>
                                <img src="${pageContext.request.contextPath}/dist/images/avatar.png" 
                                     class="rounded-circle shadow-sm profile-img-style">
                            </c:otherwise>
                        </c:choose>
                        <span class="position-absolute bottom-0 end-0 badge rounded-pill bg-dark text-white border border-2 border-white shadow-sm" 
                              style="font-size: 0.75rem; padding: 5px 8px;">
                            ${empty dto.preferred_position ? '미설정' : dto.preferred_position}
                        </span>
                    </div>
                    
                    <h5 class="fw-bold mb-1" style="letter-spacing: -0.5px;">${dto.member_name}</h5>
                    
                    <p class="text-muted small mb-4">
                        <i class="bi bi-geo-alt-fill text-secondary"></i> ${empty dto.region ? '지역 미설정' : dto.region}
                    </p>
                    <a href="${pageContext.request.contextPath}/member/updateInfo" 
                       class="btn btn-mypage btn-sm rounded-pill w-100 fw-bold py-2">
                        회원정보 수정
                    </a>
                </div>
                <div class="list-group shadow-sm rounded-4 overflow-hidden border-0 modern-card">
                    <a href="#" class="list-group-item list-group-item-action py-3 fw-bold bg-light border-0">🚀 대시보드</a>
                    
                    <a href="#" class="list-group-item list-group-item-action py-3 border-light" onclick="openMyPageTeamModal(event)">내 구단 이동</a>
                    
                    <a href="${pageContext.request.contextPath}/member/history" class="list-group-item list-group-item-action py-3 border-light">매치/용병 신청 내역</a>
                    <a href="${pageContext.request.contextPath}/calendar/match_calendar" class="list-group-item list-group-item-action py-3 border-light">매치 캘린더</a>
                    <a href="${pageContext.request.contextPath}/member/logout" class="list-group-item list-group-item-action py-3 border-0 text-danger fw-bold">로그아웃</a>
                </div>
            </div>
            <div class="col-lg-9">
                <div class="row g-3 mb-4">
                    <div class="col-md-4">
                        <div class="modern-card p-4 bg-dark text-white h-100 d-flex justify-content-between align-items-center position-relative overflow-hidden">
                            <div style="z-index: 1;">
                                <p class="mb-1 text-white-50 small fw-bold">NEXT MATCH</p>
                                <c:choose>
                                    <c:when test="${not empty stats.next_match_dday}">
                                         <h3 class="fw-bold m-0" style="color: #D4F63F;">D-${stats.next_match_dday}</h3>
                                    </c:when>
                                    <c:otherwise>
                                         <h5 class="fw-bold m-0 text-secondary">일정 없음</h5>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <div class="text-end" style="z-index: 1;">
                                <span class="d-block small fw-bold">
                                    ${not empty stats.next_match_opponent ? 'vs '.concat(stats.next_match_opponent) : '-'}
                                </span>
                                <span class="d-block small opacity-50">
                                    ${not empty stats.next_match_date ? stats.next_match_date : '예정된 경기 없음'}
                                </span>
                            </div>
                            <i class="bi bi-calendar-check position-absolute text-white" style="font-size: 5rem; opacity: 0.05; right: -10px; bottom: -20px;"></i>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="modern-card p-3 h-100 text-center d-flex flex-column justify-content-center">
                            <span class="text-muted small fw-bold mb-1">이번 달 경기</span>
                            <h3 class="fw-bold m-0">${empty stats.month_match_count ? 0 : stats.month_match_count} <span class="fs-6 text-muted">matches</span></h3>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="modern-card p-3 h-100 text-center d-flex flex-column justify-content-center">
                            <span class="text-muted small fw-bold mb-1">공격 포인트</span>
                            <h3 class="fw-bold m-0">${empty stats.total_point ? 0 : stats.total_point} <span class="fs-6 text-muted">points</span></h3>
                        </div>
                    </div>
                </div>
                <h5 class="fw-bold mb-3 ms-1">📅 나의 매치 일정</h5>
                <div class="modern-card p-0 mb-5">
                    <c:choose>
                        <c:when test="${empty matchList}">
                             <div class="p-5 text-center">
                                <div class="mb-3 text-muted">
                                    <i class="bi bi-emoji-frown fs-1"></i>
                                </div>
                                <h6 class="text-muted fw-bold mb-2">아직 참여한 매치 내역이 없습니다.</h6>
                                <p class="small text-secondary mb-4">새로운 매치를 생성하거나 용병으로 경기에 참여해보세요!</p>
                                <a href="${pageContext.request.contextPath}/match/list" class="btn btn-dark rounded-pill px-4 fw-bold">
                                    매치 둘러보기
                                </a>
                             </div>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="match" items="${matchList}">
                                <c:if test="${match.status != '완료' && match.status != 'END'}">
                                    <div class="p-4 border-bottom match-card upcoming bg-white">
                                        <div class="d-flex justify-content-between align-items-center">
                                            <div>
                                                <span class="badge bg-dark text-warning mb-2 rounded-pill px-3">${match.status}</span>
                                                <h5 class="fw-bold mb-1">${match.home_team_name} vs ${match.away_team_name}</h5>
                                                <p class="text-muted mb-0 small">🏟 ${match.region} | ⏰ ${match.match_date}</p>
                                            </div>
                                            <a href="${pageContext.request.contextPath}/match/article?matchNum=${match.match_code}" class="btn btn-sm btn-outline-dark rounded-pill px-3">상세보기</a>
                                        </div>
                                    </div>
                                </c:if>
                                <c:if test="${match.status == '완료' || match.status == 'END'}">
                                    <div class="p-4 match-card end border-bottom">
                                        <div class="d-flex justify-content-between align-items-center">
                                            <div>
                                                <span class="badge bg-secondary mb-2 rounded-pill px-3">종료</span>
                                                <h6 class="fw-bold mb-1 text-muted text-decoration-line-through">${match.home_team_name} vs ${match.away_team_name}</h6>
                                                <p class="text-muted mb-0 small">결과: ${match.home_score} - ${match.away_score}</p>
                                            </div>
                                            <span class="fw-bold fs-5 text-muted fst-italic">END</span>
                                        </div>
                                    </div>
                                </c:if>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div> 
        </div> 
    </div> 
            
    <footer>
       <jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
    </footer>

    <jsp:include page="/WEB-INF/views/layout/footerResources.jsp"/>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    
    <div class="modal fade" id="myPageTeamModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content rounded-4 border-0 shadow-lg">
                <div class="modal-header border-0 pb-0 pt-4 px-4">
                    <h1 class="modal-title fs-5 fw-bold">내 구단 선택</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body p-4" id="myPageTeamListArea">
                    <div class="text-center text-secondary py-3">
                        <div class="spinner-border spinner-border-sm mb-2" role="status"></div>
                        <p class="small mb-0">불러오는 중...</p>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
    function openMyPageTeamModal(e) {
        e.preventDefault();
        
        const modalEl = document.getElementById('myPageTeamModal');
        const modal = new bootstrap.Modal(modalEl);
        modal.show();
        
        $('#myPageTeamListArea').html(`
            <div class="text-center text-secondary py-4">
                <div class="spinner-border spinner-border-sm mb-2" role="status"></div>
                <p class="small mb-0">구단 목록을 불러오는 중...</p>
            </div>
        `);
        
        // 헤더와 동일한 JSON 경로 호출
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
                        if(team.emblem_image) {
                            imgSrc = '${pageContext.request.contextPath}/uploads/team/' + team.emblem_image;
                        }

                        html += '<a href="${pageContext.request.contextPath}/myteam/main?teamCode=' + team.team_code + '"';
                        html += '   class="list-group-item list-group-item-action d-flex align-items-center py-3 px-2 border-0 rounded-3 mb-1"';
                        html += '   style="transition: background 0.2s;">';
                        html += '   <div class="rounded-circle border me-3 overflow-hidden bg-light d-flex justify-content-center align-items-center" style="width: 48px; height: 48px; min-width: 48px;">';
                        html += '       <img src="' + imgSrc + '" class="w-100 h-100 object-fit-cover" onerror="this.src=\'${pageContext.request.contextPath}/dist/images/emblem.png\'">';
                        html += '   </div>';
                        html += '   <div>';
                        html += '       <div class="fw-bold text-dark" style="font-size: 1rem;">' + team.team_name + '</div>';
                        html += '       <div class="small text-secondary mt-1"><i class="bi bi-geo-alt me-1"></i>' + (team.region ? team.region : '지역미정') + '</div>';
                        html += '   </div>';
                        html += '   <i class="bi bi-chevron-right ms-auto text-muted opacity-50"></i>';
                        html += '</a>';
                    });
                    
                    html += '</div>';

                } else {
                    html += '<div class="text-center pt-5 pb-0">';
                    html += '   <i class="bi bi-exclamation-circle text-secondary fs-1 mb-3 d-block opacity-25"></i>';
                    html += '   <p class="text-secondary mb-4">아직 가입된 구단이 없습니다.</p>';
                    html += '   <a href="${pageContext.request.contextPath}/team/write" class="btn btn-dark rounded-pill w-100 py-2 fw-bold mt-5">새 구단 만들기</a>';
                    html += '</div>';
                }

                $('#myPageTeamListArea').html(html);
            },
            error: function(xhr) {
                console.log(xhr);
                $('#myPageTeamListArea').html('<div class="text-center py-4 text-danger">목록을 불러오지 못했습니다.</div>');
            }
        });
    }
    </script>
</body>
</html>