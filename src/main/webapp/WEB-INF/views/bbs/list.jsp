<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>자유게시판 - Footlog</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/style.css">
    
    <style>
        .board-table thead th { background-color: #111; color: #fff; border: none; padding: 15px; font-weight: 700; }
        .board-table tbody tr { transition: 0.2s; cursor: pointer; }
        .board-table tbody tr:hover { background-color: rgba(212, 246, 63, 0.1); transform: translateY(-2px); box-shadow: 0 5px 15px rgba(0,0,0,0.05); }
        .btn-category { border: 1px solid #ddd; color: #666; font-size: 0.9rem; font-weight: 600; text-decoration: none; }
        .btn-category:hover, .btn-category.active { background-color: #111; color: #fff; border-color: #111; }
        .neon-search-box { background-color: #111; border: 2px solid #333; transition: 0.3s; height: 40px; max-width: 350px; font-size: 0.9rem; }
        .neon-search-box:hover, .neon-search-box:focus-within { border-color: #D4F63F; box-shadow: 0 0 10px rgba(212, 246, 63, 0.2); }
        .neon-search-box select { background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 16 16'%3e%3cpath fill='none' stroke='%23ffffff' stroke-linecap='round' stroke-linejoin='round' stroke-width='2' d='m2 5 6 6 6-6'/%3e%3c/svg%3e"); background-size: 10px; }
    
    /* 페이징 디자인 추가 */
.page-navigation {
    display: flex;
    justify-content: center;
    align-items: center;
    gap: 8px; /* 숫자 사이 간격 */
}

/* 모든 숫자와 이전/다음 버튼 */
.page-navigation a, 
.page-navigation b {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    width: 38px;
    height: 38px;
    border-radius: 12px; /* 둥근 사각형 */
    text-decoration: none;
    font-size: 0.95rem;
    font-weight: 600;
    transition: all 0.2s ease;
}

/* 현재 페이지 (b 태그로 강조된 경우) */
.page-navigation b {
    background-color: #111;
    color: #D4F63F !important; /* 사이트 포인트 형광색 */
    box-shadow: 0 4px 12px rgba(0,0,0,0.15);
}

/* 이동 가능한 숫자 (a 태그) */
.page-navigation a {
    color: #666;
    background-color: #f8f9fa;
    border: 1px solid #eee;
}

/* 마우스 올렸을 때 */
.page-navigation a:hover {
    background-color: #111;
    color: #D4F63F;
    border-color: #111;
    transform: translateY(-2px);
}
    
    </style>
</head>
<jsp:include page="/WEB-INF/views/layout/headerResources.jsp"/>
<body>
    <header>
        <jsp:include page="/WEB-INF/views/layout/header.jsp"/>
    </header>

    <div class="container-fluid px-lg-5 mt-5 mb-5">
        <div class="row">
            <div class="col-lg-2 d-none d-lg-block">
                <div class="sidebar-menu sticky-top" style="top: 100px;">
                    <p class="sidebar-title">Board List</p>
                    <div class="list-group">
                        <a href="${pageContext.request.contextPath}/bbs/list?category=1" class="list-group-item list-group-item-action ${category==1?'active bg-dark text-white border-0 fw-bold':''}">공지사항</a>
                        <a href="${pageContext.request.contextPath}/bbs/list?category=2" class="list-group-item list-group-item-action ${category==2?'active bg-dark text-white border-0 fw-bold':''}">자유 게시판</a>
                        <a href="${pageContext.request.contextPath}/bbs/list?category=3" class="list-group-item list-group-item-action ${category==3?'active bg-dark text-white border-0 fw-bold':''}">이벤트 / 뉴스</a>
                    </div>
                </div>
            </div>

            <div class="col-lg-9 col-12 ms-lg-4">
                <div class="d-flex justify-content-between align-items-end mb-4 border-bottom pb-3">
                    <div>
                        <h2 class="fw-bold display-6 mb-1">FREE BOARD</h2>
                        <p class="text-muted mb-0">축구 팬들과 자유롭게 소통하세요.</p>
                    </div>
                    <a href="${pageContext.request.contextPath}/bbs/write?category=${category}" class="btn btn-dark rounded-pill px-4 fw-bold shadow-sm" style="color: #D4F63F;">
                        🖊️ 글쓰기
                    </a>
                </div>

                <div class="row g-2 align-items-center mb-4">
                    <div class="col-md-6">
                        <div class="d-flex gap-2">
                            <a href="${pageContext.request.contextPath}/bbs/list" class="btn btn-category rounded-pill px-3 ${empty category or category==0 ? 'active' : ''}">전체</a>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <form action="${pageContext.request.contextPath}/bbs/list" method="get" class="d-flex justify-content-md-end">
                            <input type="hidden" name="category" value="${category}">
                            <div class="neon-search-box d-flex align-items-center rounded-pill px-2 w-100">
                                <select name="schType" class="form-select border-0 text-white bg-transparent py-0" style="width: auto; font-size: 0.9em;">
                                    <option value="all" ${schType=='all'?'selected':''} class="text-dark">전체</option>
                                    <option value="title" ${schType=='title'?'selected':''} class="text-dark">제목</option>
                                    <option value="content" ${schType=='content'?'selected':''} class="text-dark">내용</option>
                                </select>
                                <input type="text" name="kwd" value="${kwd}" class="form-control border-0 bg-transparent text-white py-0" placeholder="Search..." style="box-shadow: none; font-size: 0.9em;">
                                <button type="submit" class="btn btn-link text-decoration-none p-2" style="color: #D4F63F;">🔍</button>
                            </div>
                        </form>
                    </div>
                </div>

                <div class="modern-card p-0 overflow-hidden shadow-sm">
                    <table class="table table-hover board-table mb-0 text-center align-middle">
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
                                <tr onclick="location.href='${pageContext.request.contextPath}/bbs/article?board_main_code=${dto.board_main_code}&page=${page}&category=${category}'">
                                    <td>${dataCount - (page-1)*10 - status.index}</td>
                                    <td>
                                        <span class="badge ${dto.category==1?'bg-danger':(dto.category==2?'bg-primary':'bg-success')} bg-opacity-10 ${dto.category==1?'text-danger':(dto.category==2?'text-primary':'text-success')} border">
                                            ${dto.category==1?'공지':(dto.category==2?'자유':'이벤트')}
                                        </span>
                                    </td>
                                    <td class="text-start fw-bold">
                                        ${dto.title}
                                        <c:if test="${dto.replyCount > 0}">
                                            <span class="text-danger small ms-1">[${dto.replyCount}]</span>
                                        </c:if>
                                    </td>
                                    <td>${dto.member_name}</td>
                                    <td>${dto.created_at}</td>
                                    <td>${dto.view_count}</td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty list}">
                                <tr><td colspan="6" class="py-5 text-muted">등록된 게시글이 없습니다.</td></tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
                
                <div class="page-navigation mt-5 text-center">
                    ${paging}
                </div>
            </div> 
        </div> 
    </div> 
    <footer>
        <jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
    </footer>
    <jsp:include page="/WEB-INF/views/layout/footerResources.jsp"/>
</body>
</html>