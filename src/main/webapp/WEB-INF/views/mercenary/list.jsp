<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<title>Footlog - 용병 게시판</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<jsp:include page="/WEB-INF/views/layout/headerResources.jsp" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/style.css">
<style>
.board-table thead th { border: none !important; }

/* 기본 변수 설정 */
:root {
	--primary-color: #D4F63F;
}

/* 1. 게시판 테이블 스타일 */
.board-table thead th {
	background-color: #111;
	color: #fff;
	border: none;
	padding: 15px;
	font-weight: 700;
	text-align: center;
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

/* 2. 네온 검색창 스타일 */
.neon-search-box {
	background-color: #111;
	border: 2px solid #333;
	transition: 0.3s;
	height: 40px;
	max-width: 350px;
	font-size: 0.9rem;
}

.neon-search-box:hover, .neon-search-box:focus-within {
	border-color: var(--primary-color);
	box-shadow: 0 0 10px rgba(212, 246, 63, 0.2);
}

.neon-search-box select option {
	background-color: #111;
	color: #fff;
}

/* 3. 카테고리 버튼 */
.btn-category {
	border: 1px solid #ddd;
	color: #666;
	font-size: 0.9rem;
	font-weight: 600;
}

.btn-category:hover, .btn-category.active {
	background-color: #111;
	color: #fff;
	border-color: #111;
}

/* 기타 스타일 */
.modern-card {
	border-radius: 15px;
	border: none;
}

/* 4. 페이징 디자인 추가 */
.page-navigation {
	display: flex;
	justify-content: center;
	align-items: center;
	gap: 8px; /* 숫자 사이 간격 */
	margin-top: 40px;
}

/* 페이징 내의 모든 링크와 숫자 공통 스타일 */
.page-navigation a, .page-navigation span, .page-navigation b {
	display: inline-block;
	min-width: 35px;
	height: 35px;
	line-height: 35px;
	text-align: center;
	text-decoration: none;
	border-radius: 50%; /* 동그란 모양 */
	font-size: 0.9rem;
	font-weight: 600;
	transition: 0.2s;
	color: #333;
}

/* 마우스 올렸을 때 효과 */
.page-navigation a:hover {
	background-color: rgba(212, 246, 63, 0.2);
	color: #000;
}

/* ★현재 페이지 강조 (가장 중요)★ */
/* 강사님 유틸이 <b>태그로 현재페이지를 만든다면 아래가 적용됨 */
.page-navigation b {
	background-color: #111;
	color: var(--primary-color) !important;
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
}

/* 화살표(이전/다음) 스타일 */
.page-navigation a[href*="page="] {
	color: #999;
}

/* 테이블 세로줄 및 스타일 수정 */
.board-table {
    border-collapse: collapse; /* 테두리 겹침 방지 */
}

/* 모든 셀에 연한 세로줄 추가 */
.board-table th, 
.board-table td {
    border-left: 1px solid #ccc;  /* 왼쪽 세로줄 */
    border-right: 1px solid #ccc; /* 오른쪽 세로줄 */
}

/* 첫 번째 열과 마지막 열의 외곽 세로줄은 제거 (선택 사항) */
.board-table th:first-child, 
.board-table td:first-child {
    border-left: none;
}
.board-table th:last-child, 
.board-table td:last-child {
    border-right: none;
}

/* 헤더 부분은 좀 더 진한 구분선 (옵션) */
.board-table thead th {
    border-left: 1px solid #333;
    border-right: 1px solid #333;
}
</style>
</head>
<body>

	<header>
		<jsp:include page="/WEB-INF/views/layout/header.jsp" />
	</header>

	<main class="container-fluid px-lg-5 mt-5 mb-5">
		<div class="row justify-content-center">
			<div class="col-lg-10">

				<div
					class="d-flex justify-content-between align-items-end mb-4 border-bottom pb-3">
					<div>
						<h2 class="fw-bold display-6 mb-1">MERCENARY</h2>
						<p class="text-muted mb-0">함께 뛸 용병을 찾거나 지원하세요.</p>
					</div>
					<button type="button"
						class="btn btn-dark rounded-pill px-4 fw-bold shadow-sm"
						style="color: var(--primary-color);"
						onclick="location.href='${pageContext.request.contextPath}/mercenary/write';">
						🖊️ 용병 등록</button>
				</div>

				<div class="row g-2 align-items-center mb-4">
					<div class="col-md-6">
						<div class="d-flex gap-2">
							<a href="${pageContext.request.contextPath}/mercenary/list"
								class="btn btn-category rounded-pill px-3 ${empty category ? 'active' : ''}">전체</a>

							<a
								href="${pageContext.request.contextPath}/mercenary/list?category=1"
								class="btn btn-category rounded-pill px-3 ${category == '1' ? 'active' : ''}">구인</a>

							<a
								href="${pageContext.request.contextPath}/mercenary/list?category=2"
								class="btn btn-category rounded-pill px-3 ${category == '2' ? 'active' : ''}">구직</a>
						</div>
					</div>

					<div class="col-md-6">
						<form name="searchForm" class="d-flex justify-content-md-end">
							<div
								class="neon-search-box d-flex align-items-center rounded-pill px-3 w-100">
								<select name="schType"
									class="form-select border-0 text-white bg-transparent py-0 shadow-none"
									style="width: auto; font-size: 0.9em;">
									<option value="all" ${schType=="all"?"selected":""}>전체</option>
									<option value="subject" ${schType=="title"?"selected":""}>제목</option>
									<option value="content" ${schType=="content"?"selected":""}>내용</option>
									<option value="userName"
										${schType=="member_code"?"selected":""}>작성자</option>
								</select> <input type="text" name="kwd" value="${kwd}"
									class="form-control border-0 bg-transparent text-white py-0 shadow-none"
									placeholder="검색어 입력...">

								<button type="button"
									class="btn btn-link text-decoration-none p-0"
									onclick="searchList()" style="color: var(--primary-color);">
									<i class="bi bi-search"></i>
								</button>
							</div>
						</form>
					</div>
				</div>

				<div class="modern-card p-0 overflow-hidden shadow-sm border">
					<table
						class="table table-hover board-table mb-0 text-center align-middle">
						<thead>
							<tr>
								<th width="80">번호</th>
								<th class="text-center">제목</th>
								<th width="120">작성일</th>
								<th width="80">조회수</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="dto" items="${list}">
								<tr onclick="location.href='${pageContext.request.contextPath}/mercenary/article?recruit_id=${dto.recruit_id}&page=${page}';">
									<td>${dto.recruit_id}</td>
									<td class="text-center fw-bold">${dto.title}</td>
									<td class="text-muted">${dto.created_at}</td>
									<td><span
										class="badge rounded-pill bg-light text-dark border">${dto.view_count}</span></td>
								</tr>
							</c:forEach>
							<c:if test="${list.size() == 0}">
								<tr>
									<td colspan="4" class="py-5 text-muted">등록된 게시글이 없습니다.</td>
								</tr>
							</c:if>
						</tbody>
					</table>
				</div>

				<div class="page-navigation">
					<c:choose>
						<c:when test="${dataCount == 0}">
							<span class="text-muted">등록된 게시물이 없습니다.</span>
						</c:when>
						<c:otherwise>
            			${paging}
        			</c:otherwise>
					</c:choose>
				</div>

			</div>
		</div>
	</main>

	<script>
window.addEventListener('DOMContentLoaded', () => {
    const inputEL = document.querySelector('form input[name=kwd]'); 
    if(inputEL) {
        inputEL.addEventListener('keydown', function (evt) {
            if(evt.key === 'Enter') {
                evt.preventDefault();
                searchList();
            }
        });
    }
});

function searchList() {
    const f = document.searchForm;
    if(! f.kwd.value.trim()) {
        f.kwd.focus();
        return;
    }
    const formData = new FormData(f);
    let params = new URLSearchParams(formData).toString();
    location.href = '${pageContext.request.contextPath}/mercenary/list?' + params;
}
</script>

	<footer>
		<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
	</footer>
	<jsp:include page="/WEB-INF/views/layout/footerResources.jsp" />
</body>
</html>