<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <title>Footlog - 팀 게시판</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <jsp:include page="/WEB-INF/views/layout/headerResources.jsp"/>
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/style.css?ver=2">
    
    <style>
        .sidebar-title { font-size: 0.85rem; font-weight: 700; color: #6c757d; text-transform: uppercase; letter-spacing: 0.5px; }
        
        /* 게시판 전용 테이블 스타일 */
        .board-table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
        }
        .board-table th {
            border-bottom: 2px solid #111;
            padding: 15px 10px;
            font-weight: 700;
            color: #333;
            background-color: #fff;
        }
        .board-table td {
            padding: 15px 10px;
            border-bottom: 1px solid #f1f3f5;
            color: #555;
            vertical-align: middle;
        }
        .board-table tr:hover td {
            background-color: #f8f9fa;
        }
        
        /* 제목 링크 스타일 */
        .subject-link {
            text-decoration: none;
            color: #333;
            font-weight: 600;
            transition: color 0.2s;
            display: block; /* 클릭 영역 확대 */
        }
        .subject-link:hover {
            color: #000;
            text-decoration: underline;
            text-underline-offset: 4px;
            text-decoration-color: var(--primary-color, #D4F63F);
        }
        
        /* 검색창 스타일 */
        .search-select {
            border-radius: 50px 0 0 50px;
            border: 1px solid #dee2e6;
            background-color: #f8f9fa;
        }
        .search-input {
            border: 1px solid #dee2e6;
            border-left: none;
            border-right: none;
        }
        .search-btn {
            border-radius: 0 50px 50px 0;
            border: 1px solid #dee2e6;
            background-color: #111;
            color: #fff;
        }
        
        /* 페이징 (기존 갤러리와 동일하게 유지) */
        .page-navigation {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 5px;
            margin-top: 30px;
        }
        .page-navigation a, .page-navigation span {
            display: inline-flex;
            justify-content: center;
            align-items: center;
            min-width: 32px;
            height: 32px;
            padding: 0 6px;
            border-radius: 50%;
            text-decoration: none;
            color: #888;
            font-size: 0.9rem;
            font-weight: 600;
        }
        .page-navigation a:hover { background-color: #f1f3f5; color: #333; }
        .page-navigation .active { background-color: #111; color: #D4F63F !important; cursor: default; }
    </style>
    
    <script type="text/javascript">
        function searchList() {
            const f = document.searchForm;
            f.submit();
        }
    </script>
</head>

<body>

    <header>
       <jsp:include page="/WEB-INF/views/layout/teamheader.jsp"/>
    </header>

    <div class="container-fluid px-lg-5 mt-4">
        <div class="row">
            
            <div class="col-lg-2 d-none d-lg-block">
                <div class="sidebar-menu sticky-top" style="top: 100px;">
                    <div class="mb-4">
                        <p class="sidebar-title mb-3">구단 커뮤니티</p>
                        <div class="list-group">
                            <a href="${pageContext.request.contextPath}/myteam/board?teamCode=${teamCode}" class="list-group-item list-group-item-action border-0 active fw-bold bg-light text-primary">
                                <i class="bi bi-card-text me-1"></i> 팀 게시판
                            </a>
                            <a href="${pageContext.request.contextPath}/myteam/schedule?teamCode=${teamCode}" class="list-group-item list-group-item-action border-0">
                                전체 일정
                            </a>
                            <a href="${pageContext.request.contextPath}/myteam/vote?teamCode=${teamCode}" class="list-group-item list-group-item-action border-0">
                                참석 여부
                            </a>                            
                            <a href="${pageContext.request.contextPath}/myteam/gallery?teamCode=${teamCode}" class="list-group-item list-group-item-action border-0">
                                팀 갤러리
                            </a>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-lg-10 col-12">
                
                <div class="d-flex justify-content-between align-items-center mb-4 border-bottom pb-3">
                    <div>
                        <h2 class="fw-bold display-6 mb-1 text-dark">TEAM BOARD</h2>
                        <p class="text-muted mb-0">팀원들과 자유롭게 소통하는 공간입니다.</p>
                    </div>
                </div>

                <div class="d-flex justify-content-between align-items-center mb-4">
                    <div class="text-muted small">
                        전체 <span class="fw-bold text-dark">${dataCount}</span>개 / <span class="fw-bold text-dark">${total_page}</span>페이지
                    </div>
                    
                    <c:if test="${myRoleLevel >= 1}"> <button type="button" class="btn btn-dark rounded-pill px-4 fw-bold" 
                                onclick="location.href='${pageContext.request.contextPath}/myteam/board_write?teamCode=${teamCode}';">
                            <i class="bi bi-pencil-fill me-1"></i> 글쓰기
                        </button>
                    </c:if>
                </div>

                <div class="card border-0 shadow-sm" style="border-radius: 15px; overflow: hidden;">
                    <div class="card-body p-0">
                        <table class="board-table table-hover">
                            <colgroup>
                                <col width="60">  <col width="*">   <col width="100"> <col width="100"> <col width="70">  </colgroup>
                            <thead>
                                <tr class="text-center">
                                    <th>번호</th>
                                    <th>제목</th>
                                    <th>작성자</th>
                                    <th>날짜</th>
                                    <th>조회</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="dto" items="${list}" varStatus="status">
                                    <tr class="text-center">
                                        <td>${dataCount - (page-1) * size - status.index}</td>
                                        <td class="text-start ps-3">
                                            <a href="${articleUrl}&board_team_code=${dto.board_team_code}" class="subject-link text-truncate" style="max-width: 500px;">
                                                ${dto.subject}
                                                <c:if test="${dto.replyCount > 0}">
                                                    <span class="text-primary small fw-bold ms-1">[${dto.replyCount}]</span>
                                                </c:if>
                                                <c:if test="${dto.gap < 24}">
                                                     <span class="badge bg-danger rounded-pill ms-1" style="font-size: 0.6rem;">N</span>
                                                </c:if>
                                            </a>
                                        </td>
                                        <td>${dto.user_name}</td>
                                        <td>${dto.reg_date}</td>
                                        <td>${dto.hit_count}</td>
                                    </tr>
                                </c:forEach>
                                
                                <c:if test="${dataCount == 0}">
                                    <tr>
                                        <td colspan="5" class="text-center py-5 text-muted">
                                            등록된 게시글이 없습니다.
                                        </td>
                                    </tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>

                <div class="page-navigation mb-5">
                    ${paging}
                </div>

                <div class="d-flex justify-content-center mb-5">
                    <form name="searchForm" action="${pageContext.request.contextPath}/myteam/board" method="get" class="d-flex">
                        <input type="hidden" name="teamCode" value="${teamCode}">
                        
                        <select name="condition" class="form-select search-select shadow-none" style="width: 120px;">
                            <option value="all" ${condition=="all"?"selected":""}>제목+내용</option>
                            <option value="subject" ${condition=="subject"?"selected":""}>제목</option>
                            <option value="content" ${condition=="content"?"selected":""}>내용</option>
                            <option value="userName" ${condition=="userName"?"selected":""}>작성자</option>
                            <option value="reg_date" ${condition=="reg_date"?"selected":""}>등록일</option>
                        </select>
                        
                        <input type="text" name="keyword" value="${keyword}" class="form-control search-input shadow-none" placeholder="검색어를 입력하세요" style="width: 250px;">
                        
                        <button type="button" class="btn search-btn px-3" onclick="searchList()">
                            <i class="bi bi-search"></i>
                        </button>
                    </form>
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