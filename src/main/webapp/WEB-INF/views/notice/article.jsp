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
        /* 상세 페이지 전용 스타일 */
        .article-container { border-top: 2px solid #111; }
        
        /* 제목 영역 */
        .article-header { background-color: #f8f9fa; padding: 20px; border-bottom: 1px solid #ddd; }
        .article-title { font-weight: 700; font-size: 1.5rem; color: #111; margin-bottom: 10px; }
        .article-meta { font-size: 0.9rem; color: #666; }
        .article-meta span { margin-right: 15px; position: relative; }
        .article-meta span:not(:last-child)::after { content: ""; position: absolute; right: -8px; top: 3px; width: 1px; height: 12px; background: #ccc; }

        /* 본문 영역 */
        .article-body { min-height: 400px; padding: 40px 20px; font-size: 1rem; line-height: 1.8; color: #333; border-bottom: 1px solid #ddd; }
        
        /* 첨부파일 영역 */
        .article-attach { background-color: #fff; padding: 15px 20px; border-bottom: 1px solid #eee; display: flex; align-items: center; }
        .article-attach .label { font-weight: bold; margin-right: 15px; color: #111; }
        .btn-download { text-decoration: none; color: #555; font-size: 0.9rem; transition: 0.2s; }
        .btn-download:hover { color: var(--primary-color, #D4F63F); background: #111; padding: 2px 8px; border-radius: 4px; }

        /* 이전글/다음글 네비게이션 */
        .article-nav { border-bottom: 1px solid #111; }
        .article-nav-item { padding: 12px 20px; border-bottom: 1px solid #eee; display: flex; align-items: center; transition: 0.2s; color: #333; text-decoration: none; }
        .article-nav-item:hover { background-color: #f8f9fa; color: #000; }
        .nav-label { font-weight: bold; width: 80px; display: inline-block; color: #111; }
        .nav-title { flex: 1; text-overflow: ellipsis; white-space: nowrap; overflow: hidden; }
        .nav-date { font-size: 0.85rem; color: #888; margin-left: auto; }

        /* 버튼 영역 */
        .btn-action { border: 1px solid #111; background: #fff; color: #111; font-weight: 600; padding: 8px 25px; transition: 0.3s; }
        .btn-action:hover { background: #111; color: #fff; }
        .btn-primary-custom { background: #111; color: var(--primary-color, #D4F63F); border: 1px solid #111; }
        .btn-primary-custom:hover { background: #333; color: #fff; border-color: #333; }
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
                
                <div class="d-flex justify-content-between align-items-end mb-4 pb-3 border-bottom">
                    <div>
                        <h2 class="fw-bold display-6 mb-1">NOTICE</h2>
                        <p class="text-muted mb-0">공지사항 상세보기</p>
                    </div>
                </div>

                <div class="article-container shadow-sm">
                    
                    <div class="article-header">
                        <div class="article-title">
                            <span class="badge bg-danger rounded-pill fs-6 mb-1 align-middle me-2">필독</span>
                            [긴급] 1월 10일 서버 정기 점검 안내 (02:00 ~ 06:00)
                        </div>
                        <div class="article-meta">
                            <span>작성자: <b>관리자</b></span>
                            <span>2026-01-07 14:30</span>
                            <span>조회 1,205</span>
                        </div>
                    </div>

                 

                    <div class="article-body">
                        <p>안녕하세요, Footlog 운영진입니다.</p>
                        <br>
                        <p>보다 안정적인 서비스 제공을 위해 아래와 같이 서버 정기 점검이 진행될 예정입니다.</p>
                        <p>점검 시간 동안은 웹사이트 접속 및 서비스 이용이 일시 중단되오니 양해 부탁드립니다.</p>
                        <br>
                        <p class="p-3 bg-light border rounded">
                            <strong>🛠 점검 일시:</strong> 2026년 1월 10일 (토) 새벽 02:00 ~ 06:00 (4시간)<br>
                            <strong>🛠 점검 내용:</strong> 데이터베이스 최적화 및 보안 업데이트<br>
                            <strong>🛠 영향:</strong> 전체 서비스 이용 불가
                        </p>
                        <br>
                        <p>이용에 불편을 드려 죄송하며, 더욱 쾌적한 환경을 제공하기 위해 최선을 다하겠습니다.</p>
                        <p>감사합니다.</p>
                        <br>
                        <p>- Footlog 드림 -</p>
                    </div>
                    
                </div>

                <div class="article-nav mt-4 mb-4">
                    <a href="#" class="article-nav-item">
                        <span class="nav-label">▲ 이전글</span>
                        <span class="nav-title">1월 베스트 골(Goal) 이벤트 당첨자 발표</span>
                        <span class="nav-date">2026-01-05</span>
                    </a>
                    <a href="#" class="article-nav-item">
                        <span class="nav-label">▼ 다음글</span>
                        <span class="nav-title">다음글이 없습니다.</span>
                        <span class="nav-date">-</span>
                    </a>
                </div>

                <div class="d-flex justify-content-between">
                    <div>
                        <button type="button" class="btn btn-action" onclick="alert('수정 기능 준비중');">수정</button>
                        <button type="button" class="btn btn-outline-danger ms-1" onclick="if(confirm('정말 삭제하시겠습니까?')) alert('삭제 기능 준비중');">삭제</button>
                    </div>
                    <div>
                        <button type="button" class="btn btn-primary-custom rounded-pill" onclick="location.href='${pageContext.request.contextPath}/notice/list?${query}';">
                            목록으로
                        </button>
                    </div>
                </div>

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