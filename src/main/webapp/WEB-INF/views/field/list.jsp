<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>Footlog - Stadium Booking</title>
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
                        <p class="sidebar-title">구장</p>
                        <div class="list-group">
                            <a href="${pageContext.request.contextPath}/field/list" class="list-group-item list-group-item-action active-menu">구장 검색 / 예약</a>
                            
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
                        <input type="text" class="form-control rounded-pill ps-5 py-2 border-0 shadow-sm" placeholder="지역명, 구장명으로 검색">
                    </div>
                    
                    <div class="d-flex gap-2 w-100 w-md-auto justify-content-end">
                        <select class="form-select rounded-pill border-0 shadow-sm" style="width: 140px;">
                            <option selected>거리순</option>
                            <option value="1">가격 낮은순</option>
                            <option value="2">평점 높은순</option>
                        </select>
                    </div>
                </div>




                <div class="row g-4">
                    
                  <c:forEach var="dto" items = "${list}">
                  
                    <div class="col-md-6" onclick="location.href='${pageContext.request.contextPath}/field/view'">
                        <div class="modern-card stadium-card p-0 h-100">
                            <div class="stadium-img-wrapper position-relative">
                                <img src="https://images.unsplash.com/photo-1529900748604-07564a03e7a6?w=500&auto=format&fit=crop&q=60" alt="stadium">
                                <span class="badge bg-dark text-primary position-absolute top-0 end-0 m-3">예약가능</span>
                            </div>
                            <div class="p-4">
                                <div class="d-flex justify-content-between align-items-start mb-1">
                                    <h5 class="fw-bold mb-0">${dto.stadiumName}</h5>
                                    <span class="text-warning fw-bold"><i class="bi bi-star-fill"></i> 4.9</span>
                                </div>
                                <p class="text-muted small mb-3">서울 마포구 성산동</p>
                                
                                <div class="d-flex gap-2 mb-3">
                                    <span class="badge bg-light text-secondary border"><i class="bi bi-p-square-fill me-1"></i>주차가능</span>
                                    <span class="badge bg-light text-secondary border"><i class="bi bi-droplet-fill me-1"></i>샤워가능</span>
                                </div>

                                <div class="d-flex justify-content-between align-items-end border-top pt-3">
                                    <div>
                                        <span class="text-muted small">시간당</span>
                                        <h5 class="fw-bold mb-0">80,000원</h5>
                                    </div>
                                    <button class="btn btn-sm btn-primary rounded-pill px-4">예약하기</button>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    </c:forEach>
                    





                </div> 
                
                
                
                <div class="text-center mt-5 mb-5">
                    <button class="btn btn-light rounded-pill px-5 py-3 shadow-sm text-muted fw-bold hover-scale w-50">
                        더 많은 구장 보기 <i class="bi bi-arrow-down-circle ms-2"></i>
                    </button>
                </div>

            </div>

            <div class="col-lg-2 d-none d-lg-block">
                <div class="sidebar-menu sticky-top" style="top: 100px;">
                    <div class="mb-4">
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