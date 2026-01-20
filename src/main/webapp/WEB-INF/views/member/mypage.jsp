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

        /* 매치 카드 디자인 */
        .match-card {
            background: #fff;
            border-radius: 16px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.02);
            border: 1px solid #eee;
            transition: all 0.2s;
            border-left: 6px solid transparent; 
        }
        .match-card:hover { transform: translateY(-2px); box-shadow: 0 8px 15px rgba(0,0,0,0.05); }
        .match-card.status-active { border-left-color: #D4F63F; } /* 라임색 (확정) */

        /* 배지 */
        .badge-custom {
            font-size: 0.75rem; font-weight: 700; padding: 6px 12px; border-radius: 20px;
        }
        .badge-lime { background-color: #111; color: #D4F63F; }

        /* 프로필 이미지 (좌측 메뉴용) */
        .profile-img-lg {
            width: 100px; height: 100px; object-fit: cover; border-radius: 50%;
            border: 3px solid #fff; box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        }
        
        /* 매치 리스트용 작은 엠블럼 */
        .match-emblem {
            width: 32px; height: 32px; 
            border-radius: 50%; 
            object-fit: cover; 
            border: 1px solid #eee;
            background-color: #f8f9fa;
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
                    
                    <a href="${pageContext.request.contextPath}/member/logout" class="list-group-item list-group-item-action py-3 border-0 text-dark fw-bold"><i class="bi bi-box-arrow-right me-2"></i> 로그아웃</a>
                    
                    <a href="javascript:deleteMember();" class="list-group-item list-group-item-action py-3 border-0 text-danger fw-bold">
                        <i class="bi bi-person-slash me-2"></i> 회원탈퇴
                    </a>
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
                            <span class="text-muted small fw-bold mb-1">소속 구단</span>
                            <h2 class="fw-bold m-0">${stats.my_team_count} <span class="fs-6 text-muted fw-normal">teams</span></h2>
                        </div>
                    </div>
                </div>
                
                <h5 class="fw-bold mb-3 ms-1"><i class="bi bi-calendar-event me-2"></i>확정된 매치 일정</h5>
                
                <c:choose>
                    <c:when test="${empty matchList}">
                         <div class="modern-card p-5 text-center">
                            <div class="mb-3 text-muted"><i class="bi bi-emoji-frown fs-1 display-4 opacity-50"></i></div>
                            <h6 class="text-muted fw-bold mb-2">아직 참여한 매치 내역이 없습니다.</h6>
                            <a href="${pageContext.request.contextPath}/match/list" class="btn btn-dark rounded-pill px-4 mt-3">매치 둘러보기</a>
                         </div>
                    </c:when>
                    
                    <c:otherwise>
                        <div class="mb-5">
                            <c:set var="hasConfirmedMatch" value="false" />
                            
                            <c:forEach var="match" items="${matchList}">
                                
                                <%-- '매칭완료' 또는 '확정' 인 경우만 출력 --%>
                                <c:if test="${match.status == '매칭완료' || match.status == '확정'}">
                                    <c:set var="hasConfirmedMatch" value="true" />
                                    
                                    <div class="match-card status-active py-3 px-4 mb-3">
                                        <div class="d-flex align-items-center w-100 justify-content-between">
                                            
                                            <div class="d-flex align-items-center">
                                                <span class="badge badge-custom badge-lime me-3 text-nowrap">매치확정</span>
                                                
                                                <img src="${pageContext.request.contextPath}/uploads/team/${match.home_team_emblem}" 
                                                     class="match-emblem me-2" 
                                                     onerror="this.src='${pageContext.request.contextPath}/dist/images/emblem.png'">
                                                <h5 class="fw-bold mb-0 text-dark text-nowrap me-2">${match.home_team_name}</h5>
                                                
                                                <span class="text-danger small mx-2 fst-italic fw-bold">VS</span>
                                                
                                                <h5 class="fw-bold mb-0 text-dark text-nowrap ms-2">${match.away_team_name}</h5>
                                                <img src="${pageContext.request.contextPath}/uploads/team/${match.away_team_emblem}" 
                                                     class="match-emblem ms-2" 
                                                     onerror="this.src='${pageContext.request.contextPath}/dist/images/emblem.png'">
                                            </div>

                                            <div class="d-flex align-items-center">
                                                <div class="text-muted small me-4 text-end d-none d-lg-block">
                                                    <span><i class="bi bi-geo-alt-fill me-1"></i>${match.region}</span>
                                                    <span class="mx-2 text-light-gray">|</span> 
                                                    <span><i class="bi bi-clock-fill me-1"></i>${fn:substring(match.match_date, 0, 16)}</span>
                                                </div>
                                                <a href="${pageContext.request.contextPath}/match/article?match_code=${match.match_code}" class="btn btn-outline-dark btn-sm rounded-pill px-4 fw-bold text-nowrap">상세보기</a>
                                            </div>
                                            
                                        </div>
                                    </div>
                                </c:if>
                            </c:forEach>
                            
                            <%-- 리스트는 있지만 '확정'된 매치가 하나도 없는 경우 --%>
                            <c:if test="${not hasConfirmedMatch}">
                                 <div class="modern-card p-5 text-center">
                                    <div class="mb-3 text-muted"><i class="bi bi-calendar-x fs-1 display-4 opacity-50"></i></div>
                                    <h6 class="text-muted fw-bold mb-2">예정된 매치 일정이 없습니다.</h6>
                                    <p class="text-secondary small mb-4">매칭이 성사되면 이곳에 표시됩니다.</p>
                                    <a href="${pageContext.request.contextPath}/match/list" class="btn btn-outline-dark rounded-pill px-4 btn-sm">매치 리스트 가기</a>
                                 </div>
                            </c:if>
                        </div>
                    </c:otherwise>
                </c:choose>

            </div> </div> </div> <footer><jsp:include page="/WEB-INF/views/layout/footer.jsp"/></footer>
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
    // 회원 탈퇴 확인 창 
    function deleteMember() {
	    // 구단장 여부 확인
	    $.ajax({
	        url: "${pageContext.request.contextPath}/member/checkLeader",
	        type: "post",
	        dataType: "json",
	        success: function(data) {
	            if(!data.isLogin) {
	                alert("로그인이 필요합니다.");
	                location.href = "${pageContext.request.contextPath}/member/login";
	                return;
	            }
	
	            let msg = "";
	
	            // 구단장일 경우 경고 메시지
	            if(data.leaderCount > 0) {
	                msg = "⚠️ [경고] 현재 운영 중인 구단이 " + data.leaderCount + "개 있습니다.\n\n"
	                    + "회원 탈퇴 시, 회원님이 구단장으로 있는\n"
	                    + "모든 구단이 자동으로 삭제 됩니다.\n\n"
	                    + "이 작업은 되돌릴 수 없습니다.\n"
	                    + "정말로 탈퇴하시겠습니까?";
	            } else {
	                // 일반 회원일 경우 메시지
	                msg = "정말 탈퇴하시겠습니까?\n\n"
	                    + "탈퇴 시 해당 아이디로 로그인이 불가능합니다.";
	            }
	
	            // 확인 누르면 탈퇴 URL로 이동
	            if(confirm(msg)) {
	                location.href = "${pageContext.request.contextPath}/member/delete";
	            }
	        },
	        error: function(e) {
	            console.log(e);
	            alert("서버 통신 오류가 발생했습니다.");
	        }
	    });
	}
    
    // 내 구단 가기 모달 창 
    function openMyPageTeamModal(e) {
        e.preventDefault();
        const modalEl = document.getElementById('myPageTeamModal');
        const modal = new bootstrap.Modal(modalEl);
        modal.show();
        
        const loadingHtml = `
            <div class="text-center text-secondary py-4">
                <div class="spinner-border spinner-border-sm mb-2" role="status"></div>
                <p class="small mb-0">구단 목록을 불러오는 중...</p>
            </div>`;
        $('#myPageTeamListArea').html(loadingHtml);
        
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
                        
                        html += '<a href="${pageContext.request.contextPath}/myteam/main?teamCode=' + team.team_code + '" class="list-group-item list-group-item-action d-flex align-items-center py-3 px-2 border-0 rounded-3 mb-1" style="transition: background 0.2s;">';
                        html += '<div class="rounded-circle border me-3 overflow-hidden bg-light d-flex justify-content-center align-items-center" style="width: 48px; height: 48px; min-width: 48px;"><img src="' + imgSrc + '" class="w-100 h-100 object-fit-cover" onerror="this.src=\'${pageContext.request.contextPath}/dist/images/emblem.png\'"></div>';
                        html += '<div><div class="fw-bold text-dark" style="font-size: 1rem;">' + team.team_name + '</div><div class="small text-secondary mt-1"><i class="bi bi-geo-alt me-1"></i>' + (team.region ? team.region : '지역미정') + '</div></div>';
                        html += '<i class="bi bi-chevron-right ms-auto text-muted opacity-50"></i></a>';
                    });
                    html += '</div>';
                } else {
                    html += '<div class="text-center pt-5 pb-0"><i class="bi bi-exclamation-circle text-secondary fs-1 mb-3 d-block opacity-25"></i><p class="text-secondary mb-4">아직 가입된 구단이 없습니다.</p><a href="${pageContext.request.contextPath}/team/write" class="btn btn-dark rounded-pill w-100 py-2 fw-bold mt-5">새 구단 만들기</a></div>';
                }
                setTimeout(() => { $('#myPageTeamListArea').html(html); }, 200);
            },
            error: function() { $('#myPageTeamListArea').html('<div class="text-center py-4 text-danger"><i class="bi bi-exclamation-triangle mb-2 d-block fs-4"></i>목록을 불러오지 못했습니다.</div>'); }
        });
    }
    </script>
</body>
</html>