<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>${boardName}- Footlog</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/dist/css/style.css">

<style>
/* 기존 스타일 유지 */
.gallery-img-wrapper {
	position: relative;
	width: 100%;
	padding-top: 66.66% !important;
	overflow: hidden;
	background-color: #f8f9fa;
}

.gallery-card .card-title {
	display: block;
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
	font-size: 0.9rem !important;
}

.gallery-card:hover .gallery-img-wrapper img {
	transform: scale(1.08);
	transition: transform 0.4s ease;
}

.board-table thead th {
	background-color: #111;
	color: #fff;
	border: none;
	padding: 15px;
	font-weight: 700;
}

.board-table tbody tr {
	transition: 0.2s;
	cursor: pointer;
}

.board-table tbody tr:hover {
	background-color: rgba(212, 246, 63, 0.1);
	transform: translateY(-2px);
	box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
}

.btn-category {
	border: 1px solid #ddd;
	color: #666;
	font-size: 0.9rem;
	font-weight: 600;
	text-decoration: none;
}

.btn-category:hover, .btn-category.active {
	background-color: #111;
	color: #fff;
	border-color: #111;
}

.neon-search-box {
	background-color: #111;
	border: 2px solid #333;
	transition: 0.3s;
	height: 40px;
	max-width: 350px;
	font-size: 0.9rem;
}

.neon-search-box:hover, .neon-search-box:focus-within {
	border-color: #D4F63F;
	box-shadow: 0 0 10px rgba(212, 246, 63, 0.2);
}

.page-navigation {
	display: flex;
	justify-content: center;
	align-items: center;
	gap: 8px;
}

.page-navigation b {
	background-color: #111;
	color: #D4F63F !important;
	width: 38px;
	height: 38px;
	display: inline-flex;
	align-items: center;
	justify-content: center;
	border-radius: 12px;
}

.gallery-card {
	transition: 0.3s;
	border-radius: 15px;
	overflow: hidden;
	border: none;
	cursor: pointer;
}

.gallery-img-wrapper img {
	position: absolute;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	object-fit: cover;
}
</style>
</head>
<jsp:include page="/WEB-INF/views/layout/headerResources.jsp" />
<body>
	<header>
		<jsp:include page="/WEB-INF/views/layout/header.jsp" />
	</header>

	<div class="container-fluid px-lg-5 mt-5 mb-5">
		<div class="row">
			<%-- 사이드바 영역 --%>
			<c:if test="${category != 4}">
				<div class="col-lg-2 d-none d-lg-block">
					<div class="sidebar-menu sticky-top" style="top: 100px;">
						<p class="sidebar-title">Board List</p>
						<div class="list-group">
							<a href="${pageContext.request.contextPath}/bbs/list?category=1"
								class="list-group-item list-group-item-action ${category==1?'active bg-dark text-white border-0 fw-bold':''}">공지사항</a>
							<a href="${pageContext.request.contextPath}/bbs/list?category=2"
								class="list-group-item list-group-item-action ${category==2?'active bg-dark text-white border-0 fw-bold':''}">자유
								게시판</a> <a
								href="${pageContext.request.contextPath}/bbs/list?category=3"
								class="list-group-item list-group-item-action ${category==3?'active bg-dark text-white border-0 fw-bold':''}">이벤트
								/ 뉴스</a>
						</div>
					</div>
				</div>
			</c:if>

			<div class="${category == 4 ? 'col-12' : 'col-lg-9 col-12 ms-lg-5'}">
				<div
					class="d-flex justify-content-between align-items-end mb-4 border-bottom pb-3">
					<div>
						<h2 class="fw-bold display-6 mb-1">${boardName}</h2>
						<p class="text-muted mb-0">${boardDesc}</p>
					</div>

					<%-- [권한 제어 핵심 로직] --%>
					<c:choose>
						<%-- 공지사항(1)은 관리자(role_level 51이상)만 글쓰기 가능 --%>
						<c:when test="${category == '1'}">
							<c:if
								test="${not empty sessionScope.member && sessionScope.member.role_level >= 51}">
								<a
									href="${pageContext.request.contextPath}/bbs/write?category=${category}"
									class="btn btn-dark rounded-pill px-4 fw-bold shadow-sm"
									style="color: #D4F63F;"> 🖊️ 공지 등록 </a>
							</c:if>
						</c:when>
						<%-- 그 외 게시판은 로그인만 하면 글쓰기 가능 --%>
						<c:otherwise>
							<c:if test="${not empty sessionScope.member}">
								<a
									href="${pageContext.request.contextPath}/bbs/write?category=${category}"
									class="btn btn-dark rounded-pill px-4 fw-bold shadow-sm"
									style="color: #D4F63F;"> ${category == 4 ? '📸 사진 등록' : '🖊️ 글쓰기'}
								</a>
							</c:if>
						</c:otherwise>
					</c:choose>
				</div>

				<%-- 검색 영역 --%>
				<div class="row g-2 align-items-center mb-4">
				<div class="col-md-6">
					<div class="d-flex gap-2">
						<a
							href="${pageContext.request.contextPath}/bbs/list?category=${category}&sortType=new&schType=${schType}&kwd=${kwd}"
							class="btn btn-category rounded-pill px-3 ${sortType == 'new' || empty sortType ? 'active' : ''}">
							최신순 </a> <a
							href="${pageContext.request.contextPath}/bbs/list?category=${category}&sortType=popular&schType=${schType}&kwd=${kwd}"
							class="btn btn-category rounded-pill px-3 ${sortType == 'popular' ? 'active' : ''}">
							인기순 </a>
					</div>
				</div>
				<div class="col-md-6">
					<form action="${pageContext.request.contextPath}/bbs/list"
						method="get" class="d-flex justify-content-md-end">
						<input type="hidden" name="category" value="${category}">
						<div
							class="neon-search-box d-flex align-items-center rounded-pill px-2 w-100">
							<select name="schType"
								class="form-select border-0 text-white bg-transparent py-0"
								style="width: auto; font-size: 0.9em;">
								<option value="all" ${schType=='all'?'selected':''}
									class="text-dark">전체</option>
								<option value="title" ${schType=='title'?'selected':''}
									class="text-dark">제목</option>
								<option value="content" ${schType=='content'?'selected':''}
									class="text-dark">내용</option>
							</select> <input type="text" name="kwd" value="${kwd}"
								class="form-control border-0 bg-transparent text-white py-0"
								placeholder="Search..."
								style="box-shadow: none; font-size: 0.9em;">
							<button type="submit"
								class="btn btn-link text-decoration-none p-2"
								style="color: #D4F63F;">🔍</button>
						</div>
					</form>
				</div>
			</div>

			<%-- 목록 렌더링 --%>
			<c:choose>
				<c:when test="${category == 4}">
					<%-- 갤러리 디자인 --%>
					<div
						class="row row-cols-1 row-cols-sm-2 row-cols-md-4 row-cols-lg-5 g-3">
						<c:forEach var="dto" items="${list}">
							<div class="col">
								<div class="card gallery-card shadow-sm h-100"
									onclick="location.href='${pageContext.request.contextPath}/bbs/article?board_main_code=${dto.board_main_code}&page=${page}&category=${category}'">
									<div class="gallery-img-wrapper">
										<c:choose>
											<c:when test="${not empty dto.imageFilename}">
												<img
													src="${pageContext.request.contextPath}/uploads/gallery/${dto.imageFilename}"
													alt="갤러리 이미지">
											</c:when>
											<c:otherwise>
												<img
													src="${pageContext.request.contextPath}/dist/images/no-image.png"
													alt="이미지 없음">
											</c:otherwise>
										</c:choose>
									</div>
									<div class="card-body p-3">
										<h6 class="card-title fw-bold text-truncate mb-2">${dto.title}</h6>
										<div
											class="d-flex justify-content-between align-items-center small text-secondary">
											<span>${dto.member_name}</span> <span>${dto.created_at}</span>
										</div>
									</div>
								</div>
							</div>
						</c:forEach>
					</div>
				</c:when>
				<c:otherwise>
					<%-- 일반 리스트 디자인 --%>
					<div class="modern-card p-0 overflow-hidden shadow-sm">
						<table
							class="table table-hover board-table mb-0 text-center align-middle">
							<thead>
								<tr>
									<th width="80">No</th>
									<th width="100">분류</th>
									<th class="text-start">제목</th>
									<th width="120">작성자</th>
									<th width="120">날짜</th>
									<th width="80">조회</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="dto" items="${list}" varStatus="status">
									<tr
										onclick="location.href='${pageContext.request.contextPath}/bbs/article?board_main_code=${dto.board_main_code}&page=${page}&category=${category}'">
										<td>${dataCount - (page-1)*10 - status.index}</td>
										<td><span
											class="badge ${dto.category==1?'bg-danger':(dto.category==2?'bg-primary':'bg-success')} bg-opacity-10 ${dto.category==1?'text-danger':(dto.category==2?'text-primary':'text-success')} border">
												${dto.category==1?'공지':(dto.category==2?'자유':'이벤트')} </span></td>
										<td class="text-start fw-bold">${dto.title} <c:if
												test="${dto.replyCount > 0}">
												<span class="text-danger small ms-1">[${dto.replyCount}]</span>
											</c:if>
										</td>
										<td>${dto.member_name}</td>
										<td>${dto.created_at}</td>
										<td>${dto.view_count}</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</c:otherwise>
			</c:choose>

			<c:if test="${empty list}">
				<div class="py-5 text-center text-muted">등록된 게시글이 없습니다.</div>
			</c:if>

			<div class="page-navigation mt-5 text-center">${paging}</div>
		</div>
	</div>
	</div>

	<footer>
		<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
	</footer>
	<jsp:include page="/WEB-INF/views/layout/footerResources.jsp" />
</body>
</html>