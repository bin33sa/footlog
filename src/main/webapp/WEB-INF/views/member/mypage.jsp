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
                        <img src="${empty sessionScope.member.profile_photo ? pageContext.request.contextPath.concat('/dist/images/') : pageContext.request.contextPath.concat('/uploads/profile/').concat(sessionScope.member.profile_photo)}" 
                             class="rounded-circle border border-3 border-dark" 
                             style="width: 100px; height: 100px; object-fit: cover;">
                             
                        <span class="position-absolute bottom-0 end-0 badge rounded-pill bg-primary text-dark">
                            ${empty sessionScope.member.position ? 'FW' : sessionScope.member.position}
                        </span>
                    </div>
                    
                    <h5 class="fw-bold mb-1">${empty sessionScope.member.name ? '게스트' : sessionScope.member.name}</h5>
                    <p class="text-muted small mb-3">서울 마포구 | FC 슛돌이</p>
                    
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
                                <h4 class="fw-bold m-0" style="color: var(--primary-color);">D-2</h4>
                            </div>
                            <div class="text-end">
                                <span class="d-block small">vs 리버풀 FC</span>
                                <span class="d-block small opacity-50">05.24 (토)</span>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="modern-card p-3 h-100 text-center d-flex flex-column justify-content-center">
                            <span class="text-muted small fw-bold">이번 달 경기</span>
                            <h3 class="fw-bold m-0">4 <span class="fs-6 text-muted">matches</span></h3>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="modern-card p-3 h-100 text-center d-flex flex-column justify-content-center">
                            <span class="text-muted small fw-bold">공격 포인트</span>
                            <h3 class="fw-bold m-0">2 <span class="fs-6 text-muted">goals</span></h3>
                        </div>
                    </div>
                </div>

                <h5 class="fw-bold mb-3">📅 나의 매치 일정</h5>
                <div class="modern-card p-0 overflow-hidden mb-5">
                    <div class="p-4 border-bottom match-card upcoming bg-white">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <span class="badge bg-dark text-primary mb-2">Upcoming</span>
                                <h5 class="fw-bold mb-1">FC 슛돌이 vs 리버풀 FC</h5>
                                <p class="text-muted mb-0 small">🏟 서울 월드컵 보조경기장 | ⏰ 2025.05.24 14:00</p>
                            </div>
                            <button class="btn btn-sm btn-outline-dark rounded-pill">라인업 확인</button>
                        </div>
                    </div>

                    <div class="p-4 match-card end">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <span class="badge bg-secondary mb-2">종료</span>
                                <h6 class="fw-bold mb-1 text-muted">FC 슛돌이 vs 바르셀로나</h6>
                                <p class="text-muted mb-0 small">결과: 2-1 승리</p>
                            </div>
                            <span class="fw-bold fs-5 text-muted">WIN</span>
                        </div>
                    </div>
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