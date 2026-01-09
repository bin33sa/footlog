<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>마이페이지 - Footlog</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/style.css">
    
    <style>
        .dashboard-header { background: #111; color: #fff; padding: 2rem; border-radius: 20px; margin-bottom: 24px; }
        .match-card { border-left: 5px solid #ddd; transition: transform 0.2s; }
        .match-card:hover { transform: translateX(5px); }
        .match-card.upcoming { border-left-color: var(--primary-color); } 
        .match-card.end { border-left-color: #555; background: #f8f9fa; }
    </style>
</head>
	<jsp:include page="/WEB-INF/views/layout/headerResources.jsp"/>
<body>

    <header>
	   <jsp:include page="/WEB-INF/views/layout/header.jsp"/>
	</header>

    <div class="container mt-4 mb-5" style="max-width: 1200px;">
        <div class="row g-4">
            
            <div class="col-lg-3">
                <div class="modern-card p-4 text-center mb-3">
                    <div class="position-relative d-inline-block mb-3">
                        <img src="${empty dto.profile_image ? pageContext.request.contextPath.concat('/dist/images/avatar.png') : pageContext.request.contextPath.concat('/uploads/profile/').concat(dto.profile_image)}" 
                             class="rounded-circle border border-3 border-dark" 
                             style="width: 100px; height: 100px; object-fit: cover;">
                             
                        <span class="position-absolute bottom-0 end-0 badge rounded-pill bg-primary text-dark">
                            ${empty dto.preferred_position ? '포지션 미설정' : dto.preferred_position}
                        </span>
                    </div>
                    
                    <h5 class="fw-bold mb-1">${dto.member_name}</h5>
                    
                    <p class="text-muted small mb-3">
                        ${empty dto.region ? '지역 미설정' : dto.region} | FC 슛돌이
                    </p>
                    
                    <a href="${pageContext.request.contextPath}/member/profile" class="btn btn-outline-dark btn-sm rounded-pill w-100">
                        프로필 관리 / 사진변경
                    </a>
                </div>
                
                <div class="list-group shadow-sm rounded-4 overflow-hidden">
                    <a href="#" class="list-group-item list-group-item-action py-3 fw-bold bg-light">🚀 대시보드</a>
                    <a href="#" class="list-group-item list-group-item-action py-3">내 구단 이동</a>
                    <a href="${pageContext.request.contextPath}/member/history" class="list-group-item list-group-item-action py-3">매치/용병 신청 내역</a>
                    <a href="${pageContext.request.contextPath}/member/updateInfo"class="list-group-item list-group-item-action py-3">회원정보 수정</a>
                    <a href="${pageContext.request.contextPath}/member/logout" class="list-group-item list-group-item-action py-3">로그아웃</a>
       
                </div>
            </div>

            <div class="col-lg-9">
                <div class="row g-3 mb-4">
                    
                    <div class="col-md-4">
                        <div class="modern-card p-4 bg-dark text-white h-100 d-flex justify-content-between align-items-center">
                            <div>
                                <p class="mb-1 text-white-50 small fw-bold">NEXT MATCH</p>
                                <c:choose>
                                    <c:when test="${not empty stats.next_match_dday}">
                                         <h4 class="fw-bold m-0" style="color: var(--primary-color);">D-${stats.next_match_dday}</h4>
                                    </c:when>
                                    <c:otherwise>
                                         <h5 class="fw-bold m-0 text-secondary">일정 없음</h5>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <div class="text-end">
                                <span class="d-block small">
                                    ${not empty stats.next_match_opponent ? 'vs '.concat(stats.next_match_opponent) : '-'}
                                </span>
                                <span class="d-block small opacity-50">
                                    ${not empty stats.next_match_date ? stats.next_match_date : '예정된 경기 없음'}
                                </span>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-4">
                        <div class="modern-card p-3 h-100 text-center d-flex flex-column justify-content-center">
                            <span class="text-muted small fw-bold">이번 달 경기</span>
                            <h3 class="fw-bold m-0">${stats.month_match_count} <span class="fs-6 text-muted">matches</span></h3>
                        </div>
                    </div>

                    <div class="col-md-4">
                        <div class="modern-card p-3 h-100 text-center d-flex flex-column justify-content-center">
                            <span class="text-muted small fw-bold">공격 포인트</span>
                            <h3 class="fw-bold m-0">${stats.total_point} <span class="fs-6 text-muted">points</span></h3>
                        </div>
                    </div>
                </div>

                <h5 class="fw-bold mb-3">📅 나의 매치 일정</h5>
                
                <div class="modern-card p-0 overflow-hidden mb-5">
                    
                    <c:choose>
                        
                        <%-- 1. 매치 내역이 아예 없을 때 (리스트가 비어있거나 null일 때) --%>
                        <c:when test="${empty matchList}">
                             <div class="p-5 text-center">
                                <div class="mb-3">
                                    <span class="fs-1">⚽</span> </div>
                                <h6 class="text-muted fw-bold mb-2">아직 참여한 매치 내역이 없습니다.</h6>
                                <p class="small text-secondary mb-4">새로운 매치를 생성하거나 용병으로 경기에 참여해보세요!</p>
                                
                                <a href="${pageContext.request.contextPath}/match/list" class="btn btn-dark rounded-pill px-4">
                                    매치 둘러보기
                                </a>
                             </div>
                        </c:when>
                        
                        <%-- 2. 매치 내역이 있을 때 --%>
                        <c:otherwise>
                            <c:forEach var="dto" items="${matchList}">
                                
                                <%-- 예정된 경기 --%>
                                <c:if test="${dto.status != '완료' && dto.status != 'END'}">
                                    <div class="p-4 border-bottom match-card upcoming bg-white">
                                        <div class="d-flex justify-content-between align-items-center">
                                            <div>
                                                <span class="badge bg-dark text-primary mb-2">${dto.status}</span>
                                                <h5 class="fw-bold mb-1">${dto.home_team_name} vs ${dto.away_team_name}</h5>
                                                <p class="text-muted mb-0 small">🏟 ${dto.region} | ⏰ ${dto.match_date}</p>
                                            </div>
                                            <button type="button" class="btn btn-sm btn-outline-dark rounded-pill">상세보기</button>
                                        </div>
                                    </div>
                                </c:if>

                                <%-- 종료된 경기 --%>
                                <c:if test="${dto.status == '완료' || dto.status == 'END'}">
                                    <div class="p-4 match-card end border-bottom">
                                        <div class="d-flex justify-content-between align-items-center">
                                            <div>
                                                <span class="badge bg-secondary mb-2">종료</span>
                                                <h6 class="fw-bold mb-1 text-muted">${dto.home_team_name} vs ${dto.away_team_name}</h6>
                                                <p class="text-muted mb-0 small">결과: ${dto.home_score} - ${dto.away_score}</p>
                                            </div>
                                            <span class="fw-bold fs-5 text-muted">END</span>
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
</body>
</html>