<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>회원가입 - Footlog</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <style>
        /* CSS는 기존과 동일하게 유지 */
        @import url('https://cdn.jsdelivr.net/gh/orioncactus/pretendard/dist/web/static/pretendard.css');
        body { background-color: #f8f9fa; padding: 60px 0; font-family: 'Pretendard', sans-serif; color: #333; }
        .signup-card { width: 100%; max-width: 480px; padding: 50px 40px; border-radius: 24px; background: #fff; box-shadow: 0 15px 35px rgba(0,0,0,0.08); margin: auto; border: 1px solid rgba(0,0,0,0.02); }
        .brand-logo { font-size: 2.2rem; font-weight: 900; font-style: italic; text-align: center; margin-bottom: 10px; display: block; text-decoration: none; color: #111; letter-spacing: -1px; }
        .sub-title { text-align: center; color: #888; font-size: 0.95rem; margin-bottom: 40px; font-weight: 500; }
        .form-label { font-size: 0.85rem; font-weight: 700; color: #444; margin-bottom: 6px; margin-left: 2px; }
        .form-control, .form-select { border-radius: 12px; padding: 14px 16px; border: 1px solid #e1e1e1; background-color: #fcfcfc; font-size: 0.95rem; transition: all 0.2s ease; }
        .form-control:focus, .form-select:focus { border-color: #111; background-color: #fff; box-shadow: 0 0 0 4px rgba(0, 0, 0, 0.03); }
        .btn-black { background: #111; color: #fff; border-radius: 12px; width: 100%; padding: 16px; font-weight: 700; font-size: 1rem; border: none; transition: all 0.3s cubic-bezier(0.25, 0.8, 0.25, 1); margin-top: 10px; }
        .btn-black:hover { background: #000; transform: translateY(-2px); box-shadow: 0 5px 15px rgba(0,0,0,0.2); }
        .btn-black:disabled { background: #e9ecef; color: #adb5bd; transform: none; box-shadow: none; }
        .btn-check-id { border-radius: 0 12px 12px 0; background: #222; color: #fff; border: 1px solid #222; padding: 0 20px; font-weight: 600; font-size: 0.85rem; transition: 0.2s; }
        .btn-check-id:hover { background: #444; border-color: #444; color: #fff; }
        .input-group .form-control { border-radius: 12px 0 0 12px; }
        .profile-section { display: flex; justify-content: center; margin-bottom: 40px; }
        .profile-wrapper { position: relative; width: 110px; height: 110px; cursor: pointer; transition: transform 0.2s; }
        .profile-wrapper:hover { transform: scale(1.02); }
        .profile-img { width: 100%; height: 100%; border-radius: 50%; object-fit: cover; border: 2px solid #f1f3f5; background-color: #f8f9fa; }
        .profile-placeholder-icon { position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); font-size: 2.5rem; color: #dee2e6; z-index: 1; pointer-events: none; }
        .profile-btn { position: absolute; bottom: 5px; right: 0px; background: #111; color: #fff; width: 34px; height: 34px; border-radius: 50%; display: flex; align-items: center; justify-content: center; box-shadow: 0 4px 10px rgba(0,0,0,0.15); border: 2px solid #fff; z-index: 2; }
        .msg-box { font-size: 0.8rem; margin-top: 8px; font-weight: 600; display: flex; align-items: center; gap: 5px; min-height: 20px; }
        .msg-success { color: #00b894; }
        .msg-error { color: #ff7675; }
        .btn-group-position { display: flex; gap: 8px; }
        .btn-check + .btn-outline-custom { flex: 1; border: 1px solid #e1e1e1; border-radius: 12px; color: #888; padding: 12px; background: #fff; transition: 0.2s; }
        .btn-check:checked + .btn-outline-custom { background-color: #111; color: #D4F63F; border-color: #111; font-weight: 800; box-shadow: 0 4px 12px rgba(0,0,0,0.1); }
        a { text-decoration: none; }
    </style>
</head>
<body>

<div class="signup-card">
    <a href="${pageContext.request.contextPath}/main" class="brand-logo">Footlog</a>
    <p class="sub-title">함께 뛰는 즐거움, 풋로그에 오신 것을 환영합니다</p>
    
    <form name="memberForm" method="post" enctype="multipart/form-data">
        
        <div class="profile-section">
            <div class="profile-wrapper" onclick="document.getElementById('selectFile').click();">
                <c:choose>
                    <c:when test="${not empty dto.profile_image}">
                        <img src="${pageContext.request.contextPath}/uploads/member/${dto.profile_image}" id="profilePreview" class="profile-img">
                    </c:when>
                    <c:otherwise>
                        <img src="data:image/gif;base64,R0lGODlhAQABAAD/ACwAAAAAAQABAAACADs=" id="profilePreview" class="profile-img">
                        <i class="bi bi-person-fill profile-placeholder-icon" id="defaultIcon"></i>
                    </c:otherwise>
                </c:choose>
                
                <div class="profile-btn">
                    <i class="bi bi-camera-fill" style="font-size: 0.9rem;"></i>
                </div>
                <input type="file" name="selectFile" id="selectFile" accept="image/png, image/jpeg" hidden>
            </div>
        </div>

        <div class="mb-4 id-check-box">
            <label class="form-label">아이디</label>
            <div class="input-group">
                <input type="text" name="member_id" id="member_id" value="${dto.member_id}" class="form-control" placeholder="영문/숫자 4~12자" ${mode=="update" ? "readonly":""}>
                <c:if test="${mode=='sign'}">
                    <button type="button" class="btn btn-check-id" onclick="userIdCheck()">중복확인</button>
                </c:if>
            </div>
            <div class="msg-box help-block"></div> 
            <input type="hidden" name="memberIdValid" id="idValid" value="false">
        </div>

        <div class="mb-3">
            <label class="form-label">이메일</label>
            <input type="email" name="email" id="email" value="${dto.email}" class="form-control" placeholder="example@footlog.com">
        </div>

        <div class="mb-3">
            <label class="form-label">비밀번호</label>
            <input type="password" name="password" id="password" class="form-control" placeholder="5~10자, 숫자/특수문자 포함">
        </div>
        <div class="mb-4">
            <input type="password" id="passwordCheck" class="form-control" placeholder="비밀번호 확인">
            <div id="pwFeedback" class="msg-box"></div>
        </div>

        <div class="row mb-4">
            <div class="col-6">
                <label class="form-label">이름</label>
                <input type="text" name="member_name" id="member_name" value="${dto.member_name}" class="form-control" placeholder="실명">
            </div>
            <div class="col-6">
                <label class="form-label">연락처</label>
                <input type="tel" name="phone_number" id="phone_number" value="${dto.phone_number}" class="form-control" placeholder="- 없이 입력">
            </div>
        </div>

        <div class="mb-4">
            <label class="form-label">주 활동 지역</label>
            <select name="region" id="region" class="form-select text-muted" onchange="toggleSelectColor(this)">
                <option value="" selected>지역을 선택해주세요</option>
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
                <label class="btn btn-outline-custom text-center" for="pos_fw"><div class="fw-bold">FW</div><div style="font-size:0.7rem">공격수</div></label>
                <input type="radio" class="btn-check" name="preferred_position" id="pos_mf" value="MF" ${dto.preferred_position=="MF" ? "checked":""}>
                <label class="btn btn-outline-custom text-center" for="pos_mf"><div class="fw-bold">MF</div><div style="font-size:0.7rem">미드필더</div></label>
                <input type="radio" class="btn-check" name="preferred_position" id="pos_df" value="DF" ${dto.preferred_position=="DF" ? "checked":""}>
                <label class="btn btn-outline-custom text-center" for="pos_df"><div class="fw-bold">DF</div><div style="font-size:0.7rem">수비수</div></label>
                <input type="radio" class="btn-check" name="preferred_position" id="pos_gk" value="GK" ${dto.preferred_position=="GK" ? "checked":""}>
                <label class="btn btn-outline-custom text-center" for="pos_gk"><div class="fw-bold">GK</div><div style="font-size:0.7rem">골키퍼</div></label>
            </div>
        </div>

        <div class="mb-4">
            <div class="form-check">
                <input class="form-check-input" type="checkbox" name="agree" id="agree" onchange="toggleSubmitBtn()">
                <label class="form-check-label" for="agree" style="font-size: 0.9rem; color: #555;">
                    <span class="fw-bold text-dark">(필수)</span> 서비스 이용약관 및 개인정보 처리방침 동의
                </label>
            </div>
        </div>

        <button type="button" name="sendButton" class="btn-black" onclick="memberOk()" disabled>
            ${mode=="update" ? "정보수정 완료" : "가입하기"}
        </button>
       
        <div class="mt-4 text-center">
            <a href="${pageContext.request.contextPath}/member/login" style="font-size: 0.85rem; color: #999;">이미 계정이 있으신가요? <span style="color:#111; font-weight:700; text-decoration:underline;">로그인</span></a>
        </div>
        
        <c:if test="${not empty message}">
             <div class="alert alert-danger mt-3 text-center p-2" style="font-size: 0.9rem;">${message}</div>
        </c:if>
    </form>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
window.addEventListener('DOMContentLoaded', ev => {
    const inputEL = document.querySelector('input[name=selectFile]');
    const avatarEL = document.querySelector('#profilePreview');
    const defaultIcon = document.querySelector('#defaultIcon');
    const maxSize = 800 * 1024;

    inputEL.addEventListener('change', ev => {
        let file = ev.target.files[0];
        if(!file) return;

        if(file.size > maxSize || !file.type.match('image.*')) {
            alert('800KB 이하의 이미지 파일만 등록 가능합니다.');
            inputEL.value = '';
            return;
        }

        var reader = new FileReader();
        reader.onload = function(e) {
            avatarEL.src = e.target.result;
            if(defaultIcon) defaultIcon.style.display = 'none';
        }
        reader.readAsDataURL(file);
    });
});

function toggleSelectColor(element) {
    if($(element).val() === "") {
        $(element).addClass("text-muted");
    } else {
        $(element).removeClass("text-muted");
    }
}

function toggleSubmitBtn() {
    const isChecked = document.getElementById('agree').checked;
    const btn = document.querySelector('button[name=sendButton]');
    btn.disabled = !isChecked;
}

$("#passwordCheck, #password").on("keyup", function() {
    const pw = $("#password").val();
    const pwConfirm = $("#passwordCheck").val();
    const feedback = $("#pwFeedback");
    
    if (pwConfirm === "") { 
        feedback.html(""); 
    } else if (pw === pwConfirm) { 
        feedback.html('<span class="msg-success"><i class="bi bi-check-circle-fill"></i> 비밀번호가 일치합니다.</span>'); 
    } else { 
        feedback.html('<span class="msg-error"><i class="bi bi-x-circle-fill"></i> 비밀번호가 일치하지 않습니다.</span>'); 
    }
});

function userIdCheck() {
    let member_id = $('#member_id').val();
    let wrapper = $('.id-check-box');
    let feedback = wrapper.find('.help-block');
    
    if(! /^[a-z][a-z0-9_]{4,9}$/i.test(member_id)) {
        let str = '<span class="msg-error"><i class="bi bi-exclamation-circle-fill"></i> 5~10자 영문 소문자/숫자만 가능합니다.</span>';
        $('#member_id').focus();
        feedback.html(str);
        return;
    }
    
    let url = '${pageContext.request.contextPath}/member/userIdCheck';
    let params = { member_id : member_id };
    
    $.ajax({
        type: 'post',
        url: url,
        data: params,
        dataType: 'json',
        success: function(data) {
            let passed = data.passed;
            if(passed === 'true') {
                let str = '<span class="msg-success"><i class="bi bi-check-circle-fill"></i> 멋진 아이디네요! 사용 가능합니다.</span>';
                feedback.html(str);
                $('#idValid').val('true'); 
            } else {
                let str = '<span class="msg-error"><i class="bi bi-x-circle-fill"></i> 이미 사용 중인 아이디입니다.</span>';
                feedback.html(str);
                $('#idValid').val('false');
                $('#member_id').val('').focus();
            }
        },
        error: function(e) { console.log(e.responseText); alert("서버 통신 오류"); }
    });
}

function memberOk() {
    const f = document.memberForm;
    let p;

    // 아이디 유효성
    p = /^[a-z][a-z0-9_]{4,9}$/i;
    if( !p.test(f.member_id.value) ) { 
        alert('아이디를 확인해주세요 (영문 소문자/숫자, 4~10자).');
        f.member_id.focus();
        return;
    }

    if( $('#idValid').val() === 'false' ) {
        alert('아이디 중복 검사를 진행해주세요.');
        $('.id-check-box').find('.help-block').html('<span class="msg-error">중복 확인이 필요합니다.</span>');
        f.member_id.focus();
        return;
    }

    // 이메일
    if( ! f.email.value.trim() ) { 
        alert('이메일을 입력하세요.'); 
        f.email.focus(); 
        return; 
    }

    // 비밀번호
    p =/^(?=.*[a-z])(?=.*[!@#$%^*+=-]|.*[0-9]).{5,10}$/i;
    if( ! p.test(f.password.value) ) { 
        alert('패스워드 형식을 맞춰주세요 (문자+숫자/특수문자, 5~10자).');
        f.password.focus();
        return;
    }

    if( f.password.value !== f.passwordCheck.value ) {
        alert('패스워드가 일치하지 않습니다.');
        f.passwordCheck.focus();
        return;
    }
    
    // 이름
    p = /^[가-힣]{2,5}$/;
    if( ! p.test(f.member_name.value) ) {
        alert('이름은 한글 2~5자로 입력해주세요.');
        f.member_name.focus();
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
    
    f.action = '${pageContext.request.contextPath}/member/signup';
    f.submit();
}
</script>
</body>
</html>