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
        .btn-category { border: 1px solid #ddd; background-color: #fff; color: #888; font-size: 0.9rem; font-weight: 600; border-radius: 50px; padding: 10px 15px; transition: 0.2s; cursor: pointer; display: flex; align-items: center; justify-content: center; height: 45px; }
        /* 비활성화된 카테고리 스타일 */
        .btn-check:disabled + .btn-category { opacity: 0.5; cursor: not-allowed; background-color: #f8f9fa; }
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
            <form name="bbsForm" method="post" action="${pageContext.request.contextPath}/bbs/${mode}" enctype="multipart/form-data">
                <div class="row g-3 mb-4">
                    <div class="col-12">
                        <label class="d-block text-muted fw-bold small mb-2 ms-1">게시글 분류</label>
                        <div class="d-flex gap-2 flex-wrap">
                            
                            <%-- [관리자 전용 권한 설정] role_level 51 이상만 공지사항 선택 가능 --%>
                            <c:choose>
                                <c:when test="${sessionScope.member.role_level >= 51}">
                                    <input type="radio" class="btn-check" name="category" id="cat1" value="1" ${(category==1 or dto.category==1) ? 'checked' : ''} onclick="toggleFile(1)">
                                    <label class="btn btn-category flex-fill" for="cat1">📢 공지사항</label>
                                </c:when>
                                <c:otherwise>
                                    <%-- 일반 사용자는 공지사항 버튼을 선택할 수 없게 처리 --%>
                                    <input type="radio" class="btn-check" name="category" id="cat1" value="1" disabled>
                                    <label class="btn btn-category flex-fill" for="cat1" title="관리자만 작성 가능합니다">📢 공지사항</label>
                                </c:otherwise>
                            </c:choose>

                            <input type="radio" class="btn-check" name="category" id="cat2" value="2" ${(category==2 or dto.category==2 or (category != 1 and category != 3 and category != 4)) ? 'checked' : ''} onclick="toggleFile(2)">
                            <label class="btn btn-category flex-fill" for="cat2">💡 자유게시판</label>
                            
                            <input type="radio" class="btn-check" name="category" id="cat3" value="3" ${category==3 or dto.category==3 ? 'checked' : ''} onclick="toggleFile(3)">
                            <label class="btn btn-category flex-fill" for="cat3">📝 뉴스</label>

                            <input type="radio" class="btn-check" name="category" id="cat4" value="4" ${category==4 or dto.category==4 ? 'checked' : ''} onclick="toggleFile(4)">
                            <label class="btn btn-category flex-fill" for="cat4">📸 갤러리</label>
                        </div>
                    </div>
                </div>

                <div class="mb-4">
                    <input type="text" name="title" value="${dto.title}" class="form-control title-input border-0 border-bottom rounded-0 px-0 py-2" placeholder="제목을 입력하세요" required>
                </div>

                <%-- 갤러리(4)일 때만 보이는 이미지 첨부란 --%>
                <div id="fileViewer" class="mb-4" style="display: ${category==4 or dto.category==4 ? 'block' : 'none'};">
                    <label class="d-block text-muted fw-bold small mb-2 ms-1">이미지 첨부 (필수)</label>
                    <input type="file" name="selectFile" class="form-control rounded-pill bg-light border-0 px-3" accept="image/*">
                    <c:if test="${mode=='update' and not empty dto.imageFilename}">
                        <div class="mt-2 ms-2 small text-muted">기존 파일: ${dto.imageFilename}</div>
                    </c:if>
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
                    <input type="hidden" name="imageFilename" value="${dto.imageFilename}">
                </c:if>
            </form>
        </div>
    </div>
    
    <footer>
        <jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
    </footer>
    <jsp:include page="/WEB-INF/views/layout/footerResources.jsp"/>

    <script>
        function toggleFile(cat) {
            const viewer = document.getElementById("fileViewer");
            if(cat == 4) {
                viewer.style.display = "block";
            } else {
                viewer.style.display = "none";
                document.bbsForm.selectFile.value = "";
            }
        }

        function sendOk() {
            const f = document.bbsForm;
            
            // 라디오 버튼(category)에서 체크된 값 가져오기
            let catValue = "";
            const categories = document.getElementsByName("category");
            for(let i=0; i<categories.length; i++) {
                if(categories[i].checked) {
                    catValue = categories[i].value;
                    break;
                }
            }

            if(!f.title.value.trim()) {
                alert("제목을 입력하세요.");
                f.title.focus();
                return;
            }
            
            // 갤러리(4)일 경우 이미지 필수 체크
            if(catValue == "4" && "${mode}" == "write") {
                if(!f.selectFile.value) {
                    alert("갤러리 게시글은 이미지를 반드시 첨부해야 합니다.");
                    return;
                }
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