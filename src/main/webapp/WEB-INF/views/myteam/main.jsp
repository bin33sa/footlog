<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>Footlog - My Team Dashboard</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/style.css?ver=2">

</head>
	<jsp:include page="/WEB-INF/views/layout/headerResources.jsp"/>
<body>

   <header>
	   <jsp:include page="/WEB-INF/views/layout/teamheader.jsp"/>
	</header>


    <div class="container-fluid px-lg-5 mt-4">
        <div class="row">

            <div class="col-lg-8 col-12 offset-lg-2">
                
                <div class="modern-card p-0 mb-4 bg-dark text-white overflow-hidden position-relative">
                    <div class="d-flex align-items-center justify-content-between p-4">
                        <button class="btn btn-icon text-white-50 hover-white"><i class="bi bi-chevron-left fs-4"></i></button>
                        <div class="d-flex align-items-center gap-3">
                            <div class="bg-white rounded-circle d-flex align-items-center justify-content-center text-dark overflow-hidden" style="width: 50px; height: 50px;">
							    <c:choose>						    
							        <c:when test="${not empty myTeam.emblem_image}">
							            <img src="${pageContext.request.contextPath}/uploads/team/${emblem_image}" 
							                 alt="Team Emblem" 
							                 style="width: 100%; height: 100%; object-fit: cover;">
							        </c:when>
							        <c:otherwise>
							            <i class="bi bi-shield-fill fs-3"></i>
							        </c:otherwise>
							    </c:choose>
							</div>
                            <div>
                                <span class="badge bg-primary text-dark mb-1">MY TEAM</span>
                                <h4 class="fw-bold mb-0">${myTeamName}</h4>
                            </div>
                        </div>
                        <button class="btn btn-icon text-white-50 hover-white"><i class="bi bi-chevron-right fs-4"></i></button>
                    </div>
                </div>

                <div class="row g-4 mb-5">
                    <div class="col-md-6">
                        <div class="modern-card dashboard-card p-4 h-100 d-flex flex-column align-items-center justify-content-center text-center bg-light"
                             onclick="location.href='${pageContext.request.contextPath}/myteam/match'"> <div class="mb-3 p-3 rounded-circle bg-white shadow-sm">
                                <i class="bi bi-calendar-check-fill fs-2 text-primary"></i>
                            </div>
                            <h5 class="fw-bold mb-1">매치 일정 / 투표</h5>
                            <p class="text-muted small mb-0">다가오는 경기 일정을 확인하고 투표하세요.</p>
                        </div>
                    </div>

                    <div class="col-md-6">
                        <div class="modern-card dashboard-card p-4 h-100 d-flex flex-column align-items-center justify-content-center text-center bg-light"
                             onclick="location.href='${pageContext.request.contextPath}/myteam/squad'">
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

                                <div class="match-slide-item">
                                    <div class="match-card bg-home">
                                        <span class="match-date-badge">SAT 15 OCT • 18:00</span>
                                        <div class="match-teams">
                                            <div class="team-row">
                                                <span class="team-logo-placeholder bg-dark"></span> FC 풋로그
                                            </div>
                                            <div class="team-row">
                                                <span class="team-logo-placeholder"></span> 마포 호랑이
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
                                        <span class="match-date-badge">SAT 22 OCT • 14:00</span>
                                        <div class="match-teams">
                                            <div class="team-row">
                                                <span class="team-logo-placeholder"></span> 레알 마드리드
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
                        <a href="#" class="text-muted small text-decoration-none">더보기 &rarr;</a>
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
                            <tr style="cursor: pointer;" onclick="location.href='#'">
                                <td class="text-center text-muted">5</td>
                                <td class="fw-bold text-truncate" style="max-width: 200px;">
                                    <span class="badge bg-danger rounded-pill me-1">공지</span> 이번 주 회식 장소 투표해주세요!
                                </td>
                                <td class="text-center">주장</td>
                                <td class="text-center text-muted small">09.20</td>
                                <td class="text-center text-muted small">42</td>
                            </tr>
                            <tr style="cursor: pointer;" onclick="location.href='#'">
                                <td class="text-center text-muted">4</td>
                                <td>다음 주 유니폼 챙겨오세요</td>
                                <td class="text-center">총무</td>
                                <td class="text-center text-muted small">09.19</td>
                                <td class="text-center text-muted small">35</td>
                            </tr>
                            <tr style="cursor: pointer;" onclick="location.href='#'">
                                <td class="text-center text-muted">3</td>
                                <td>전술 공유합니다 (영상 첨부)</td>
                                <td class="text-center">전술코치</td>
                                <td class="text-center text-muted small">09.18</td>
                                <td class="text-center text-muted small">28</td>
                            </tr>
                            <tr>
                                <td colspan="5" class="text-center py-5 text-muted">
                                    등록된 게시글이 없습니다.
                                </td>
                            </tr>
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

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

    <script>
        const track = document.getElementById('matchTrack');
        const prevBtn = document.getElementById('prevMatchBtn');
        const nextBtn = document.getElementById('nextMatchBtn');
        
        let currentIndex = 0;
        const totalItems = 6; // 아이템 총 개수
        const itemsPerView = 3; // 한 화면에 보이는 개수
        
        function updateSlider() {
            // 33.333% 씩 이동
            const percentage = -(currentIndex * 33.333); 
            track.style.transform = `translateX(${percentage}%)`;
            
            // 버튼 상태 업데이트
            prevBtn.disabled = (currentIndex === 0);
            nextBtn.disabled = (currentIndex >= totalItems - itemsPerView);
        }

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
    </script>

</body>
</html>