<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>1:1 문의 - Footlog</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/style.css">
    
    <style>
        /* 문의 게시판 전용 스타일 (제공된 디자인 가이드 적용) */
        .board-table thead th { background-color: #111; color: #fff; border: none; padding: 15px; font-weight: 700; }
        .board-table tbody tr { transition: 0.2s; cursor: pointer; }
        .board-table tbody tr:hover { background-color: rgba(212, 246, 63, 0.1); transform: translateY(-2px); box-shadow: 0 5px 15px rgba(0,0,0,0.05); }
        
        .neon-search-box { background-color: #111; border: 2px solid #333; transition: 0.3s; height: 40px; max-width: 350px; font-size: 0.9rem; }
        .neon-search-box:hover, .neon-search-box:focus-within { border-color: #D4F63F; box-shadow: 0 0 10px rgba(212, 246, 63, 0.2); }
        .neon-search-box select { background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 16 16'%3e%3cpath fill='none' stroke='%23ffffff' stroke-linecap='round' stroke-linejoin='round' stroke-width='2' d='m2 5 6 6 6-6'/%3e%3c/svg%3e"); background-size: 10px; }
    
        /* 페이징 디자인 */
        .page-navigation { display: flex; justify-content: center; align-items: center; gap: 8px; }
        .page-navigation a, .page-navigation b { display: inline-flex; align-items: center; justify-content: center; width: 38px; height: 38px; border-radius: 12px; text-decoration: none; font-size: 0.95rem; font-weight: 600; transition: all 0.2s ease; }
        .page-navigation b { background-color: #111; color: #D4F63F !important; box-shadow: 0 4px 12px rgba(0,0,0,0.15); }
        .page-navigation a { color: #666; background-color: #f8f9fa; border: 1px solid #eee; }
        .page-navigation a:hover { background-color: #111; color: #D4F63F; border-color: #111; transform: translateY(-2px); }

        /* 상태 배지 */
        .badge-qna { border-radius: 50px; padding: 5px 12px; font-weight: 600; font-size: 0.8rem; }
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
                    <p class="sidebar-title">Information</p>
                    <div class="list-group">
                        <a href="${pageContext.request.contextPath}/introduction" class="list-group-item list-group-item-action">사이트 소개</a>
                        <a href="${pageContext.request.contextPath}/qna/list" class="list-group-item list-group-item-action active bg-dark text-white border-0 fw-bold">1:1 문의 게시판</a>
                        <a href="${pageContext.request.contextPath}/faq/list" class="list-group-item list-group-item-action">자주 묻는 질문</a>
                    </div>
                </div>
            </div>

            <div class="col-lg-9 col-12 ms-lg-4">
                <div class="d-flex justify-content-between align-items-end mb-4 border-bottom pb-3">
                    <div>
                        <h2 class="fw-bold display-6 mb-1">문의 게시판</h2>
                        <p class="text-muted mb-0">궁금한 점을 남겨주시면 관리자가 신속하게 답변해 드립니다.</p>
                    </div>
                    <a href="${pageContext.request.contextPath}/qna/write" class="btn btn-dark rounded-pill px-4 fw-bold shadow-sm" style="color: #D4F63F;">
                        🖊️ 문의하기
                    </a>
                </div>

                <div class="row g-2 align-items-center mb-4">
                    <div class="col-md-6"></div>
                    <div class="col-md-6">
                        <form action="${pageContext.request.contextPath}/qna/list" method="get" class="d-flex justify-content-md-end">
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

                <div class="modern-card p-0 overflow-hidden shadow-sm border-0" style="border-radius: 15px;">
                    <table class="table table-hover board-table mb-0 text-center align-middle">
                        <thead>
                            <tr>
                                <th width="100">상태</th>
                                <th width="100">분류</th>
                                <th class="text-start">제목</th>
                                <th width="120">작성자</th>
                                <th width="120">날짜</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="dto" items="${list}">
                                <tr onclick="location.href='${pageContext.request.contextPath}/qna/article?board_qna_code=${dto.board_qna_code}&page=${page}'">
                                    <td>
                                        <c:choose>
                                            <c:when test="${dto.status == 2}">
                                                <span class="badge bg-dark text-primary badge-qna border border-dark">답변완료</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-light text-muted badge-qna border">답변대기</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <span class="text-muted small">
                                            ${dto.category==1?'계정':(dto.category==2?'구장':'기타')}
                                        </span>
                                    </td>
                                    <td class="text-start fw-bold">
                                        <i class="bi bi-lock-fill text-muted me-1"></i> ${dto.title}
                                    </td>
                                    <td>${dto.member_name}</td>
                                    <td class="text-muted small">${dto.created_at}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                    <c:if test="${empty list}">
                        <div class="py-5 text-center text-muted">등록된 문의가 없습니다.</div>
                    </c:if>
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