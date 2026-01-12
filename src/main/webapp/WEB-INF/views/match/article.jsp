<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>Footlog - Match Detail</title>
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
          
            <div class="col-lg-8 col-12">
                
                <div class="d-flex align-items-center justify-content-between mb-4">
                    <div>
                        <span class="badge bg-primary text-dark rounded-pill mb-2 px-3 py-2">${dto.status}</span> 
                        <h2 class="fw-bold mb-1">${dto.title}</h2>
                        <div class="d-flex align-items-center text-muted gap-2">
                            <span><i class="bi bi-eye me-1"></i> 124</span>
                            <span>•</span>
                            <span>주최팀: ${dto.home_team_name}</span>
                        </div>
                    </div>
                    <button class="btn btn-light rounded-circle"><i class="bi bi-share"></i></button>
                </div>

                <div class="modern-card p-4 mb-4">
                    <table class="table table-borderless match-info-table mb-0">
                        <tbody>
                            <tr>
                                <td class="text-muted" style="width: 100px;">일시</td>
                                <td class="fw-bold fs-5">${dto.match_date }</td>
                            </tr>
                            <tr>
                                <td class="text-muted">구장</td>
                                <td class="fw-bold">${dto.stadium_name } <a href="#" class="text-primary small ms-2 text-decoration-underline">지도보기</a></td>
                            </tr>
                            <tr>
                                <td class="text-muted">진행방식</td>
                                <td class="fw-bold">${dto.matchType }(3파전)</td>
                            </tr>
                            <tr>
                                <td class="text-muted">참가비</td>
                                <td class="fw-bold text-primary">${dto.fee}원</td>
                            </tr>
                            <tr>
                                <td class="text-muted">실력/성별</td>
                                <td class="fw-bold">중하(세미프로 금지) / ${dto.gender }</td>
                            </tr>
                        </tbody>
                    </table>
                </div>

                <div class="modern-card p-5" style="min-height: 300px;">
                    
                    <h5 class="fw-bold mb-3">매치 소개</h5>
                    
                    <c:if test="${not empty dto.imageFilename}">
                        <div class="mb-4">
                            <img src="${pageContext.request.contextPath}/uploads/match/${dto.imageFilename}" 
                                 class="img-fluid rounded-4 w-100 shadow-sm object-fit-cover" 
                                 alt="매치 이미지">
                        </div>
                    </c:if>
                    
                    <p class="text-muted mb-5" style="line-height: 1.8;">
                        ${dto.content }
                    </p>
                    
                    <h5 class="fw-bold mb-3">위치 안내</h5>

					<div id="map" class="rounded-4 border shadow-sm w-100" style="height: 400px;"></div>
					
                    <div class="d-flex justify-content-end align-items-center gap-2 mt-5">
                        <button class="btn btn-light rounded-pill px-4 py-2 fw-bold hover-scale" onclick="location.href='${pageContext.request.contextPath}/match/list'">
                            목록으로
                        </button>
                        <button class="btn btn-primary rounded-pill px-5 py-2 fw-bold shadow-sm hover-scale" onclick="alert('신청이 완료되었습니다!')">
                            매치 신청하기 <i class="bi bi-check-lg ms-1"></i>
                        </button>
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
    
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=키넣을곳"></script>
    <script>
        var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
            mapOption = { 
                center: new kakao.maps.LatLng(37.571679, 126.898320), // 지도의 중심좌표
                level: 3 
            };
    
        var map = new kakao.maps.Map(mapContainer, mapOption); 
        
        var markerPosition  = new kakao.maps.LatLng(37.571679, 126.898320);
        
        var marker = new kakao.maps.Marker({
            position: markerPosition
        });
        
        marker.setMap(map);	
    </script>

</body>
</html>