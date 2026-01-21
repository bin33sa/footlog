<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html>
<head>
    <title>Footlog - 팀 게시판</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <jsp:include page="/WEB-INF/views/layout/headerResources.jsp"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/style.css?ver=2">
    
    <style>
      .paginate {
    text-align: center;
    margin-top: 20px;
}
.paginate a, .paginate span {
    display: inline-block;
    padding: 6px 12px;
    margin: 0 2px;
    border: 1px solid #ddd;
    border-radius: 4px;
    color: #333;
    text-decoration: none;
    cursor: pointer;
    font-size: 14px;
}
.paginate span { /* 현재 페이지 */
    background-color: #0d6efd;
    color: #fff;
    border-color: #0d6efd;
    font-weight: bold;
}
.paginate a:hover {
    background-color: #f8f9fa;
}

/* 댓글 수정/삭제 버튼 */
.reply-btn-area span {
    cursor: pointer;
    font-size: 12px;
    margin-left: 10px;
}
.reply-btn-area span:hover {
    text-decoration: underline;
}
    </style>
    
    <script type="text/javascript">
        <c:if test="${sessionScope.member.member_code == dto.member_code}">
        function deleteBoard() {
            if(confirm("게시글을 삭제 하시겠습니까?")) {
                let query = "board_team_code=${dto.board_team_code}&teamCode=${teamCode}&page=${page}";
                let url = "${pageContext.request.contextPath}/myteam/board_delete?" + query;
                location.href = url;
            }
        }
        </c:if>
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
                                <i class="bi bi-layout-text-window-reverse me-1"></i> 팀 게시판
                            </a>
                            <a href="${pageContext.request.contextPath}/myteam/schedule?teamCode=${teamCode}" class="list-group-item list-group-item-action border-0">
                                전체 일정
                            </a>
                            <a href="${pageContext.request.contextPath}/myteam/attendance?teamCode=${teamCode}" class="list-group-item list-group-item-action border-0">
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
                        <p class="text-muted mb-0">팀원들과 자유롭게 이야기를 나누세요.</p>
                    </div>
                </div>

                <div class="card article-card p-4 mb-3">
                    <div class="card-body">
                        
                        <h4 class="fw-bold mb-3">
                            <c:if test="${dto.notice == 1}">[공지] </c:if>
                            ${dto.title}
                        </h4>
                        
                        <div class="d-flex justify-content-between align-items-center mb-4 text-muted small border-bottom pb-3">
                            <div>
                                <span class="fw-bold text-dark me-2">${dto.member_name}</span>
                                <span>${dto.created_at}</span>
                            </div>
                            <div>
                                <span>조회 ${dto.view_count}</span>
                            </div>
                        </div>

                        <div class="board-content mb-5" style="min-height: 200px;">
                            ${dto.content}
                        </div>

                        <div class="text-center mb-4">
                            <button type="button" class="btn ${isUserLiked ? 'btn-danger' : 'btn-outline-danger'} btn-sm rounded-pill px-4 py-2" id="btnLike">
                                <i class="bi ${isUserLiked ? 'bi-heart-fill' : 'bi-heart'} me-1"></i> 
                                좋아요 <span id="likeCount">${dto.like_count}</span>
                            </button>
                        </div>

                        <div class="border-top pt-3">
                            <div class="mb-2">
                                <span class="fw-bold text-secondary me-2">이전글 <i class="bi bi-chevron-up small"></i></span>
                                <c:if test="${not empty preDto}">
                                    <a href="${pageContext.request.contextPath}/myteam/board_article?${query}&board_team_code=${preDto.board_team_code}" class="text-decoration-none text-dark">${preDto.title}</a>
                                </c:if>
                                <c:if test="${empty preDto}">
                                    <span class="text-muted">이전글이 없습니다.</span>
                                </c:if>
                            </div>
                            <div>
                                <span class="fw-bold text-secondary me-2">다음글 <i class="bi bi-chevron-down small"></i></span>
                                <c:if test="${not empty nextDto}">
                                    <a href="${pageContext.request.contextPath}/myteam/board_article?${query}&board_team_code=${nextDto.board_team_code}" class="text-decoration-none text-dark">${nextDto.title}</a>
                                </c:if>
                                <c:if test="${empty nextDto}">
                                    <span class="text-muted">다음글이 없습니다.</span>
                                </c:if>
                            </div>
                        </div>

                    </div>
                </div>

                <div class="d-flex justify-content-between align-items-center mb-5">
                    <div>
                        <c:if test="${sessionScope.member.member_code == dto.member_code}">
                            <button type="button" class="btn btn-light border" onclick="location.href='${pageContext.request.contextPath}/myteam/board_update?board_team_code=${dto.board_team_code}&page=${page}&teamCode=${teamCode}';">수정</button>
                            <button type="button" class="btn btn-light border" onclick="deleteBoard();">삭제</button>
                        </c:if>
                    </div>
                    <button type="button" class="btn btn-dark px-4" onclick="location.href='${pageContext.request.contextPath}/myteam/board?${query}';">목록으로</button>
                </div>

                <div class="card article-card p-4 bg-light bg-opacity-25">
                     <div class="card-body">
                         <div class="mb-3 fw-bold reply-info">
                             <i class="bi bi-chat-dots-fill me-1"></i> <span class="fw-bold">댓글 0개</span>
                         </div>
                         
                         <div id="listReply">
                             <div class="list-content"></div>
                             <div class="page-navigation mt-3 text-center"></div>
                         </div>
                         
                         <div class="input-group mt-3">
                             <textarea class="form-control" id="replyContent" rows="2" placeholder="댓글을 입력하세요."></textarea>
                             <button class="btn btn-primary btnSendReply" type="button" id="btnSendReply">등록</button>
                         </div>
                     </div>
                </div>

            </div>
        </div> 
    </div>

    <footer>
       <jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
    </footer>
    
    <jsp:include page="/WEB-INF/views/layout/footerResources.jsp"/>

    <script type="text/javascript">
        const contextPath = "${pageContext.request.contextPath}";
        const boardTeamCode = "${dto.board_team_code}";
        const myMemberCode = "${sessionScope.member.member_code}";
    </script>
    
    <script src="${pageContext.request.contextPath}/dist/js/paginate.js"></script>

    <script src="${pageContext.request.contextPath}/dist/js2/boardReply.js"></script>
</body>
</html>