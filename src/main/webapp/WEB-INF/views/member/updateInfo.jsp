<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>회원정보 수정 - Footlog</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/style.css">
    
    <style>
        body { background-color: #f8f9fa; padding: 50px 0; }
        .update-card { width: 100%; max-width: 500px; padding: 40px; border-radius: 20px; background: #fff; box-shadow: 0 10px 30px rgba(0,0,0,0.05); margin: auto; }
        .form-control, .form-select { border-radius: 10px; padding: 12px; border: 1px solid #eee; }
        .form-text { font-size: 0.8rem; margin-top: 5px; }
        
        .btn-black { background: #111; color: #fff; border-radius: 10px; width: 100%; padding: 12px; font-weight: bold; border: none; transition: 0.3s; }
        .btn-black:hover { background: #D4F63F; color: #111; }
        
        .btn-cancel { background: #fff; color: #666; border: 1px solid #ddd; border-radius: 10px; width: 100%; padding: 12px; font-weight: bold; transition: 0.3s; }
        .btn-cancel:hover { background: #f1f1f1; color: #333; }

        .brand-logo { font-family: 'Pretendard', sans-serif; font-size: 2rem; font-weight: 900; font-style: italic; text-align: center; margin-bottom: 20px; display: block; text-decoration: none; color: #000; }
        
        /* 읽기 전용 필드 스타일 */
        .form-control[readonly] { background-color: #e9ecef; color: #6c757d; cursor: not-allowed; }

        .position-label { cursor: pointer; transition: all 0.2s; }
        .btn-check:checked + .btn-outline-dark {
            background-color: #111;
            color: #D4F63F;
            border-color: #111;
            font-weight: 800;
        }
    </style>
</head>
<body>

<%-- <jsp:include page="/WEB-INF/views/include/header.jsp" /> --%>

<div class="update-card">
    <a href="${pageContext.request.contextPath}/main" class="brand-logo">Footlog</a>
    <h5 class="fw-bold mb-4 text-center">회원정보 수정</h5>
    
    <form id="updateForm" action="${pageContext.request.contextPath}/member/updateDo" method="post" onsubmit="return handleUpdate(event)">
        
        <div class="mb-3">
            <label class="form-label small fw-bold">아이디</label>
            <input type="text" name="userId" id="userId" class="form-control" value="${sessionScope.member.userId}" readonly>
            <div class="form-text text-muted">아이디는 변경할 수 없습니다.</div>
        </div>

        <div class="mb-3">
            <label class="form-label small fw-bold">이메일 주소</label>
            <input type="email" name="email" id="email" class="form-control" value="${sessionScope.member.email}" placeholder="example@footlog.com">
        </div>

        <div class="mb-3">
            <label class="form-label small fw-bold">새 비밀번호</label>
            <input type="password" name="password" id="password" class="form-control" placeholder="변경할 경우에만 입력하세요">
        </div>
        <div class="mb-3">
            <input type="password" id="passwordConfirm" class="form-control" placeholder="새 비밀번호 확인">
            <div id="pwFeedback" class="form-text"></div>
        </div>

        <div class="row mb-3">
            <div class="col-6">
                <label class="form-label small fw-bold">이름</label>
                <input type="text" name="name" id="userName" class="form-control" value="${sessionScope.member.name}">
            </div>
            <div class="col-6">
                <label class="form-label small fw-bold">연락처</label>
                <input type="tel" name="phone" id="phone" class="form-control" value="${sessionScope.member.phone}">
            </div>
        </div>

        <div class="mb-3">
            <label class="form-label small fw-bold">거주지 주소</label>
            <input type="text" name="address" id="address" class="form-control mb-2" value="${sessionScope.member.address}">
            <input type="text" name="addressDetail" id="addressDetail" class="form-control" value="${sessionScope.member.addressDetail}" placeholder="상세 주소">
        </div>

        <div class="mb-3">
            <label class="form-label small fw-bold">주 활동 지역</label>
            <select name="activityArea" id="activityArea" class="form-select">
                <option value="SEOUL" ${sessionScope.member.activityArea == 'SEOUL' ? 'selected' : ''}>서울</option>
                <option value="GYEONGGI" ${sessionScope.member.activityArea == 'GYEONGGI' ? 'selected' : ''}>경기</option>
                <option value="INCHEON" ${sessionScope.member.activityArea == 'INCHEON' ? 'selected' : ''}>인천</option>
                <option value="GANGWON" ${sessionScope.member.activityArea == 'GANGWON' ? 'selected' : ''}>강원</option>
                <option value="CHUNGCHEONG" ${sessionScope.member.activityArea == 'CHUNGCHEONG' ? 'selected' : ''}>충청</option>
                <option value="JEOLLA" ${sessionScope.member.activityArea == 'JEOLLA' ? 'selected' : ''}>전라</option>
                <option value="GYEONGSANG" ${sessionScope.member.activityArea == 'GYEONGSANG' ? 'selected' : ''}>경상</option>
                <option value="JEJU" ${sessionScope.member.activityArea == 'JEJU' ? 'selected' : ''}>제주</option>
            </select>
        </div>

        <div class="mb-4">
            <label class="form-label small fw-bold">주 포지션</label>
            <div class="d-flex gap-2 w-100">
                <input type="radio" class="btn-check" name="position" id="pos_fw" value="FW" ${sessionScope.member.position == 'FW' ? 'checked' : ''}>
                <label class="btn btn-outline-dark flex-fill py-3" for="pos_fw">
                    <span class="d-block fs-5 fw-bold">FW</span>
                    <span class="d-block small text-muted" style="font-size: 0.7rem;">공격수</span>
                </label>

                <input type="radio" class="btn-check" name="position" id="pos_mf" value="MF" ${sessionScope.member.position == 'MF' ? 'checked' : ''}>
                <label class="btn btn-outline-dark flex-fill py-3" for="pos_mf">
                    <span class="d-block fs-5 fw-bold">MF</span>
                    <span class="d-block small text-muted" style="font-size: 0.7rem;">미드필더</span>
                </label>

                <input type="radio" class="btn-check" name="position" id="pos_df" value="DF" ${sessionScope.member.position == 'DF' ? 'checked' : ''}>
                <label class="btn btn-outline-dark flex-fill py-3" for="pos_df">
                    <span class="d-block fs-5 fw-bold">DF</span>
                    <span class="d-block small text-muted" style="font-size: 0.7rem;">수비수</span>
                </label>

                <input type="radio" class="btn-check" name="position" id="pos_gk" value="GK" ${sessionScope.member.position == 'GK' ? 'checked' : ''}>
                <label class="btn btn-outline-dark flex-fill py-3" for="pos_gk">
                    <span class="d-block fs-5 fw-bold">GK</span>
                    <span class="d-block small text-muted" style="font-size: 0.7rem;">골키퍼</span>
                </label>
            </div>
        </div>

        <div class="row g-2">
            <div class="col-6">
                <a href="${pageContext.request.contextPath}/member/mypage" class="btn btn-cancel text-decoration-none text-center d-block">취소</a>
            </div>
            <div class="col-6">
                <button type="submit" class="btn btn-black shadow-sm">수정 완료</button>
            </div>
        </div>
        
    </form>
</div>

<%-- <jsp:include page="/WEB-INF/views/include/footer.jsp" /> --%>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    // 비밀번호 확인 로직 (기존과 동일)
    $("#passwordConfirm, #password").on("keyup", function() {
        const pw = $("#password").val();
        const pwConfirm = $("#passwordConfirm").val();
        
        if (pw === "" && pwConfirm === "") {
             $("#pwFeedback").text(""); 
        } else if (pwConfirm === "") {
             $("#pwFeedback").text(""); 
        } else if (pw === pwConfirm) { 
            $("#pwFeedback").text("비밀번호가 일치합니다.").css("color", "green"); 
        } else { 
            $("#pwFeedback").text("비밀번호가 일치하지 않습니다.").css("color", "red"); 
        }
    });

    // 수정 완료 버튼 클릭 시 처리 함수
    function handleUpdate(e) {
        // 1. 폼의 기본 제출 동작(페이지 리로드/이동)을 막습니다. (테스트용)
        // 실제 서버 통신을 하려면 AJAX를 쓰거나, 아래 return true로 바꿔야 합니다.
        e.preventDefault(); 

        // [유효성 검사 예시]
        const pw = $("#password").val();
        const pwConfirm = $("#passwordConfirm").val();
        if(pw !== "" && pw !== pwConfirm) {
            alert("새 비밀번호가 일치하지 않습니다.");
            return false;
        }

        // 2. 서버로 데이터를 전송했다고 가정하고 성공 처리를 합니다.
        // 실제 프로젝트에서는 여기서 $.ajax() 등을 호출하여 DB 업데이트를 수행합니다.
        
        // --- 시나리오: 수정 성공 ---
        alert("회원정보가 성공적으로 수정되었습니다.");
        
        // 3. 마이페이지로 이동
        location.href = "${pageContext.request.contextPath}/member/mypage";
        
        return false; // 폼 제출 중단
    }
</script>
</body>
</html>l>