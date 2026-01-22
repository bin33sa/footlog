<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<fmt:formatDate value="<%=new java.util.Date()%>" pattern="yyyy-MM-dd"
	var="today" />


<!DOCTYPE html>
<html lang="ko">
<head>
<title>Footlog - Stadium Detail</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/dist/css/style.css">

<style>
/* 시간 선택 버튼 스타일 */
.btn-check:checked+.btn-outline-primary {
	background-color: var(--primary-color, #D4F63F);
	color: #000;
	border-color: var(--primary-color, #D4F63F);
	font-weight: bold;
}

.facility-icon {
	width: 50px;
	height: 50px;
	background-color: #f8f9fa;
	border-radius: 50%;
	display: flex;
	align-items: center;
	justify-content: center;
	font-size: 1.2rem;
	color: #333;
	margin-bottom: 5px;
}
</style>
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
						<p class="sidebar-title">구장</p>
						<div class="list-group">
							<a href="${pageContext.request.contextPath}/field/list"
								class="list-group-item list-group-item-action active-menu">구장
								검색 / 예약</a>

						</div>
					</div>
				</div>
			</div>

			<div class="col-lg-8 col-12">

				<div class="modern-card p-0 overflow-hidden mb-4">
					<div class="position-relative" style="height: 400px;">

						<c:choose>
							<c:when test="${not empty dto and not empty dto.stadiumImage}">
							<img
								src="${pageContext.request.contextPath}/uploads/stadium/${dto.stadiumImage}"
								class="w-100 h-100 object-fit-cover" alt="${dto.stadiumName}">
						</c:when>

						<c:otherwise>
							<img
								src="${pageContext.request.contextPath}/dist/images/default.jpg"
								class="w-100 h-100 object-fit-cover" alt="${dto.stadiumName}">
						</c:otherwise>
						</c:choose>

						<div class="position-absolute bottom-0 start-0 w-100 p-4"
							style="background: linear-gradient(to top, rgba(0, 0, 0, 0.7), transparent);">
							<h2 class="text-white fw-bold mb-1">${dto.stadiumName}</h2>
							<p class="text-white-50 mb-0">
								<i class="bi bi-geo-alt-fill me-1"></i>${dto.region}</p>
						</div>
					</div>

					<div class="p-5">

						<div class="row mb-5">
							<div class="col-md-8">
								<h5 class="fw-bold mb-3">시설 정보</h5>
								<div class="d-flex gap-4 text-center">
									<div>
										<div class="facility-icon">
											<i class="bi bi-p-square-fill"></i>
										</div>
										<span class="small text-muted">주차가능</span>
									</div>
									<div>
										<div class="facility-icon">
											<i class="bi bi-droplet-fill"></i>
										</div>
										<span class="small text-muted">샤워실</span>
									</div>
									<div>
										<div class="facility-icon">
											<i class="bi bi-shop"></i>
										</div>
										<span class="small text-muted">매점</span>
									</div>
									<div>
										<div class="facility-icon">
											<i class="bi bi-lightbulb-fill"></i>
										</div>
										<span class="small text-muted">조명</span>
									</div>
								</div>
								<hr class="my-4">
								<h5 class="fw-bold mb-3">구장 소개</h5>
								<p class="text-muted" style="line-height: 1.8;">
									${dto.description}</p>
							</div>

							<div class="col-md-4 border-start ps-md-4">
								<div class="text-center bg-light p-4 rounded-4 mb-3">
									<h6 class="text-muted mb-2">평균 별점</h6>
									<h1 class="fw-bold mb-0">${dto.rating}
										<span class="fs-6 text-muted">/ 5.0</span>
									</h1>
									<div class="text-warning small mb-2">
										<i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i
											class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i
											class="bi bi-star-fill"></i>
									</div>
									<a href="#" class="text-decoration-underline small text-muted">리뷰
										128개 보기</a>
								</div>
								<div class="d-grid">
									<button class="btn btn-outline-dark rounded-pill">
										<i class="bi bi-heart me-1"></i> 찜하기
									</button>
								</div>
							</div>
						</div>

						<form id="reservationForm"
							action="${pageContext.request.contextPath}/field/reservation"
							method="post">
							<input type="hidden" name="stadiumCode"
								value="${dto.stadiumCode}"> <input type="hidden"
								name="playDate" id="selectedDate"> <input type="hidden"
								name="timeCode" id="selectedTimeCode">

							<div class="bg-light p-4 rounded-4 mb-4 border">
								<h4 class="fw-bold mb-4">📅 예약 일정 선택</h4>

								<div class="mb-4">
									<label class="form-label fw-bold">날짜</label> <input type="date"
										id="reservationDate"
										class="form-control form-control-lg border-0 shadow-sm"
										value="${today}" min="${today}" required>
								</div>

								<div class="mb-4">
									<label class="form-label fw-bold d-block mb-2">시간 선택</label>

									<!-- 타임슬롯카드 -->
									<div class="row g-2" id="timeSlotArea"></div>


									<div class="mt-2 small text-muted">
										<span class="me-2"><i
											class="bi bi-square-fill text-secondary opacity-25"></i> 마감</span> <span><i
											class="bi bi-square-fill text-primary opacity-50"></i> 예약가능</span>
									</div>
								</div>

								<hr>

								<div class="mb-4">
									<label class="form-label fw-bold">예약 팀 선택</label>


									<c:choose>
										<c:when test="${not empty teams}">
											<select name="teamCode"
												class="form-select form-select-lg border-0 shadow-sm"
												required>
												<option value="">-- 팀을 선택하세요 --</option>

												<c:forEach var="team" items="${teams}">
													<option value="${team.team_code}">
														${team.team_name}</option>
												</c:forEach>
											</select>
										</c:when>

										<c:otherwise>
											<div
												class="form-control form-control-lg border-0 shadow-sm bg-light text-muted">
												가입한 팀이 없습니다</div>
										</c:otherwise>
									</c:choose>
								</div>

								<hr>

								<div
									class="d-flex justify-content-between align-items-center mt-4">
									<div>
										<span class="text-muted small">총 결제금액 (2시간)</span>
										<h3 class="fw-bold text-dark mb-0">${dto.price}원</h3>
									</div>

									<c:choose>
										<c:when test="${not empty teams}">
											<button type="submit"
												class="btn btn-dark btn-lg rounded-pill px-5 fw-bold">
												예약하기</button>
										</c:when>

										<c:otherwise>
											<button type="button"
												class="btn btn-secondary btn-lg rounded-pill px-5 fw-bold"
												disabled style="cursor: not-allowed;">팀 가입 후 예약 가능
											</button>
										</c:otherwise>
									</c:choose>

								</div>

								<hr>

								<h5 class="fw-bold mb-3">위치 안내</h5>

								<div id="map" class="rounded-4 border shadow-sm w-100"
									style="height: 400px;"></div>

								<script>
									var mapContainer = document
											.getElementById('map'), // 지도를 표시할 div 
									mapOption = {
										center : new kakao.maps.LatLng(
												37.571679, 126.898320), // 지도의 중심좌표
										level : 3
									};

									var map = new kakao.maps.Map(mapContainer,
											mapOption);

									var markerPosition = new kakao.maps.LatLng(
											37.571679, 126.898320);

									var marker = new kakao.maps.Marker({
										position : markerPosition
									});

									marker.setMap(map);
								</script>


							</div>
						</form>


					</div>
				</div>

			</div>
		</div>

		<div class="text-center mb-5">
			<button class="btn btn-light rounded-pill px-4"
				onclick="location.href='${pageContext.request.contextPath}/field/list'">
				목록으로 돌아가기</button>
		</div>

	</div>

	<footer>
		<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
	</footer>


	<script type="text/javascript">
	(function () {
		  const params = new URLSearchParams(window.location.search);
		  const success = params.get('success');   // 예: /field/view?success=1
		  const error   = params.get('error');     // 예: /field/view?error=1

		  // 서버에서 mav.addObject("message", "...")로 넘긴 경우 대비
		  const message = "<c:out value='${message}'/>";

		  if (success === '1') {
		    alert('예약이 완료되었습니다 ✅');
		    // 원하면 쿼리 제거(뒤로가기/새로고침 중복 알림 방지)
		    params.delete('success');
		    history.replaceState(null, '', window.location.pathname + (params.toString() ? '?' + params.toString() : ''));
		    return;
		  }

		  if (error === '1') {
		    alert((message && message !== 'null') ? message : '예약에 실패했습니다 ❌');
		    params.delete('error');
		    history.replaceState(null, '', window.location.pathname + (params.toString() ? '?' + params.toString() : ''));
		  }
		})();
	
	
	
	
		$(function() {

			function loadTimeSlots(date) {
				const $list = $('#timeSlotArea');

				// hidden 날짜 세팅
				$('#selectedDate').val(date);

				$.ajax({
					url : '${pageContext.request.contextPath}/field/timeSlot',
					type : 'get',
					data : {
						stadiumCode : '${dto.stadiumCode}',
						date : date
					},
					dataType : 'html',
					success : function(html) {
						$list.html(html);
						// 날짜 바뀌면 시간 선택 초기화
						$('#selectedTimeCode').val('');
					},
					error : function() {
						console.error('타임슬롯 로드 실패');
					}
				});
			}

			// 날짜 변경 시
			$('#reservationDate').on('change', function() {
				loadTimeSlots(this.value);
			});

			// 최초 진입 시
			loadTimeSlots($('#reservationDate').val());
		});

		// 시간 선택 (AJAX로 생긴 요소라 document.on)
		$(document).on(
				'click',
				'.time-btn',
				function() {

					// 기존 선택 해제
					$('.time-btn').removeClass('btn-primary').addClass(
							'btn-outline-primary');

					// 현재 선택
					$(this).removeClass('btn-outline-primary').addClass(
							'btn-primary');

					// hidden에 timeCode 저장
					$('#selectedTimeCode').val($(this).data('time-code'));
				});
	</script>



</body>
</html>