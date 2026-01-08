<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>Footlog - FC Thunderbolt</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/style.css">
</head>
	<jsp:include page="/WEB-INF/views/layout/headerResources.jsp"/>
<body>

    <header>
	   <jsp:include page="/WEB-INF/views/layout/header.jsp"/>
	</header>


    <div class="container-fluid px-lg-5 mt-4">
        <div class="row">
             <div class="col-lg-2 d-none d-lg-block">
                <div class="sidebar-menu sticky-top" style="top: 100px;">
                    <div class="mb-4">
                        <p class="sidebar-title">구단</p>
                        <div class="list-group">
                            <a href="${pageContext.request.contextPath}/myteam/main" class="list-group-item list-group-item-action">내 구단 이동</a>
                            <a href="${pageContext.request.contextPath}/team/list" class="list-group-item list-group-item-action">전체 구단 리스트</a>
                            <a href="${pageContext.request.contextPath}/team/write" class="list-group-item list-group-item-action">구단 생성하기</a>
                        </div>
                    </div>
                </div>
            </div>
  

            <div class="col-lg-8 col-12 ">
                
                <div class="modern-card p-5 bg-light">
                    
                    <div class="row align-items-center mb-5">
                        <div class="col-md-3 text-center mb-3 mb-md-0">
                            <div class="rounded-circle bg-white border shadow-sm d-flex align-items-center justify-content-center mx-auto overflow-hidden" style="width: 140px; height: 140px;">
                                <img src="https://images.unsplash.com/photo-1522770179533-24471fcdba45?w=500&auto=format&fit=crop&q=60" alt="emblem" style="width: 100%; height: 100%; object-fit: cover;">
                            </div>
                        </div>
                        
                        <div class="col-md-9">
                            <div class="d-flex justify-content-between align-items-center mb-3">
                                <div>
                                    <span class="badge bg-primary text-dark mb-2">모집중</span>
                                    <h2 class="fw-bold mb-0 text-dark">FC 썬더볼트</h2>
                                </div>
                                <div class="text-end">
                                    <span class="d-block text-muted small">구단장</span>
                                    <span class="fw-bold">캡틴손</span>
                                </div>
                            </div>
                            
                            <div class="d-flex gap-2 flex-wrap">
                                <span class="badge bg-white text-secondary border px-3 py-2"><i class="bi bi-geo-alt-fill me-1"></i> 서울 마포구</span>
                                <span class="badge bg-white text-secondary border px-3 py-2"><i class="bi bi-person-fill me-1"></i> 20대~30대</span>
                                <span class="badge bg-white text-secondary border px-3 py-2"><i class="bi bi-trophy-fill me-1"></i> 실력 중</span>
                            </div>
                        </div>
                    </div>

                    <div class="row mb-5">
                        <div class="col-12">
                            <h5 class="fw-bold mb-3"><i class="bi bi-megaphone-fill me-2"></i>구단 소개</h5>
                            <div class="bg-white p-4 rounded-4 border shadow-sm" style="min-height: 150px; line-height: 1.8;">
                                <p class="mb-0 text-secondary">
                                    안녕하세요! 마포구를 기반으로 활동하는 <strong>FC 썬더볼트</strong>입니다. ⚡<br><br>
                                    저희는 승패보다는 <strong>'즐겁고 매너있는 축구'</strong>를 지향합니다.<br>
                                    주로 주말 오전에 상암 보조경기장이나 난지천 공원에서 경기를 진행합니다.<br>
                                    현재 미드필더와 수비수 포지션을 충원 중이니, 열정 있는 분들의 많은 지원 바랍니다!<br>
                                    (끝나고 회식 강요 없습니다!)
                                </p>
                            </div>
                        </div>
                    </div>

                    <div class="row g-3 mb-5">
                        <div class="col-md-6">
                            <div class="bg-white p-3 rounded-3 border d-flex justify-content-between align-items-center">
                                <span class="text-muted">현재 인원</span>
                                <span class="fw-bold fs-5">24 / 30명</span>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="bg-white p-3 rounded-3 border d-flex justify-content-between align-items-center">
                                <span class="text-muted">매너 점수</span>
                                <span class="fw-bold fs-5 text-warning"><i class="bi bi-star-fill"></i> 4.8</span>
                            </div>
                        </div>
                    </div>

                    <div class="d-flex justify-content-between align-items-end border-top pt-4">
                        
                        <div class="text-center d-none d-md-block">
                            <div class="btn-group shadow-sm">
                                <button class="btn btn-light border" title="이전 구단"><i class="bi bi-chevron-left"></i></button>
                                <button class="btn btn-light border" title="다음 구단"><i class="bi bi-chevron-right"></i></button>
                            </div>
                        </div>

                        <div class="d-flex gap-2 w-100 w-md-auto justify-content-end">
                            <button class="btn btn-secondary rounded-pill px-4 fw-bold" 
                                    onclick="location.href='${pageContext.request.contextPath}/team/list'">
                                목록으로
                            </button>
                            <button class="btn btn-dark rounded-pill px-5 fw-bold" 
                                    onclick="alert('가입 신청이 구단장에게 전송되었습니다!')">
                                가입 신청하기
                            </button>
                        </div>
                    </div>

                </div>

            </div>

            <div class="col-lg-2 d-none d-lg-block">
                <div class="sidebar-menu sticky-top" style="top: 100px;">
                    <div class="mb-4">
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