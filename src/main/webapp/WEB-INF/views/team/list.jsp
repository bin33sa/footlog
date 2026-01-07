<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>Footlog - Find Your Team</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@9/swiper-bundle.min.css" />
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
                            <a href="${pageContext.request.contextPath}/team/list" class="list-group-item list-group-item-action active-menu">전체 구단 리스트</a>
                            <a href="${pageContext.request.contextPath}/team/write" class="list-group-item list-group-item-action">구단 생성하기</a>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-lg-8 col-12">
                
                <div class="modern-card p-4 mb-4">
                    <div class="d-flex justify-content-between align-items-center">
                        <div class="d-flex align-items-center gap-3">
                            <div class="bg-light rounded-circle d-flex align-items-center justify-content-center" style="width: 50px; height: 50px;">
                                <i class="bi bi-shield-shaded fs-3 text-secondary"></i>
                            </div>
                            <div>
                                <h6 class="text-muted small mb-0">MY TEAM</h6>
                                <h5 class="fw-bold mb-0">가입된 구단이 없습니다.</h5>
                            </div>
                        </div>
                        <button class="btn btn-outline-dark rounded-pill btn-sm px-3" onclick="location.href='${pageContext.request.contextPath}/team/list'">구단 생성 / 가입 &rarr;</button>
                    </div>
                </div>

                <div class="d-flex flex-column flex-md-row justify-content-between align-items-center mb-4 gap-3">
                    <div class="search-bar-wrapper w-100">
                        <i class="bi bi-search position-absolute ms-3 text-muted"></i>
                        <input type="text" class="form-control rounded-pill ps-5 py-2 border-0 shadow-sm" placeholder="구단명, 지역으로 검색해보세요">
                    </div>
                    
                    <div class="d-flex gap-2 w-100 w-md-auto justify-content-end">
                        <select class="form-select rounded-pill border-0 shadow-sm" style="width: 120px;">
                            <option selected>최신순</option>
                            <option value="1">인원 많은순</option>
                            <option value="2">매너 점수순</option>
                        </select>
                        <button class="btn btn-primary rounded-pill px-4 text-nowrap" onclick="location.href='${pageContext.request.contextPath}/team/write'">
                            <i class="bi bi-plus-lg me-1" ></i> 구단 생성
                        </button>
                    </div>
                </div>

                <div class="row g-4">
                    
                    <div class="col-md-6" onclick="location.href='${pageContext.request.contextPath}/team/team'">
                        <div class="modern-card team-card p-0 h-100">
                            <div class="team-img-wrapper">
                                <img src="https://images.unsplash.com/photo-1522770179533-24471fcdba45?w=500&auto=format&fit=crop&q=60" alt="team">
                                <span class="badge bg-primary text-dark position-absolute top-0 end-0 m-3">모집중</span>
                            </div>
                            <div class="p-4">
                                <div class="d-flex justify-content-between align-items-start mb-2">
                                    <h4 class="fw-bold mb-0">FC 썬더볼트</h4>
                                    <span class="text-warning"><i class="bi bi-star-fill"></i> 4.8</span>
                                </div>
                                <p class="text-muted small mb-3">서울 마포구 | 20대~30대 | 실력 중</p>
                                <div class="d-flex justify-content-between align-items-center">
                                    <div class="team-members">
                                        <i class="bi bi-people-fill me-1"></i> 24/30명
                                    </div>
                                    <button class="btn btn-sm btn-dark rounded-pill px-3">상세보기</button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-6">
                        <div class="modern-card team-card p-0 h-100">
                            <div class="team-img-wrapper">
                                <img src="https://images.unsplash.com/photo-1579952363873-27f3bade9f55?w=500&auto=format&fit=crop&q=60" alt="team">
                            </div>
                            <div class="p-4">
                                <div class="d-flex justify-content-between align-items-start mb-2">
                                    <h4 class="fw-bold mb-0">레알 마드리드 조기축구</h4>
                                    <span class="text-warning"><i class="bi bi-star-fill"></i> 4.5</span>
                                </div>
                                <p class="text-muted small mb-3">경기 수원시 | 연령 무관 | 즐겜러 환영</p>
                                <div class="d-flex justify-content-between align-items-center">
                                    <div class="team-members">
                                        <i class="bi bi-people-fill me-1"></i> 15/50명
                                    </div>
                                    <button class="btn btn-sm btn-dark rounded-pill px-3">상세보기</button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-6">
                        <div class="modern-card team-card p-0 h-100">
                            <div class="team-img-wrapper">
                                <img src="https://images.unsplash.com/photo-1517466787929-bc90951d0974?w=500&auto=format&fit=crop&q=60" alt="team">
                                <span class="badge bg-primary text-dark position-absolute top-0 end-0 m-3">모집중</span>
                            </div>
                            <div class="p-4">
                                <div class="d-flex justify-content-between align-items-start mb-2">
                                    <h4 class="fw-bold mb-0">개발자 FC</h4>
                                    <span class="text-warning"><i class="bi bi-star-fill"></i> 5.0</span>
                                </div>
                                <p class="text-muted small mb-3">판교 | 개발자만 가입 가능 | 디버깅 금지</p>
                                <div class="d-flex justify-content-between align-items-center">
                                    <div class="team-members">
                                        <i class="bi bi-people-fill me-1"></i> 10/11명
                                    </div>
                                    <button class="btn btn-sm btn-dark rounded-pill px-3">상세보기</button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-6">
                        <div class="modern-card team-card p-0 h-100">
                            <div class="team-img-wrapper">
                                <img src="https://images.unsplash.com/photo-1431324155629-1a6deb1dec8d?w=500&auto=format&fit=crop&q=60" alt="team">
                            </div>
                            <div class="p-4">
                                <div class="d-flex justify-content-between align-items-start mb-2">
                                    <h4 class="fw-bold mb-0">새벽반 유나이티드</h4>
                                    <span class="text-warning"><i class="bi bi-star-fill"></i> 4.2</span>
                                </div>
                                <p class="text-muted small mb-3">부산 해운대구 | 새벽 5시 킥오프</p>
                                <div class="d-flex justify-content-between align-items-center">
                                    <div class="team-members">
                                        <i class="bi bi-people-fill me-1"></i> 22/30명
                                    </div>
                                    <button class="btn btn-sm btn-dark rounded-pill px-3">상세보기</button>
                                </div>
                            </div>
                        </div>
                    </div>

                </div> <div class="text-center mt-5 mb-5">
                    <button class="btn btn-light rounded-pill px-5 py-2 shadow-sm text-muted fw-bold hover-scale">
                        더보기 <i class="bi bi-chevron-down ms-1"></i>
                    </button>
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