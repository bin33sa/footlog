<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>Footlog - Team Squad</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/style.css">
</head>
	<jsp:include page="/WEB-INF/views/layout/headerResources.jsp"/>
	
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
                            <a href="${pageContext.request.contextPath}/myteam/main" class="list-group-item list-group-item-action">구단 대시보드</a>
                            <a href="${pageContext.request.contextPath}/myteam/edit" class="list-group-item list-group-item-action">구단 정보 수정</a>
                            <a href="${pageContext.request.contextPath}/myteam/squad" class="list-group-item list-group-item-action active-menu">스쿼드(선수) 관리</a>
                            <a href="${pageContext.request.contextPath}/myteam/match" class="list-group-item list-group-item-action">매치 관리</a>
                            <a href="${pageContext.request.contextPath}/myteam/apply" class="list-group-item list-group-item-action">가입 신청 관리 <span class="badge bg-danger rounded-pill ms-1">2</span></a>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-lg-10 col-12">
                
                <div class="d-flex justify-content-between align-items-end mb-5">
                    <div>
                        <h2 class="fw-bold mb-1">스쿼드 관리</h2>
                        <span class="text-muted">FC 풋로그 선수 명단 (총 24명)</span>
                    </div>
                    <button class="btn btn-dark rounded-pill px-4 fw-bold" onclick="alert('초대 링크가 복사되었습니다!')">
                        <i class="bi bi-link-45deg me-1"></i> 팀원 초대하기
                    </button>
                </div>

                <div class="squad-tabs">
                    <a class="squad-tab-item active" onclick="filterSquad('all', this)">ALL</a>
                    <a class="squad-tab-item" onclick="filterSquad('coach', this)">STAFFS</a>
                    <a class="squad-tab-item" onclick="filterSquad('gk', this)">GOALKEEPERS</a>
                    <a class="squad-tab-item" onclick="filterSquad('df', this)">DEFENDERS</a>
                    <a class="squad-tab-item" onclick="filterSquad('mf', this)">MIDFIELDERS</a>
                    <a class="squad-tab-item" onclick="filterSquad('fw', this)">FORWARDS</a>
                </div>

                <div id="section-coach" class="squad-section">
                    <h4 class="fw-bold text-primary border-bottom pb-2 mb-4">운영진</h4>
                    <div class="row g-3 mb-5">
                        <div class="col-xl-3 col-lg-4 col-md-6">
                            <div class="modern-card player-card p-3 d-flex align-items-center gap-3 bg-light border-warning">
                                <div class="position-relative">
                                    <img src="https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?w=100" class="rounded-circle object-fit-cover" width="60" height="60" alt="profile">
                                    <span class="position-absolute bottom-0 end-0 badge rounded-pill bg-dark border border-white">C</span>
                                </div>
                                <div>
                                    <span class="badge bg-warning text-dark mb-1">구단주</span>
                                    <h6 class="fw-bold mb-0">박지성</h6>
                                </div>
                                <div class="ms-auto"><button class="btn btn-sm btn-icon"><i class="bi bi-gear-fill text-muted"></i></button></div>
                            </div>
                        </div>
                        <div class="col-xl-3 col-lg-4 col-md-6">
                            <div class="modern-card player-card p-3 d-flex align-items-center gap-3">
                                <img src="https://images.unsplash.com/photo-1599566150163-29194dcaad36?w=100" class="rounded-circle object-fit-cover" width="60" height="60" alt="profile">
                                <div>
                                    <span class="badge bg-secondary mb-1">매니저</span>
                                    <h6 class="fw-bold mb-0">이강인</h6>
                                </div>
                                <div class="ms-auto"><button class="btn btn-sm btn-icon"><i class="bi bi-three-dots-vertical text-muted"></i></button></div>
                            </div>
                        </div>
                    </div>
                </div>

                <div id="section-fw" class="squad-section">
                    <h4 class="fw-bold border-bottom pb-2 mb-4">FORWARDS</h4>
                    <div class="row g-3 mb-5">
                        <div class="col-xl-3 col-lg-4 col-md-6">
                            <div class="modern-card player-card p-3 text-center">
                                <div class="d-flex justify-content-between mb-2">
                                    <span class="badge badge-position pos-fw rounded-pill">FW</span>
                                    <span class="fw-bold text-muted fs-5">7</span>
                                </div>
                                <img src="https://images.unsplash.com/photo-1527980965255-d3b416303d12?w=150" class="rounded-circle object-fit-cover mb-3 shadow-sm" width="100" height="100" alt="profile">
                                <h5 class="fw-bold mb-1">손흥민</h5>
                                <p class="text-muted small mb-3">Left Winger</p>
                                <div class="bg-light rounded-3 p-2 d-flex justify-content-around">
                                    <div><small class="d-block text-muted">경기</small><b>12</b></div>
                                    <div><small class="d-block text-muted">골</small><b>8</b></div>
                                    <div><small class="d-block text-muted">어시</small><b>5</b></div>
                                </div>
                            </div>
                        </div>
                        <div class="col-xl-3 col-lg-4 col-md-6">
                            <div class="modern-card player-card p-3 text-center">
                                <div class="d-flex justify-content-between mb-2">
                                    <span class="badge badge-position pos-fw rounded-pill">FW</span>
                                    <span class="fw-bold text-muted fs-5">9</span>
                                </div>
                                <img src="https://images.unsplash.com/photo-1570295999919-56ceb5ecca61?w=150" class="rounded-circle object-fit-cover mb-3 shadow-sm" width="100" height="100" alt="profile">
                                <h5 class="fw-bold mb-1">홀란드</h5>
                                <p class="text-muted small mb-3">Striker</p>
                                <div class="bg-light rounded-3 p-2 d-flex justify-content-around">
                                    <div><small class="d-block text-muted">경기</small><b>10</b></div>
                                    <div><small class="d-block text-muted">골</small><b>15</b></div>
                                    <div><small class="d-block text-muted">어시</small><b>1</b></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div id="section-mf" class="squad-section">
                    <h4 class="fw-bold border-bottom pb-2 mb-4">MIDFIELDERS</h4>
                    <div class="row g-3 mb-5">
                        <div class="col-xl-3 col-lg-4 col-md-6">
                            <div class="modern-card player-card p-3 text-center">
                                <div class="d-flex justify-content-between mb-2">
                                    <span class="badge badge-position pos-mf rounded-pill">MF</span>
                                    <span class="fw-bold text-muted fs-5">6</span>
                                </div>
                                <div class="bg-light rounded-circle d-flex align-items-center justify-content-center mx-auto mb-3 shadow-sm" style="width: 100px; height: 100px;">
                                    <i class="bi bi-person-fill fs-1 text-secondary"></i>
                                </div>
                                <h5 class="fw-bold mb-1">황인범</h5>
                                <p class="text-muted small mb-3">Central Midfielder</p>
                                <div class="bg-light rounded-3 p-2 d-flex justify-content-around">
                                    <div><small class="d-block text-muted">경기</small><b>15</b></div>
                                    <div><small class="d-block text-muted">골</small><b>2</b></div>
                                    <div><small class="d-block text-muted">어시</small><b>8</b></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div id="section-df" class="squad-section">
                    <h4 class="fw-bold border-bottom pb-2 mb-4">DEFENDERS</h4>
                    <div class="row g-3 mb-5">
                        <div class="col-xl-3 col-lg-4 col-md-6">
                            <div class="modern-card player-card p-3 text-center">
                                <div class="d-flex justify-content-between mb-2">
                                    <span class="badge badge-position pos-df rounded-pill">DF</span>
                                    <span class="fw-bold text-muted fs-5">4</span>
                                </div>
                                <img src="https://images.unsplash.com/photo-1580489944761-15a19d654956?w=150" class="rounded-circle object-fit-cover mb-3 shadow-sm" width="100" height="100" alt="profile">
                                <h5 class="fw-bold mb-1">김민재</h5>
                                <p class="text-muted small mb-3">Center Back</p>
                                <div class="bg-light rounded-3 p-2 d-flex justify-content-around">
                                    <div><small class="d-block text-muted">경기</small><b>20</b></div>
                                    <div><small class="d-block text-muted">태클</small><b>45</b></div>
                                    <div><small class="d-block text-muted">클린</small><b>10</b></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div id="section-gk" class="squad-section">
                    <h4 class="fw-bold border-bottom pb-2 mb-4">GOALKEEPERS</h4>
                    <div class="row g-3 mb-5">
                        <div class="col-xl-3 col-lg-4 col-md-6">
                            <div class="modern-card player-card p-3 text-center">
                                <div class="d-flex justify-content-between mb-2">
                                    <span class="badge badge-position pos-gk rounded-pill">GK</span>
                                    <span class="fw-bold text-muted fs-5">1</span>
                                </div>
                                <img src="https://images.unsplash.com/photo-1633332755192-727a05c4013d?w=150" class="rounded-circle object-fit-cover mb-3 shadow-sm" width="100" height="100" alt="profile">
                                <h5 class="fw-bold mb-1">조현우</h5>
                                <p class="text-muted small mb-3">Goalkeeper</p>
                                <div class="bg-light rounded-3 p-2 d-flex justify-content-around">
                                    <div><small class="d-block text-muted">경기</small><b>15</b></div>
                                    <div><small class="d-block text-muted">선방</small><b>42</b></div>
                                    <div><small class="d-block text-muted">실점</small><b>10</b></div>
                                </div>
                            </div>
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

    <script>
        function filterSquad(position, element) {
            // 1. 모든 탭에서 active 제거 후 클릭한 탭에 추가
            document.querySelectorAll('.squad-tab-item').forEach(tab => tab.classList.remove('active'));
            element.classList.add('active');

            // 2. 모든 섹션 숨기기/보이기
            const sections = document.querySelectorAll('.squad-section');
            
            sections.forEach(sec => {
                if (position === 'all') {
                    // ALL이면 전부 보이기
                    sec.style.display = 'block';
                } else {
                    // 아니면 해당 ID만 보이기 (예: section-fw)
                    if (sec.id === 'section-' + position) {
                        sec.style.display = 'block';
                    } else {
                        sec.style.display = 'none';
                    }
                }
            });
        }
    </script>

</body>
</html>