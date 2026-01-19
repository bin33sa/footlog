<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>Footlog - About Us</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/style.css?v=7">
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
	            
	            <p class="sidebar-title">사이트 소개</p>
	            
	            <div class="list-group">
	                <a href="${pageContext.request.contextPath}/introduction" class="list-group-item list-group-item-action active-menu">사이트 기능 소개</a>
	                <a href="${pageContext.request.contextPath}/qna/list" class="list-group-item list-group-item-action">문의 게시판</a>
	                <a href="${pageContext.request.contextPath}/faq/list" class="list-group-item list-group-item-action">자주 묻는 질문 (Q/A)</a>
				 </div>
				    </div>
				    </div>
				</div>

            <div class="col-lg-8 col-12">
                
                <div class="modern-card p-5 text-center bg-dark text-white mb-4 position-relative overflow-hidden">
                    <div class="position-absolute top-0 start-0 w-100 h-100" style="background: radial-gradient(circle at 10% 20%, rgba(212, 246, 63, 0.1) 0%, transparent 50%);"></div>
                    
                    <div class="position-relative" style="z-index: 1;">
                        <h1 class="fw-bold display-4 mb-3" style="color: #D4F63F; font-style: italic;">FOOTLOG</h1>
                        <p class="fs-5 mb-4 fw-light">"Connect, Play, Record"</p>
                        <p class="text-white-50 mb-0" style="line-height: 1.6;">
                            풋로그는 모든 아마추어 풋살 플레이어를 위한 통합 플랫폼입니다.<br>
                            팀 관리부터 매치 매칭, 구장 예약까지. 풋살의 모든 순간을 기록하세요.
                        </p>
                    </div>
                </div>

                <h4 class="fw-bold mb-3 ms-2">Key Features</h4>
                <div class="row g-4 mb-5">
                    
                    <div class="col-md-6">
                        <div class="modern-card p-4 h-100 text-center hover-up">
                            <div class="mb-3 d-inline-block p-3 rounded-circle bg-light text-primary">
                                <i class="bi bi-people-fill fs-2 text-dark"></i>
                            </div>
                            <h5 class="fw-bold">팀 매니지먼트</h5>
                            <p class="text-muted small mb-0">
                                나만의 구단을 창단하고 멤버를 모집하세요.<br>
                                팀원 관리와 일정 공유가 쉬워집니다.
                            </p>
                        </div>
                    </div>

                    <div class="col-md-6">
                        <div class="modern-card p-4 h-100 text-center hover-up">
                            <div class="mb-3 d-inline-block p-3 rounded-circle bg-light text-primary">
                                <i class="bi bi-trophy-fill fs-2 text-dark"></i>
                            </div>
                            <h5 class="fw-bold">매치 & 용병 매칭</h5>
                            <p class="text-muted small mb-0">
                                실력에 맞는 상대팀을 찾거나,<br>
                                부족한 인원을 용병으로 빠르게 충원하세요.
                            </p>
                        </div>
                    </div>

                    <div class="col-md-6">
                        <div class="modern-card p-4 h-100 text-center hover-up">
                            <div class="mb-3 d-inline-block p-3 rounded-circle bg-light text-primary">
                                <i class="bi bi-geo-alt-fill fs-2 text-dark"></i>
                            </div>
                            <h5 class="fw-bold">간편한 구장 예약</h5>
                            <p class="text-muted small mb-0">
                                지역별, 시간대별 구장 정보를 한눈에 비교하고<br>
                                복잡한 절차 없이 즉시 예약하세요.
                            </p>
                        </div>
                    </div>

                    <div class="col-md-6">
                        <div class="modern-card p-4 h-100 text-center hover-up">
                            <div class="mb-3 d-inline-block p-3 rounded-circle bg-light text-primary">
                                <i class="bi bi-chat-dots-fill fs-2 text-dark"></i>
                            </div>
                            <h5 class="fw-bold">커뮤니티 소통</h5>
                            <p class="text-muted small mb-0">
                                경기 사진을 공유하고 후기를 남겨보세요.<br>
                                풋살인들과의 즐거운 소통이 시작됩니다.
                            </p>
                        </div>
                    </div>

                </div>

                <div class="modern-card p-5 text-center bg-light border-0">
                    <h5 class="fw-bold mb-3">지금 바로 시작해보세요!</h5>
                    <p class="text-muted small mb-4">풋로그와 함께라면 풋살이 더 즐거워집니다.</p>
                    <div class="d-flex justify-content-center gap-3">
                        <button class="btn btn-outline-dark rounded-pill px-4" onclick="location.href='${pageContext.request.contextPath}/team/list'">구단 둘러보기</button>
                        <button class="btn btn-primary rounded-pill px-4 fw-bold" onclick="location.href='${pageContext.request.contextPath}/match/list'">매치 찾기</button>
                    </div>
                </div>

            </div>

            <div class="col-lg-2 d-none d-lg-block">
                <div class="sidebar-menu sticky-top" style="top: 100px;">
                    <div class="mb-4">
                        <p class="sidebar-title">Community</p>
                        <div class="list-group">
                            <a href="${pageContext.request.contextPath}/bbs/list?category=1" class="list-group-item list-group-item-action">공지사항</a>
                			<a href="${pageContext.request.contextPath}/bbs/list?category=2" class="list-group-item list-group-item-action">자유 게시판</a>
                			<a href="${pageContext.request.contextPath}/bbs/list?category=3" class="list-group-item list-group-item-action">이벤트 / 뉴스</a>
                			<a href="${pageContext.request.contextPath}/bbs/list?category=4" class="list-group-item list-group-item-action">갤러리</a>
                        </div>
                    </div>
                </div>
            </div>

        </div> </div>
        <footer>
		   <jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
		</footer>
		
		<jsp:include page="/WEB-INF/views/layout/footerResources.jsp"/>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>