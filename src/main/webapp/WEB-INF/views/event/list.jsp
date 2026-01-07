<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <title>이벤트/뉴스 - Footlog</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/style.css">
    
    <style>
        .board-table thead th { background-color: #111; color: #fff; border: none; padding: 15px; font-weight: 700; }
        .board-table tbody tr { transition: 0.2s; cursor: pointer; }
        .board-table tbody tr:hover { background-color: rgba(212, 246, 63, 0.05); transform: translateY(-2px); box-shadow: 0 5px 15px rgba(0,0,0,0.05); }
        
        /* 카테고리별 배지 스타일 */
        .badge-event-ing { background-color: var(--primary-color, #D4F63F); color: #111; border: none; font-weight: 800; }
        .badge-event-end { background-color: #343a40; color: #fff; border: none; font-weight: 600; opacity: 0.8; }
        .badge-event-news { background-color: #fff; color: #666; border: 1px solid #ddd; font-weight: 600; }

        .neon-search-box {
            background-color: #111; border: 2px solid #333; transition: 0.3s;
            height: 40px; max-width: 350px; font-size: 0.9rem;
        }
        .neon-search-box:hover, .neon-search-box:focus-within {
            border-color: var(--primary-color, #D4F63F); box-shadow: 0 0 10px rgba(212, 246, 63, 0.2);
        }

        .paginate { text-align: center; }
        .paginate a, .paginate span {
            display: inline-block; padding: 8px 14px; margin: 0 4px;
            border-radius: 50%; color: #333; text-decoration: none; font-weight: 600; transition: 0.2s;
        }
        .paginate a:hover { background-color: #eee; }
        .paginate span { background-color: #111; color: #D4F63F; cursor: default; }
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
                        <a href="${pageContext.request.contextPath}/notice/list" class="list-group-item list-group-item-action">공지사항</a>
                        <a href="${pageContext.request.contextPath}/bbs/list" class="list-group-item list-group-item-action">자유 게시판</a>
                        <a href="${pageContext.request.contextPath}/photo/list" class="list-group-item list-group-item-action">갤러리</a>
                        <a href="${pageContext.request.contextPath}/event/list" class="list-group-item list-group-item-action active bg-dark text-white border-0 fw-bold">
                            이벤트 / 뉴스
                        </a>
                    </div>
                </div>
            </div>

            <div class="col-lg-9 col-12 ms-lg-4">
                
               <div class="d-flex justify-content-between align-items-end mb-4 border-bottom pb-3">
                    <div>
                        <h2 class="fw-bold display-6 mb-1">EVENT & NEWS</h2>
                        <p class="text-muted mb-0">Footlog의 풍성한 이벤트와 새로운 소식을 만나보세요.</p>
                    </div>
                    
                    <%-- 관리자 글쓰기 버튼 --%>
                    <a href="${pageContext.request.contextPath}/event/write" class="btn btn-dark rounded-pill px-4 fw-bold shadow-sm" style="color: var(--primary-color, #D4F63F);">
                        ✨ 이벤트 등록
                    </a>
                </div>

                <div class="row g-2 align-items-center mb-4">
                    <div class="col-md-6">
                        <span class="text-muted fw-bold">Total <span class="text-dark">12</span> 건</span>
                    </div>

                    <div class="col-md-6">
                        <form name="searchForm" action="${pageContext.request.contextPath}/event/list" method="get" class="d-flex justify-content-md-end">
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
                            <tr style="background-color: #fcfcfc; border-left: 5px solid #111;" onclick="location.href='${pageContext.request.contextPath}/event/article?seq=100'">
                                <td><span class="fw-bold text-danger">HOT</span></td>
                                <td><span class="badge badge-event-ing rounded-pill px-2">진행중</span></td>
                                <td class="text-start text-truncate fw-bold" style="max-width: 400px;">
                                    [신년 이벤트] 새해 첫 골(Goal)을 인증하세요! (상품: 유니폼)
                                </td>
                                <td>관리자</td>
                                <td>2026.01.01</td>
                                <td>5,421</td>
                            </tr>

                            <tr onclick="location.href='${pageContext.request.contextPath}/event/article?seq=10'">
                                <td>10</td>
                                <td><span class="badge badge-event-ing rounded-pill px-2">진행중</span></td>
                                <td class="text-start text-truncate" style="max-width: 400px;">
                                    풋로그 1주년 기념 포인트 2배 적립 이벤트
                                </td>
                                <td>운영팀</td>
                                <td>2026.01.05</td>
                                <td>1,203</td>
                            </tr>
                            <tr onclick="location.href='${pageContext.request.contextPath}/event/article?seq=9'">
                                <td>9</td>
                                <td><span class="badge badge-event-news rounded-pill px-2">News</span></td>
                                <td class="text-start text-truncate" style="max-width: 400px;">
                                    [인터뷰] 12월 랭킹 1위 '메시'님을 만나다
                                </td>
                                <td>에디터</td>
                                <td>2026.01.03</td>
                                <td>890</td>
                            </tr>
                            <tr onclick="location.href='${pageContext.request.contextPath}/event/article?seq=8'">
                                <td>8</td>
                                <td><span class="badge badge-event-end rounded-pill px-2">마감</span></td>
                                <td class="text-start text-truncate" style="max-width: 400px;">
                                    [종료] 크리스마스 매치 매칭 수수료 무료 이벤트
                                </td>
                                <td>관리자</td>
                                <td>2025.12.20</td>
                                <td>3,100</td>
                            </tr>
                             <tr onclick="location.href='${pageContext.request.contextPath}/event/article?seq=7'">
                                <td>7</td>
                                <td><span class="badge badge-event-news rounded-pill px-2">News</span></td>
                                <td class="text-start text-truncate" style="max-width: 400px;">
                                    풋로그 모바일 앱 출시 예정 안내 (2월 중)
                                </td>
                                <td>개발팀</td>
                                <td>2025.12.15</td>
                                <td>4,500</td>
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