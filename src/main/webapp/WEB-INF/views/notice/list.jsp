<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <title>공지사항 - Footlog</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/style.css">
    
    <style>
        /* 공지사항 전용 스타일 */
        .board-table thead th { background-color: #111; color: #fff; border: none; padding: 15px; font-weight: 700; }
        .board-table tbody tr { transition: 0.2s; cursor: pointer; }
        .board-table tbody tr:hover { background-color: rgba(212, 246, 63, 0.05); transform: translateY(-2px); box-shadow: 0 5px 15px rgba(0,0,0,0.05); }
        
        /* 중요 공지(필독) 강조 스타일 */
        .tr-notice-important { background-color: #f8f9fa; border-left: 5px solid var(--primary-color, #D4F63F); }
        .tr-notice-important td { font-weight: bold; color: #333; }
        .badge-must-read { background-color: #ff4d4d; color: white; border: none; }
        
        /* 검색창 스타일 */
        .neon-search-box {
            background-color: #111; border: 2px solid #333; transition: 0.3s;
            height: 40px; max-width: 350px; font-size: 0.9rem;
        }
        .neon-search-box:hover, .neon-search-box:focus-within {
            border-color: var(--primary-color, #D4F63F); box-shadow: 0 0 10px rgba(212, 246, 63, 0.2);
        }

        /* 페이징 버튼 스타일 (하드코딩용) */
        .pagination .page-link { color: #111; border: none; border-radius: 50%; margin: 0 5px; width: 35px; height: 35px; display: flex; align-items: center; justify-content: center; font-weight: 600; }
        .pagination .page-item.active .page-link { background-color: #111; color: var(--primary-color, #D4F63F); }
        .pagination .page-item.disabled .page-link { color: #ccc; background: transparent; }
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
                        <a href="${pageContext.request.contextPath}/notice/list" class="list-group-item list-group-item-action active bg-dark text-white border-0 fw-bold">
                            공지사항
                        </a>
                        <a href="${pageContext.request.contextPath}/bbs/list" class="list-group-item list-group-item-action">자유 게시판</a>
                        <a href="${pageContext.request.contextPath}/photo/list" class="list-group-item list-group-item-action">갤러리</a>
                        <a href="${pageContext.request.contextPath}/event/list" class="list-group-item list-group-item-action">이벤트 / 뉴스</a>
                    </div>
                </div>
            </div>

            <div class="col-lg-9 col-12 ms-lg-4">
                
               <div class="d-flex justify-content-between align-items-end mb-4 border-bottom pb-3">
                    <div>
                        <h2 class="fw-bold display-6 mb-1">NOTICE</h2>
                        <p class="text-muted mb-0">Footlog의 주요 소식과 업데이트를 확인하세요.</p>
                    </div>
                    
                    <!-- 관리자만 공지 등록이 보이게(일단 테스트니까 주석처리함) -->
                    <%-- <c:if test="${sessionScope.member.userId == 'admin'}"> --%>
				        <a href="${pageContext.request.contextPath}/notice/write" class="btn btn-dark rounded-pill px-4 fw-bold shadow-sm" style="color: var(--primary-color);">
				            📢 공지 등록
				        </a>
				    <%-- </c:if> --%>
				    
                </div>

                <div class="row g-2 align-items-center mb-4">
                    <div class="col-md-6">
                        <span class="text-muted fw-bold">Total <span class="text-dark">15</span> 건</span>
                    </div>

                    <div class="col-md-6">
                        <form name="searchForm" action="#" method="get" class="d-flex justify-content-md-end">
                            <div class="neon-search-box d-flex align-items-center rounded-pill px-2 w-100">
                                <select name="schType" class="form-select border-0 text-white bg-transparent py-0" style="width: auto; cursor: pointer; font-size: 0.9em;">
                                    <option value="all" class="text-dark">전체</option>
                                    <option value="title" class="text-dark">제목</option>
                                    <option value="content" class="text-dark">내용</option>
                                </select>
                                <input type="text" name="kwd" class="form-control border-0 bg-transparent text-white py-0" placeholder="Search..." style="box-shadow: none; font-size: 0.9em;">
                                <button type="submit" class="btn btn-link text-decoration-none p-2 d-flex align-items-center" style="color: var(--primary-color, #D4F63F);">
                                    🔍
                                </button>
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
                            <tr class="tr-notice-important" onclick="location.href='${pageContext.request.contextPath}/notice/article?seq=100'">
                                <td><span class="text-danger fw-bold">📢</span></td>
                                <td><span class="badge badge-must-read rounded-pill px-2">필독</span></td>
                                <td class="text-start text-truncate fw-bold">
                                    [긴급] 1월 10일 서버 정기 점검 안내 (02:00 ~ 06:00)
                                </td>
                                <td>관리자</td>
                                <td>2026.01.07</td>
                                <td>3,421</td>
                            </tr>
                            
                            <tr class="tr-notice-important" onclick="location.href='${pageContext.request.contextPath}/notice/article?seq=99'">
                                <td><span class="text-danger fw-bold">📢</span></td>
                                <td><span class="badge badge-must-read rounded-pill px-2">필독</span></td>
                                <td class="text-start text-truncate fw-bold">
                                    커뮤니티 이용 규정 안내 (필독 부탁드립니다)
                                </td>
                                <td>관리자</td>
                                <td>2026.01.01</td>
                                <td>15,201</td>
                            </tr>

                            <tr onclick="location.href='${pageContext.request.contextPath}/notice/article?seq=10'">
                                <td>10</td>
                                <td><span class="badge bg-secondary bg-opacity-10 text-secondary border">이벤트</span></td>
                                <td class="text-start text-truncate">
                                    1월 베스트 골(Goal) 영상 컨테스트 개최!
                                </td>
                                <td>운영팀</td>
                                <td>2026.01.06</td>
                                <td>854</td>
                            </tr>
                            <tr onclick="location.href='${pageContext.request.contextPath}/notice/article?seq=9'">
                                <td>9</td>
                                <td><span class="badge bg-secondary bg-opacity-10 text-secondary border">안내</span></td>
                                <td class="text-start text-truncate">
                                    레벨 포인트 정책 변경 안내
                                </td>
                                <td>관리자</td>
                                <td>2026.01.05</td>
                                <td>622</td>
                            </tr>
                            <tr onclick="location.href='${pageContext.request.contextPath}/notice/article?seq=8'">
                                <td>8</td>
                                <td><span class="badge bg-secondary bg-opacity-10 text-secondary border">업데이트</span></td>
                                <td class="text-start text-truncate">
                                    v2.1 패치 노트 (다크모드 오류 수정)
                                </td>
                                <td>개발팀</td>
                                <td>2026.01.04</td>
                                <td>410</td>
                            </tr>
                            <tr onclick="location.href='${pageContext.request.contextPath}/notice/article?seq=7'">
                                <td>7</td>
                                <td><span class="badge bg-secondary bg-opacity-10 text-secondary border">안내</span></td>
                                <td class="text-start text-truncate">
                                    불량 사용자 제재 명단 (1월 1주차)
                                </td>
                                <td>클린봇</td>
                                <td>2026.01.03</td>
                                <td>1,230</td>
                            </tr>
                            <tr onclick="location.href='${pageContext.request.contextPath}/notice/article?seq=6'">
                                <td>6</td>
                                <td><span class="badge bg-secondary bg-opacity-10 text-secondary border">안내</span></td>
                                <td class="text-start text-truncate">
                                    개인정보 처리방침 개정 안내
                                </td>
                                <td>관리자</td>
                                <td>2025.12.28</td>
                                <td>230</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                
                <nav class="mt-5">
                    <ul class="pagination justify-content-center">
                        <li class="page-item disabled"><a class="page-link" href="#">&lt;</a></li>
                        <li class="page-item active"><a class="page-link" href="#">1</a></li>
                        <li class="page-item"><a class="page-link" href="#">2</a></li>
                        <li class="page-item"><a class="page-link" href="#">3</a></li>
                        <li class="page-item"><a class="page-link" href="#">4</a></li>
                        <li class="page-item"><a class="page-link" href="#">5</a></li>
                        <li class="page-item"><a class="page-link" href="#">&gt;</a></li>
                    </ul>
                </nav>

            </div> 
        </div> 
    </div> 
    <footer>
	   <jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
	</footer>

	<jsp:include page="/WEB-INF/views/layout/footerResources.jsp"/>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>