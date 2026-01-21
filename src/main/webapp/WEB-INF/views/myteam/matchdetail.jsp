<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Match Center - Footlog</title>
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

    <div class="match-hero">
        <div class="container position-relative">
            
            <div class="text-center mb-4">
                <span class="match-info-badge">Regular Season • Week 19</span>
                <h5 class="fw-light mb-0">Saturday 24 January 2026 • 20:00</h5>
            </div>

            <div class="match-score-board">
                <div class="text-center">
                    <img src="https://cdn-icons-png.flaticon.com/512/3232/3232822.png" class="team-logo-large mb-3" alt="home">
                    <h2 class="fw-bold mb-0">FC 풋로그</h2>
                </div>
                
                <div class="match-vs-text">VS</div>
                
                <div class="text-center">
                    <img src="https://cdn-icons-png.flaticon.com/512/1152/1152912.png" class="team-logo-large mb-3" alt="away">
                    <h2 class="fw-bold mb-0">개발자 UTD</h2>
                </div>
            </div>

            <div class="countdown-box d-none d-lg-block">
                <div class="small text-white-50 text-uppercase mb-1">Kick-off in</div>
                <div class="display-4 fw-bold text-white">16 <span class="fs-4 fw-normal">DAYS</span></div>
            </div>

        </div>
    </div>

    <div class="match-tabs shadow-sm">
        <div class="container d-flex justify-content-center">
            <button class="nav-custom-tab active" onclick="showTab('lineup')">Team Lineups</button>
            <button class="nav-custom-tab" onclick="showTab('info')">Match Info</button>
            <button class="nav-custom-tab" onclick="showTab('vote')">Vote</button>
        </div>
    </div>

    <div class="container py-5" style="min-height: 600px;">
        
        <div id="tab-lineup" class="tab-content-area">
            <h3 class="fw-bold text-center mb-5 fst-italic">STARTING XI</h3>
            
            <div class="row g-5">
                <div class="col-md-6 border-end">
                    <div class="d-flex align-items-center mb-4">
                        <img src="https://cdn-icons-png.flaticon.com/512/3232/3232822.png" width="40" class="me-3">
                        <h4 class="fw-bold mb-0">FC 풋로그</h4>
                    </div>

                    <div class="mb-4">
                        <h6 class="text-primary fw-bold small">GOALKEEPER</h6>
                        <div class="lineup-card">
                            <span class="player-number">1</span>
                            <img src="https://images.unsplash.com/photo-1633332755192-727a05c4013d?w=50" class="rounded-circle me-3" width="40" height="40">
                            <div>
                                <div class="fw-bold">조현우</div>
                            </div>
                        </div>
                    </div>

                    <div class="mb-4">
                        <h6 class="text-primary fw-bold small">DEFENDERS</h6>
                        <div class="lineup-card">
                            <span class="player-number">4</span>
                            <img src="https://images.unsplash.com/photo-1580489944761-15a19d654956?w=50" class="rounded-circle me-3" width="40" height="40">
                            <div><div class="fw-bold">김민재</div></div>
                        </div>
                        <div class="lineup-card">
                            <span class="player-number">2</span>
                            <img src="https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?w=50" class="rounded-circle me-3" width="40" height="40">
                            <div><div class="fw-bold">카일 워커</div></div>
                        </div>
                    </div>

                    <div class="mb-4">
                        <h6 class="text-primary fw-bold small">MIDFIELDERS</h6>
                        <div class="lineup-card">
                            <span class="player-number">7</span>
                            <img src="https://images.unsplash.com/photo-1599566150163-29194dcaad36?w=50" class="rounded-circle me-3" width="40" height="40">
                            <div>
                                <div class="fw-bold">박지성 <span class="badge bg-warning text-dark ms-1">C</span></div>
                            </div>
                        </div>
                        <div class="lineup-card">
                            <span class="player-number">10</span>
                            <img src="https://images.unsplash.com/photo-1527980965255-d3b416303d12?w=50" class="rounded-circle me-3" width="40" height="40">
                            <div><div class="fw-bold">이강인</div></div>
                        </div>
                    </div>
                </div>

                <div class="col-md-6">
                    <div class="d-flex align-items-center mb-4 justify-content-end">
                        <h4 class="fw-bold mb-0 text-end">개발자 UTD</h4>
                        <img src="https://cdn-icons-png.flaticon.com/512/1152/1152912.png" width="40" class="ms-3">
                    </div>

                    <div class="alert alert-light text-center py-5">
                        <i class="bi bi-lock-fill fs-1 text-muted mb-3 d-block"></i>
                        <h5 class="fw-bold text-muted">라인업 미공개</h5>
                        <p class="text-small text-muted mb-0">상대팀 라인업은 경기 1시간 전에 공개됩니다.</p>
                    </div>
                </div>
            </div>
        </div>

        <div id="tab-info" class="tab-content-area" style="display: none;">
            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <h3 class="fw-bold text-center mb-5 fst-italic">STADIUM INFO</h3>
                    
                    <div class="stadium-info-box mb-4">
                        <div class="row align-items-center">
                            <div class="col-md-6">
                                <img src="https://images.unsplash.com/photo-1522770179533-24471fcdba45?w=600" class="img-fluid rounded-3 shadow-sm mb-3 mb-md-0">
                            </div>
                            <div class="col-md-6 text-start ps-md-4">
                                <h6 class="text-primary fw-bold text-uppercase mb-2">Venue</h6>
                                <h3 class="fw-bold mb-2">서울 월드컵 경기장</h3>
                                <p class="text-muted mb-4"><i class="bi bi-geo-alt-fill me-2"></i>서울특별시 마포구 성산동 515</p>
                                
                                <div class="row g-3">
                                    <div class="col-6">
                                        <div class="border p-2 rounded text-center">
                                            <i class="bi bi-cloud-sun fs-4 text-secondary"></i>
                                            <div class="small mt-1">맑음 (24°C)</div>
                                        </div>
                                    </div>
                                    <div class="col-6">
                                        <div class="border p-2 rounded text-center">
                                            <i class="bi bi-droplet fs-4 text-primary"></i>
                                            <div class="small mt-1">습도 40%</div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="rounded-3 overflow-hidden shadow-sm">
                        <img src="https://images.unsplash.com/photo-1569336415962-a4bd9f69cd83?w=1000" class="w-100" style="height: 300px; object-fit: cover; opacity: 0.8;">
                    </div>
                </div>
            </div>
        </div>

        <div id="tab-vote" class="tab-content-area" style="display: none;">
            <div class="text-center py-5">
                <i class="bi bi-check-circle-fill fs-1 text-primary mb-3"></i>
                <h3 class="fw-bold">참석 여부를 알려주세요!</h3>
                <p class="text-muted mb-4">현재 <strong class="text-dark">12명</strong>의 팀원이 참석 예정입니다.</p>
                
                <div class="d-flex justify-content-center gap-3">
                    <button class="btn btn-dark btn-lg px-5 rounded-pill">참석</button>
                    <button class="btn btn-outline-danger btn-lg px-5 rounded-pill">불참</button>
                    <button class="btn btn-outline-secondary btn-lg px-5 rounded-pill">미정</button>
                </div>
            </div>
        </div>
    </div>

    <footer>
	   <jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
	</footer>
	
	<jsp:include page="/WEB-INF/views/layout/footerResources.jsp"/>

    <script>
        function showTab(tabName) {
            // 1. 모든 컨텐츠 숨기기
            document.querySelectorAll('.tab-content-area').forEach(el => el.style.display = 'none');
            
            // 2. 선택한 컨텐츠 보이기
            document.getElementById('tab-' + tabName).style.display = 'block';
            
            // 3. 버튼 활성화 스타일 변경
            document.querySelectorAll('.nav-custom-tab').forEach(btn => btn.classList.remove('active'));
            event.target.classList.add('active');
        }
    </script>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>