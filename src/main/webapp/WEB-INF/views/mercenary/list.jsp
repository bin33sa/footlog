<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Footlog - 용병 게시판</title>
<jsp:include page="/WEB-INF/views/layout/headerResources.jsp" />

<style>
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
							<a href="#" class="btn btn-category rounded-pill px-3 active">전체</a>
							<a href="#" class="btn btn-category rounded-pill px-3">구인</a> <a
								href="#" class="btn btn-category rounded-pill px-3">구직</a>
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
								<th class="text-start">제목</th>
								<th width="120">작성일</th>
								<th width="80">조회수</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="dto" items="${list}">
								<tr
									onclick="location.href='${pageContext.request.contextPath}/mercenary/article?recruit_id=${dto.recruit_id}&page=${page}';">
									<td>${dto.recruit_id}</td>
									<td class="text-start fw-bold">${dto.title}</td>
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

				<div class="mt-4">${dataCount == 0 ? "등록된 게시물이 없습니다." : paging}
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