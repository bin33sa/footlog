<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>글쓰기 - Footlog</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/style.css">
    
    <style>
        .form-control:focus { border-color: #D4F63F; box-shadow: 0 0 0 0.25rem rgba(212, 246, 63, 0.25); }
        .title-input { font-size: 1.5rem; font-weight: 700; background: transparent; }
        .title-input::placeholder { color: #ccc; }
        .btn-check:checked + .btn-category { background-color: #111; color: #D4F63F; border-color: #111; font-weight: 800; }
        .btn-category { border: 1px solid #ddd; background-color: #fff; color: #888; font-weight: 600; border-radius: 50px; padding: 10px 20px; transition: 0.2s; cursor: pointer; }
    </style>
</head>
<jsp:include page="/WEB-INF/views/layout/headerResources.jsp"/>
<body>
    <header>
        <jsp:include page="/WEB-INF/views/layout/header.jsp"/>
    </header>

    <div class="container mt-5 mb-5" style="max-width: 900px;">
        <div class="d-flex align-items-center justify-content-between mb-4 border-bottom pb-3">
            <div>
                <h2 class="fw-bold display-6 mb-1">${mode=='update'?'EDIT POST':'WRITE POST'}</h2>
                <p class="text-muted mb-0">게시글 내용을 작성해 주세요.</p>
            </div>
        </div>

        <div class="modern-card p-5 shadow-lg">
            <form name="bbsForm" method="post" action="${pageContext.request.contextPath}/bbs/${mode}">
                <div class="row g-3 mb-4">
                    <div class="col-12">
                        <label class="d-block text-muted fw-bold small mb-2 ms-1">게시글 분류</label>
                        <div class="d-flex gap-2">
                            <input type="radio" class="btn-check" name="category" id="cat1" value="1" ${category==1 or dto.category==1?'checked':''}>
                            <label class="btn btn-category flex-fill" for="cat1">💬 공지사항</label>

                            <input type="radio" class="btn-check" name="category" id="cat2" value="2" ${category==2 or dto.category==2?'checked':''}>
                            <label class="btn btn-category flex-fill" for="cat2">💡 자유게시판</label>
                            
                            <input type="radio" class="btn-check" name="category" id="cat3" value="3" ${category==3 or dto.category==3?'checked':''}>
                            <label class="btn btn-category flex-fill" for="cat3">📝 이벤트/뉴스</label>
                        </div>
                    </div>
                </div>

                <div class="mb-4">
                    <input type="text" name="title" value="${dto.title}" class="form-control title-input border-0 border-bottom rounded-0 px-0 py-2" placeholder="제목을 입력하세요" required>
                </div>

                <div class="mb-4">
                    <label class="d-block text-muted fw-bold small mb-2 ms-1">유튜브 링크 (선택사항)</label>
                    <input type="text" name="video_url" value="${dto.video_url}" class="form-control rounded-pill bg-light border-0 px-3" placeholder="https://www.youtube.com/watch?v=...">
                </div>

                <div class="mb-5">
                    <textarea name="content" class="form-control border-0 bg-light rounded-4 p-4" rows="12" placeholder="내용을 입력하세요." style="resize: none;" required>${dto.content}</textarea>
                </div>

                <div class="d-flex justify-content-between align-items-center">
                    <a href="${pageContext.request.contextPath}/bbs/list?category=${category}" class="text-decoration-none text-muted fw-bold">
                        &larr; 목록으로 돌아가기
                    </a>
                    <div class="d-flex gap-2">
                        <button type="reset" class="btn btn-light rounded-pill px-4 fw-bold">다시쓰기</button>
                        <button type="button" class="btn btn-dark rounded-pill px-5 fw-bold" style="color: #D4F63F;" onclick="sendOk();">
                            ${mode=='update'?'수정완료':'등록하기'}
                        </button>
                    </div>
                </div>

                <c:if test="${mode=='update'}">
                    <input type="hidden" name="board_main_code" value="${dto.board_main_code}">
                    <input type="hidden" name="page" value="${page}">
                </c:if>
            </form>
        </div>
    </div>
    
    <footer>
        <jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
    </footer>
    <jsp:include page="/WEB-INF/views/layout/footerResources.jsp"/>

    <script>
        function sendOk() {
            const f = document.bbsForm;
            if(!f.title.value.trim()) {
                alert("제목을 입력하세요.");
                f.title.focus();
                return;
            }
            if(!f.content.value.trim()) {
                alert("내용을 입력하세요.");
                f.content.focus();
                return;
            }
            f.submit();
        }
    </script>
</body>
</html>