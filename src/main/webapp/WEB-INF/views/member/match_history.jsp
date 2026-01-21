<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>신청 내역 - Footlog</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/style.css">
    
    <style>
        body { background-color: #f8f9fa; font-family: 'Pretendard', sans-serif; }
        
        .modern-card {
            background: #fff; border-radius: 20px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.03); border: 1px solid rgba(0,0,0,0.03);
            overflow: hidden;
        }

        .profile-img-lg {
            width: 100px; height: 100px; object-fit: cover; border-radius: 50%;
            border: 3px solid #fff; box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        }

        /* 탭 버튼 스타일 */
        .nav-pills .nav-link {
            color: #555; background-color: #fff; border-radius: 50px; padding: 10px 24px;
            margin-right: 10px; font-weight: 600; font-size: 0.95rem; border: 1px solid #eee; transition: all 0.2s;
        }
        .nav-pills .nav-link:hover { background-color: #f8f9fa; transform: translateY(-2px); }
        .nav-pills .nav-link.active {
            background-color: #111; color: #D4F63F; border-color: #111; box-shadow: 0 4px 12px rgba(0,0,0,0.15);
        }

        .history-card {
            background: #fff; border-radius: 16px; padding: 20px 24px; margin-bottom: 16px;
            border: 1px solid #f1f1f1; transition: all 0.2s cubic-bezier(0.4, 0, 0.2, 1);
            position: relative; 
        }
        .history-card:hover { transform: translateY(-3px); box-shadow: 0 10px 20px rgba(0,0,0,0.05); border-color: #e0e0e0; }

        /* --- 배지 스타일 --- */
        .status-badge { 
            font-size: 0.8rem; padding: 5px 12px; border-radius: 50px;
            font-weight: 700; display: inline-block; margin-bottom: 6px; letter-spacing: -0.5px;
        }
        .status-wait { background: #fff8e1; color: #b78a00; border: 1px solid #ffeeba; }
        .status-recruiting { background: #e7f5ff; color: #1c7ed6; border: 1px solid #d0ebff; }
        .status-ok { background: #e6fcf5; color: #0ca678; border: 1px solid #c3fae8; }
        .status-no { background: #fff5f5; color: #fa5252; border: 1px solid #ffc9c9; }
        
        .match-tag { font-size: 0.65rem; padding: 3px 6px; border-radius: 4px; font-weight: 800; margin-right: 6px; vertical-align: middle; }
        .tag-home { background: #212529; color: #fff; }
        .tag-away { background: #fff; color: #212529; border: 1px solid #dee2e6; }
        
        .match-versus-area { display: flex; align-items: center; justify-content: flex-start; gap: 20px; margin-top: 5px; margin-bottom: 5px;}
        .team-unit { display: flex; flex-direction: column; align-items: center; justify-content: center; width: 100px; text-align: center; }
        
        .team-emblem-img { 
            width: 48px; height: 48px; border-radius: 50%; object-fit: cover; 
            border: 1px solid #eee; margin-bottom: 8px; background-color: #fff;
        }
        .team-emblem-placeholder { 
            width: 48px; height: 48px; background: #f8f9fa; border-radius: 50%; border: 1px solid #eee;
            display: flex; align-items: center; justify-content: center; margin-bottom: 8px; color: #adb5bd;
        }
        .team-name-text { font-size: 0.95rem; font-weight: 700; color: #333; word-break: keep-all; line-height: 1.2;}
        .vs-text { font-size: 0.9rem; font-weight: 900; color: #e9ecef; margin-top: -15px; }

        .btn-arrow-go {
            width: 42px; height: 42px; 
            border-radius: 50%; background-color: #fff; border: 1px solid #e9ecef;
            display: flex; align-items: center; justify-content: center;
            color: #212529; transition: all 0.2s; text-decoration: none !important;
            z-index: 10; position: relative;
        }
        .btn-arrow-go:hover { background-color: #111; color: #fff; border-color: #111; }

        /* --- [중요] 페이징 스타일 수정 (MyUtil 호환) --- */
        .page-navigation {
            display: flex; justify-content: center; align-items: center; margin-top: 30px;
        }
        .page-navigation .paginate {
            display: flex; gap: 6px;
        }
        .page-navigation a, .page-navigation span { 
            display: inline-flex; align-items: center; justify-content: center;
            width: 36px; height: 36px;
            border-radius: 10px;
            text-decoration: none;
            font-size: 0.9rem; font-weight: 600;
            color: #666; background-color: #fff; border: 1px solid #eee;
            transition: all 0.2s; cursor: pointer;
        }
        .page-navigation a:hover {
            background-color: #f8f9fa; border-color: #ddd; color: #333;
        }
        .page-navigation span {
            background-color: #111 !important;
            color: #D4F63F !important;
            border-color: #111 !important;
            cursor: default;
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
                            <c:when test="${not empty sessionScope.member.profile_image && sessionScope.member.profile_image != 'avatar.png'}">
                                <img src="${pageContext.request.contextPath}/uploads/member/${sessionScope.member.profile_image}" class="profile-img-lg" onerror="this.src='${pageContext.request.contextPath}/dist/images/avatar.png'">
                            </c:when>
                            <c:otherwise>
                                <img src="${pageContext.request.contextPath}/dist/images/avatar.png" class="profile-img-lg">
                            </c:otherwise>
                        </c:choose>
                        <span class="position-absolute bottom-0 end-0 badge bg-dark rounded-circle border border-white p-2">FW</span>
                    </div>
                    <h5 class="fw-bold mb-1">${sessionScope.member.member_name}</h5>
                    <p class="text-secondary small mb-4"><i class="bi bi-geo-alt-fill"></i> 서울</p>
                    <a href="${pageContext.request.contextPath}/member/updateInfo" class="btn btn-dark w-100 rounded-pill py-2 fw-bold">회원정보 수정</a>
                </div>

                <div class="list-group modern-card border-0">
                    <a href="${pageContext.request.contextPath}/member/mypage" class="list-group-item list-group-item-action py-3 border-0"><i class="bi bi-speedometer2 me-2"></i> 대시보드</a>
                    <a href="#" class="list-group-item list-group-item-action py-3 border-0" onclick="openMyPageTeamModal(event)"><i class="bi bi-shield-shaded me-2"></i> 내 구단 이동</a>
                    <a href="${pageContext.request.contextPath}/member/history" class="list-group-item list-group-item-action py-3 fw-bold bg-light border-0"><i class="bi bi-clock-history me-2"></i> 신청 내역</a>
                    <a href="${pageContext.request.contextPath}/calendar/match_calendar" class="list-group-item list-group-item-action py-3 border-0"><i class="bi bi-calendar-week me-2"></i> 매치 캘린더</a>
                    <a href="${pageContext.request.contextPath}/member/logout" class="list-group-item list-group-item-action py-3 border-0 text-danger fw-bold"><i class="bi bi-box-arrow-right me-2"></i> 로그아웃</a>
                </div>
            </div>

            <div class="col-lg-9">
                <div class="d-flex align-items-center justify-content-between mb-3 mt-1">
                    <h5 class="fw-bold m-0"><i class="bi bi-clipboard-check me-2"></i>신청 현황판</h5>
                </div>

                <ul class="nav nav-pills mb-4" id="pills-tab" role="tablist">
                    <li class="nav-item">
                        <button class="nav-link ${empty param.tab || param.tab == 'match' ? 'active' : ''}" 
                                id="pills-match-tab" 
                                onclick="location.href='${pageContext.request.contextPath}/member/history?tab=match'"
                                type="button">매치 신청 </button>
                    </li>
                    <li class="nav-item">
                        <button class="nav-link ${param.tab == 'mercenary' ? 'active' : ''}" 
                                id="pills-mercenary-tab" 
                                onclick="location.href='${pageContext.request.contextPath}/member/history?tab=mercenary'"
                                type="button">내 용병 활동 </button>
                    </li>
                </ul>

                <div class="tab-content" id="pills-tabContent">
                    
                    <div class="tab-pane fade ${empty param.tab || param.tab == 'match' ? 'show active' : ''}" id="pills-match">
                         <c:choose>
                            <c:when test="${empty matchApplyList}">
                                <div class="modern-card p-5 text-center text-muted">
                                    <i class="bi bi-inbox fs-1 d-block mb-3 opacity-50"></i><p>신청하거나 모집 중인 매치 내역이 없습니다.</p>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="item" items="${matchApplyList}">
                                    <div class="history-card">
                                        <div class="d-flex justify-content-between align-items-center mb-1">
                                            <div>
                                                <c:choose>
                                                    <c:when test="${item.apply_code == 0}">
                                                        <span class="match-tag tag-home">HOME</span>
                                                        <c:choose>
                                                            <c:when test="${item.status eq '모집중'}"><span class="status-badge status-recruiting">상대 모집중</span></c:when>
                                                            <c:when test="${item.status eq '매칭완료' or item.status eq '확정'}"><span class="status-badge status-ok">매치 확정</span></c:when>
                                                            <c:when test="${item.status eq '마감'}"><span class="status-badge status-no">마감</span></c:when>
                                                            <c:otherwise><span class="status-badge status-wait">${item.status}</span></c:otherwise>
                                                        </c:choose>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="match-tag tag-away">AWAY</span>
                                                        <c:choose>
                                                            <c:when test="${item.status eq '매칭대기'}"><span class="status-badge status-wait">수락 대기중</span></c:when>
                                                            <c:when test="${item.status eq '수락'}"><span class="status-badge status-ok">매치 성사</span></c:when>                                                
                                                            <c:when test="${item.status eq '마감'}"><span class="status-badge status-no">마감</span></c:when>
                                                            <c:otherwise><span class="status-badge status-no">${item.status}</span></c:otherwise>
                                                        </c:choose>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                            <div class="text-muted small">
                                                <i class="bi bi-clock me-1"></i>${fn:substring(item.match_date, 0, 16)} 
                                                <span class="mx-1">|</span> <i class="bi bi-geo-alt me-1"></i>${item.region}
                                            </div>
                                        </div>

                                        <div class="d-flex justify-content-between align-items-center">
                                            <div class="match-versus-area">
                                                <div class="team-unit">
                                                    <c:choose>
                                                        <c:when test="${not empty item.team_emblem}">
                                                            <img src="${pageContext.request.contextPath}/uploads/team/${item.team_emblem}" class="team-emblem-img" onerror="this.src='${pageContext.request.contextPath}/dist/images/emblem.png'">
                                                        </c:when>
                                                        <c:otherwise><div class="team-emblem-placeholder"><i class="bi bi-shield-shaded fs-4"></i></div></c:otherwise>
                                                    </c:choose>
                                                    <div class="team-name-text">${item.team_name}</div>
                                                </div>
                                                <div class="vs-text">VS</div>
                                                <div class="team-unit">
                                                    <c:choose>
                                                        <c:when test="${item.opponent_name eq '상대 미정'}">
                                                            <div class="team-emblem-placeholder" style="border-style: dashed;"><i class="bi bi-question-lg fs-4 opacity-50"></i></div>
                                                            <div class="text-secondary small fw-bold">미정</div>
                                                        </c:when>
                                                        <c:when test="${not empty item.opponent_emblem}">
                                                            <img src="${pageContext.request.contextPath}/uploads/team/${item.opponent_emblem}" class="team-emblem-img" onerror="this.src='${pageContext.request.contextPath}/dist/images/emblem.png'">
                                                            <div class="team-name-text">${item.opponent_name}</div>
                                                        </c:when>
                                                        <c:otherwise><div class="team-emblem-placeholder"><i class="bi bi-shield-fill fs-4 text-dark"></i></div><div class="team-name-text">${item.opponent_name}</div></c:otherwise>
                                                    </c:choose>
                                                </div>
                                            </div>
                                            
                                            <div>
                                                <c:choose>
                                                    <c:when test="${item.status eq '매칭완료' or item.status eq '수락' or item.status eq '확정'}">
                                                        <a href="${pageContext.request.contextPath}/match/article?page=1&match_code=${item.match_code}" class="btn btn-sm btn-dark rounded-pill px-3 fw-bold">게시글 보기</a>
                                                    </c:when>
                                                    <c:when test="${item.apply_code == 0}">
                                                        <a href="${pageContext.request.contextPath}/match/article?page=1&match_code=${item.match_code}" class="btn-arrow-go" title="게시글로 이동"><i class="bi bi-arrow-right fs-5"></i></a>
                                                    </c:when>
                                                    <c:when test="${item.status eq '매칭대기'}">
                                                        <a href="${pageContext.request.contextPath}/match/article?page=1&match_code=${item.match_code}" class="btn btn-sm btn-dark rounded-pill px-3 fw-bold">게시글 보기</a>
                                                    </c:when>
                                                </c:choose>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                                
                                <div class="page-navigation">
                                    ${matchPaging}
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <div class="tab-pane fade ${param.tab == 'mercenary' ? 'show active' : ''}" id="pills-mercenary">
                        <c:choose>
                            <c:when test="${empty myMercenaryList}">
                                <div class="modern-card p-5 text-center text-muted">
                                    <i class="bi bi-pencil-square fs-1 d-block mb-3 opacity-50"></i>
                                    <p>작성한 용병 게시글이 없습니다.</p>
                                    <a href="${pageContext.request.contextPath}/mercenary/list" class="btn btn-outline-dark rounded-pill px-4 btn-sm mt-2">게시판 가기</a>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="item" items="${myMercenaryList}">
                                    <div class="history-card">
                                        <div class="d-flex justify-content-between align-items-center mb-3">
                                            <div>
                                                <c:choose>
                                                    <c:when test="${item.category == 'RECRUIT'}">
                                                        <span class="status-badge status-recruiting">구인 (용병모집)</span>
                                                    </c:when>
                                                    <c:when test="${item.category == 'SEEK'}">
                                                        <span class="status-badge status-ok">구직 (용병지원)</span>
                                                    </c:when>
                                                </c:choose>
                                            </div>
                                            <div class="text-muted small">
                                                <i class="bi bi-calendar me-1"></i> ${item.created_at} 
                                                <span class="mx-2">|</span> 
                                                <i class="bi bi-eye me-1"></i> ${item.view_count}
                                            </div>
                                        </div>

                                        <div class="d-flex justify-content-between align-items-center">
                                            <div class="d-flex align-items-center">
                                                
                                                <div class="me-3">
                                                    <c:choose>
                                                        <%-- 1. 구인 (팀 엠블럼) --%>
                                                        <c:when test="${item.category == 'RECRUIT'}">
                                                            <c:choose>
                                                                <c:when test="${not empty item.emblem_image}">
                                                                    <%-- [수정] icon.jpg -> emblem.png --%>
                                                                    <img src="${pageContext.request.contextPath}/uploads/team/${item.emblem_image}" 
                                                                         class="team-emblem-img" 
                                                                         style="width: 48px; height: 48px; border: 1px solid #eee;"
                                                                         onerror="this.src='${pageContext.request.contextPath}/dist/images/emblem.png'">
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <div class="team-emblem-placeholder" style="width: 48px; height: 48px;">
                                                                        <i class="bi bi-shield-shaded fs-4 text-secondary"></i>
                                                                    </div>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </c:when>
                                                        
                                                        <%-- 2. 구직 (사람 아이콘) --%>
                                                        <c:otherwise>
                                                            <div class="team-emblem-placeholder bg-light text-dark" style="width: 48px; height: 48px; border: 1px solid #eee;">
                                                                <i class="bi bi-person-fill fs-3"></i>
                                                            </div>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>

                                                <div>
                                                    <div class="fw-bold text-dark fs-5" style="word-break: break-all; line-height: 1.2;">
                                                        ${item.title}
                                                    </div>
                                                    
                                                    <div class="small text-muted mt-1">
                                                        <c:choose>
                                                            <c:when test="${item.category == 'RECRUIT'}">
                                                                <i class="bi bi-shield-fill me-1"></i> ${not empty item.team_name ? item.team_name : '팀 정보 없음'}
                                                            </c:when>
                                                            <c:otherwise>
                                                                <i class="bi bi-person me-1"></i> 개인 용병
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                </div>
                                            </div>
                                            
                                            <div>
                                                <a href="${pageContext.request.contextPath}/mercenary/article?recruit_id=${item.recruit_id}&page=1" 
                                                   class="btn btn-sm btn-dark rounded-pill px-3 fw-bold">
                                                   글 확인
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                                
                                <div class="page-navigation">
                                    ${mercenaryPaging}
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>

                </div> 
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
                        html += '<a href="${pageContext.request.contextPath}/myteam/main?teamCode=' + team.team_code + '" class="list-group-item list-group-item-action d-flex align-items-center py-3 px-2 border-0 rounded-3 mb-1" style="transition: background 0.2s;"><div class="rounded-circle border me-3 overflow-hidden bg-light d-flex justify-content-center align-items-center" style="width: 48px; height: 48px; min-width: 48px;"><img src="' + imgSrc + '" class="w-100 h-100 object-fit-cover" onerror="this.src=\'${pageContext.request.contextPath}/dist/images/emblem.png\'"></div><div><div class="fw-bold text-dark" style="font-size: 1rem;">' + team.team_name + '</div><div class="small text-secondary mt-1"><i class="bi bi-geo-alt me-1"></i>' + (team.region ? team.region : '지역미정') + '</div></div><i class="bi bi-chevron-right ms-auto text-muted opacity-50"></i></a>';
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