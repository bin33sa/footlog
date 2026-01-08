<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>Footlog - Match List</title>
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
                        <p class="sidebar-title">매치</p>
                        <div class="list-group">
                            <a href="${pageContext.request.contextPath}/match/myMatch" class="list-group-item list-group-item-action ">내 매치 일정</a>
                            <a href="${pageContext.request.contextPath}/match/list" class="list-group-item list-group-item-action  active-menu">전체 매치 리스트</a>
                            <a href="${pageContext.request.contextPath}/match/write" class="list-group-item list-group-item-action ">매치 개설하기</a>
                            <a href="${pageContext.request.contextPath}/mercenary/list" class="list-group-item list-group-item-action ">용병 구하기</a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-8 col-12 ">

                <div class="modern-card p-4 d-flex justify-content-between align-items-center bg-dark text-white mb-4">
                    <div>
                        <h4 class="fw-bold mb-1">원하는 매치가 없나요?</h4>
                        <p class="text-white-50 mb-0 small">직접 매치를 개설하고 팀원을 모집해보세요.</p>
                    </div>
                    <button class="btn btn-primary rounded-pill px-4 fw-bold" onclick="location.href='${pageContext.request.contextPath}/match/write'">매치 개설하기 +</button>
                </div>

                <div class="d-flex flex-wrap gap-2 mb-4 justify-content-between align-items-center">
                    <div class="d-flex gap-2 flex-grow-1">
                        <input type="date" class="form-control rounded-pill border-0 shadow-sm" style="max-width: 160px;"> 
                        <select class="form-select rounded-pill border-0 shadow-sm" style="max-width: 120px;">
                            <option selected>지역 전체</option>
                            <option value="1">서울</option>
                            <option value="2">경기</option>
                            <option value="3">인천</option>
                        </select>
                        <div class="position-relative flex-grow-1">
                            <input type="text" class="form-control rounded-pill ps-5 border-0 shadow-sm" placeholder="구장명, 팀명 검색"> 
                            <i class="bi bi-search position-absolute top-50 start-0 translate-middle-y ms-3 text-muted"></i>
                        </div>
                    </div>

                    <div class="btn-group shadow-sm rounded-pill" role="group">
                        <input type="radio" class="btn-check" name="btnradio" id="btnradio1" autocomplete="off" checked> 
                        <label class="btn btn-outline-dark border-0 rounded-start-pill px-3" for="btnradio1">최신순</label>
                        <input type="radio" class="btn-check" name="btnradio" id="btnradio2" autocomplete="off"> 
                        <label class="btn btn-outline-dark border-0 rounded-end-pill px-3" for="btnradio2">임박순</label>
                    </div>
                </div>

                <div class="d-flex flex-column gap-3">
                    <div class="match-item modern-card p-3 mb-0 d-flex align-items-center gap-4" onclick="location.href='${pageContext.request.contextPath}/match/article'">
                        <div class="match-time-box text-center rounded-3 p-2 bg-light">
                            <span class="d-block small text-muted">9.20(토)</span> 
                            <span class="d-block fw-bold fs-5">18:00</span>
                        </div>
                        <div class="flex-grow-1">
                            <div class="d-flex align-items-center gap-2 mb-1">
                                <span class="badge bg-primary text-dark rounded-pill">모집중</span>
                                <span class="badge bg-light text-secondary border">6 vs 6</span> 
                                <span class="badge bg-light text-secondary border">남성</span>
                            </div>
                            <h5 class="fw-bold mb-1">상암 월드컵 보조경기장 3파전</h5>
                            <p class="text-muted small mb-0">
                                <i class="bi bi-geo-alt-fill me-1"></i>서울 마포구 | 호스트: 슛돌이주장
                            </p>
                        </div>
                        <div class="text-end d-none d-md-block">
                            <span class="d-block fw-bold text-primary mb-1">10,000원</span>
                            <button class="btn btn-sm btn-outline-dark rounded-pill px-3">신청가능</button>
                        </div>
                    </div>

                    <div class="match-item modern-card p-3 mb-0 d-flex align-items-center gap-4" onclick="location.href='match/detail'">
                        <div class="match-time-box text-center rounded-3 p-2 bg-light">
                            <span class="d-block small text-muted">9.20(토)</span> <span class="d-block fw-bold fs-5">20:00</span>
                        </div>
                        <div class="flex-grow-1">
                            <div class="d-flex align-items-center gap-2 mb-1">
                                <span class="badge bg-danger text-white rounded-pill">마감임박</span>
                                <span class="badge bg-light text-secondary border">5 vs 5</span>
                                <span class="badge bg-light text-secondary border">남녀무관</span>
                            </div>
                            <h5 class="fw-bold mb-1">용산 아이파크몰 풋살장</h5>
                            <p class="text-muted small mb-0">
                                <i class="bi bi-geo-alt-fill me-1"></i>서울 용산구 | 호스트: 메시
                            </p>
                        </div>
                        <div class="text-end d-none d-md-block">
                            <span class="d-block fw-bold text-dark mb-1">12,000원</span>
                            <button class="btn btn-sm btn-dark rounded-pill px-3">신청하기</button>
                        </div>
                    </div>

                    <div class="match-item modern-card p-3 mb-0 d-flex align-items-center gap-4 opacity-75" style="background-color: #f9f9f9;">
                        <div class="match-time-box text-center rounded-3 p-2">
                            <span class="d-block small text-muted">9.19(금)</span> <span class="d-block fw-bold fs-5 text-decoration-line-through">19:00</span>
                        </div>
                        <div class="flex-grow-1">
                            <div class="d-flex align-items-center gap-2 mb-1">
                                <span class="badge bg-secondary text-white rounded-pill">마감</span>
                                <span class="badge bg-light text-secondary border">6 vs 6</span>
                            </div>
                            <h5 class="fw-bold mb-1 text-muted">잠실 유수지 풋살장 매치</h5>
                            <p class="text-muted small mb-0">서울 송파구</p>
                        </div>
                        <div class="text-end d-none d-md-block">
                            <button class="btn btn-sm btn-secondary rounded-pill px-3" disabled>마감됨</button>
                        </div>
                    </div>

                    <div class="match-item modern-card p-3 mb-0 d-flex align-items-center gap-4" onclick="location.href='match/detail'">
                        <div class="match-time-box text-center rounded-3 p-2 bg-light">
                            <span class="d-block small text-muted">9.21(일)</span> <span class="d-block fw-bold fs-5">10:00</span>
                        </div>
                        <div class="flex-grow-1">
                            <div class="d-flex align-items-center gap-2 mb-1">
                                <span class="badge bg-primary text-dark rounded-pill">모집중</span>
                                <span class="badge bg-light text-secondary border">6 vs 6</span>
                            </div>
                            <h5 class="fw-bold mb-1">고양 백석 구장 오전 운동</h5>
                            <p class="text-muted small mb-0">경기 고양시</p>
                        </div>
                        <div class="text-end d-none d-md-block">
                            <span class="d-block fw-bold text-primary mb-1">5,000원</span>
                            <button class="btn btn-sm btn-outline-dark rounded-pill px-3">신청가능</button>
                        </div>
                    </div>
                </div>

                <nav class="mt-5" aria-label="Page navigation">
                    <ul class="pagination justify-content-center">
                        <li class="page-item disabled"><a class="page-link border-0 rounded-circle mx-1 text-dark" href="#" tabindex="-1">&lt;</a></li>
                        <li class="page-item"><a class="page-link border-0 rounded-circle mx-1 bg-dark text-primary fw-bold" href="#">1</a></li>
                        <li class="page-item"><a class="page-link border-0 rounded-circle mx-1 text-dark" href="#">2</a></li>
                        <li class="page-item"><a class="page-link border-0 rounded-circle mx-1 text-dark" href="#">3</a></li>
                        <li class="page-item"><a class="page-link border-0 rounded-circle mx-1 text-dark" href="#">&gt;</a></li>
                    </ul>
                </nav>

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