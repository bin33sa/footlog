<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>신청 내역 - Footlog</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/style.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    
    <style>
        /* 탭 버튼 스타일 커스텀 */
        .nav-pills .nav-link {
            color: #555;
            background-color: #fff; /* 배경 흰색으로 변경 */
            border-radius: 50px;
            padding: 8px 20px;
            margin-right: 8px;
            font-weight: 600;
            font-size: 0.95rem;
            border: 1px solid #eee;
            transition: all 0.2s;
        }
        .nav-pills .nav-link:hover {
            background-color: #f8f9fa;
        }
        .nav-pills .nav-link.active {
            background-color: #111;
            color: #D4F63F; /* 형광 라임 포인트 */
            border-color: #111;
            box-shadow: 0 4px 10px rgba(0,0,0,0.15);
        }
        
        /* 리스트 아이템 스타일 */
        .history-card {
            background: #fff;
            border-radius: 16px;
            padding: 24px;
            margin-bottom: 16px;
            border: 1px solid #f1f1f1;
            transition: all 0.2s cubic-bezier(0.4, 0, 0.2, 1);
            position: relative;
        }
        .history-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.05);
            border-color: #e0e0e0;
        }

        /* 상태 뱃지 */
        .status-badge {
            font-size: 0.75rem;
            padding: 5px 10px;
            border-radius: 6px;
            font-weight: 700;
            letter-spacing: -0.5px;
        }
        .status-wait { background: #fff8e1; color: #b78a00; border: 1px solid #ffeeba; } /* 대기중 */
        .status-ok { background: #e6fcf5; color: #0ca678; border: 1px solid #c3fae8; }   /* 승인 */
        .status-no { background: #fff5f5; color: #fa5252; border: 1px solid #ffc9c9; }   /* 거절 */
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
                        <img src="${empty sessionScope.member.profile_photo ? pageContext.request.contextPath.concat('/dist/images') : pageContext.request.contextPath.concat('/uploads/profile/').concat(sessionScope.member.profile_photo)}" 
                             class="rounded-circle border border-3 border-dark" 
                             style="width: 100px; height: 100px; object-fit: cover;">
                        <span class="position-absolute bottom-0 end-0 badge rounded-pill bg-primary text-dark">
                            ${empty sessionScope.member.position ? 'FW' : sessionScope.member.position}
                        </span>
                    </div>
                    
                    <h5 class="fw-bold mb-1">${empty sessionScope.member.name ? '게스트' : sessionScope.member.name}</h5>
                    <p class="text-muted small mb-3">서울 마포구 | FC 슛돌이</p>
                    
                    <a href="${pageContext.request.contextPath}/member/profile" class="btn btn-outline-dark btn-sm rounded-pill w-100">
                        프로필 관리
                    </a>
                </div>

                <div class="list-group shadow-sm rounded-4 overflow-hidden">
                    <a href="${pageContext.request.contextPath}/member/mypage" class="list-group-item list-group-item-action py-3">🚀 대시보드</a>
                    <a href="#" class="list-group-item list-group-item-action py-3">내 구단 이동</a>
                    <a href="${pageContext.request.contextPath}/member/history" class="list-group-item list-group-item-action py-3 fw-bold bg-light" style="border-left: 5px solid #111;">매치/용병 신청 내역</a>
                    <a href="${pageContext.request.contextPath}/member/updateInfo" class="list-group-item list-group-item-action py-3">회원정보 수정</a>
                    <a href="${pageContext.request.contextPath}/member/logout" class="list-group-item list-group-item-action py-3">로그아웃</a>
                </div>
            </div>

            <div class="col-lg-9">
                
                <div class="d-flex justify-content-between align-items-end mb-4 border-bottom pb-3">
                    <div>
                        <h4 class="fw-bold m-0"><i class="bi bi-clipboard-check me-2"></i>매치 및 용병 신청 내역</h4>
                        <span class="text-muted small mt-1 d-block">나의 경기 매칭 현황과 용병 지원 내역을 한눈에 확인하세요.</span>
                    </div>
                    </div>

                <ul class="nav nav-pills mb-4" id="pills-tab" role="tablist">
                    <li class="nav-item" role="presentation">
                        <button class="nav-link active" id="pills-match-tab" data-bs-toggle="pill" data-bs-target="#pills-match" type="button" role="tab" aria-selected="true">
                            매치 신청 (팀)
                        </button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link" id="pills-mercenary-tab" data-bs-toggle="pill" data-bs-target="#pills-mercenary" type="button" role="tab" aria-selected="false">
                            용병 신청 (개인)
                        </button>
                    </li>
                </ul>

                <div class="tab-content" id="pills-tabContent">
                    
                    <div class="tab-pane fade show active" id="pills-match" role="tabpanel">
                        <div class="modern-card p-4 bg-light border-0">
                            
                            <div class="history-card">
                                <div class="d-flex justify-content-between align-items-start">
                                    <div>
                                        <span class="status-badge status-wait mb-2 d-inline-block">수락 대기중</span>
                                        <h5 class="fw-bold mb-1">VS 첼시 FC</h5>
                                        <p class="text-muted small mb-0 mt-2">
                                            <i class="bi bi-calendar-check me-1"></i> 2026.02.15 (일) 14:00 <span class="mx-1">|</span>
                                            <i class="bi bi-geo-alt me-1"></i> 서울 월드컵 보조경기장
                                        </p>
                                    </div>
                                    <button class="btn btn-sm btn-outline-danger rounded-pill px-3 fw-bold">신청 취소</button>
                                </div>
                            </div>

                            <div class="history-card">
                                <div class="d-flex justify-content-between align-items-start">
                                    <div>
                                        <span class="status-badge status-ok mb-2 d-inline-block">매치 성사</span>
                                        <h5 class="fw-bold mb-1">VS 리버풀 FC</h5>
                                        <p class="text-muted small mb-0 mt-2">
                                            <i class="bi bi-calendar-check me-1"></i> 2026.01.20 (토) 10:00 <span class="mx-1">|</span>
                                            <i class="bi bi-geo-alt me-1"></i> 잠실 풋살장 A구장
                                        </p>
                                    </div>
                                    <button class="btn btn-sm btn-dark rounded-pill px-3 fw-bold">상세 보기 &rarr;</button>
                                </div>
                            </div>

                            <div class="history-card bg-light border-0" style="opacity: 0.8;">
                                <div class="d-flex justify-content-between align-items-start">
                                    <div>
                                        <span class="status-badge status-no mb-2 d-inline-block">거절됨</span>
                                        <h5 class="fw-bold mb-1 text-decoration-line-through text-muted">VS 맨유 조기축구회</h5>
                                        <p class="text-muted small mb-0 mt-2">
                                            <i class="bi bi-calendar-check me-1"></i> 2026.01.05 (월) 19:00
                                        </p>
                                    </div>
                                    <span class="text-danger small fw-bold pt-2"><i class="bi bi-info-circle me-1"></i>사유: 이미 매칭됨</span>
                                </div>
                            </div>

                        </div>
                    </div>

                    <div class="tab-pane fade" id="pills-mercenary" role="tabpanel">
                        <div class="modern-card p-4 bg-light border-0">
                            
                            <div class="history-card">
                                <div class="d-flex justify-content-between align-items-start">
                                    <div>
                                        <span class="status-badge status-wait mb-2 d-inline-block">지원 완료 (대기중)</span>
                                        <h5 class="fw-bold mb-1">FC 슛돌이 - 미드필더 용병 모집</h5>
                                        <p class="text-muted small mb-0 mt-2">
                                            <i class="bi bi-calendar-check me-1"></i> 2026.02.22 (일) 08:00 <span class="mx-1">|</span>
                                            <i class="bi bi-coin me-1"></i> 참가비 무료
                                        </p>
                                    </div>
                                    <button class="btn btn-sm btn-outline-danger rounded-pill px-3 fw-bold">지원 취소</button>
                                </div>
                            </div>

                            <div class="history-card">
                                <div class="d-flex justify-content-between align-items-start">
                                    <div>
                                        <span class="status-badge status-ok mb-2 d-inline-block">참가 확정</span>
                                        <h5 class="fw-bold mb-1">개발자 FC - 골키퍼 급구</h5>
                                        <p class="text-muted small mb-0 mt-2">
                                            <i class="bi bi-calendar-check me-1"></i> 2026.01.10 (토) 18:00 <span class="mx-1">|</span>
                                            <i class="bi bi-geo-alt me-1"></i> 상암 풋살장
                                        </p>
                                    </div>
                                    <button class="btn btn-sm btn-dark rounded-pill px-3 fw-bold">연락처 보기</button>
                                </div>
                            </div>

                        </div>
                    </div>
                </div> </div>
        </div>
    </div>

    <footer>
	   <jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
	</footer>

<jsp:include page="/WEB-INF/views/layout/footerResources.jsp"/>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>