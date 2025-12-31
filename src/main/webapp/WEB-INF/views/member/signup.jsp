<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>회원가입 - Footlog</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/style.css">
    
    <style>
        body { background-color: #f8f9fa; padding: 50px 0; }
        .signup-card { width: 100%; max-width: 500px; padding: 40px; border-radius: 20px; background: #fff; box-shadow: 0 10px 30px rgba(0,0,0,0.05); margin: auto; }
        .form-control, .form-select { border-radius: 10px; padding: 12px; border: 1px solid #eee; } /* Select 스타일 추가 */
        .form-text { font-size: 0.8rem; margin-top: 5px; }
        
        /* Gen.G 스타일 버튼 (Black & Neon Lime Hover) */
        .btn-black { background: #111; color: #fff; border-radius: 10px; width: 100%; padding: 12px; font-weight: bold; border: none; transition: 0.3s; }
        .btn-black:hover { background: #D4F63F; color: #111; } /* 네온 라임 호버 효과 적용 */
        
        .brand-logo { font-family: 'Pretendard', sans-serif; font-size: 2rem; font-weight: 900; font-style: italic; text-align: center; margin-bottom: 20px; display: block; text-decoration: none; color: #000; }
        
        .input-group .btn { border-radius: 0 10px 10px 0; }
        .input-group .form-control { border-radius: 10px 0 0 10px; }

        /* 포지션 선택 버튼 커스텀 스타일 */
        .position-label { cursor: pointer; transition: all 0.2s; }
        .btn-check:checked + .btn-outline-dark {
            background-color: #111;
            color: #D4F63F; /* 선택 시 네온 컬러 텍스트 */
            border-color: #111;
            font-weight: 800;
        }
    </style>
</head>
<body>

<div class="signup-card">
    <a href="${pageContext.request.contextPath}/main" class="brand-logo">Footlog</a>
    <h5 class="fw-bold mb-4 text-center">새로운 팀원을 기다립니다</h5>
    
    <form id="signupForm" action="${pageContext.request.contextPath}/signupDo" method="post" onsubmit="return validateForm()">
        
        <div class="mb-3">
            <label class="form-label small fw-bold">아이디</label>
            <div class="input-group">
                <input type="text" name="userId" id="userId" class="form-control" placeholder="4~12자 영문/숫자" required>
                <button type="button" class="btn btn-outline-dark btn-sm" onclick="checkDupId()">중복확인</button>
            </div>
            <div id="idFeedback" class="form-text"></div>
        </div>

        <div class="mb-3">
            <label class="form-label small fw-bold">이메일 주소</label>
            <div class="input-group">
                <input type="email" name="email" id="email" class="form-control" placeholder="example@footlog.com" required>
                <button type="button" class="btn btn-outline-dark btn-sm" onclick="checkDupEmail()">중복확인</button>
            </div>
            <div id="emailFeedback" class="form-text"></div>
        </div>

        <div class="mb-3">
            <label class="form-label small fw-bold">비밀번호</label>
            <input type="password" name="password" id="password" class="form-control" placeholder="8자 이상 조합" required>
        </div>
        <div class="mb-3">
            <input type="password" id="passwordConfirm" class="form-control" placeholder="비밀번호 확인" required>
            <div id="pwFeedback" class="form-text"></div>
        </div>

        <div class="row mb-3">
            <div class="col-6">
                <label class="form-label small fw-bold">이름</label>
                <input type="text" name="name" id="userName" class="form-control" placeholder="실명" required>
            </div>
            <div class="col-6">
                <label class="form-label small fw-bold">연락처</label>
                <input type="tel" name="phone" id="phone" class="form-control" placeholder="숫자만 입력" required>
            </div>
        </div>

        <div class="mb-3">
            <label class="form-label small fw-bold">거주지 주소</label>
            <input type="text" name="address" id="address" class="form-control mb-2" placeholder="시/구/동 입력 (예: 서울시 마포구 상암동)" required>
            <input type="text" name="addressDetail" id="addressDetail" class="form-control" placeholder="상세 주소 (선택)">
        </div>

        <div class="mb-3">
            <label class="form-label small fw-bold">주 활동 지역 <span class="text-muted fw-normal" style="font-size: 0.8em;">(선택)</span></label>
            <select name="activityArea" id="activityArea" class="form-select text-muted">
                <option value="" selected>활동 지역을 선택하세요</option>
                <option value="SEOUL">서울</option>
                <option value="GYEONGGI">경기</option>
                <option value="INCHEON">인천</option>
                <option value="GANGWON">강원</option>
                <option value="CHUNGCHEONG">충청</option>
                <option value="JEOLLA">전라</option>
                <option value="GYEONGSANG">경상</option>
                <option value="JEJU">제주</option>
            </select>
        </div>

        <div class="mb-4">
            <label class="form-label small fw-bold">주 포지션 <span class="text-danger">*</span></label>
            <div class="d-flex gap-2 w-100">
                <input type="radio" class="btn-check" name="position" id="pos_fw" value="FW" autocomplete="off" required>
                <label class="btn btn-outline-dark flex-fill py-3" for="pos_fw">
                    <span class="d-block fs-5 fw-bold">FW</span>
                    <span class="d-block small text-muted" style="font-size: 0.7rem;">공격수</span>
                </label>

                <input type="radio" class="btn-check" name="position" id="pos_mf" value="MF" autocomplete="off">
                <label class="btn btn-outline-dark flex-fill py-3" for="pos_mf">
                    <span class="d-block fs-5 fw-bold">MF</span>
                    <span class="d-block small text-muted" style="font-size: 0.7rem;">미드필더</span>
                </label>

                <input type="radio" class="btn-check" name="position" id="pos_df" value="DF" autocomplete="off">
                <label class="btn btn-outline-dark flex-fill py-3" for="pos_df">
                    <span class="d-block fs-5 fw-bold">DF</span>
                    <span class="d-block small text-muted" style="font-size: 0.7rem;">수비수</span>
                </label>

                <input type="radio" class="btn-check" name="position" id="pos_gk" value="GK" autocomplete="off">
                <label class="btn btn-outline-dark flex-fill py-3" for="pos_gk">
                    <span class="d-block fs-5 fw-bold">GK</span>
                    <span class="d-block small text-muted" style="font-size: 0.7rem;">골키퍼</span>
                </label>
            </div>
        </div>

        <div class="mb-4 p-3 bg-light rounded shadow-sm">
            <div class="form-check small">
                <input class="form-check-input" type="checkbox" id="agreeCheck" required>
                <label class="form-check-label text-muted" for="agreeCheck">
                    (필수) 이용약관 및 개인정보 처리방침에 동의합니다.
                </label>
            </div>
        </div>

        <button type="submit" class="btn-black shadow-sm">가입하기</button>
        
        <div class="mt-3 text-center">
            <a href="${pageContext.request.contextPath}/login" class="text-muted small text-decoration-none">이미 계정이 있으신가요? 로그인</a>
        </div>
    </form>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    // 중복 확인 상태
    let isIdChecked = false;
    let isEmailChecked = false;

    // 활동 지역 선택 시 텍스트 색상 변경 (UX)
    $("#activityArea").on("change", function(){
        if($(this).val() === "") {
            $(this).addClass("text-muted");
        } else {
            $(this).removeClass("text-muted");
        }
    });

    // 폼 제출 유효성 검사
    function validateForm() {
        const userId = $("#userId").val();
        const pw = $("#password").val();
        const pwConfirm = $("#passwordConfirm").val();
        const phone = $("#phone").val();
        const address = $("#address").val();
        // 포지션 체크 여부 확인
        const position = $("input[name='position']:checked").val();

        // 1. 기본 검사
        if (!isIdChecked) { alert("아이디 중복확인을 해주세요."); return false; }
        if (!isEmailChecked) { alert("이메일 중복확인을 해주세요."); return false; }
        if (pw !== pwConfirm) { alert("비밀번호가 일치하지 않습니다."); return false; }
        if (pw.length < 8) { alert("비밀번호는 8자 이상이어야 합니다."); return false; }

        // 2. 추가된 필드 검사
        if (!address) {
            alert("거주지 주소를 입력해주세요.");
            $("#address").focus();
            return false;
        }

        if (!position) {
            alert("주 포지션을 선택해주세요.");
            return false;
        }

        return true;
    }

    // (기존 스크립트 기능 유지: 중복확인 및 PW체크)
    function checkDupId() {
        const userId = $("#userId").val();
        if(!userId) { alert("아이디를 입력해주세요."); return; }
        // Ajax 자리
        alert("사용 가능한 아이디입니다.");
        isIdChecked = true;
        $("#idFeedback").text("확인 완료").css("color", "blue");
    }

    function checkDupEmail() {
        const email = $("#email").val();
        if(!email) { alert("이메일을 입력해주세요."); return; }
        // Ajax 자리
        alert("사용 가능한 이메일입니다.");
        isEmailChecked = true;
        $("#emailFeedback").text("확인 완료").css("color", "blue");
    }

    $("#passwordConfirm, #password").on("keyup", function() {
        const pw = $("#password").val();
        const pwConfirm = $("#passwordConfirm").val();
        if (pwConfirm === "") { $("#pwFeedback").text(""); }
        else if (pw === pwConfirm) { $("#pwFeedback").text("일치합니다.").css("color", "green"); }
        else { $("#pwFeedback").text("일치하지 않습니다.").css("color", "red"); }
    });
</script>
</body>
</html>