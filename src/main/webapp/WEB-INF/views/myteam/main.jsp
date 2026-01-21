<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Footlog - My Team Dashboard</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <jsp:include page="/WEB-INF/views/layout/headerResources.jsp"/>
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/style.css?ver=2">

    <style>
        /* 게시글 행 클릭 시 효과 */
        .board-row:hover {
            background-color: #f8f9fa;
        }
    </style>
</head>

<body>

   <header>
       <jsp:include page="/WEB-INF/views/layout/teamheader.jsp"/>
    </header>


    <div class="container-fluid px-lg-5 mt-4">
        <div class="row">

            <div class="col-lg-8 col-12 offset-lg-2">
                
                <div class="modern-card p-0 mb-4 bg-dark text-white overflow-hidden position-relative">
                    <div class="d-flex align-items-center justify-content-between p-4">
                        
                        <c:choose>
                            <c:when test="${myTeamsCount > 1}">
                                <button class="btn btn-icon text-white-50 hover-white" 
                                        onclick="location.href='${pageContext.request.contextPath}/myteam/main?teamCode=${prevTeamCode}'"
                                        title="이전 팀 보기">
                                    <i class="bi bi-chevron-left fs-4"></i>
                                </button>
                            </c:when>
                            <c:otherwise>
                                <button class="btn btn-icon text-white-50" style="visibility: hidden; cursor: default;">
                                    <i class="bi bi-chevron-left fs-4"></i>
                                </button>
                            </c:otherwise>
                        </c:choose>

                        <div class="d-flex align-items-center gap-3">
                            <div class="bg-white rounded-circle d-flex align-items-center justify-content-center text-dark overflow-hidden" style="width: 50px; height: 50px;">
                                <c:set var="defaultEmblem" value="${pageContext.request.contextPath}/dist/images/icon.jpg" />
                                <c:choose>                          
                                    <c:when test="${not empty myTeam.emblem_image}">
                                        <img src="${pageContext.request.contextPath}/uploads/team/${myTeam.emblem_image}" 
                                             alt="Team Emblem" 
                                             style="width: 100%; height: 100%; object-fit: cover;"
                                             onerror="this.src='${defaultEmblem}'">
                                    </c:when>
                                    <c:otherwise>
                                        <img src="${defaultEmblem}" 
                                             alt="Default Team"
                                             style="width: 100%; height: 100%; object-fit: cover;">
                                    </c:otherwise>
                                </c:choose>
                            </div>

                            <div>
                                <span class="badge bg-primary text-dark mb-1">MY TEAM</span>
                                <h4 class="fw-bold mb-0">${myTeamName}</h4>
                            </div>
                        </div>

                        <c:choose>
                            <c:when test="${myTeamsCount > 1}">
                                <button class="btn btn-icon text-white-50 hover-white" 
                                        onclick="location.href='${pageContext.request.contextPath}/myteam/main?teamCode=${nextTeamCode}'"
                                        title="다음 팀 보기">
                                    <i class="bi bi-chevron-right fs-4"></i>
                                </button>
                            </c:when>
                            <c:otherwise>
                                <button class="btn btn-icon text-white-50" style="visibility: hidden; cursor: default;">
                                    <i class="bi bi-chevron-right fs-4"></i>
                                </button>
                            </c:otherwise>
                        </c:choose>

                    </div>
                </div>

                <div class="row g-4 mb-5">
                    <div class="col-md-6">
                        <div class="modern-card dashboard-card p-4 h-100 d-flex flex-column align-items-center justify-content-center text-center bg-light"
                             onclick="location.href='${pageContext.request.contextPath}/myteam/match?teamCode=${myTeam.team_code}'"
                             style="cursor: pointer;"> 
                            <div class="mb-3 p-3 rounded-circle bg-white shadow-sm">
                                <i class="bi bi-calendar-check-fill fs-2 text-primary"></i>
                            </div>
                            <h5 class="fw-bold mb-1">매치 일정 / 투표</h5>
                            <p class="text-muted small mb-0">다가오는 경기 일정을 확인하고 투표하세요.</p>
                        </div>
                    </div>

                    <div class="col-md-6">
                        <div class="modern-card dashboard-card p-4 h-100 d-flex flex-column align-items-center justify-content-center text-center bg-light"
                             onclick="location.href='${pageContext.request.contextPath}/myteam/squad?teamCode=${myTeam.team_code}'"
                             style="cursor: pointer;">
                            <div class="mb-3 p-3 rounded-circle bg-white shadow-sm">
                                <i class="bi bi-people-fill fs-2 text-success"></i>
                            </div>
                            <h5 class="fw-bold mb-1">구단 스쿼드 보기</h5>
                            <p class="text-muted small mb-0">팀원 정보를 확인하고 포지션을 관리하세요.</p>
                        </div>
                    </div>
                </div>

                <div class="mb-5">
                    <div class="d-flex align-items-center mb-3">
                        <h4 class="fw-bold fst-italic text-uppercase mb-0">Fixtures</h4> <div class="ms-3 border-bottom flex-grow-1"></div>
                    </div>

                    <div class="match-slider-container">
                        <button class="slider-nav-btn slider-prev" id="prevMatchBtn" disabled>
                            <i class="bi bi-chevron-left fs-5"></i>
                        </button>

                        <div class="match-slider-wrapper">
                            <div class="match-slider-track" id="matchTrack">
                                
                                <div class="match-slide-item">
                                    <div class="match-card bg-home">
                                        <span class="match-date-badge text-primary">Today • 19:00</span>
                                        <div class="match-teams">
                                            <div class="team-row text-primary"> <span class="team-logo-placeholder bg-dark"></span> FC 풋로그
                                            </div>
                                            <div class="team-row text-muted">
                                                <span class="team-logo-placeholder"></span> 맨체스터 시티
                                            </div>
                                        </div>
                                        <div class="match-footer" onclick="location.href='${pageContext.request.contextPath}/myteam/matchdetail'">
                                            <span>Match Center</span>
                                            <i class="bi bi-arrow-right"></i>
                                        </div>
                                    </div>
                                </div>
                                <div class="match-slide-item">
                                    <div class="match-card bg-away">
                                        <span class="match-date-badge">SAT 28 SEP • 20:00</span>
                                        <div class="match-teams">
                                            <div class="team-row">
                                                <span class="team-logo-placeholder"></span> 개발자 유나이티드
                                            </div>
                                            <div class="team-row">
                                                <span class="team-logo-placeholder bg-dark"></span> FC 풋로그
                                            </div>
                                        </div>
                                        <div class="match-footer">
                                            <span>Vote Now</span>
                                            <i class="bi bi-arrow-right"></i>
                                        </div>
                                    </div>
                                </div>
                                <div class="match-slide-item">
                                    <div class="match-card bg-home">
                                        <span class="match-date-badge">SUN 02 OCT • 08:00</span>
                                        <div class="match-teams">
                                            <div class="team-row">
                                                <span class="team-logo-placeholder bg-dark"></span> FC 풋로그
                                            </div>
                                            <div class="team-row">
                                                <span class="team-logo-placeholder"></span> 조기축구회
                                            </div>
                                        </div>
                                        <div class="match-footer">
                                            <span>Match Center</span>
                                            <i class="bi bi-arrow-right"></i>
                                        </div>
                                    </div>
                                </div>
                                <div class="match-slide-item">
                                    <div class="match-card bg-away">
                                        <span class="match-date-badge">SUN 09 OCT • 10:00</span>
                                        <div class="match-teams">
                                            <div class="team-row">
                                                <span class="team-logo-placeholder"></span> FC 서울팬
                                            </div>
                                            <div class="team-row">
                                                <span class="team-logo-placeholder bg-dark"></span> FC 풋로그
                                            </div>
                                        </div>
                                        <div class="match-footer">
                                            <span>Coming Soon</span>
                                            <i class="bi bi-arrow-right"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <button class="slider-nav-btn slider-next" id="nextMatchBtn">
                            <i class="bi bi-chevron-right fs-5"></i>
                        </button>
                    </div>
                </div>

                <div class="modern-card p-4 bg-white" style="min-height: 400px;">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h5 class="fw-bold"><i class="bi bi-card-text me-2"></i>팀 게시판 최근 글</h5>
                        <a href="${pageContext.request.contextPath}/myteam/board?teamCode=${myTeam.team_code}" class="text-muted small text-decoration-none">더보기 &rarr;</a>
                    </div>
                    
                    <table class="table table-hover align-middle">
                        <thead class="table-light">
                            <tr>
                                <th scope="col" class="text-center" style="width: 10%;">번호</th>
                                <th scope="col" style="width: 50%;">제목</th>
                                <th scope="col" class="text-center" style="width: 15%;">작성자</th>
                                <th scope="col" class="text-center" style="width: 15%;">날짜</th>
                                <th scope="col" class="text-center" style="width: 10%;">조회</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${not empty boardList}">
                                    <c:forEach var="dto" items="${boardList}">
                                        <tr class="board-row" style="cursor: pointer;" 
                                            onclick="location.href='${pageContext.request.contextPath}/myteam/board_article?board_team_code=${dto.board_team_code}&teamCode=${myTeam.team_code}&page=1'">
                                            
                                            <td class="text-center text-muted">
                                                <c:choose>
                                                    <c:when test="${dto.notice == 1}">
                                                        <span class="badge bg-danger rounded-pill">공지</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        ${dto.board_team_code}
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            
                                            <td class="fw-bold text-truncate" style="max-width: 200px;">
                                                ${dto.title}
                                                <c:if test="${dto.replyCount > 0}">
                                                    <span class="text-primary small fw-normal ms-1">[${dto.replyCount}]</span>
                                                </c:if>
                                            </td>
                                            
                                            <td class="text-center">${dto.member_name}</td>
                                            
                                            <td class="text-center text-muted small">${dto.created_at}</td>
                                            
                                            <td class="text-center text-muted small">${dto.view_count}</td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr>
                                        <td colspan="5" class="text-center py-5 text-muted">
                                            <i class="bi bi-clipboard-x fs-1 d-block mb-3 text-secondary"></i>
                                            등록된 게시글이 없습니다.
                                        </td>
                                    </tr>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>
                </div>

            </div>
        </div> 
    </div>

    <footer>
       <jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
    </footer>
    
    <jsp:include page="/WEB-INF/views/layout/footerResources.jsp"/>

    <script>
        const track = document.getElementById('matchTrack');
        const prevBtn = document.getElementById('prevMatchBtn');
        const nextBtn = document.getElementById('nextMatchBtn');
        
        let currentIndex = 0;
        const totalItems = 6; // 아이템 총 개수 (추후 동적으로 변경 필요)
        const itemsPerView = 3; // 한 화면에 보이는 개수 (반응형에 따라 조정 필요할 수 있음)
        
        function updateSlider() {
            // 33.333% 씩 이동
            const percentage = -(currentIndex * 33.333); 
            track.style.transform = `translateX(${percentage}%)`;
            
            // 버튼 상태 업데이트
            prevBtn.disabled = (currentIndex === 0);
            nextBtn.disabled = (currentIndex >= totalItems - itemsPerView);
        }

        if(nextBtn && prevBtn && track) {
            nextBtn.addEventListener('click', () => {
                if (currentIndex < totalItems - itemsPerView) {
                    currentIndex++;
                    updateSlider();
                }
            });

            prevBtn.addEventListener('click', () => {
                if (currentIndex > 0) {
                    currentIndex--;
                    updateSlider();
                }
            });
        }
    </script>

</body>
</html>