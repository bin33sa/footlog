<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<!DOCTYPE html>
<html>
<head>
    <title>Footlog - 갤러리 상세</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <jsp:include page="/WEB-INF/views/layout/headerResources.jsp"/>
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/style.css?ver=2">
    
    <style>
        .sidebar-title { font-size: 0.85rem; font-weight: 700; color: #6c757d; text-transform: uppercase; letter-spacing: 0.5px; }
        
        /* 상세 페이지 전용 스타일 */
        .article-card {
            border: none;
            box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.03);
            border-radius: 15px;
            overflow: hidden;
            background: #fff;
        }
        
        .article-header {
            border-bottom: 1px solid #f1f3f5;
            padding-bottom: 20px;
            margin-bottom: 30px;
        }
        
        .article-img-box {
            background-color: #f8f9fa;
            border-radius: 10px;
            overflow: hidden;
            text-align: center;
            margin-bottom: 30px;
            border: 1px solid #dee2e6;
        }
        
        .article-img-box img {
            max-width: 100%;
            max-height: 800px;
            object-fit: contain;
        }
        
        /* 본문 내용 스타일 */
        .article-content {
            font-size: 1.05rem;
            line-height: 1.8;
            color: #333;
            min-height: 150px;
            white-space: normal;
            text-align: left;
        }
        
        .article-actions {
            margin-top: 50px;
            padding-top: 30px;
            border-top: 1px solid #f1f3f5;
            text-align: center;
        }
        
        .btn-like {
            border-color: #dee2e6;
            color: #495057;
            padding: 10px 25px;
            border-radius: 50px;
            transition: all 0.2s;
            background-color: #fff;
        }
        .btn-like:hover {
            background-color: #ffe3e3;
            border-color: #ff6b6b;
            color: #e03131;
        }
        
        /* 댓글 영역 스타일 */
        #listReply .table td { border-bottom: 1px solid #f1f3f5; }
        #listReply .reply-count { color: #333; }
        
        /* =========================================
           [추가] 댓글 페이징 디자인 (커스텀)
           ========================================= */
        .page-navigation {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 5px;
            margin-top: 20px;
        }
        
        /* 페이지 번호 링크 공통 스타일 */
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
            transition: all 0.2s;
            cursor: pointer;
        }

        /* 마우스 올렸을 때 */
        .page-navigation a:hover {
            background-color: #f1f3f5;
            color: #333;
        }

        /* 현재 페이지 (보통 span이나 strong) */
        .page-navigation span, 
        .page-navigation strong,
        .page-navigation .active {
            background-color: #111;    /* 검은색 배경 */
            color: #D4F63F !important; /* 형광색 글씨 */
            cursor: default;
        }
        
        /* '이전', '다음' 버튼 스타일 */
        .page-navigation a[title="이전"], .page-navigation a[title="다음"] {
            border-radius: 4px;
            width: auto;
        }
    </style>
    
    <script type="text/javascript">
        // 게시글 삭제 확인 함수
        function deleteGallery(galleryCode, teamCode) {
            if(confirm("정말로 이 게시글을 삭제하시겠습니까?")) {
                location.href = "${pageContext.request.contextPath}/myteam/galleryDelete?gallery_code=" + galleryCode + "&teamCode=" + teamCode;
            }
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
                            <a href="${pageContext.request.contextPath}/myteam/attendance?teamCode=${teamCode}" class="list-group-item list-group-item-action border-0">
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
                
                <div class="card article-card p-4 p-lg-5 mb-5">
                    
                    <div class="article-header">
                        <div class="d-flex justify-content-between align-items-start">
                            <h2 class="fw-bold mb-3 text-break">${dto.title}</h2>
                            
                            <c:if test="${sessionMemberCode == dto.member_code || myRoleLevel >= 10}">
                                <div class="position-relative">
                                    <button class="btn btn-link text-muted p-0" type="button" 
                                            id="dropdownMenuButton" data-bs-toggle="dropdown" aria-expanded="false">
                                        <i class="bi bi-three-dots-vertical fs-5"></i>
                                    </button>
                                    
                                    <ul class="dropdown-menu dropdown-menu-end shadow-sm border-0" aria-labelledby="dropdownMenuButton">
                                        <li>
                                            <a class="dropdown-item text-danger" href="javascript:deleteGallery('${dto.gallery_code}', '${teamCode}');">삭제하기</a>
                                        </li>
                                        
                                        <c:if test="${sessionMemberCode == dto.member_code}">
                                            <li>
                                                <a class="dropdown-item" 
                                                   href="${pageContext.request.contextPath}/myteam/gallery_update?gallery_code=${dto.gallery_code}&teamCode=${teamCode}&page=${page}">
                                                   수정하기
                                                </a>
                                            </li>
                                        </c:if>
                                    </ul>
                                </div>
                            </c:if>
                        </div>
                        
                        <div class="d-flex justify-content-between align-items-center text-muted">
                            <div class="d-flex align-items-center">
                                <div class="rounded-circle bg-light d-flex align-items-center justify-content-center me-2 overflow-hidden" style="width: 40px; height: 40px;">
                                    <img src="${pageContext.request.contextPath}/uploads/profile/${dto.profile_image}" 
                                         style="width:100%; height:100%; object-fit:cover;"
                                         onerror="this.src='${pageContext.request.contextPath}/dist/images/avatar.png'">
                                </div>
                                <div>
                                    <span class="fw-bold text-dark d-block" style="font-size: 0.9rem;">${dto.member_name}</span>
                                    <span class="small">${dto.created_at}</span>
                                </div>
                            </div>
                            <div class="small">
                                <span class="me-3"><i class="bi bi-eye me-1"></i> ${dto.view_count}</span>
                                <span><i class="bi bi-chat-dots me-1"></i> ${dto.reply_count}</span>
                            </div>
                        </div>
                    </div>

                    <c:if test="${not empty dto.title_image}">
                        <div class="article-img-box">
                            <img src="${pageContext.request.contextPath}/uploads/gallery/${dto.title_image}" alt="Gallery Image">
                        </div>
                    </c:if>

                    <c:if test="${not empty dto.listFile}">
                        <c:forEach var="fileVo" items="${dto.listFile}">
                            <c:if test="${fileVo.file_server_name != dto.title_image}">
                                <div class="article-img-box">
                                    <img src="${pageContext.request.contextPath}/uploads/gallery/${fileVo.file_server_name}" alt="Additional Image">
                                </div>
                            </c:if>
                        </c:forEach>
                    </c:if>

                    <div class="article-content mb-5">${dto.content}</div>

                    <div class="article-actions">
                        <button type="button" class="btn btn-like">
                            <i class="bi bi-heart me-1"></i> 좋아요 
                            <span id="likeCount" class="fw-bold ms-1">${dto.like_count}</span>
                        </button>
                    </div>

                    <div id="listReply" class="mt-5 border-top pt-4">
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <h5 class="fw-bold reply-count">댓글 0</h5>
                            <span class="small text-muted reply-page"></span>
                        </div>

                        <div class="list-content mb-4">
                            <table class="table table-borderless">
                                <tbody></tbody>
                            </table>
                        </div>
                        
                        <div class="page-navigation text-center mb-4"></div>

                        <div class="card bg-light border-0 p-3">
                            <div class="d-flex gap-2">
                                <textarea class="form-control" id="replyContent" rows="3" placeholder="댓글을 입력하세요..."></textarea>
                                <button type="button" class="btn btn-primary px-4 fw-bold btnSendReply text-nowrap">등록</button>
                            </div>
                        </div>
                    </div>
                    </div>

                <div class="d-flex justify-content-center mb-5">
                    <button type="button" class="btn btn-dark rounded-pill px-5 py-2 fw-bold" 
                            onclick="location.href='${pageContext.request.contextPath}/myteam/gallery?teamCode=${teamCode}&page=${page}';">
                        목록으로
                    </button>
                </div>

            </div>
        </div> 
    </div>

    <footer>
       <jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
    </footer>
    
    <jsp:include page="/WEB-INF/views/layout/footerResources.jsp"/>

    <script>
        const contextPath = "${pageContext.request.contextPath}";
        const galleryCode = "${dto.gallery_code}";
        const teamCode = "${teamCode}";
        const sessionMemberCode = "${sessionMemberCode}";
    </script>

    <script src="${pageContext.request.contextPath}/dist/js2/gallery_article.js?ver=<%=System.currentTimeMillis()%>"></script>

</body>
</html>