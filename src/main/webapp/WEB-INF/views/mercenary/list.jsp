<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<title>Footlog - 용병 게시판</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<jsp:include page="/WEB-INF/views/layout/headerResources.jsp" />
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/dist/css/style.css">
<style>
/* [핵심 1] 변수를 :root에 선언하여 색상이 안 나오는 문제 원천 차단 */
:root {
	--mc-neon: #D4F63F;
	--mc-dark: #111;
	--mc-border: #ddd;
	--primary-color: #D4F63F;
}

/* 1. 테이블 스타일 */
#mercenary-wrapper table {
	width: 100%;
	border-collapse: collapse;
	background-color: #fff;
	table-layout: fixed;
}

#mercenary-wrapper thead th {
	background-color: var(--mc-dark);
	color: #fff;
	padding: 15px;
	font-weight: 700;
	text-align: center;
	border: none;
	border-left: 1px solid #444;
	border-right: 1px solid #444;
}

#mercenary-wrapper thead th:first-child {
	border-left: none;
}

#mercenary-wrapper thead th:last-child {
	border-right: none;
}

#mercenary-wrapper tbody tr {
	border-bottom: 1px solid var(--mc-border);
	transition: 0.2s;
}

#mercenary-wrapper tbody tr:hover {
	background-color: rgba(212, 246, 63, 0.1);
	cursor: pointer;
}

#mercenary-wrapper tbody td {
	padding: 12px;
	vertical-align: middle;
	color: #333;
	border-left: 1px solid #eee;
	border-right: 1px solid #eee;
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
}

#mercenary-wrapper tbody td:first-child {
	border-left: none;
}

#mercenary-wrapper tbody td:last-child {
	border-right: none;
}

/* 2. 네온 검색창 */
#mercenary-wrapper .neon-search-box {
	background-color: var(--mc-dark);
	border: 2px solid #333;
	height: 40px;
	max-width: 350px;
	display: flex;
	align-items: center;
	border-radius: 50px;
	overflow: hidden;
}

#mercenary-wrapper .neon-search-box select, #mercenary-wrapper .neon-search-box input
	{
	background-color: transparent !important;
	color: #fff !important;
	border: none !important;
	box-shadow: none !important;
}

#mercenary-wrapper .neon-search-box select option {
	background-color: #111;
	color: #fff;
}

#mercenary-wrapper .neon-search-box button {
	color: var(--mc-neon);
}

/* 3. 카테고리 버튼 */
#mercenary-wrapper .btn-category {
	border: 1px solid #ccc;
	background-color: #fff;
	color: #555;
	font-weight: 600;
	font-size: 0.9rem;
}

#mercenary-wrapper .btn-category:hover, #mercenary-wrapper .btn-category.active
	{
	background-color: var(--mc-dark);
	color: #fff;
	border-color: var(--mc-dark);
}

/* [핵심 2] 페이징 강제 가로 정렬 
   ${paging} 안에 div나 ul이 있어도 무시하고 내부 링크들을 가로로 배치합니다.
*/
.page-navigation {
    display: flex;
    justify-content: center;
    align-items: center;
    gap: 8px;
    margin-top: 40px;
    margin-bottom: 20px;
}

/* ${paging} 내부의 div나 ul 대응 */
.page-navigation > div,
.page-navigation > ul {
    display: flex !important;
    gap: 8px;
    list-style: none;
    padding: 0;
    margin: 0;
}

/* 숫자 버튼 및 이전/다음 버튼 스타일 (중요: 원형 제거, 둥근 사각형 적용) */
.page-navigation a, 
.page-navigation b,
.page-navigation span,
.page-navigation li a { 
    display: inline-flex;
    align-items: center;
    justify-content: center;
    width: 38px;
    height: 38px;
    border-radius: 12px !important; /* 자유게시판과 동일한 둥근 사각형 */
    text-decoration: none;
    font-size: 0.95rem;
    font-weight: 600;
    transition: all 0.2s ease;
    color: #666;
    background-color: #f8f9fa;
    border: 1px solid #eee !important; /* 테두리 다시 살리기 */
}

/* 현재 페이지 강조 (검정 배경 + 형광 글씨) */
.page-navigation b,
.page-navigation .active,
.page-navigation li.active a {
    background-color: #111 !important;
    color: #D4F63F !important;
    border-color: #111 !important;
    box-shadow: 0 4px 12px rgba(0,0,0,0.15);
}

/* 마우스 올렸을 때 */
.page-navigation a:hover,
.page-navigation li a:hover {
    background-color: #111;
    color: #D4F63F;
    border-color: #111;
    transform: translateY(-2px);
}
</style>
</head>
<body>

	<jsp:include page="/WEB-INF/views/layout/header.jsp" />

	<main class="container-fluid px-lg-5 mt-5 mb-5">
		<div class="row justify-content-center">
			<div class="col-lg-10">

				<div id="mercenary-wrapper">

					<div
						class="d-flex justify-content-between align-items-end mb-4 border-bottom pb-3">
						<div>
							<h2 class="fw-bold display-6 mb-1">MERCENARY</h2>
							<p class="text-muted mb-0">함께 뛸 용병을 찾거나 지원하세요.</p>
						</div>
						<button type="button"
							class="btn btn-dark rounded-pill px-4 fw-bold shadow-sm"
							style="color: #D4F63F;"
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
							<form name="searchForm" class="d-flex justify-content-md-end"
								onsubmit="return false;">
								<div class="neon-search-box px-3 w-100">
									<select name="schType" style="width: auto;">
										<option value="all" ${schType=="all"?"selected":""}>전체</option>
										<option value="subject" ${schType=="title"?"selected":""}>제목</option>
										<option value="content" ${schType=="content"?"selected":""}>내용</option>
										<option value="userName"
											${schType=="member_code"?"selected":""}>작성자</option>
									</select> <input type="text" name="kwd" value="${kwd}"
										class="w-100 px-2" placeholder="검색어...">

									<button type="button"
										class="btn btn-link p-0 text-decoration-none"
										onclick="searchList()">
										<i class="bi bi-search"></i>
									</button>
								</div>
							</form>
						</div>
					</div>

					<div class="shadow-sm border rounded-3 overflow-hidden">
						<table>
							<colgroup>
								<col width="80">
								<col width="*">
								<col width="150">
								<col width="80">
							</colgroup>
							<thead>
								<tr>
									<th>번호</th>
									<th>제목</th>
									<th>작성일</th>
									<th>조회수</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="dto" items="${list}">
									<tr
										onclick="location.href='${pageContext.request.contextPath}/mercenary/article?recruit_id=${dto.recruit_id}&page=${page}';">
										<td class="text-center">${dto.recruit_id}</td>
										<td class="fw-bold ps-3">${dto.title}</td>
										<td class="text-center text-muted">${dto.created_at}</td>
										<td class="text-center"><span
											class="badge rounded-pill bg-light text-dark border">${dto.view_count}</span></td>
									</tr>
								</c:forEach>
								<c:if test="${empty list}">
									<tr>
										<td colspan="4" class="py-5 text-center text-muted">등록된
											게시글이 없습니다.</td>
									</tr>
								</c:if>
							</tbody>
						</table>
					</div>

					<div class="page-nav-wrap page-navigation">
						<c:if test="${dataCount != 0}">
         				${paging}
    					</c:if>
					</div>

				</div>
			</div>
		</div>
	</main>

	<script>
		function searchList() {
			const f = document.searchForm;
			if (!f.kwd.value.trim()) {
				f.kwd.focus();
				return;
			}
			f.method = "get";
			f.action = "${pageContext.request.contextPath}/mercenary/list";
			f.submit();
		}

		const inputEL = document
				.querySelector("#mercenary-wrapper input[name=kwd]");
		if (inputEL) {
			inputEL.addEventListener('keydown', function(evt) {
				if (evt.key === 'Enter') {
					evt.preventDefault();
					searchList();
				}
			});
		}
	</script>

	<footer>
		<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
	</footer>
	<jsp:include page="/WEB-INF/views/layout/footerResources.jsp" />
</body>
</html>