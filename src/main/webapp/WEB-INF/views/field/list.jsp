<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>Footlog - Stadium Booking</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/dist/css/style.css">


<jsp:include page="/WEB-INF/views/layout/headerResources.jsp" />
</head>
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
				
				<!-- 예약 탭 -->
				<div class="mb-3">
					<ul class="nav nav-pills nav-fill booking-tabs">
						<li class="nav-item"><a class="nav-link"
							href="${pageContext.request.contextPath}/field/booking">
								<i class="bi bi-calendar-check me-1"></i> 내가 예약한 구장
						</a></li>
					</ul>
				</div>

				<div
					class="d-flex flex-column flex-md-row justify-content-between align-items-center mb-4 gap-3">
					<div class="search-bar-wrapper w-100">
						<i class="bi bi-search position-absolute ms-3 text-muted"></i> <input
							id="searchInput" type="text"
							class="form-control rounded-pill ps-5 py-2 border-0 shadow-sm"
							placeholder="지역명, 구장명으로 검색">
					</div>

					<div class="d-flex gap-2 w-100 w-md-auto justify-content-end">
						<select id="sortSelect"
							class="form-select rounded-pill border-0 shadow-sm"
							style="width: 140px;">
							<option selected>조회 방법</option>
							<option value="price">가격 낮은순</option>
							<option value="rating">평점 높은순</option>
						</select>
					</div>
				</div>




				<div class="stadium row g-4" id="stadiumList"
					data-page-no="${pageNo}" data-total-page="${totalPage}">

					<!-- 리스트jsp -->
					<jsp:include page="/WEB-INF/views/field/stadiumList.jsp" />
				</div>



				<div class="list-footer text-center mt-5 mb-5">
					<button id="loadMoreBtn"
						class="btn btn-light rounded-pill px-5 py-3 shadow-sm text-muted fw-bold hover-scale w-50">
						더 많은 구장 보기 <i class="bi bi-arrow-down-circle ms-2"></i>
					</button>
				</div>

			</div>

			<div class="col-lg-2 d-none d-lg-block">
				<div class="sidebar-menu sticky-top" style="top: 100px;">
					<div class="mb-4"></div>
				</div>
			</div>

		</div>
	</div>
	<footer>
		<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
	</footer>

	<jsp:include page="/WEB-INF/views/layout/footerResources.jsp" />

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

	<script type="text/javascript">
		function getSort() {
			return $('#sortSelect').val();
		}

		$('#sortSelect').on('change', function() {
			const $list = $('#stadiumList');
			$list.empty();
			$list.data('pageNo', 1);

			loadContent(1);

		});

		function getKeyword() {
			return $('#searchInput').val().trim();
		}

		$('#searchInput').on('keydown', function(e) {
			if (e.key === 'Enter') {
				e.preventDefault();

				const $list = $('#stadiumList');

				$list.empty();
				$list.data('pageNo', 1);

				loadContent(1);

			}
		});

		function loadContent(pageNo) {
			const $list = $('#stadiumList');
			const keyword = getKeyword();
			const sort = getSort();

			$.ajax({
				url : `${pageContext.request.contextPath}/field/listMore`,
				type : 'get',
				data : {
					pageNo : pageNo,
					keyword : keyword,
					sort : sort
				},
				dataType : 'html',
				success : function(html) {
					$list.append(html);
				},
				error : function() {
					console.error('구장 목록 로드 실패');
				}
			});
		}

		$(function() {
			$('#loadMoreBtn').click(function() {

				const $list = $('#stadiumList');

				let pageNo = $list.data('pageNo') || 1;

				let totalPage = $list.data('totalPage');

				if (totalPage == null) {
					console.error('data-totalPage 누락');
					return;
				}

				pageNo = Number(pageNo);
				totalPage = Number(totalPage);

				if (pageNo < totalPage) {
					pageNo++;
					$list.data('pageNo', pageNo);
					loadContent(pageNo);
				} else {
					$('#loadMoreBtn').hide(); // 더불러올게 없으면 일단 버튼숨김
				}
			});
		});
	</script>




</body>
</html>