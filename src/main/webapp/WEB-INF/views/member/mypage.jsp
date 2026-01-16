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

        /* 수정된 버튼 스타일: 주변 레이아웃을 깨트리지 않음 */
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
            transform: scale(1.03); /* 적당한 확대 */
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
    
   	<!-- 일반회원 -->
	<c:if test="${not empty dto and dto.role_level < 50}">
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
                    <a href="${pageContext.request.contextPath}/myteam/main" class="list-group-item list-group-item-action py-3 border-light">내 구단 이동</a>
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
            </div> </div> 
            </c:if>
            
    <!-- 관리자 -->
	<c:if test="${not empty dto and dto.role_level > 50}">
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
                    <a href="${pageContext.request.contextPath}/member/mypage" class="list-group-item list-group-item-action py-3 fw-bold bg-light border-0">🚀 관리메뉴</a>
                    <a href="${pageContext.request.contextPath}/member/mypage?menu=team" class="list-group-item list-group-item-action py-3 border-light">구단 관리</a>
                    <a href="${pageContext.request.contextPath}/member/mypage?menu=stadium" class="list-group-item list-group-item-action py-3 border-light">구장 관리</a>
                    <a href="${pageContext.request.contextPath}/member/mypage?menu=member" class="list-group-item list-group-item-action py-3 border-light">회원 관리</a>
                    <a href="${pageContext.request.contextPath}/member/mypage?menu=faq" class="list-group-item list-group-item-action py-3 border-light">FAQ 수정</a>
                    <a href="${pageContext.request.contextPath}/member/logout" class="list-group-item list-group-item-action py-3 border-0 text-danger fw-bold">로그아웃</a>
                </div>
            </div>
            
            
            
            <div class="col-lg-9">
            
            <c:choose>
            	<c:when test="${param.menu == 'team'}">
  			          <jsp:include page="/WEB-INF/views/admin/mypage/team.jsp" />
            	</c:when>
            	<c:when test="${param.menu == 'stadium'}">
  			          <jsp:include page="/WEB-INF/views/admin/mypage/stadium.jsp" />
            	</c:when>
            	<c:when test="${param.menu == 'member'}">
  			          <jsp:include page="/WEB-INF/views/admin/mypage/member.jsp" />
            	</c:when>
            	<c:when test="${param.menu == 'faq'}">
  			          <jsp:include page="/WEB-INF/views/admin/mypage/faq.jsp" />
            	</c:when>
            	
            	
            	<c:otherwise>
                <div class="row g-3 mb-4">
                    <div class="col-md-4">
                        <div class="modern-card p-3 h-100 text-center d-flex flex-column justify-content-center">
                            <span class="text-muted small fw-bold mb-1">전체 구단 수</span>
                            <h3 class="fw-bold m-0">? <span class="fs-6 text-muted">개 구단</span></h3>
                        </div>
                    </div>

                    <div class="col-md-4">
                        <div class="modern-card p-3 h-100 text-center d-flex flex-column justify-content-center">
                            <span class="text-muted small fw-bold mb-1">전체 구장 수</span>
                            <h3 class="fw-bold m-0">? <span class="fs-6 text-muted">개 구장</span></h3>
                        </div>
                    </div>

                    <div class="col-md-4">
                        <div class="modern-card p-3 h-100 text-center d-flex flex-column justify-content-center">
                            <span class="text-muted small fw-bold mb-1">전체 회원 수</span>
                            <h3 class="fw-bold m-0">? <span class="fs-6 text-muted">명</span></h3>
                        </div>
                    </div>
                </div>

                <h5 class="fw-bold mb-3 ms-1">📅 문의게시판 "미답변" 게시글</h5>
                
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
                </c:otherwise>
            
            </c:choose>
                
            </div> 
            </div> </div> 
            </c:if>
            
    <footer>
       <jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
    </footer>

    <jsp:include page="/WEB-INF/views/layout/footerResources.jsp"/>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    
    <script type="text/javascript">
    
    
    
    </script>
    
    
</body>
</html>