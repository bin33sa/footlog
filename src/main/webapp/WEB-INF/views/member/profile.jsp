<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>프로필 설정 - Footlog</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/style.css">
    <style>
        .profile-upload-zone { width: 150px; height: 150px; margin: 0 auto; position: relative; cursor: pointer; }
        .profile-preview { width: 100%; height: 100%; object-fit: cover; border-radius: 50%; border: 4px solid var(--primary-color); transition: 0.3s; }
        .upload-icon { position: absolute; bottom: 0; right: 0; background: #111; color: #fff; width: 40px; height: 40px; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-size: 1.2rem; border: 2px solid #fff; }
        .profile-upload-zone:hover .profile-preview { opacity: 0.7; }
    </style>
</head>
<body>

    <jsp:include page="/WEB-INF/views/layout/header.jsp" />

    <div class="container mt-5 mb-5" style="max-width: 800px;">
        
        <div class="d-flex align-items-center justify-content-between mb-4">
            <h3 class="fw-bold">프로필 편집</h3>
            <a href="${pageContext.request.contextPath}/member/mypage" class="btn btn-outline-secondary rounded-pill btn-sm">
                &larr; 마이페이지로 돌아가기
            </a>
        </div>

        <div class="modern-card p-5">
            <form action="${pageContext.request.contextPath}/profileUpdate" method="post" enctype="multipart/form-data">
                
                <div class="text-center mb-5">
                    <label for="profileImgInput" class="profile-upload-zone">
                        <img src="${empty sessionScope.user.img ? 'https://via.placeholder.com/150' : sessionScope.user.img}" 
                             id="previewImg" class="profile-preview">
                        <div class="upload-icon">+</div>
                    </label>
                    <input type="file" name="profileImg" id="profileImgInput" class="d-none" accept="image/*" onchange="readURL(this);">
                    <p class="text-muted small mt-2">클릭하여 사진을 변경하세요</p>
                </div>

                <h5 class="fw-bold border-bottom pb-2 mb-4">플레이어 정보</h5>
                
                <div class="row g-3 mb-3">
                    <div class="col-md-6">
                        <label class="form-label fw-bold small">주 포지션</label>
                        <select name="position" class="form-select">
                            <option value="FW">FW (공격수)</option>
                            <option value="MF">MF (미드필더)</option>
                            <option value="DF">DF (수비수)</option>
                            <option value="GK">GK (골키퍼)</option>
                        </select>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label fw-bold small">주로 쓰는 발 (주발)</label>
                        <div class="btn-group w-100" role="group">
                            <input type="radio" class="btn-check" name="mainFoot" id="footRight" value="R" checked>
                            <label class="btn btn-outline-dark" for="footRight">오른발</label>

                            <input type="radio" class="btn-check" name="mainFoot" id="footLeft" value="L">
                            <label class="btn btn-outline-dark" for="footLeft">왼발</label>
                            
                            <input type="radio" class="btn-check" name="mainFoot" id="footBoth" value="B">
                            <label class="btn btn-outline-dark" for="footBoth">양발</label>
                        </div>
                    </div>
                </div>

                <div class="row g-3 mb-4">
                     <div class="col-md-6">
                        <label class="form-label fw-bold small">활동 지역</label>
                        <input type="text" name="area" class="form-control" value="서울 마포구">
                    </div>
                    <div class="col-md-6">
                        <label class="form-label fw-bold small">신체 조건</label>
                        <div class="d-flex gap-2">
                            <input type="text" name="height" class="form-control" placeholder="180cm">
                            <input type="text" name="weight" class="form-control" placeholder="75kg">
                        </div>
                    </div>
                </div>

                <div class="mb-4">
                    <label class="form-label fw-bold small">플레이 스타일 / 자기소개</label>
                    <textarea name="intro" class="form-control" rows="4" placeholder="자신의 플레이 스타일이나 소개를 적어주세요."></textarea>
                </div>

                <div class="d-grid">
                    <button type="submit" class="btn btn-dark rounded-pill py-3 fw-bold" style="color: var(--primary-color);">
                        프로필 저장하기
                    </button>
                </div>
            </form>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        function readURL(input) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.onload = function(e) {
                    $('#previewImg').attr('src', e.target.result);
                }
                reader.readAsDataURL(input.files[0]);
            }
        }
    </script>
    
     <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    
</body>
</html>