<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>Footlog - Match Detail</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/dist/css/style.css">
</head>
<jsp:include page="/WEB-INF/views/layout/headerResources.jsp" />
<body>

	<header>
		<jsp:include page="/WEB-INF/views/layout/header.jsp" />
	</header>

	<div class="container-fluid px-lg-5 mt-4">
		<div class="row">

			<div class="col-lg-2 d-none d-lg-block">
				<div class="sidebar-menu sticky-top" style="top: 100px;">
					<div class="mb-4">
						<p class="sidebar-title">매치</p>
						<div class="list-group">
							<a href="${pageContext.request.contextPath}/match/myMatch"
								class="list-group-item list-group-item-action ">내 매치 일정</a> <a
								href="${pageContext.request.contextPath}/match/list"
								class="list-group-item list-group-item-action  active-menu">전체
								매치 리스트</a> <a href="${pageContext.request.contextPath}/match/write"
								class="list-group-item list-group-item-action ">매치 개설하기</a> <a
								href="${pageContext.request.contextPath}/mercenary/list"
								class="list-group-item list-group-item-action ">용병 구하기</a>
						</div>
					</div>
				</div>
			</div>

			<div class="col-lg-8 col-12">

				<div class="d-flex align-items-center justify-content-between mb-4">
					<div>
						<c:choose>
							<c:when test="${dto.status == '모집중'}">
								<span class="badge bg-primary text-dark rounded-pill mb-2 px-3 py-2">${dto.status}</span>
							</c:when>
							<c:when test="${dto.status == '마감임박'}">
								<span class="badge bg-danger text-white rounded-pill mb-2 px-3 py-2">${dto.status}</span>
							</c:when>
							<c:otherwise>
								<span class="badge bg-secondary text-white rounded-pill mb-2 px-3 py-2">${dto.status}</span>
							</c:otherwise>
						</c:choose>
						
						<h2 class="fw-bold mb-1">${dto.title}</h2>
						<div class="d-flex align-items-center text-muted gap-2">
							<span><i class="bi bi-eye me-1"></i> ${dto.view_count}</span> <span>•</span> <span>주최팀: ${dto.home_team_name}</span>
						</div>
					</div>
					<button class="btn btn-light rounded-circle">
						<i class="bi bi-share"></i>
					</button>
				</div>

				<div class="modern-card p-4 mb-4">
					<table class="table table-borderless match-info-table mb-0">
						<tbody>
							<tr>
								<td class="text-muted" style="width: 100px;">일시</td>
								<td class="fw-bold fs-5">${dto.match_date}</td>
							</tr>
							<tr>
								<td class="text-muted">구장</td>
								<td class="fw-bold">${dto.stadiumName}<a href="#" class="text-primary small ms-2 text-decoration-underline">지도보기</a></td>
							</tr>
							<tr>
								<td class="text-muted">진행방식</td>
								<td class="fw-bold">${dto.matchType}</td>
							</tr>
							<tr>
								<td class="text-muted">참가비</td>
								<td class="fw-bold text-primary"><fmt:formatNumber value="${dto.fee}"/>원</td>
							</tr>
							<tr>
								<td class="text-muted">실력/성별</td>
								<td class="fw-bold">${dto.matchLevel} / ${dto.gender}</td>
							</tr>
						</tbody>
					</table>
				</div>

				<div class="modern-card p-5" style="min-height: 300px;">

					<h5 class="fw-bold mb-3">매치 소개</h5>
					<p class="text-muted mb-5" style="line-height: 1.8;">
						${dto.content}</p>

					<h5 class="fw-bold mb-3">위치 안내</h5>
					<div id="map" class="rounded-4 border shadow-sm w-100"
						style="height: 400px;"></div>

					<div class="d-flex justify-content-between align-items-center mt-5">
						<div class="d-flex gap-2">
							<c:if test="${sessionScope.member.member_code == dto.member_code || sessionScope.member.role_level > 0}">
								<button type="button" class="btn btn-outline-dark rounded-pill px-4 py-2 fw-bold hover-scale"
									onclick="location.href='${pageContext.request.contextPath}/match/update?match_code=${dto.match_code}&page=${page}'">
									수정</button>
								<button type="button" class="btn btn-outline-danger rounded-pill px-4 py-2 fw-bold hover-scale"
									onclick="deleteOk()">삭제</button>
							</c:if>
						</div>

						<div class="d-flex gap-2">
							<button type="button" class="btn btn-light rounded-pill px-4 py-2 fw-bold hover-scale"
								onclick="location.href='${pageContext.request.contextPath}/match/list?${query}'">
								목록으로</button>

							<c:if test="${sessionScope.member.member_code != dto.member_code}">
								<button type="button" class="btn btn-primary rounded-pill px-5 py-2 fw-bold shadow-sm hover-scale"
									onclick="apply()"> 매치 신청하기 <i class="bi bi-check-lg ms-1"></i>
								</button>
							</c:if>
						</div>
					</div>
				</div> 
				<c:if test="${sessionScope.member.member_code == dto.member_code}">
					<div class="card border-0 shadow-sm mt-4">
						<div class="card-header bg-white border-bottom fw-bold py-3">
					        <i class="bi bi-people-fill me-2"></i>매치 신청 현황
					    </div>
					    
					    <div class="card-body p-0">
					        <div class="list-group list-group-flush">
					            
					            <c:if test="${empty applicantList}">
					                <div class="list-group-item text-center py-5 text-muted">
					                    <i class="bi bi-info-circle d-block fs-3 mb-2"></i>
					                    아직 신청한 팀이 없습니다.
					                </div>
					            </c:if>
			
					            <c:forEach var="apply" items="${applicantList}">
					                <div class="list-group-item d-flex justify-content-between align-items-center py-3">
					                    <div class="d-flex align-items-center">
					                        <div class="rounded-circle bg-light d-flex justify-content-center align-items-center me-3" style="width: 45px; height: 45px;">
					                            <i class="bi bi-shield-shaded text-secondary fs-5"></i>
					                        </div>
					                        <div>
					                            <span class="fw-bold d-block">${apply.team_name}</span>
					                            <span class="small text-muted">실력: ${apply.team_level}</span>
					                        </div>
					                    </div>
					                    
					                    <c:if test="${dto.status == '모집중'}">
					                        <button type="button" class="btn btn-primary btn-sm px-3 rounded-pill" 
					                                onclick="confirmMatch('${apply.team_code}', '${apply.team_name}');">
					                            수락하기
					                        </button>
					                    </c:if>
					                </div>
					            </c:forEach>
					        </div>
					    </div>
					</div>
				</c:if>
				</div>
		</div>
	</div>

	<footer>
		<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
	</footer>

	<jsp:include page="/WEB-INF/views/layout/footerResources.jsp" />

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

	<script type="text/javascript"
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=키넣을곳"></script>
		
	<script>
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		mapOption = {
			center : new kakao.maps.LatLng(37.571679, 126.898320), // 지도의 중심좌표
			level : 3
		};

		var map = new kakao.maps.Map(mapContainer, mapOption);
		var markerPosition = new kakao.maps.LatLng(37.571679, 126.898320);
		var marker = new kakao.maps.Marker({
			position : markerPosition
		});
		marker.setMap(map);
	</script>
	
	<script type="text/javascript">
		function confirmMatch(awayCode, awayName) {
			
		}
	</script>
	
	<c:choose>
		<c:when test="${sessionScope.member.member_code == dto.member_code || sessionScope.member_team.role_level>=10 }">
			<script type="text/javascript">
				function deleteOk(){
					if(confirm('매치 게시글을 삭제하시겠습니까?')){
						let params = 'match_code=${dto.match_code}&${query}';
						let url = '${pageContext.request.contextPath}/match/delete?'+params;
						location.href=url;
					}
				}
			</script>
		</c:when>
		<c:otherwise>
			<script type="text/javascript">
				function apply(){
					if("${sessionScope.member}"==""){
						alert('로그인이 필요합니다.');
						location.href="${pageContext.request.contextPath}/member/login";
						return;
					}
					if(!confirm('매치를 신청하시겠습니까?')){
						return;
					}
					if(!my)
					let params = 'match_code=${dto.match_code}&${query}';
					let url = '${pageContext.request.contextPath}/match/'
				}
			</script>
		</c:otherwise>
	</c:choose>
	
</body>
</html>