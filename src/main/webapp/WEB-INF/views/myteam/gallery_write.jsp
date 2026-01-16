<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <title>Footlog - 갤러리 글쓰기</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <jsp:include page="/WEB-INF/views/layout/headerResources.jsp"/>
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/style.css?ver=2">
    
    <style>
        /* 사이드바 타이틀 스타일 (style.css에 없다면 여기서 보정) */
        .sidebar-title { font-size: 0.85rem; font-weight: 700; color: #6c757d; text-transform: uppercase; letter-spacing: 0.5px; }
        
        /* 이미지 미리보기 영역 */
        .img-preview-wrapper {
            width: 100%;
            height: 400px;
            background-color: #f8f9fa;
            border: 2px dashed #dee2e6;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
            margin-bottom: 15px;
            position: relative;
        }
        
        .img-preview-wrapper img {
            width: 100%;
            height: 100%;
            object-fit: contain;
            display: none; 
        }

        .img-preview-placeholder {
            text-align: center;
            color: #adb5bd;
        }

        .write-card {
            border: none;
            box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.03);
            border-radius: 15px;
        }
    </style>
    
    <script type="text/javascript">
        function previewImage(input) {
            const previewImg = document.getElementById('previewImg');
            const placeholder = document.getElementById('previewPlaceholder');

            if (input.files && input.files[0]) {
                if(typeof isImageFile === 'function') {
                    if(!isImageFile(input.files[0].name)) {
                        alert("이미지 파일만 등록 가능합니다.");
                        input.value = "";
                        return;
                    }
                }

                const reader = new FileReader();
                reader.onload = function(e) {
                    previewImg.src = e.target.result;
                    previewImg.style.display = 'block';
                    placeholder.style.display = 'none';
                }
                reader.readAsDataURL(input.files[0]);
            } else {
                previewImg.src = "";
                previewImg.style.display = 'none';
                placeholder.style.display = 'block';
            }
        }

        function sendOk() {
            const f = document.galleryForm;
            
            if(!f.title.value.trim()) {
                alert("제목을 입력하세요.");
                f.title.focus();
                return;
            }
            
            if(!f.selectFile.value) {
                alert("사진을 등록해주세요.");
                return;
            }
            
            if(typeof isImageFile === 'function') {
                if(!isImageFile(f.selectFile.value)) {
                    alert("이미지 파일(jpg, png, gif 등)만 업로드 가능합니다.");
                    return;
                }
            }

            f.action = "${pageContext.request.contextPath}/myteam/gallery_write";
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
                        <h2 class="fw-bold display-6 mb-1 text-dark">GALLERY WRITE</h2>
                        <p class="text-muted mb-0">우리 팀의 멋진 순간을 사진으로 기록하세요.</p>
                    </div>
                </div>

                <div class="card write-card p-4">
                    <div class="card-body">
                        
                        <form name="galleryForm" method="post" enctype="multipart/form-data">
                            <input type="hidden" name="teamCode" value="${teamCode}">
                            
                            <div class="mb-4">
                                <label class="form-label fw-bold">제목 <span class="text-danger">*</span></label>
                                <input type="text" name="title" class="form-control form-control-lg" placeholder="사진 제목을 입력하세요">
                            </div>

                            <div class="mb-4">
                                <label class="form-label fw-bold">사진 업로드 <span class="text-danger">*</span></label>
                                
                                <div class="img-preview-wrapper">
                                    <img id="previewImg" src="" alt="Image Preview">
                                    <div id="previewPlaceholder" class="img-preview-placeholder">
                                        <i class="bi bi-camera fs-1"></i>
                                        <p class="mb-0 mt-2">이미지를 선택하면 미리보기가 표시됩니다.</p>
                                    </div>
                                </div>

                                <input type="file" name="selectFile" class="form-control" accept="image/*" onchange="previewImage(this)">
                                <div class="form-text">JPG, PNG, GIF 파일만 업로드 가능합니다. (권장: 10MB 이하)</div>
                            </div>

                            <div class="mb-5">
                                <label class="form-label fw-bold">설명</label>
                                <textarea name="content" class="form-control" rows="5" placeholder="사진에 대한 설명을 자유롭게 작성해주세요."></textarea>
                            </div>

                            <div class="d-flex justify-content-center gap-2">
                                <button type="button" class="btn btn-primary px-5 py-2 fw-bold" onclick="sendOk();">
                                    등록하기
                                </button>
                                <button type="button" class="btn btn-light px-5 py-2 border" onclick="location.href='${pageContext.request.contextPath}/myteam/gallery?teamCode=${teamCode}';">
                                    취소
                                </button>
                            </div>
                        </form>

                    </div>
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