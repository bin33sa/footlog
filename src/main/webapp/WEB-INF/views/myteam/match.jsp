<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html>
<head>
    <title>Footlog - Match Schedule</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <jsp:include page="/WEB-INF/views/layout/headerResources.jsp"/>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/style.css?ver=1">

    <style>
       /* 필요한 경우 추가 스타일 작성 */
    </style>
</head>

<body>

    <header>
	   <jsp:include page="/WEB-INF/views/layout/teamheader.jsp"/>
	</header>


    <div class="container-fluid px-lg-5 mt-4">
        <div class="row">
            
            <div class="col-lg-2 d-none d-lg-block">
                <div class="sidebar-menu sticky-top" style="top: 100px;">
                    <div class="mb-4">
                        <p class="sidebar-title">구단 관리</p>
                        <div class="list-group">
                            <a href="${pageContext.request.contextPath}/myteam/update?teamCode=${sessionScope.currentTeamCode}" class="list-group-item list-group-item-action">구단 프로필 수정</a>
                            
                            <c:if test="${myRoleLevel >= 10}">
                                <a href="${pageContext.request.contextPath}/myteam/teamUpdate?teamCode=${sessionScope.currentTeamCode}" class="list-group-item list-group-item-action">구단 정보 수정</a>
                            </c:if>

                            <a href="${pageContext.request.contextPath}/myteam/squad?teamCode=${teamCode}" class="list-group-item list-group-item-action">
                                <c:choose>
                                    <c:when test="${myRoleLevel >= 10}">스쿼드(선수) 관리</c:when>
                                    <c:otherwise>구단 스쿼드</c:otherwise>
                                </c:choose>
                            </a>
                            
                            <a href="${pageContext.request.contextPath}/myteam/manage/match?teamCode=${teamCode}" class="list-group-item list-group-item-action active-menu fw-bold bg-light text-primary">매치 관리</a>
                            
                            <c:if test="${myRoleLevel >= 10}">
                                <a href="${pageContext.request.contextPath}/myteam/requestList?teamCode=${teamCode}" class="list-group-item list-group-item-action">
                                    가입 신청 관리 
                                </a>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-lg-10 col-12">
                
                <div class="d-flex justify-content-between align-items-end mb-4">
                    <div>
                        <h2 class="fw-bold mb-1">매치 일정 / 투표</h2>
                        <span class="text-muted">다가오는 경기 일정을 확인하고 참석 여부를 투표해주세요.</span>
                    </div>
                    <button class="btn btn-dark rounded-pill px-4 fw-bold" onclick="location.href='${pageContext.request.contextPath}/match/write'">
                        <i class="bi bi-plus-lg me-1"></i> 매치 등록
                    </button>
                </div>

                <ul class="nav nav-tabs border-bottom-0 mb-3 gap-2">
                    <li class="nav-item">
                        <a class="nav-link active bg-dark text-white rounded-pill px-4 fw-bold" href="#">예정된 매치</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link text-muted rounded-pill px-4" href="#">종료된 매치</a>
                    </li>
                </ul>

                <div class="row g-3">

                    <div class="col-12">
                        <div class="modern-card p-4 hover-scale transition-card">
                            <div class="d-flex flex-column flex-md-row gap-4 align-items-center">
                                
                                <div class="match-date-box">
                                    <span class="match-month">9월</span>
                                    <span class="match-day">20</span>
                                    <span class="match-time">14:00</span>
                                </div>

                                <div class="flex-grow-1 text-center text-md-start w-100">
                                    <div class="mb-2">
                                        <span class="status-badge status-recruiting mb-2 d-inline-block">투표 진행중</span>
                                        <h4 class="fw-bold mb-1">VS 레알 마드리드 조기축구회</h4>
                                        <p class="text-muted small mb-0"><i class="bi bi-geo-alt-fill me-1"></i>서울 상암 보조경기장 A구장</p>
                                    </div>
                                    
                                    <div class="mt-3">
                                        <div class="d-flex justify-content-between small text-muted mb-1">
                                            <span>참석 <strong class="text-primary">14명</strong></span>
                                            <span>목표 22명</span>
                                        </div>
                                        <div class="vote-progress">
                                            <div class="vote-bar" style="width: 65%;"></div>
                                        </div>
                                    </div>
                                </div>

                                <div class="d-flex gap-2 w-100 w-md-auto justify-content-center">
                                    <button class="btn btn-vote rounded-pill px-4 py-2 active">
                                        <i class="bi bi-check-circle-fill me-1"></i> 참석
                                    </button>
                                    <button class="btn btn-vote rounded-pill px-4 py-2">
                                        <i class="bi bi-x-circle me-1"></i> 불참
                                    </button>
                                    <button class="btn btn-vote rounded-pill px-4 py-2">
                                        <i class="bi bi-question-circle me-1"></i> 미정
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-12">
                        <div class="modern-card p-4 hover-scale transition-card border-primary" style="border-width: 0 0 0 4px;">
                            <div class="d-flex flex-column flex-md-row gap-4 align-items-center">
                                
                                <div class="match-date-box bg-white border-dark">
                                    <span class="match-month text-dark">9월</span>
                                    <span class="match-day">27</span>
                                    <span class="match-time bg-dark text-white">19:00</span>
                                </div>

                                <div class="flex-grow-1 text-center text-md-start w-100">
                                    <div class="mb-2">
                                        <span class="status-badge status-confirmed mb-2 d-inline-block">매치 확정</span>
                                        <h4 class="fw-bold mb-1">VS 맨시티 동호회</h4>
                                        <p class="text-muted small mb-0"><i class="bi bi-geo-alt-fill me-1"></i>용산 아이파크몰 풋살장</p>
                                    </div>
                                    <div class="mt-3">
                                        <div class="d-flex justify-content-between small text-muted mb-1">
                                            <span>참석 <strong class="text-success">10명</strong></span>
                                            <span>(5vs5 풋살)</span>
                                        </div>
                                        <div class="vote-progress">
                                            <div class="vote-bar bg-success" style="width: 100%;"></div>
                                        </div>
                                    </div>
                                </div>

                                <div class="d-flex gap-2 w-100 w-md-auto justify-content-center">
                                    <button class="btn btn-light rounded-pill px-4 py-2 disabled" disabled>
                                        <i class="bi bi-check-lg me-1"></i> 투표 마감
                                    </button>
                                    <button class="btn btn-outline-dark rounded-pill px-3 py-2" onclick="alert('전술 게시판으로 이동합니다.')">
                                        전술 보기 &rarr;
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-12">
                        <div class="modern-card p-4 hover-scale transition-card opacity-75">
                            <div class="d-flex flex-column flex-md-row gap-4 align-items-center">
                                
                                <div class="match-date-box">
                                    <span class="match-month">10월</span>
                                    <span class="match-day">05</span>
                                    <span class="match-time">10:00</span>
                                </div>

                                <div class="flex-grow-1 text-center text-md-start w-100">
                                    <div class="mb-2">
                                        <span class="status-badge bg-secondary text-white mb-2 d-inline-block">매칭 중</span>
                                        <h4 class="fw-bold mb-1 text-muted">상대 팀을 찾는 중입니다...</h4>
                                        <p class="text-muted small mb-0"><i class="bi bi-geo-alt-fill me-1"></i>장소 미정</p>
                                    </div>
                                </div>

                                <div class="d-flex gap-2 w-100 w-md-auto justify-content-center">
                                    <button class="btn btn-vote rounded-pill px-4 py-2">참석</button>
                                    <button class="btn btn-vote rounded-pill px-4 py-2">불참</button>
                                </div>
                            </div>
                        </div>
                    </div>

                </div> <div class="text-center mt-5 mb-5">
                    <button class="btn btn-light rounded-pill px-5 py-2 shadow-sm text-muted fw-bold hover-scale">
                        일정 더보기 <i class="bi bi-chevron-down ms-1"></i>
                    </button>
                </div>

            </div>
        </div> 
    </div>

    <footer>
	   <jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
	</footer>
	
    <jsp:include page="/WEB-INF/views/layout/footerResources.jsp"/>
    
    <script>
        // 투표 버튼 클릭 시 스타일 변경 예시 스크립트
        const voteButtons = document.querySelectorAll('.btn-vote');
        voteButtons.forEach(btn => {
            btn.addEventListener('click', function() {
                // 형제 버튼들의 active 클래스 제거
                const siblings = this.parentElement.querySelectorAll('.btn-vote');
                siblings.forEach(sib => sib.classList.remove('active'));
                
                // 클릭한 버튼 active 추가
                this.classList.add('active');
            });
        });
    </script>

</body>
</html>