<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <title>Footlog - 팀 갤러리</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <jsp:include page="/WEB-INF/views/layout/headerResources.jsp"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/style.css?ver=2">
    
    <style>
        .sidebar-title { font-size: 0.85rem; font-weight: 700; color: #6c757d; text-transform: uppercase; letter-spacing: 0.5px; }
        
        .gallery-item {
            transition: transform 0.2s, box-shadow 0.2s;
            border: 1px solid #eee;
            border-radius: 10px;
            overflow: hidden;
            background: #fff;
        }
        .gallery-item:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.08);
        }
        
        .gallery-thumb {
            height: 200px;
            overflow: hidden;
            background-color: #f8f9fa;
            position: relative;
        }
        .gallery-thumb img {
            width: 100%;
            height: 100%;
            object-fit: cover; /* 꽉 차게 */
        }
        
        .gallery-body { padding: 15px; }
        .gallery-title { font-size: 1.1rem; font-weight: bold; margin-bottom: 5px; color: #333; }
        .gallery-meta { font-size: 0.85rem; color: #888; }
        
        .btn-write {
            background-color: #333; color: #fff; border-radius: 50px; padding: 10px 25px; font-weight: bold;
        }
        .btn-write:hover { background-color: #000; color: #fff; }
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
                            <a href="${pageContext.request.contextPath}/myteam/board?teamCode=${teamCode}" class="list-group-item list-group-item-action border-0">
                                팀 게시판
                            </a>
                            <a href="${pageContext.request.contextPath}/myteam/schedule?teamCode=${teamCode}" class="list-group-item list-group-item-action border-0">
                                전체 일정
                            </a>
                            <a href="${pageContext.request.contextPath}/myteam/vote?teamCode=${teamCode}" class="list-group-item list-group-item-action border-0">
                                참석 여부
                            </a>                            
                            <a href="${pageContext.request.contextPath}/myteam/gallery?teamCode=${teamCode}" class="list-group-item list-group-item-action border-0 active fw-bold bg-light text-primary">
                                <i class="bi bi-images me-1"></i> 팀 갤러리
                            </a>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-lg-10 col-12">
                
                <div class="d-flex justify-content-between align-items-center mb-4 border-bottom pb-3">
                    <div>
                        <h2 class="fw-bold display-6 mb-1 text-dark">TEAM GALLERY</h2>
                        <p class="text-muted mb-0">우리 팀의 추억을 공유하는 공간입니다.</p>
                    </div>
                    <div>
                        <button type="button" class="btn btn-write" onclick="location.href='${pageContext.request.contextPath}/myteam/gallery_write?teamCode=${teamCode}';">
                            <i class="bi bi-pencil-square me-1"></i> 글쓰기
                        </button>
                    </div>
                </div>

                <div class="row g-4">
                    <c:forEach var="dto" items="${list}">
                        <div class="col-md-6 col-lg-4 col-xl-3">
                            <div class="gallery-item cursor-pointer" onclick="location.href='${pageContext.request.contextPath}/myteam/gallery_article?teamCode=${teamCode}&gallery_code=${dto.gallery_code}&page=${page}';">
                                <div class="gallery-thumb">
                                    <c:choose>
                                        <c:when test="${not empty dto.title_image}">
                                            <img src="${pageContext.request.contextPath}/uploads/gallery/${dto.title_image}" alt="썸네일">
                                        </c:when>
                                        <c:otherwise>
                                            <div class="d-flex justify-content-center align-items-center h-100 text-muted">
                                                <i class="bi bi-image fs-1"></i>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                
                                <div class="gallery-body">
                                    <div class="gallery-title text-truncate">${dto.title}</div>
                                    <div class="gallery-meta d-flex justify-content-between align-items-center mt-2">
                                        <div class="d-flex align-items-center">
                                            <span class="fw-bold me-2 text-dark small">${dto.member_name}</span>
                                        </div>
                                        <span class="small">${dto.created_at}</span>
                                    </div>
                                    <div class="gallery-meta mt-2 border-top pt-2 d-flex justify-content-between">
                                        <span><i class="bi bi-eye"></i> ${dto.view_count}</span>
                                        <span>
                                            <i class="bi bi-heart me-1 text-danger"></i> ${dto.like_count}
                                            <i class="bi bi-chat-dots ms-2 text-primary"></i> ${dto.reply_count}
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                    
                    <c:if test="${empty list}">
                        <div class="col-12 text-center py-5">
                            <p class="text-muted fs-5">등록된 게시물이 없습니다.</p>
                        </div>
                    </c:if>
                </div>

                <div class="page-navigation text-center mt-5">
                    ${dataCount == 0 ? "" : paging}
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