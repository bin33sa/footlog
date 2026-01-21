<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>${boardName}- Footlog</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/style.css">

<style>
/* 기존 스타일 유지 */
.sidebar-title { font-weight: 800; font-size: 1.2rem; margin-bottom: 1.5rem; color: #111; }
.list-group-item { border: none; padding: 12px 20px; border-radius: 10px !important; margin-bottom: 5px; transition: 0.2s; cursor: pointer; }
.list-group-item:hover { background-color: #f8f9fa; }

.board-table thead th { background-color: #111; color: #fff; border: none; padding: 15px; font-weight: 700; text-align: center; }
.board-table tbody tr { transition: 0.2s; cursor: pointer; border-bottom: 1px solid #eee; }
.board-table tbody tr:hover { background-color: rgba(212, 246, 63, 0.05); }

.gallery-img-wrapper { position: relative; width: 100%; padding-top: 66.66% !important; overflow: hidden; background-color: #f8f9fa; border-radius: 12px 12px 0 0; }
.gallery-card { transition: 0.3s; border-radius: 15px; overflow: hidden; border: 1px solid #eee; cursor: pointer; height: 100%; }
.gallery-card:hover { transform: translateY(-8px); box-shadow: 0 10px 20px rgba(0,0,0,0.1); border-color: #D4F63F; }
.gallery-img-wrapper img { position: absolute; top: 0; left: 0; width: 100%; height: 100%; object-fit: cover; }

.page-navigation { display: flex; justify-content: center; align-items: center; margin: 40px 0; gap: 8px; }
.page-navigation a, .page-navigation span, .page-navigation b { 
    display: inline-flex; align-items: center; justify-content: center;
    width: 38px; height: 38px; border-radius: 10px; text-decoration: none !important;
    font-size: 0.9rem; font-weight: 600; color: #666; background-color: #fff; border: 1px solid #eee; transition: 0.2s;
}
.page-navigation a:hover { background-color: #111; border-color: #111; color: #fff !important; transform: translateY(-2px); }
.page-navigation span, .page-navigation b { background-color: #111 !important; color: #D4F63F !important; border-color: #111 !important; cursor: default; }

.neon-search-box { background-color: #111; border: 2px solid #333; height: 40px; max-width: 350px; overflow: hidden; border-radius: 50px; }
.neon-search-box:focus-within { border-color: #D4F63F; }
.neon-search-box select, .neon-search-box input { color: #fff !important; }
.neon-search-box option { background-color: #fff; color: #000; }
.btn-category { border: 1px solid #ddd; color: #666; font-size: 0.9rem; font-weight: 600; text-decoration: none; border-radius: 50px; padding: 5px 20px; }
.btn-category.active { background-color: #111; color: #D4F63F; border-color: #111; }
</style>
</head>

<body>
	<header><jsp:include page="/WEB-INF/views/layout/header.jsp" /></header>

	<div class="container-fluid px-lg-5 mt-5 mb-5">
		<div class="row">
			<%-- 사이드바 --%>
			<div class="col-lg-2 d-none d-lg-block">
				<div class="sidebar-menu sticky-top" style="top: 100px;">
					<p class="sidebar-title">MENU</p>
					<div class="list-group">
						<a href="${pageContext.request.contextPath}/bbs/list?category=1" class="list-group-item list-group-item-action ${category==1?'active bg-dark text-white fw-bold':''}">공지사항</a>
						<a href="${pageContext.request.contextPath}/bbs/list?category=2" class="list-group-item list-group-item-action ${category==2?'active bg-dark text-white fw-bold':''}">자유 게시판</a>
						<a href="${pageContext.request.contextPath}/bbs/list?category=3" class="list-group-item list-group-item-action ${category==3?'active bg-dark text-white fw-bold':''}">이벤트 / 뉴스</a>
						<a href="${pageContext.request.contextPath}/bbs/list?category=4" class="list-group-item list-group-item-action ${category==4?'active bg-dark text-white fw-bold':''}">갤러리</a>
					</div>
				</div>
			</div>

			<div class="col-lg-9 col-12 ms-lg-5">
				<div class="d-flex justify-content-between align-items-end mb-4 border-bottom pb-3">
					<div>
						<h2 class="fw-bold display-6 mb-1">${boardName}</h2>
						<p class="text-muted mb-0">${boardDesc}</p>
					</div>
					<c:if test="${not empty sessionScope.member}">
						<a href="${pageContext.request.contextPath}/bbs/write?category=${category}" class="btn btn-dark rounded-pill px-4 fw-bold shadow-sm" style="color: #D4F63F;"> 
							${category == 4 ? '📸 사진 등록' : '🖊️ 글쓰기'}
						</a>
					</c:if>
				</div>

				<div class="row g-2 align-items-center mb-4">
					<div class="col-md-6">
						<div class="d-flex gap-2">
							<a href="${pageContext.request.contextPath}/bbs/list?category=${category}&sortType=new&schType=${schType}&kwd=${kwd}" class="btn btn-category ${sortType == 'new' || empty sortType ? 'active' : ''}">최신순</a> 
							<a href="${pageContext.request.contextPath}/bbs/list?category=${category}&sortType=popular&schType=${schType}&kwd=${kwd}" class="btn btn-category ${sortType == 'popular' ? 'active' : ''}">인기순</a>
						</div>
					</div>
					
					<%-- [핵심 수정] 갤러리(category 4)가 아닐 때만 검색창 출력 --%>
					<c:if test="${category != 4}">
						<div class="col-md-6 text-end">
							<form action="${pageContext.request.contextPath}/bbs/list" method="get" class="d-inline-block w-100" style="max-width:350px;">
								<input type="hidden" name="category" value="${category}">
								<c:if test="${not empty sortType}"><input type="hidden" name="sortType" value="${sortType}"></c:if>
								
								<div class="neon-search-box d-flex align-items-center px-2">
									<select name="schType" class="form-select border-0 bg-transparent py-0" style="width: auto; font-size: 0.9em; box-shadow: none;">
										<option value="all" ${schType=='all'?'selected':''}>전체</option>
										<option value="title" ${schType=='title'?'selected':''}>제목</option>
										<option value="content" ${schType=='content'?'selected':''}>내용</option>
									</select> 
									<input type="text" name="kwd" value="${kwd}" class="form-control border-0 bg-transparent text-white py-0" placeholder="검색어..." style="box-shadow: none;">
									<button type="submit" class="btn btn-link text-decoration-none p-2" style="color: #D4F63F;">🔍</button>
								</div>
							</form>
						</div>
					</c:if>
				</div>

				<c:choose>
					<c:when test="${category == 4}">
						<%-- 갤러리 리스트 --%>
						<div class="row row-cols-1 row-cols-sm-2 row-cols-md-4 g-4">
							<c:forEach var="dto" items="${list}">
								<div class="col">
									<div class="card gallery-card shadow-sm" onclick="location.href='${pageContext.request.contextPath}/bbs/article?board_main_code=${dto.board_main_code}&page=${page}&category=${category}'">
										<div class="gallery-img-wrapper">
											<c:choose>
												<c:when test="${not empty dto.imageFilename}">
													<img src="${pageContext.request.contextPath}/uploads/gallery/${dto.imageFilename}" onerror="this.src='https://placehold.co/600x400?text=No+Image'">
												</c:when>
												<c:otherwise>
													<img src="https://placehold.co/600x400?text=No+Image">
												</c:otherwise>
											</c:choose>
										</div>
										<div class="card-body p-3">
											<h6 class="card-title fw-bold text-truncate mb-2">${dto.title}</h6>
											<div class="d-flex justify-content-between align-items-center small text-secondary">
												<span>${dto.member_name}</span> <span><i class="bi bi-eye"></i> ${dto.view_count}</span>
											</div>
										</div>
									</div>
								</div>
							</c:forEach>
						</div>
					</c:when>
					<c:otherwise>
						<%-- 일반 게시판 리스트 --%>
						<div class="table-responsive rounded-3 border shadow-sm overflow-hidden">
							<table class="table table-hover board-table mb-0">
								<thead>
									<tr>
										<th width="80">번호</th>
										<th class="text-start">제목</th>
										<th width="120">작성자</th>
										<th width="120">작성일</th>
										<th width="80">조회</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="dto" items="${list}" varStatus="status">
										<tr onclick="location.href='${pageContext.request.contextPath}/bbs/article?board_main_code=${dto.board_main_code}&page=${page}&category=${category}&schType=${schType}&kwd=${kwd}'">
											<td class="text-center">${dataCount - (page-1)*10 - status.index}</td>
											<td class="text-start fw-bold">
                                                ${dto.title}
                                                <c:if test="${dto.replyCount > 0}"><span class="text-danger small ms-1">[${dto.replyCount}]</span></c:if>
                                            </td>
											<td class="text-center">${dto.member_name}</td>
											<td class="text-center">${dto.created_at}</td>
											<td class="text-center">${dto.view_count}</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
					</c:otherwise>
				</c:choose>

				<c:if test="${empty list}">
					<div class="py-5 text-center text-muted border rounded-4 mt-4 bg-light">
						<h5 class="mb-0">게시글이 없습니다.</h5>
					</div>
				</c:if>

				<nav class="page-navigation">${paging}</nav>
			</div>
		</div>
	</div>

	<footer><jsp:include page="/WEB-INF/views/layout/footer.jsp" /></footer>
</body>
</html>