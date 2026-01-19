<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>프로필 편집 - Footlog</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <style>
        /* 기존 스타일 그대로 유지 */
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
        <div class="page-title">회원 정보 수정</div>
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
        <div class="profile-section">
            <div class="profile-wrapper">
                <c:choose>
                    <c:when test="${not empty dto.profile_image && dto.profile_image != 'avatar.png'}">
                        <img src="${pageContext.request.contextPath}/uploads/member/${dto.profile_image}" id="profilePreview" class="profile-img" onerror="this.src='${pageContext.request.contextPath}/dist/images/avatar.png'">
                    </c:when>
                    <c:otherwise>
                        <img src="${pageContext.request.contextPath}/dist/images/avatar.png" id="profilePreview" class="profile-img">
                    </c:otherwise>
                </c:choose>
                <div class="delete-btn" onclick="deleteImage()" title="기본 이미지로 변경"><i class="bi bi-trash-fill"></i></div>
                <div class="profile-btn" onclick="document.getElementById('selectFile').click();" title="사진 변경"><i class="bi bi-camera-fill"></i></div>
                <input type="file" name="selectFile" id="selectFile" accept="image/png, image/jpeg" hidden>
                <input type="hidden" name="imageDeleted" id="imageDeleted" value="false">
            </div>
        </div>

        <div class="mb-4">
            <label class="form-label">아이디</label>
            <input type="text" name="member_id" value="${dto.member_id}" class="form-control" readonly>
        </div>
        <div class="mb-3">
            <label class="form-label">이메일</label>
            <input type="email" name="email" value="${dto.email}" class="form-control">
        </div>
        
        <div class="mb-3">
            <label class="form-label">비밀번호 변경 <span class="text-muted fw-normal" style="font-size:0.75rem">(변경 시에만 입력)</span></label>
            <input type="password" name="password" id="password" class="form-control" placeholder="변경할 경우에만 입력하세요">
        </div>
        <div class="mb-4">
            <input type="password" id="passwordCheck" class="form-control" placeholder="비밀번호 확인">
            <div id="pwFeedback" class="msg-box"></div>
        </div>
        
        <div class="row mb-4">
            <div class="col-6"><label class="form-label">이름</label><input type="text" name="member_name" value="${dto.member_name}" class="form-control"></div>
            <div class="col-6"><label class="form-label">연락처</label><input type="tel" name="phone_number" value="${dto.phone_number}" class="form-control"></div>
        </div>
        
        <div class="mb-4">
            <label class="form-label">주 활동 지역</label>
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
        
        <div class="mb-5">
            <label class="form-label">주 포지션</label>
            <div class="btn-group-position">
                <input type="radio" class="btn-check" name="preferred_position" id="pos_fw" value="FW" ${dto.preferred_position=="FW" ? "checked":""}>
                <label class="btn btn-outline-custom text-center" for="pos_fw"><div class="fw-bold">FW</div></label>
                <input type="radio" class="btn-check" name="preferred_position" id="pos_mf" value="MF" ${dto.preferred_position=="MF" ? "checked":""}>
                <label class="btn btn-outline-custom text-center" for="pos_mf"><div class="fw-bold">MF</div></label>
                <input type="radio" class="btn-check" name="preferred_position" id="pos_df" value="DF" ${dto.preferred_position=="DF" ? "checked":""}>
                <label class="btn btn-outline-custom text-center" for="pos_df"><div class="fw-bold">DF</div></label>
                <input type="radio" class="btn-check" name="preferred_position" id="pos_gk" value="GK" ${dto.preferred_position=="GK" ? "checked":""}>
                <label class="btn btn-outline-custom text-center" for="pos_gk"><div class="fw-bold">GK</div></label>
            </div>
        </div>
        
        <div class="row g-2">
            <div class="col-6"><button type="button" class="btn-cancel" onclick="location.href='${pageContext.request.contextPath}/member/mypage'">취소</button></div>
            <div class="col-6"><button type="button" class="btn-black" onclick="updateOk()">수정 완료</button></div>
        </div>
    </form>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
// [성공 알림]
$(function() {
    if ("${updateComplete}" === "true") {
        alert("회원 정보 수정이 완료되었습니다!\n확인을 누르면 마이페이지로 이동합니다.");
        location.href = "${pageContext.request.contextPath}/member/mypage";
    }
});

// [비밀번호 실시간 일치 확인]
$("#passwordCheck, #password").on("keyup", function() {
    const pw = $("#password").val();
    const pwConfirm = $("#passwordCheck").val();
    const feedback = $("#pwFeedback");
    
    if (pw === "") {
        feedback.html("");
        return;
    }
    
    if (pwConfirm === "") { 
        feedback.html(""); 
    } else if (pw === pwConfirm) { 
        feedback.html('<span class="msg-success"><i class="bi bi-check-circle-fill"></i> 비밀번호가 일치합니다.</span>'); 
    } else { 
        feedback.html('<span class="msg-error"><i class="bi bi-x-circle-fill"></i> 비밀번호가 일치하지 않습니다.</span>'); 
    }
});

// [이미지 삭제 로직]
function deleteImage() {
    if(!confirm("프로필 사진을 삭제하시겠습니까?")) return;
    document.getElementById('profilePreview').src = '${pageContext.request.contextPath}/dist/images/avatar.png';
    document.getElementById('selectFile').value = '';
    document.getElementById('imageDeleted').value = "true";
}

// [수정 완료 전송 함수]
function updateOk() {
    const f = document.memberForm;
    let p;

    // 1. 비밀번호 검사 (입력된 경우에만 체크!)
    const pw = f.password.value;
    const pwCheck = document.getElementById("passwordCheck").value;

    if(pw.length > 0) {
        p = /^(?=.*[a-z])(?=.*[!@#$%^*+=-]|.*[0-9]).{5,10}$/i;
        if( ! p.test(pw) ) {
            alert('패스워드 형식을 맞춰주세요 (문자+숫자/특수문자, 5~10자).');
            f.password.focus();
            return;
        }

        if(pw !== pwCheck) {
            alert('패스워드가 일치하지 않습니다.');
            f.passwordCheck.focus();
            return;
        }
    }

    // 2. 이름 검사
    p = /^[가-힣]{2,5}$/;
    if( ! p.test(f.member_name.value) ) {
        alert('이름은 한글 2~5자로 입력해주세요.');
        f.member_name.focus();
        return;
    }

    // 3. 이메일 검사
    if( ! f.email.value.trim() ) { 
        alert('이메일을 입력하세요.'); 
        f.email.focus(); 
        return; 
    }

    // 4. 전화번호 검사 
    const phone = f.phone_number.value.trim();
    if( ! phone ) {
        alert('전화번호를 입력하세요.');
        f.phone_number.focus();
        return;
    }
    
    // 숫자와 하이픈만 허용하는 정규식
    const phonePattern = /^[0-9]{2,3}-[0-9]{3,4}-[0-9]{4}$/;
    if( ! phonePattern.test(phone) ) {
        alert("연락처 형식이 올바르지 않습니다.\n숫자와 하이픈(-)을 포함하여 정확히 입력해주세요.\n(예: 010-1234-5678)");
        f.phone_number.focus();
        return;
    }

    // 전송
    f.action = '${pageContext.request.contextPath}/member/updateDo';
    f.submit();
}

// [이미지 미리보기]
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