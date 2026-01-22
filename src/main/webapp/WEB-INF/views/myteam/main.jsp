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
        .board-row:hover { background-color: #f8f9fa; }
        .match-card {
            cursor: pointer; transition: transform 0.2s; min-height: 240px;
            display: flex; flex-direction: column; justify-content: space-between;
        }
        .match-card:hover { transform: translateY(-5px); }
        
        /* 팀명 및 엠블럼 배치: 팀명(vs...) 뒤에 엠블럼 배치 */
        .team-row { display: flex; align-items: center; white-space: nowrap; gap: 8px; }
        .opponent-emblem { flex-shrink: 0; border: 1px solid #eee; }
        
        .progress-container { margin-top: 15px; }
        .progress { background-color: rgba(0,0,0,0.08); border-radius: 10px; height: 6px; }
        .progress-bar { background-color: #D4F63F !important; border-radius: 10px; }
        
        .match-date-badge { color: #666; font-size: 0.8rem; font-weight: 600; }
        .match-status-text { font-size: 0.8rem; font-weight: 700; }
        
        /* 대시보드 퀵링크 카드 스타일 */
        .dashboard-card { transition: all 0.3s ease; border: 1px solid #eee; }
        .dashboard-card:hover { border-color: #D4F63F; box-shadow: 0 10px 20px rgba(0,0,0,0.05); }
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
                                <button class="btn btn-icon text-white-50 hover-white" onclick="location.href='${pageContext.request.contextPath}/myteam/main?teamCode=${prevTeamCode}'"><i class="bi bi-chevron-left fs-4"></i></button>
                            </c:when>
                            <c:otherwise>
                                <button class="btn btn-icon text-white-50" style="visibility: hidden;"><i class="bi bi-chevron-left fs-4"></i></button>
                            </c:otherwise>
                        </c:choose>
                        <div class="d-flex align-items-center gap-3">
                            <div class="bg-white rounded-circle overflow-hidden" style="width: 50px; height: 50px;">
                                <img src="${pageContext.request.contextPath}/uploads/team/${myTeam.emblem_image}" style="width: 100%; height: 100%; object-fit: cover;" onerror="this.src='${pageContext.request.contextPath}/dist/images/icon.jpg'">
                            </div>
                            <div>
                                <span class="badge bg-primary text-dark mb-1">MY TEAM</span>
                                <h4 class="fw-bold mb-0">${myTeamName}</h4>
                            </div>
                        </div>
                        <c:choose>
                            <c:when test="${myTeamsCount > 1}">
                                <button class="btn btn-icon text-white-50 hover-white" onclick="location.href='${pageContext.request.contextPath}/myteam/main?teamCode=${nextTeamCode}'"><i class="bi bi-chevron-right fs-4"></i></button>
                            </c:when>
                            <c:otherwise>
                                <button class="btn btn-icon text-white-50" style="visibility: hidden;"><i class="bi bi-chevron-right fs-4"></i></button>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <div class="row g-4 mb-5">
                    <div class="col-md-6">
                        <div class="modern-card dashboard-card p-4 h-100 d-flex flex-column align-items-center justify-content-center text-center bg-white"
                             onclick="location.href='${pageContext.request.contextPath}/myteam/match?teamCode=${myTeam.team_code}'"
                             style="cursor: pointer; border-radius: 20px;"> 
                            <div class="mb-3 p-3 rounded-circle bg-light">
                                <i class="bi bi-calendar-check-fill fs-2 text-primary"></i>
                            </div>
                            <h5 class="fw-bold mb-1">매치 일정 / 투표</h5>
                            <p class="text-muted small mb-0">다가오는 경기 일정을 확인하고 투표하세요.</p>
                        </div>
                    </div>

                    <div class="col-md-6">
                        <div class="modern-card dashboard-card p-4 h-100 d-flex flex-column align-items-center justify-content-center text-center bg-white"
                             onclick="location.href='${pageContext.request.contextPath}/myteam/squad?teamCode=${myTeam.team_code}'"
                             style="cursor: pointer; border-radius: 20px;">
                            <div class="mb-3 p-3 rounded-circle bg-light">
                                <i class="bi bi-people-fill fs-2 text-success"></i>
                            </div>
                            <h5 class="fw-bold mb-1">구단 스쿼드 보기</h5>
                            <p class="text-muted small mb-0">팀원 정보를 확인하고 포지션을 관리하세요.</p>
                        </div>
                    </div>
                </div>

                <div class="mb-5">
                    <div class="d-flex align-items-center mb-3">
                        <h4 class="fw-bold fst-italic text-uppercase mb-0">Fixtures</h4> 
                        <div class="ms-3 border-bottom flex-grow-1"></div>
                    </div>

                    <div class="match-slider-container">
                        <button class="slider-nav-btn slider-prev" id="prevMatchBtn" disabled><i class="bi bi-chevron-left fs-5"></i></button>

                        <div class="match-slider-wrapper">
                            <div class="match-slider-track" id="matchTrack">
                                <c:choose>
                                    <c:when test="${not empty matchList}">
                                        <c:forEach var="match" items="${matchList}">
                                            <div class="match-slide-item">
                                                <c:set var="cardClass" value="${match.home_code == teamCode ? 'bg-home' : 'bg-away'}" />
                                                <div class="match-card ${cardClass}" onclick="location.href='${pageContext.request.contextPath}/myteam/attendance?teamCode=${teamCode}&matchCode=${match.match_code}'">
                                                    
                                                    <div class="d-flex justify-content-between align-items-center">
                                                        <span class="match-date-badge">${match.match_date}</span>
                                                        <span class="match-status-text text-primary">${match.status}</span>
                                                    </div>

                                                    <div class="match-teams mt-2">
                                                        <div class="team-row text-dark fw-bold">
                                                            <span>vs ${match.opponent_name} (${match.home_away_side})</span>
                                                            <img src="${pageContext.request.contextPath}/uploads/${match.opponent_emblem}" 
                                                                 class="rounded-circle opponent-emblem" width="22" height="22"
                                                                 onerror="this.src='${pageContext.request.contextPath}/dist/images/icon.jpg'">
                                                        </div>
                                                        <div class="team-row text-muted small mt-1">
                                                            <i class="bi bi-geo-alt-fill me-1"></i>${match.stadiumName}
                                                        </div>
                                                    </div>
                                                    
                                                    <div class="progress-container">
                                                        <div class="d-flex justify-content-between small mb-1">
                                                            <span class="fw-bold" style="font-size: 0.7rem; color: #777;">ATTENDANCE</span>
                                                            <span>
                                                                <%
                                                                    com.fl.model.MatchDTO m = (com.fl.model.MatchDTO)pageContext.getAttribute("match");
                                                                    int max = 11; 
                                                                    try {
                                                                        String mt = m.getMatchType();
                                                                        if(mt != null && mt.contains("vs")) {
                                                                            max = Integer.parseInt(mt.substring(0, mt.indexOf("vs")).trim());
                                                                        }
                                                                    } catch(Exception e) { max = 11; }
                                                                    pageContext.setAttribute("maxLimit", max);
                                                                %>
                                                                <b class="text-dark">${match.attend_count}</b> / ${maxLimit}
                                                            </span>
                                                        </div>
                                                        <div class="progress">
                                                            <c:set var="percent" value="${maxLimit > 0 ? (match.attend_count / maxLimit) * 100 : 0}" />
                                                            <div class="progress-bar" style="width: ${percent > 100 ? 100 : percent}%"></div>
                                                        </div>
                                                    </div>
                                                    
                                                    <div class="match-footer mt-auto pt-2 border-top">
                                                        <span class="small fw-bold">
                                                            <c:choose>
                                                                <c:when test="${not empty match.my_attendance_status}">
                                                                    <i class="bi bi-check-circle-fill text-success"></i> ${match.my_attendance_status}
                                                                </c:when>
                                                                <c:otherwise>Vote Now</c:otherwise>
                                                            </c:choose>
                                                        </span>
                                                        <i class="bi bi-arrow-right"></i>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="match-slide-item" style="width: 100%;">
                                            <div class="match-card bg-light d-flex align-items-center justify-content-center"><p class="text-muted mb-0">예정된 일정이 없습니다.</p></div>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                        <button class="slider-nav-btn slider-next" id="nextMatchBtn"><i class="bi bi-chevron-right fs-5"></i></button>
                    </div>
                </div>

                <div class="modern-card p-4 bg-white shadow-sm" style="min-height: 400px; border-radius: 15px;">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h5 class="fw-bold"><i class="bi bi-card-text me-2"></i>팀 게시판 최근 글</h5>
                        <a href="${pageContext.request.contextPath}/myteam/board?teamCode=${myTeam.team_code}" class="text-muted small text-decoration-none">더보기 &rarr;</a>
                    </div>
                    <table class="table table-hover align-middle">
                        <thead class="table-light"><tr><th class="text-center" style="width: 10%;">번호</th><th style="width: 50%;">제목</th><th class="text-center" style="width: 15%;">작성자</th><th class="text-center" style="width: 15%;">날짜</th><th class="text-center" style="width: 10%;">조회</th></tr></thead>
                        <tbody>
                            <c:forEach var="dto" items="${boardList}">
                                <tr class="board-row" style="cursor: pointer;" onclick="location.href='${pageContext.request.contextPath}/myteam/board_article?board_team_code=${dto.board_team_code}&teamCode=${myTeam.team_code}&page=1'">
                                    <td class="text-center"><c:choose><c:when test="${dto.notice == 1}"><span class="badge bg-danger">공지</span></c:when><c:otherwise>${dto.board_team_code}</c:otherwise></c:choose></td>
                                    <td class="fw-bold">${dto.title} <c:if test="${dto.replyCount > 0}"><span class="text-primary small">[${dto.replyCount}]</span></c:if></td>
                                    <td class="text-center">${dto.member_name}</td><td class="text-center text-muted small">${dto.created_at}</td><td class="text-center text-muted small">${dto.view_count}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>

            </div>
        </div> 
    </div>

    <footer><jsp:include page="/WEB-INF/views/layout/footer.jsp"/></footer>
    <jsp:include page="/WEB-INF/views/layout/footerResources.jsp"/>

    <script>
        const track = document.getElementById('matchTrack');
        const prevBtn = document.getElementById('prevMatchBtn');
        const nextBtn = document.getElementById('nextMatchBtn');
        let currentIndex = 0;
        const totalItems = ${not empty matchList ? matchList.size() : 0}; 
        const itemsPerView = 3;
        function updateSlider() {
            if (totalItems <= itemsPerView) return;
            const percentage = -(currentIndex * (100 / itemsPerView)); 
            track.style.transform = `translateX(\${percentage}%)`;
            prevBtn.disabled = (currentIndex === 0);
            nextBtn.disabled = (currentIndex >= totalItems - itemsPerView);
        }
        if(nextBtn && prevBtn && track) {
            updateSlider();
            nextBtn.addEventListener('click', () => { if (currentIndex < totalItems - itemsPerView) { currentIndex++; updateSlider(); } });
            prevBtn.addEventListener('click', () => { if (currentIndex > 0) { currentIndex--; updateSlider(); } });
        }
    </script>
</body>
</html>