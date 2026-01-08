<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <title>갤러리 - Footlog</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/style.css">
    
    <style>
        /* 갤러리 카드 스타일 */
        .gallery-card {
            background-color: #fff;
            border: 1px solid #eee;
            transition: all 0.3s ease;
            cursor: pointer;
            overflow: hidden;
        }
        .gallery-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.1);
            border-color: var(--primary-color, #D4F63F);
        }
        
        /* 이미지 비율 고정 (4:3) 및 줌 효과 */
        .img-wrapper {
            position: relative;
            width: 100%;
            padding-top: 75%; /* 4:3 비율 */
            overflow: hidden;
            background-color: #f8f9fa;
        }
        .img-wrapper img {
            position: absolute;
            top: 0; left: 0; width: 100%; height: 100%;
            object-fit: cover; /* 꽉 차게 */
            transition: transform 0.5s ease;
        }
        .gallery-card:hover .img-wrapper img {
            transform: scale(1.05); /* 호버 시 살짝 확대 */
        }

        /* 페이징 & 검색창 */
        .paginate { text-align: center; }
        .paginate a, .paginate span {
            display: inline-block; padding: 8px 14px; margin: 0 4px;
            border-radius: 50%; color: #333; text-decoration: none; font-weight: 600; transition: 0.2s;
        }
        .paginate a:hover { background-color: #eee; }
        .paginate span { background-color: #111; color: #D4F63F; cursor: default; }
        
        .neon-search-box {
            background-color: #111; border: 2px solid #333; height: 40px; max-width: 350px; font-size: 0.9rem;
        }
        .neon-search-box:hover, .neon-search-box:focus-within {
            border-color: var(--primary-color, #D4F63F);
            box-shadow: 0 0 10px rgba(212, 246, 63, 0.2);
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
                        <a href="${pageContext.request.contextPath}/bbs/list" class="list-group-item list-group-item-action">자유 게시판</a>
                        <a href="${pageContext.request.contextPath}/photo/list" class="list-group-item list-group-item-action active bg-dark text-white border-0 fw-bold">
                            갤러리
                        </a>
                        <a href="${pageContext.request.contextPath}/event/list" class="list-group-item list-group-item-action">이벤트 / 뉴스</a>
                    </div>
                </div>
            </div>

            <div class="col-lg-9 col-12 ms-lg-4">
                
                <div class="d-flex justify-content-between align-items-end mb-4 border-bottom pb-3">
                    <div>
                        <h2 class="fw-bold display-6 mb-1">GALLERY</h2>
                        <p class="text-muted mb-0">회원님들의 멋진 사진을 공유해주세요.</p>
                    </div>
                    <a href="${pageContext.request.contextPath}/photo/write" class="btn btn-dark rounded-pill px-4 fw-bold shadow-sm" style="color: var(--primary-color, #D4F63F);">
                        📷 사진 등록
                    </a>
                </div>

                <div class="row g-2 align-items-center mb-4">
                    <div class="col-md-6">
                        <span class="text-muted fw-bold">Total <span class="text-dark">8</span> pic</span>
                    </div>
                    <div class="col-md-6">
                        <form name="searchForm" action="${pageContext.request.contextPath}/photo/list" method="get" class="d-flex justify-content-md-end">
                            <div class="neon-search-box d-flex align-items-center rounded-pill px-2 w-100">
                                <select name="schType" class="form-select border-0 text-white bg-transparent py-0" style="width: auto; cursor: pointer;">
                                    <option value="all" class="text-dark">전체</option>
                                    <option value="subject" class="text-dark">제목</option>
                                    <option value="content" class="text-dark">내용</option>
                                </select>
                                <input type="text" name="kwd" class="form-control border-0 bg-transparent text-white py-0" placeholder="Search...">
                                <button type="submit" class="btn btn-link text-decoration-none p-2" style="color: var(--primary-color, #D4F63F);">🔍</button>
                            </div>
                        </form>
                    </div>
                </div>

                <div class="row g-4">
                    
                    <div class="col-6 col-md-4 col-lg-3">
                        <div class="gallery-card rounded-4 h-100" onclick="location.href='${pageContext.request.contextPath}/photo/article?seq=1'">
                            <div class="img-wrapper rounded-top-4">
                                <img src="https://via.placeholder.com/400x300/111/D4F63F?text=NEW+UNIFORM" alt="사진">
                            </div>
                            <div class="p-3">
                                <h6 class="fw-bold mb-1 text-truncate">새 유니폼 도착했습니다!</h6>
                                <div class="d-flex justify-content-between align-items-center text-muted small mt-2">
                                    <span>손흥민</span>
                                    <span>2026.01.07</span>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-6 col-md-4 col-lg-3">
                        <div class="gallery-card rounded-4 h-100" onclick="location.href='${pageContext.request.contextPath}/photo/article?seq=2'">
                            <div class="img-wrapper rounded-top-4">
                                <img src="https://via.placeholder.com/400x300/333/fff?text=Match+Day" alt="사진">
                            </div>
                            <div class="p-3">
                                <h6 class="fw-bold mb-1 text-truncate">주말 상암 원정 경기 단체사진</h6>
                                <div class="d-flex justify-content-between align-items-center text-muted small mt-2">
                                    <span>박지성</span>
                                    <span>2026.01.06</span>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-6 col-md-4 col-lg-3">
                        <div class="gallery-card rounded-4 h-100" onclick="location.href='#'">
                            <div class="img-wrapper rounded-top-4">
                                <img src="https://via.placeholder.com/400x300/eee/111?text=Football+Boots" alt="사진">
                            </div>
                            <div class="p-3">
                                <h6 class="fw-bold mb-1 text-truncate">새로 산 축구화 리뷰</h6>
                                <div class="d-flex justify-content-between align-items-center text-muted small mt-2">
                                    <span>이강인</span>
                                    <span>2026.01.05</span>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-6 col-md-4 col-lg-3">
                        <div class="gallery-card rounded-4 h-100" onclick="location.href='#'">
                            <div class="img-wrapper rounded-top-4">
                                <img src="https://via.placeholder.com/400x300/000/fff?text=Night+Game" alt="사진">
                            </div>
                            <div class="p-3">
                                <h6 class="fw-bold mb-1 text-truncate">야간 경기 분위기 좋네요</h6>
                                <div class="d-flex justify-content-between align-items-center text-muted small mt-2">
                                    <span>김민재</span>
                                    <span>2026.01.04</span>
                                </div>
                            </div>
                        </div>
                    </div>

                     <div class="col-6 col-md-4 col-lg-3">
                        <div class="gallery-card rounded-4 h-100" onclick="location.href='#'">
                            <div class="img-wrapper rounded-top-4">
                                <img src="https://via.placeholder.com/400x300/555/D4F63F?text=Tactics" alt="사진">
                            </div>
                            <div class="p-3">
                                <h6 class="fw-bold mb-1 text-truncate">오늘의 전술 회의</h6>
                                <div class="d-flex justify-content-between align-items-center text-muted small mt-2">
                                    <span>감독님</span>
                                    <span>2026.01.03</span>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-6 col-md-4 col-lg-3">
                        <div class="gallery-card rounded-4 h-100" onclick="location.href='#'">
                            <div class="img-wrapper rounded-top-4 d-flex align-items-center justify-content-center bg-light">
                                <span class="text-muted fw-bold">NO IMAGE</span>
                            </div>
                            <div class="p-3">
                                <h6 class="fw-bold mb-1 text-truncate">이미지가 없는 게시글 예시</h6>
                                <div class="d-flex justify-content-between align-items-center text-muted small mt-2">
                                    <span>테스터</span>
                                    <span>2026.01.02</span>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
                
                <div class="d-flex justify-content-center mt-5">
                    <nav>
                        <ul class="pagination justify-content-center">
                            <li class="page-item disabled"><a class="page-link" href="#">&lt;</a></li>
                            <li class="page-item active"><a class="page-link" href="#">1</a></li>
                            <li class="page-item"><a class="page-link" href="#">2</a></li>
                            <li class="page-item"><a class="page-link" href="#">&gt;</a></li>
                        </ul>
                    </nav>
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