<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <title>Footlog - Team Gallery</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/style.css?ver=2">
    
    <jsp:include page="/WEB-INF/views/layout/headerResources.jsp"/>
    
    <style>
        /* 갤러리 카드 디자인 */
        .gallery-card {
            border: none;
            border-radius: 12px;
            overflow: hidden;
            transition: all 0.3s ease;
            box-shadow: 0 4px 6px rgba(0,0,0,0.05);
            background: #fff;
            height: 100%;
            cursor: pointer;
        }
        .gallery-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.1);
        }

        /* 이미지 비율 유지 (4:3) */
        .gallery-img-box {
            position: relative;
            width: 100%;
            padding-top: 75%; 
            overflow: hidden;
            background-color: #f1f3f5;
        }
        
        .gallery-img-box img {
            position: absolute;
            top: 0; left: 0; right: 0; bottom: 0;
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.5s ease;
        }
        
        .gallery-card:hover .gallery-img-box img { transform: scale(1.05); }

        /* 오버레이 효과 */
        .gallery-overlay {
            position: absolute;
            bottom: 0; left: 0; right: 0;
            background: linear-gradient(to top, rgba(0,0,0,0.7), transparent);
            padding: 20px 15px 10px;
            opacity: 0;
            transition: opacity 0.3s;
        }
        .gallery-card:hover .gallery-overlay { opacity: 1; }

        .sidebar-title { font-size: 0.85rem; font-weight: 700; color: #6c757d; text-transform: uppercase; letter-spacing: 0.5px; }
        
        /* [중요] MyUtil이 생성하는 .paginate 스타일 정의 */
        .paginate {
            text-align: center;
            margin-top: 40px;
            display: flex;
            justify-content: center;
            gap: 5px;
        }
        .paginate a, .paginate span {
            display: inline-block;
            padding: 6px 12px;
            font-size: 0.9rem;
            color: #333;
            text-decoration: none;
            border: 1px solid #dee2e6;
            border-radius: 4px;
            background-color: #fff;
            transition: all 0.2s;
        }
        .paginate a:hover {
            background-color: #e9ecef;
            color: #0d6efd;
            border-color: #dee2e6;
        }
        /* 현재 페이지 (span 태그로 생성됨) */
        .paginate span {
            background-color: #0d6efd;
            color: #fff;
            border-color: #0d6efd;
            font-weight: bold;
            pointer-events: none;
        }
    </style>
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
                
                <div class="d-flex justify-content-between align-items-end mb-4 border-bottom pb-3">
                    <div>
                        <h2 class="fw-bold display-6 mb-1 text-dark">TEAM GALLERY</h2>
                        <p class="text-muted mb-0">우리 팀의 추억을 사진으로 공유하세요. <span class="text-primary fw-bold">(${dataCount}개)</span></p>
                    </div>
                    
                    <button type="button" class="btn btn-dark rounded-pill px-4 fw-bold shadow-sm" 
                            onclick="location.href='${pageContext.request.contextPath}/myteam/galleryWrite?teamCode=${teamCode}';">
                        <i class="bi bi-camera-fill me-1"></i> 사진 올리기
                    </button>
                </div>

                <div class="row row-cols-1 row-cols-sm-2 row-cols-lg-3 row-cols-xl-4 g-4">
                    
                    <c:forEach var="dto" items="${list}">
                        <div class="col">
                            <div class="gallery-card" onclick="location.href='${pageContext.request.contextPath}/myteam/galleryArticle?num=${dto.num}&page=${page}&teamCode=${teamCode}';">
                                
                                <div class="gallery-img-box">
                                    <c:choose>
                                        <c:when test="${not empty dto.saveFilename}">
                                            <img src="${pageContext.request.contextPath}/uploads/gallery/${dto.saveFilename}" alt="${dto.subject}">
                                        </c:when>
                                        <c:otherwise>
                                            <img src="${pageContext.request.contextPath}/resources/images/no_image.png" style="object-fit: contain; padding: 20px;">
                                        </c:otherwise>
                                    </c:choose>
                                    
                                    <div class="gallery-overlay text-white d-flex justify-content-between small">
                                        <span><i class="bi bi-eye"></i> ${dto.hitCount}</span>
                                        <span><i class="bi bi-chat-dots"></i> ${dto.replyCount}</span>
                                    </div>
                                </div>

                                <div class="p-3">
                                    <h6 class="fw-bold text-dark text-truncate mb-1">${dto.subject}</h6>
                                    
                                    <div class="d-flex justify-content-between align-items-center mt-2">
                                        <div class="d-flex align-items-center">
                                            <div class="rounded-circle bg-light d-flex align-items-center justify-content-center me-2 overflow-hidden" style="width: 24px; height: 24px;">
                                                <img src="${pageContext.request.contextPath}/uploads/profile/${dto.profile_image}" 
                                                     style="width:100%; height:100%; object-fit:cover;"
                                                     onerror="this.src='${pageContext.request.contextPath}/resources/images/default_profile.png'">
                                            </div>
                                            <span class="text-muted small text-truncate" style="max-width: 80px;">${dto.userName}</span>
                                        </div>
                                        <span class="text-muted small" style="font-size: 0.75rem;">${dto.created_date}</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>

                </div>

                <c:if test="${dataCount == 0}">
                    <div class="text-center py-5">
                        <div class="mb-3 text-secondary">
                            <i class="bi bi-images" style="font-size: 3rem;"></i>
                        </div>
                        <h5 class="text-muted">등록된 사진이 없습니다.</h5>
                        <p class="small text-secondary">첫 번째 추억을 기록해보세요!</p>
                    </div>
                </c:if>

                <div class="page-navigation-wrap">
                    ${dataCount == 0 ? "" : paging}
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