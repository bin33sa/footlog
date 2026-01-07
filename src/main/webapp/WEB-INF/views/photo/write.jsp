<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <title>사진 등록 - Footlog</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/style.css">
    
    <style>
        .form-control:focus { border-color: var(--primary-color); box-shadow: 0 0 0 0.25rem rgba(212, 246, 63, 0.25); }
        .title-input { font-size: 1.5rem; font-weight: 700; background: transparent; }
        
        /* 이미지 미리보기 영역 */
        .img-preview-box {
            width: 100%;
            height: 300px;
            background-color: #f8f9fa;
            border: 2px dashed #ddd;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
            color: #aaa;
        }
        .img-preview-box img {
            max-width: 100%;
            max-height: 100%;
            object-fit: contain;
        }
    </style>
</head>
	<jsp:include page="/WEB-INF/views/layout/headerResources.jsp"/>
	
<body>

    <header>
	   <jsp:include page="/WEB-INF/views/layout/header.jsp"/>
	</header>

    <div class="container mt-5 mb-5" style="max-width: 900px;">
        
        <div class="mb-4 border-bottom pb-3">
            <h2 class="fw-bold display-6 mb-1">GALLERY WRITE</h2>
            <p class="text-muted mb-0">멋진 순간을 기록하세요.</p>
        </div>

        <div class="modern-card p-5 shadow-lg">
            <form name="photoForm" action="${pageContext.request.contextPath}/photo/${mode=='update'?'update':'write'}" method="post" enctype="multipart/form-data" onsubmit="return sendOk();">
                
                <c:if test="${mode=='update'}">
                    <input type="hidden" name="num" value="${dto.num}">
                    <input type="hidden" name="page" value="${page}">
                    <input type="hidden" name="imageFilename" value="${dto.imageFilename}">
                </c:if>

                <div class="mb-4">
                    <input type="text" name="subject" value="${dto.subject}" class="form-control title-input border-0 border-bottom rounded-0 px-0 py-2" placeholder="제목을 입력하세요" required>
                </div>

                <div class="row mb-4">
                    <div class="col-md-6">
                        <label class="form-label fw-bold small text-muted">사진 업로드</label>
                        <input type="file" name="uploadFile" class="form-control mb-2" accept="image/*" onchange="previewImage(this);">
                        <small class="text-muted">* 이미지 파일만 업로드 가능합니다.</small>
                    </div>
                    <div class="col-md-6">
                        <div class="img-preview-box rounded-4" id="imgPreview">
                            <c:if test="${mode=='update' && not empty dto.imageFilename}">
                                <img src="${pageContext.request.contextPath}/uploads/photo/${dto.imageFilename}">
                            </c:if>
                            <c:if test="${mode!='update'}">
                                <span>이미지 미리보기</span>
                            </c:if>
                        </div>
                    </div>
                </div>

                <div class="mb-5">
                    <textarea name="content" class="form-control border-0 bg-light rounded-4 p-4" rows="10" placeholder="사진에 대한 설명을 입력하세요." style="resize: none;" required>${dto.content}</textarea>
                </div>

                <div class="d-flex justify-content-between align-items-center">
                    <button type="button" class="btn btn-light rounded-pill px-4 fw-bold" onclick="location.href='${pageContext.request.contextPath}/photo/list';">취소</button>
                    <button type="submit" class="btn btn-dark rounded-pill px-5 fw-bold" style="color: var(--primary-color);">
                        ${mode=='update' ? '수정완료' : '등록하기'}
                    </button>
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
            const f = document.photoForm;
            if(!f.subject.value.trim()) { alert("제목을 입력하세요."); f.subject.focus(); return false; }
            if(!f.content.value.trim()) { alert("내용을 입력하세요."); f.content.focus(); return false; }
            
            // 등록 모드일 때 파일 필수 체크
            <c:if test="${mode!='update'}">
                if(!f.uploadFile.value) { alert("이미지를 선택해주세요."); return false; }
            </c:if>
            
            return true;
        }

        // 이미지 미리보기 JS
        function previewImage(input) {
            const previewBox = document.getElementById('imgPreview');
            if (input.files && input.files[0]) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    previewBox.innerHTML = '<img src="' + e.target.result + '">';
                };
                reader.readAsDataURL(input.files[0]);
            } else {
                previewBox.innerHTML = '<span>이미지 미리보기</span>';
            }
        }
    </script>
    
</body>
</html>