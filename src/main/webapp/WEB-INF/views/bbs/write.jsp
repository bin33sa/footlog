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
        .form-control:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 0.25rem rgba(212, 246, 63, 0.25);
        }
        .title-input { font-size: 1.5rem; font-weight: 700; background: transparent; }
        .title-input::placeholder { color: #ccc; }
        .form-control[type="file"] { line-height: 2; }
        
        /* [공통] 카테고리 버튼 스타일 (Notice와 동일하게 적용) */
        .btn-check:checked + .btn-category {
            background-color: #111;
            color: var(--primary-color, #D4F63F); /* 형광 라임 */
            border-color: #111;
            box-shadow: 0 4px 10px rgba(0,0,0,0.2);
            font-weight: 800;
        }
        .btn-category {
            border: 1px solid #ddd;
            background-color: #fff;
            color: #888;
            font-weight: 600;
            border-radius: 50px;
            padding: 10px 20px;
            transition: all 0.2s ease;
            cursor: pointer;
        }
        .btn-category:hover {
            background-color: #f8f9fa;
            color: #333;
            transform: translateY(-2px);
        }
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
                <h2 class="fw-bold display-6 mb-1">WRITE POST</h2>
                <p class="text-muted mb-0">당신의 이야기를 자유롭게 들려주세요.</p>
            </div>
        </div>

        <div class="modern-card p-5 shadow-lg">
            <form name="bbsForm" action="${pageContext.request.contextPath}/bbs/writeDo" method="post" enctype="multipart/form-data" onsubmit="return sendOk();">
                
                <div class="row g-3 mb-4 align-items-end">
                    <div class="col-md-7">
                        <label class="d-block text-muted fw-bold small mb-2 ms-1">게시글 분류</label>
                        <div class="d-flex gap-2">
                            <input type="radio" class="btn-check" name="category" id="cat_chat" value="chat" checked>
                            <label class="btn btn-category flex-fill text-center" for="cat_chat">
                                💬 잡담
                            </label>

                            <input type="radio" class="btn-check" name="category" id="cat_info" value="info">
                            <label class="btn btn-category flex-fill text-center" for="cat_info">
                                💡 정보
                            </label>
                            
                            <input type="radio" class="btn-check" name="category" id="cat_review" value="review">
                            <label class="btn btn-category flex-fill text-center" for="cat_review">
                                📝 후기
                            </label>
                        </div>
                    </div>
                    
                    <div class="col-md-5">
                         <label class="d-block text-muted fw-bold small mb-2 ms-1">첨부파일</label>
                        <input type="file" name="uploadFile" class="form-control rounded-4 border-secondary bg-light px-3" style="padding: 10px;">
                    </div>
                </div>

                <div class="mb-4">
                    <input type="text" name="subject" class="form-control title-input border-0 border-bottom rounded-0 px-0 py-2" placeholder="제목을 입력하세요" required>
                </div>

                <div class="mb-5">
                    <textarea name="content" class="form-control border-0 bg-light rounded-4 p-4" rows="15" placeholder="내용을 자유롭게 입력하세요.&#13;&#10;욕설이나 비방, 광고성 글은 제재 대상이 될 수 있습니다." style="resize: none;" required></textarea>
                </div>

                <div class="d-flex justify-content-between align-items-center">
                    <a href="${pageContext.request.contextPath}/bbs/list" class="text-decoration-none text-muted fw-bold">
                        &larr; 목록으로 돌아가기
                    </a>
                    <div class="d-flex gap-2">
                        <a href="${pageContext.request.contextPath}/bbs/list" class="btn btn-light rounded-pill px-4 fw-bold">취소</a>
                        <button type="submit" class="btn btn-dark rounded-pill px-5 fw-bold" style="color: var(--primary-color);">
                            등록하기
                        </button>
                    </div>
                </div>

            </form>
        </div>
    </div>
    
    <footer>
		   <jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
		</footer>

	<jsp:include page="/WEB-INF/views/layout/footerResources.jsp"/>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        function sendOk() {
            const f = document.bbsForm;
            
            // 제목 검사
            if(!f.subject.value.trim()) {
                alert("제목을 입력하세요.");
                f.subject.focus();
                return false;
            }
            
            // 내용 검사
            if(!f.content.value.trim()) {
                alert("내용을 입력하세요.");
                f.content.focus();
                return false;
            }
            
            return true;
        }
    </script>
    
</body>
</html>