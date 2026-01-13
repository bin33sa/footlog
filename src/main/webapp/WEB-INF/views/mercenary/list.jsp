<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Footlog - 용병 게시판</title>

<jsp:include page="/WEB-INF/views/layout/headerResources.jsp" />

<style>
/* [스타일 격리 전략]
   모든 CSS 선택자 앞에 #mercenary-wrapper를 붙입니다.
   이러면 이 스타일은 상단 헤더(header.jsp)에 절대로 영향을 줄 수 없습니다.
*/

/* 변수 선언 (이 페이지 전용) */
#mercenary-wrapper {
    --mc-neon: #D4F63F;
    --mc-dark: #111;
    --mc-border: #ddd;
}

/* 1. 테이블 스타일 */
#mercenary-wrapper table {
    width: 100%;
    border-collapse: collapse;
    background-color: #fff; /* 배경 흰색 고정 */
}

#mercenary-wrapper thead th {
    background-color: var(--mc-dark);
    color: #fff;
    padding: 15px;
    font-weight: 700;
    text-align: center;
    border: none;
    /* 헤더 세로 구분선 */
    border-left: 1px solid #444;
    border-right: 1px solid #444;
}
#mercenary-wrapper thead th:first-child { border-left: none; }
#mercenary-wrapper thead th:last-child { border-right: none; }

#mercenary-wrapper tbody tr {
    border-bottom: 1px solid var(--mc-border);
    transition: 0.2s;
}
#mercenary-wrapper tbody tr:hover {
    background-color: rgba(212, 246, 63, 0.1); /* 호버 효과 */
    cursor: pointer;
}

#mercenary-wrapper tbody td {
    padding: 12px;
    vertical-align: middle;
    color: #333;
    /* 본문 세로 구분선 */
    border-left: 1px solid #eee;
    border-right: 1px solid #eee;
}
#mercenary-wrapper tbody td:first-child { border-left: none; }
#mercenary-wrapper tbody td:last-child { border-right: none; }


/* 2. 네온 검색창 (헤더와 충돌 방지) */
#mercenary-wrapper .neon-search-box {
    background-color: var(--mc-dark);
    border: 2px solid #333;
    height: 40px;
    max-width: 350px;
    display: flex;
    align-items: center;
    border-radius: 50px; /* 둥글게 */
    overflow: hidden;
}

/* 부트스트랩 스타일 강제 덮어쓰기 (!important) */
#mercenary-wrapper .neon-search-box select {
    background-color: transparent !important;
    color: #fff !important;
    border: none !important;
    box-shadow: none !important;
    cursor: pointer;
}
#mercenary-wrapper .neon-search-box select option {
    background-color: #111;
    color: #fff;
}
#mercenary-wrapper .neon-search-box input {
    background-color: transparent !important;
    color: #fff !important;
    border: none !important;
    box-shadow: none !important;
}
#mercenary-wrapper .neon-search-box input::placeholder {
    color: #aaa;
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
#mercenary-wrapper .btn-category:hover, 
#mercenary-wrapper .btn-category.active {
    background-color: var(--mc-dark);
    color: #fff;
    border-color: var(--mc-dark);
}


/* 4. 페이징 */
#mercenary-wrapper .page-nav-wrap {
    display: flex;
    justify-content: center;
    margin-top: 40px;
    gap: 5px;
}
/* 페이징 내부의 a, span 태그 스타일 */
#mercenary-wrapper .page-nav-wrap a, 
#mercenary-wrapper .page-nav-wrap span,
#mercenary-wrapper .page-nav-wrap b { 
    display: flex;
    justify-content: center;
    align-items: center;
    width: 35px;
    height: 35px;
    border-radius: 50%;
    text-decoration: none;
    color: #333;
    font-size: 0.9rem;
    background: transparent;
}
#mercenary-wrapper .page-nav-wrap a:hover {
    background-color: rgba(0,0,0,0.05);
}
/* 현재 페이지 (b 태그로 가정) */
#mercenary-wrapper .page-nav-wrap b {
    background-color: var(--mc-dark);
    color: var(--mc-neon) !important;
}

</style>
</head>
<body>

    <jsp:include page="/WEB-INF/views/layout/header.jsp" />

    <main class="container-fluid px-lg-5 mt-5 mb-5">
        <div class="row justify-content-center">
            <div class="col-lg-10">
                
                <div id="mercenary-wrapper">

                    <div class="d-flex justify-content-between align-items-end mb-4 border-bottom pb-3">
                        <div>
                            <h2 class="fw-bold display-6 mb-1">MERCENARY</h2>
                            <p class="text-muted mb-0">함께 뛸 용병을 찾거나 지원하세요.</p>
                        </div>
                        <button type="button"
                            class="btn btn-dark rounded-pill px-4 fw-bold shadow-sm"
                            style="color: #D4F63F;"
                            onclick="location.href='${pageContext.request.contextPath}/mercenary/write';">
                            🖊️ 용병 등록
                        </button>
                    </div>

                    <div class="row g-2 align-items-center mb-4">
                        <div class="col-md-6">
                            <div class="d-flex gap-2">
                                <a href="${pageContext.request.contextPath}/mercenary/list"
                                    class="btn btn-category rounded-pill px-3 ${empty category ? 'active' : ''}">전체</a>
                                <a href="${pageContext.request.contextPath}/mercenary/list?category=1"
                                    class="btn btn-category rounded-pill px-3 ${category == '1' ? 'active' : ''}">구인</a>
                                <a href="${pageContext.request.contextPath}/mercenary/list?category=2"
                                    class="btn btn-category rounded-pill px-3 ${category == '2' ? 'active' : ''}">구직</a>
                            </div>
                        </div>

                        <div class="col-md-6">
                            <form name="searchForm" class="d-flex justify-content-md-end" onsubmit="return false;">
                                <div class="neon-search-box px-3 w-100">
                                    <select name="schType" style="width: auto;">
                                        <option value="all" ${schType=="all"?"selected":""}>전체</option>
                                        <option value="subject" ${schType=="title"?"selected":""}>제목</option>
                                        <option value="content" ${schType=="content"?"selected":""}>내용</option>
                                        <option value="userName" ${schType=="member_code"?"selected":""}>작성자</option>
                                    </select> 
                                    
                                    <input type="text" name="kwd" value="${kwd}" class="w-100 px-2" placeholder="검색어...">

                                    <button type="button" class="btn btn-link p-0 text-decoration-none" onclick="searchList()">
                                        <i class="bi bi-search"></i>
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>

                    <div class="shadow-sm border rounded-3 overflow-hidden">
                        <table>
                            <thead>
                                <tr>
                                    <th width="80">번호</th>
                                    <th>제목</th>
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
                                        <td><span class="badge rounded-pill bg-light text-dark border">${dto.view_count}</span></td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty list}">
                                    <tr>
                                        <td colspan="4" class="py-5 text-center text-muted">등록된 게시글이 없습니다.</td>
                                    </tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>

                    <div class="page-nav-wrap">
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
        if(!f.kwd.value.trim()) {
            f.kwd.focus();
            return;
        }
        f.method = "get"; // 검색은 보통 GET 방식
        f.action = "${pageContext.request.contextPath}/mercenary/list";
        f.submit();
    }
    
    // 엔터키 입력 시 검색 실행
    const inputEL = document.querySelector("#mercenary-wrapper input[name=kwd]");
    if(inputEL){
        inputEL.addEventListener('keydown', function (evt) {
            if(evt.key === 'Enter') {
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