<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>${dto.title} - Footlog</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/style.css">

<style>
/* 전반적인 레이아웃 테마 */
:root {
    --point-color: #D4F63F;
    --dark-bg: #111111;
}

body { background-color: #fcfcfc; }

.modern-card {
    background: #ffffff;
    border-radius: 24px;
    border: 1px solid rgba(0,0,0,0.05);
}

/* 제목 섹션 스타일 */
.article-header {
    background: linear-gradient(to bottom, #ffffff, #f9f9f9);
    border-radius: 24px 24px 0 0;
}

.category-badge {
    background-color: var(--dark-bg);
    color: var(--point-color) !important;
    font-weight: 700;
    font-size: 0.85rem;
    letter-spacing: -0.02em;
}

/* 이미지 및 본문 스타일 */
.gallery-image-container {
    max-width: 600px; !important;
    margin-left: auto !important; 
    margin-right: auto !important;
    text-align: center;
    background: #f1f1f1;
    border-radius: 20px;
    padding: 10px;
    transition: transform 0.3s ease;
}
.img-fluid,
.gallery-main-img {
   max-width: 100% !important;
    height: auto !important;
    display: block;      
    object-fit: contain;
}

.content-body {
    min-height: 350px;
    line-height: 1.9;
    font-size: 1.1rem;
    color: #333;
    padding: 0 10px;
}

/* 댓글창 스타일 */
.reply-section-title {
    font-size: 1.25rem;
    border-left: 5px solid var(--point-color);
    padding-left: 15px;
}

.comment-input {
    background-color: #ffffff !important;
    border: 1px solid #eee !important;
    transition: all 0.3s ease;
}

.comment-input:focus {
    border-color: var(--point-color) !important;
    box-shadow: 0 8px 20px rgba(0,0,0,0.05) !important;
}

.reply-item {
    transition: all 0.2s ease;
    border: 1px solid #f0f0f0 !important;
}

.reply-item:hover {
    border-color: var(--point-color) !important;
    transform: translateY(-2px);
}

/* 버튼 스타일 커스텀 */
.btn-point {
    background-color: var(--dark-bg);
    color: var(--point-color);
    transition: all 0.3s;
}

.btn-point:hover {
    background-color: #000;
    color: #fff;
    transform: scale(1.02);
}

.btn-list {
    border: 2px solid var(--dark-bg);
    color: var(--dark-bg);
}

.btn-list:hover {
    background-color: var(--dark-bg);
    color: #fff;
}
</style>
</head>
<jsp:include page="/WEB-INF/views/layout/headerResources.jsp" />

<body>
    <header>
        <jsp:include page="/WEB-INF/views/layout/header.jsp" />
    </header>

    <div class="container mt-5 mb-5" style="max-width: 900px;">
        <div class="modern-card mb-4 shadow-sm overflow-hidden">
            <div class="article-header p-4 p-md-5 pb-0">
                <div class="d-flex align-items-center gap-2 mb-3">
                    <span class="badge category-badge border px-3 py-2 rounded-pill">
                        <c:choose>
                            <c:when test="${dto.category == 1}">💬 공지사항</c:when>
                            <c:when test="${dto.category == 2}">💡 자유게시판</c:when>
                            <c:when test="${dto.category == 3}">📝 뉴스/이벤트</c:when>
                            <c:when test="${dto.category == 4}">📸 갤러리</c:when>
                            <c:otherwise>게시판</c:otherwise>
                        </c:choose>
                    </span>
                </div>
                <h2 class="fw-bold mb-4 text-dark" style="letter-spacing: -0.04em;">${dto.title}</h2>
                
                <div class="d-flex justify-content-between align-items-center pb-4 border-bottom">
                    <div class="d-flex align-items-center gap-3">
                        <div class="bg-light rounded-circle p-1 border">
                             <img src="https://cdn-icons-png.flaticon.com/512/149/149071.png" width="35" height="35">
                        </div>
                        <div>
                            <div class="fw-bold text-dark mb-0" style="font-size: 0.95rem;">${dto.member_name}</div>
                            <div class="text-muted" style="font-size: 0.8rem;">${dto.created_at}</div>
                        </div>
                    </div>
                    <div class="text-muted small">
                        <span class="bg-light px-3 py-1 rounded-pill">조회 ${dto.view_count}</span>
                    </div>
                </div>
            </div>

            <div class="p-4 p-md-5 pt-0">
                <div class="content-body mt-4">
                    <c:if test="${dto.category == 4 && not empty dto.imageFilename}">
                        <div class="gallery-image-container shadow-sm border" style="max-width: 400px; margin: 20px auto;">
                            <img src="${pageContext.request.contextPath}/uploads/gallery/${dto.imageFilename}" 
                                 class="gallery-main-img" alt="갤러리 이미지">
                        </div>
                    </c:if>

                    <div class="article-text mb-4">
                        ${dto.content}
                    </div>
                    
                    <c:if test="${not empty dto.video_url}">
                        <div class="mt-5 ratio ratio-16x9 shadow rounded-4 overflow-hidden border border-5 border-white">
                            <c:set var="videoUrl" value="${dto.video_url}"/>
                            <c:if test="${videoUrl.contains('watch?v=')}">
                                <c:set var="videoUrl" value="${videoUrl.replace('watch?v=', 'embed/')}"/>
                            </c:if>
                            <iframe src="${videoUrl}" 
                                    allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share; fullscreen"
                                    title="YouTube video player">
                            </iframe>
                        </div>
                    </c:if>
                </div>

                <div class="d-flex justify-content-between pt-5 mt-5 border-top">
                    <a href="${pageContext.request.contextPath}/bbs/list?page=${page}&category=${category}"
                        class="btn btn-list rounded-pill px-4 fw-bold"> &larr; 목록 </a>

                    <c:if test="${sessionScope.member.member_code == dto.member_code}">
                        <div class="d-flex gap-2">
                            <a href="${pageContext.request.contextPath}/bbs/update?board_main_code=${dto.board_main_code}&page=${page}&category=${category}"
                                class="btn btn-light rounded-pill px-4 fw-bold border">수정</a>
                            <button type="button"
                                class="btn btn-light rounded-pill px-4 fw-bold text-danger border"
                                onclick="deleteOk();">삭제</button>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>

        <div class="modern-card p-4 p-md-5 bg-white border-0 shadow-sm rounded-4">
            <h5 class="fw-bold mb-4 reply-section-title">
                댓글 <span class="badge rounded-pill bg-dark ms-1" id="replyCount">0</span>
            </h5>

            <div class="bg-light p-3 rounded-4 mb-5">
                <div class="d-flex gap-3">
                    <div class="flex-grow-1">
                        <textarea id="replyContent"
                            class="form-control comment-input rounded-4 border-0 p-3"
                            rows="2" placeholder="풋로그 친구들과 의견을 나눠보세요!" style="resize: none;"></textarea>
                    </div>
                    <div class="d-flex align-items-end">
                        <button class="btn btn-point rounded-4 px-4 py-3 fw-bold shadow-sm"
                            onclick="sendReply();">등록</button>
                    </div>
                </div>
            </div>

            <div id="listReply" class="vstack gap-3"></div>
            <div id="listReplyPaging" class="mt-5 d-flex justify-content-center"></div>
        </div>
    </div>

    <footer>
        <jsp:include page="/WEB-INF/views/layout/footer.jsp" />
    </footer>

    <jsp:include page="/WEB-INF/views/layout/footerResources.jsp" />

    <script>
    /* 기존 스크립트 기능 유지 (ajaxFun, listPage 등 생략되지 않도록 주의) */
    function ajaxFun(url, method, query, dataType, fn) {
        $.ajax({
            type: method, url: url, data: query, dataType: dataType,
            success: function(data) { fn(data); },
            beforeSend: function(jqXHR) { jqXHR.setRequestHeader("AJAX", true); },
            error: function(jqXHR) {
                if (jqXHR.status === 403) { location.href = '${pageContext.request.contextPath}/member/login'; return false; }
                console.log("AJAX 에러: " + jqXHR.responseText);
            }
        });
    }

    function deleteOk() {
        if (confirm("정말로 이 게시글을 삭제하시겠습니까?")) {
            location.href = '${pageContext.request.contextPath}/bbs/delete?board_main_code=${dto.board_main_code}&page=${page}&category=${category}';
        }
    }

    $(function() { listPage(1); });

    function listPage(page) {
        let url = "${pageContext.request.contextPath}/bbs/listReply";
        let query = "board_main_code=${dto.board_main_code}&pageNo=" + page;
        ajaxFun(url, "get", query, "json", function(data) { printReply(data); });
    }

    function printReply(data) {
        let count = data.replyCount || 0;
        $("#replyCount").text(count);

        let out = "";
        if (count > 0 && data.listReply) {
            data.listReply.forEach(function(item) {
                let name = item.member_name || "이름없음"; 
                let content = item.content || "";
                let date = item.created_at || "";
                let photo = item.profile_image ? item.profile_image : 'default.png';
                let photoPath = "${pageContext.request.contextPath}/uploads/member/" + photo;

                out += '<div class="reply-item d-flex gap-3 bg-white p-4 rounded-4 shadow-sm border mb-2">';
                out += '  <div class="flex-shrink-0">';
                out += '    <img src="' + photoPath + '" class="rounded-circle border" style="width:45px; height:45px; object-fit:cover;" onerror="this.src=\'https://cdn-icons-png.flaticon.com/512/149/149071.png\'">';
                out += '  </div>';
                out += '  <div class="w-100">';
                out += '    <div class="d-flex justify-content-between align-items-center mb-2">';
                out += '      <h6 class="fw-bold mb-0 text-dark">' + name + '</h6>';
                out += '      <small class="text-muted" style="font-size:0.75rem;">' + date + '</small>';
                out += '    </div>';
                out += '    <p class="mb-0 text-secondary" style="white-space:pre-wrap; font-size:0.95rem;">' + content + '</p>';
                out += '  </div>';
                out += '</div>';
            });
        } else {
            out = '<div class="text-center p-5 text-muted bg-light rounded-4">아직 작성된 댓글이 없습니다. 첫 댓글을 남겨보세요!</div>';
        }
        $("#listReply").html(out);
        $("#listReplyPaging").html(data.paging || "");
    }

    function sendReply() {
        let content = $("#replyContent").val().trim();
        if (!content) { $("#replyContent").focus(); return; }

        let url = "${pageContext.request.contextPath}/bbs/insertReply";
        let query = { board_main_code: "${dto.board_main_code}", content: content };

        ajaxFun(url, "post", query, "json", function(data) {
            if (data.state === "true") { $("#replyContent").val(""); listPage(1); }
            else if(data.state === "loginFail") { alert("로그인이 필요합니다."); location.href = "${pageContext.request.contextPath}/member/login"; }
            else { alert("댓글 등록에 실패했습니다."); }
        });
    }
</script>

</body>
</html>