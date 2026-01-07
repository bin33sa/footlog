<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>자유게시판 - Footlog</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/style.css">
    
    <style>
        /* 1. 게시판 테이블 스타일 */
        .board-table thead th { background-color: #111; color: #fff; border: none; padding: 15px; font-weight: 700; }
        .board-table tbody tr { transition: 0.2s; cursor: pointer; }
        .board-table tbody tr:hover { background-color: rgba(212, 246, 63, 0.1); transform: translateY(-2px); box-shadow: 0 5px 15px rgba(0,0,0,0.05); }
        
        /* 2. 페이지네이션 */
        .pagination .page-link { color: #111; border: none; border-radius: 50%; margin: 0 5px; width: 40px; height: 40px; display: flex; align-items: center; justify-content: center; }
        .pagination .page-item.active .page-link { background-color: #111; color: var(--primary-color); font-weight: bold; }
        
        /* 3. 카테고리 버튼 */
        .btn-category { border: 1px solid #ddd; color: #666; font-size: 0.9rem; font-weight: 600; }
        .btn-category:hover, .btn-category.active { background-color: #111; color: #fff; border-color: #111; }

        /* 4. [수정] 네온 검색창 스타일 (사이즈 축소 및 최적화) */
        .neon-search-box {
            background-color: #111; /* 딥 블랙 */
            border: 2px solid #333;
            transition: 0.3s;
            height: 40px; /* 높이 50px -> 40px로 축소 */
            max-width: 350px; /* 너무 길어지지 않게 너비 제한 */
            font-size: 0.9rem; /* 글자 크기 살짝 줄임 */
        }
        .neon-search-box:hover,
        .neon-search-box:focus-within {
            border-color: var(--primary-color, #D4F63F); /* 호버 시 네온 컬러 */
            box-shadow: 0 0 10px rgba(212, 246, 63, 0.2);
        }
        .neon-search-box input::placeholder { color: #888; }
        
        /* Select 화살표를 흰색으로 변경 */
        .neon-search-box select {
            background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 16 16'%3e%3cpath fill='none' stroke='%23ffffff' stroke-linecap='round' stroke-linejoin='round' stroke-width='2' d='m2 5 6 6 6-6'/%3e%3c/svg%3e");
            background-size: 10px; /* 화살표 크기 조절 */
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
                        <a href="${pageContext.request.contextPath}/notice/list" class="list-group-item list-group-item-action">공지사항</a>
                        <a href="${pageContext.request.contextPath}/bbs/list" class="list-group-item list-group-item-action active bg-dark text-white border-0 fw-bold">
                            자유 게시판
                        </a>
                        <a href="${pageContext.request.contextPath}/photo/list" class="list-group-item list-group-item-action">갤러리</a>
                        <a href="${pageContext.request.contextPath}/event/list" class="list-group-item list-group-item-action">이벤트 / 뉴스</a>
                    </div>
                </div>
            </div>

            <div class="col-lg-9 col-12 ms-lg-4">
                
                <div class="d-flex justify-content-between align-items-end mb-4 border-bottom pb-3">
                    <div>
                        <h2 class="fw-bold display-6 mb-1">FREE BOARD</h2>
                        <p class="text-muted mb-0">자유롭게 축구 이야기를 나누는 공간입니다.</p>
                    </div>
                    <a href="${pageContext.request.contextPath}/bbs/write" class="btn btn-dark rounded-pill px-4 fw-bold shadow-sm" style="color: var(--primary-color);">
                        🖊️ 글쓰기
                    </a>
                </div>

                <div class="row g-2 align-items-center mb-4">
                    <div class="col-md-6">
                        <div class="d-flex gap-2">
                            <a href="?category=all" class="btn btn-category rounded-pill px-3 active">전체</a>
                            <a href="?category=chat" class="btn btn-category rounded-pill px-3">잡담</a>
                            <a href="?category=info" class="btn btn-category rounded-pill px-3">정보</a>
                            <a href="?category=review" class="btn btn-category rounded-pill px-3">후기</a>
                        </div>
                    </div>

                    <div class="col-md-6">
                        <form action="${pageContext.request.contextPath}/bbs/list" method="get" class="d-flex justify-content-md-end">
                            <div class="neon-search-box d-flex align-items-center rounded-pill px-2 w-100">
                                <select name="key" class="form-select border-0 text-white bg-transparent py-0" style="width: auto; cursor: pointer; font-size: 0.9em;">
                                    <option value="title" class="text-dark">제목</option>
                                    <option value="content" class="text-dark">내용</option>
                                    <option value="writer" class="text-dark">작성자</option>
                                </select>
                                
                                <input type="text" name="keyword" class="form-control border-0 bg-transparent text-white py-0" placeholder="Search..." style="box-shadow: none; font-size: 0.9em;">
        
                                <button type="submit" class="btn btn-link text-decoration-none p-2 d-flex align-items-center" style="color: var(--primary-color);">
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
                            <tr onclick="location.href='${pageContext.request.contextPath}/bbs/article?seq=1'">
                                <td>10</td>
                                <td><span class="badge bg-light text-dark border">잡담</span></td>
                                <td class="text-start fw-bold">
                                    집가고싶다... 호호우
                                    <span class="text-danger small ms-1">[2]</span><!-- 댓글 개수 -->
                                </td>
                                <td>호날두</td> <!-- 작성자 -->
                                <td>2026.01.06</td> <!-- 날짜 -->
                                <td>52</td> <!-- 조회수 -->
                            </tr>
                            <tr onclick="location.href='${pageContext.request.contextPath}/bbs/article?seq=2'">
                                <td>9</td>
                                <td><span class="badge bg-info bg-opacity-10 text-info border border-info">정보</span></td>
                                <td class="text-start">
                                    이번 주말 상암 보조경기장 예약 꿀팁 공유합니다
                                </td>
                                <td>관리자</td>
                                <td>2025.05.22</td>
                                <td>124</td>
                            </tr>
                            <tr onclick="location.href='${pageContext.request.contextPath}/bbs/article?seq=8'">
                                <td>8</td>
                                <td><span class="badge bg-success bg-opacity-10 text-success border border-success">후기</span></td>
                                <td class="text-start">FC 슛돌이 용병 참여 후기 (매너 굿)</td>
                                <td>메시</td>
                                <td>2025.05.21</td>
                                <td>88</td>
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