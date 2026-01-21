<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>
	    <c:choose>
		    <c:when test="${mode == 'insert'}">
		        구장 추가 - Footlog
		    </c:when>
		    <c:otherwise>
		        구장 수정 - Footlog
		    </c:otherwise>
		</c:choose>
	</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    
    <style>
        @import url('https://cdn.jsdelivr.net/gh/orioncactus/pretendard/dist/web/static/pretendard.css');
        body { background-color: #f8f9fa; padding: 60px 0; font-family: 'Pretendard', sans-serif; color: #222; }
        .update-card { width: 100%; max-width: 480px; padding: 50px 40px; border-radius: 24px; background: #fff; box-shadow: 0 15px 35px rgba(0,0,0,0.06); margin: auto; border: 1px solid rgba(0,0,0,0.02); }
        .brand-logo { font-size: 2.4rem; font-weight: 900; font-style: italic; text-align: center; display: block; text-decoration: none; color: #111; letter-spacing: -1.5px; margin-bottom: 30px; }
        .page-header { text-align: center; margin-bottom: 40px; }
        .page-title { font-size: 1.5rem; font-weight: 800; color: #111; margin-bottom: 5px; }
        .sub-title { font-size: 0.9rem; color: #888; font-weight: 500; letter-spacing: -0.2px; }
        .form-label { font-size: 0.8rem; font-weight: 700; color: #555; margin-bottom: 6px; margin-left: 2px; }
        .form-control, .form-select { border-radius: 12px; padding: 13px 16px; border: 1px solid #e1e1e1; background-color: #fcfcfc; font-size: 0.95rem; transition: all 0.2s ease; }
        .form-control:focus, .form-select:focus { border-color: #111; background-color: #fff; box-shadow: 0 0 0 3px rgba(0, 0, 0, 0.05); }
        .form-control[readonly] { background-color: #f8f9fa; color: #adb5bd; cursor: default; border-color: #f1f3f5; }
        .btn-black { background: #111; color: #fff; border-radius: 12px; width: 100%; padding: 15px; font-weight: 700; font-size: 1rem; border: none; transition: all 0.2s; margin-top: 10px; }
        .btn-black:hover { background: #000; transform: translateY(-2px); box-shadow: 0 5px 15px rgba(0,0,0,0.15); }
        .btn-cancel { background: #fff; color: #666; border: 1px solid #e1e1e1; border-radius: 12px; width: 100%; padding: 15px; font-weight: 700; font-size: 1rem; margin-top: 10px; transition: all 0.2s; }
        .btn-cancel:hover { background: #f8f9fa; color: #333; border-color: #d1d1d1; }
        .profile-section { display: flex; justify-content: center; margin-bottom: 40px; position: relative; }
        .profile-wrapper { position: relative; width: 120px; height: 120px; }
        .profile-img { width: 100%; height: 100%; border-radius: 50%; object-fit: cover; border: 4px solid #fff; box-shadow: 0 8px 20px rgba(0,0,0,0.1); background-color: #f8f9fa; }
        .profile-btn { position: absolute; bottom: 0; right: 0; background: #111; color: #fff; width: 36px; height: 36px; border-radius: 50%; display: flex; align-items: center; justify-content: center; box-shadow: 0 4px 10px rgba(0,0,0,0.15); border: 2px solid #fff; cursor: pointer; z-index: 2; transition: transform 0.2s; }
        .delete-btn { position: absolute; bottom: 0; left: 0; background: #ff4757; color: #fff; width: 36px; height: 36px; border-radius: 50%; display: flex; align-items: center; justify-content: center; box-shadow: 0 4px 10px rgba(0,0,0,0.15); border: 2px solid #fff; cursor: pointer; z-index: 2; transition: transform 0.2s; }
        .msg-box { font-size: 0.8rem; margin-top: 8px; font-weight: 600; display: flex; align-items: center; gap: 5px; min-height: 20px; }
        .msg-success { color: #00b894; }
        .msg-error { color: #ff7675; }
        .btn-group-position { display: flex; gap: 8px; }
        .btn-check + .btn-outline-custom { flex: 1; border: 1px solid #e1e1e1; border-radius: 12px; color: #888; padding: 12px; background: #fff; transition: 0.2s; }
        .btn-check:checked + .btn-outline-custom { background-color: #111; color: #D4F63F; border-color: #111; font-weight: 800; box-shadow: 0 4px 12px rgba(0,0,0,0.1); }
    </style>
</head>
<body>

<div class="update-card">
    <a href="${pageContext.request.contextPath}/main" class="brand-logo">Footlog</a>
    
    <div class="page-header">
        <div class="page-title">
	        <c:choose>
			    <c:when test="${mode == 'insert'}">
		        구장 추가 - Footlog
		   		</c:when>
		    	<c:otherwise>
		        구장 수정 - Footlog
		    	</c:otherwise>
			</c:choose>
        </div>
        <div class="sub-title">새로운 시즌, 새로운 모습으로</div>
    </div>

    <c:if test="${not empty message}">
        <div class="alert alert-danger alert-dismissible fade show mb-4" role="alert" 
             style="border-radius: 12px; font-size: 0.9rem; font-weight: 600;">
            <i class="bi bi-exclamation-triangle-fill me-2"></i> ${message}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>
    
    <form name="memberForm" method="post" enctype="multipart/form-data">
    	<input type="hidden" name="mode" value="${mode}">
    	<c:if test="${mode == 'update'}">
  		  <input type="hidden" name="stadiumCode" value="${dto.stadiumCode}">
		</c:if>

        <div class="profile-section">
            <div class="profile-wrapper">
                <c:choose>
                    <c:when test="${not empty dto.stadium_image && dto.stadium_image != 'avatar.png'}">
                        <img src="${pageContext.request.contextPath}/uploads/member/${dto.stadium_image}" id="profilePreview" class="profile-img" onerror="this.src='${pageContext.request.contextPath}/dist/images/avatar.png'">
                    </c:when>
                    <c:otherwise>
                        <img src="${pageContext.request.contextPath}/dist/images/avatar.png" id="profilePreview" class="profile-img">
                    </c:otherwise>
                </c:choose>
                <div class="delete-btn" onclick="deleteImage()" title="기본 이미지로 변경"><i class="bi bi-trash-fill"></i></div>
                <div class="profile-btn" onclick="document.getElementById('selectFile').click();" title="사진 변경"><i class="bi bi-camera-fill"></i></div>
                <input type="file" name="selectFile" id="selectFile" accept="image/png, image/jpeg" hidden>
                <input type="hidden" name="imageDeleted" id="imageDeleted" value="false">
                <input type="hidden" name="stadiumImage" value="${dto.stadium_image}">
            </div>
        </div>

        <div class="mb-4">
            <label class="form-label">구장 명</label>
            <input type="text" name="stadiumName" value="${dto.stadiumName}" class="form-control">
        </div>
        <div class="mb-4">
            <label class="form-label">지역</label>
            <select name="region" id="region" class="form-select">
                <option value="서울" ${dto.region=="서울" ? "selected":""}>서울</option>
                <option value="경기" ${dto.region=="경기" ? "selected":""}>경기</option>
                <option value="인천" ${dto.region=="인천" ? "selected":""}>인천</option>
                <option value="강원" ${dto.region=="강원" ? "selected":""}>강원</option>
                <option value="충청" ${dto.region=="충청" ? "selected":""}>충청</option>
                <option value="전라" ${dto.region=="전라" ? "selected":""}>전라</option>
                <option value="경상" ${dto.region=="경상" ? "selected":""}>경상</option>
                <option value="제주" ${dto.region=="제주" ? "selected":""}>제주</option>
            </select>
        </div>
        <div class="mb-3">
            <label class="form-label">대표연락처</label>
            <input type="text" name="phoneNumber" value="${dto.phoneNumber}" class="form-control">
        </div>
        <div class="mb-3">
            <label class="form-label">구장 소개글</label>
            <input type="text" name="description" value="${dto.description}" class="form-control">
        </div>
	        
	    <div class="mb-3">
			<label class="form-label">평점</label>
			<input type="number" name="rating" value="${dto.rating}" class="form-control">
		</div>
		<div class="mb-3">
			<label class="form-label">시간당 가격</label>
			<input type="number" name="price" value="${dto.price}" class="form-control">
		</div>
	        
        <div class="row g-2">
            <div class="col-6"><button type="button" class="btn-cancel" onclick="location.href='${pageContext.request.contextPath}/admin/mypage?menu=stadium'">취소</button></div>
            <div class="col-6"><button type="button" class="btn-black" onclick="insertOk()">등록 완료</button></div>
        </div>
    </form>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
// [성공 알림 및 페이지 이동]
$(function() {
    if ("${updateComplete}" === "true") {
        alert("회원 정보 수정이 완료되었습니다!\n확인을 누르면 마이페이지로 이동합니다.");
        location.href = "${pageContext.request.contextPath}/member/mypage";
    }
});

function deleteImage() {
    if(!confirm("프로필 사진을 삭제하시겠습니까?")) return;
    document.getElementById('profilePreview').src = '${pageContext.request.contextPath}/dist/images/avatar.png';
    document.getElementById('selectFile').value = '';
    document.getElementById('imageDeleted').value = "true";
}

function insertOk() {
    const f = document.memberForm;
    // 유효성 검사 생략 (기존 코드와 동일)
    f.action = '${pageContext.request.contextPath}/admin/updateDo';
    f.submit();
}

// 이미지 미리보기 및 기타 JS (기존 유지)
const inputEL = document.querySelector('input[name=selectFile]');
inputEL.addEventListener('change', ev => {
    let file = ev.target.files[0];
    if(!file) return;
    var reader = new FileReader();
    reader.onload = function(e) { 
        document.querySelector('#profilePreview').src = e.target.result;
        document.getElementById('imageDeleted').value = "false";
    }
    reader.readAsDataURL(file);
});
</script>
</body>
</html>