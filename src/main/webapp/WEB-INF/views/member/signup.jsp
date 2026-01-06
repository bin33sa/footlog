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
        .form-control, .form-select { border-radius: 10px; padding: 12px; border: 1px solid #eee; }
        .form-text { font-size: 0.8rem; margin-top: 5px; }
        
        .btn-black { background: #111; color: #fff; border-radius: 10px; width: 100%; padding: 12px; font-weight: bold; border: none; transition: 0.3s; }
        .btn-black:hover { background: #D4F63F; color: #111; }
        
        .brand-logo { font-family: 'Pretendard', sans-serif; font-size: 2rem; font-weight: 900; font-style: italic; text-align: center; margin-bottom: 20px; display: block; text-decoration: none; color: #000; }
        
        .input-group .btn { border-radius: 0 10px 10px 0; }
        .input-group .form-control { border-radius: 10px 0 0 10px; }

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

<div class="signup-card">
    <a href="${pageContext.request.contextPath}/main" class="brand-logo">Footlog</a>
    <h5 class="fw-bold mb-4 text-center">새로운 팀원을 기다립니다</h5>
    
    <form id="signupForm" action="${pageContext.request.contextPath}/member/signupDo" method="post" onsubmit="return validateForm()">
        
        <div class="mb-3">
            <label class="form-label small fw-bold">아이디</label>
            <div class="input-group">
                <input type="text" name="userId" id="userId" class="form-control" placeholder="4~12자 영문/숫자">
                <button type="button" class="btn btn-outline-dark btn-sm" onclick="checkDupId()">중복확인</button>
            </div>
            <div id="idFeedback" class="form-text"></div>
        </div>

        <div class="mb-3">
            <label class="form-label small fw-bold">이메일 주소</label>
            <div class="input-group">
                <input type="email" name="email" id="email" class="form-control" placeholder="example@footlog.com">
                <button type="button" class="btn btn-outline-dark btn-sm" onclick="checkDupEmail()">중복확인</button>
            </div>
            <div id="emailFeedback" class="form-text"></div>
        </div>

        <div class="mb-3">
            <label class="form-label small fw-bold">비밀번호</label>
            <input type="password" name="password" id="password" class="form-control" placeholder="8자 이상 조합">
        </div>
        <div class="mb-3">
            <input type="password" id="passwordConfirm" class="form-control" placeholder="비밀번호 확인">
            <div id="pwFeedback" class="form-text"></div>
        </div>

        <div class="row mb-3">
            <div class="col-6">
                <label class="form-label small fw-bold">이름</label>
                <input type="text" name="name" id="userName" class="form-control" placeholder="실명">
            </div>
            <div class="col-6">
                <label class="form-label small fw-bold">연락처</label>
                <input type="tel" name="phone" id="phone" class="form-control" placeholder="숫자만 입력">
            </div>
        </div>

        <div class="mb-3">
            <label class="form-label small fw-bold">거주지 주소</label>
            <input type="text" name="address" id="address" class="form-control mb-2" placeholder="시/구/동 입력">
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
            <label class="form-label small fw-bold">주 포지션</label>
            <div class="d-flex gap-2 w-100">
                <input type="radio" class="btn-check" name="position" id="pos_fw" value="FW" autocomplete="off">
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
                <input class="form-check-input" type="checkbox" id="agreeCheck">
                <label class="form-check-label text-muted" for="agreeCheck">
                    (필수) 이용약관 및 개인정보 처리방침에 동의합니다.
                </label>
            </div>
        </div>

        <!--<button type="submit" class="btn-black shadow-sm">가입하기</button> -->
        <div class="d-grid">
	        <a href="${pageContext.request.contextPath}/member/signupSuccess" class="btn btn-black shadow-sm text-decoration-none text-center">
	            가입하기
	        </a>
	    </div>
        
        <div class="mt-3 text-center">
            <a href="${pageContext.request.contextPath}/member/login" class="text-muted small text-decoration-none">이미 계정이 있으신가요? 로그인</a>
        </div>
    </form>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    // 중복 확인 상태 (테스트용이므로 무시됨)
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

    // 폼 제출 함수 (임시 테스트용)
    function validateForm() {
        // [임시] 복잡한 유효성 검사 모두 주석 처리
        /*
        const userId = $("#userId").val();
        const pw = $("#password").val();
        // ... (생략) ...
        
        if (!isIdChecked) { alert("아이디 중복확인을 해주세요."); return false; }
        if (pw.length < 8) { alert("비밀번호는 8자 이상이어야 합니다."); return false; }
        // ... (생략) ...
        */

        // [임시] 서버 전송(submit) 주석 처리
        // return true;
        
        // [임시] 바로 가입 완료 페이지(signup_success.jsp)로 화면만 이동
        // 주의: WEB-INF에 숨겨진 파일이 아니라, 컨트롤러를 거치거나 공개된 경로여야 함.
        // 여기서는 같은 폴더 내(혹은 컨트롤러 매핑) signup_success.jsp로 이동한다고 가정
        location.href = "signup_success.jsp"; 
        
        return false; // 폼이 실제로 전송되지 않게 막음
    }

    // (기능 유지: UI 테스트용)
    function checkDupId() {
        alert("사용 가능한 아이디입니다.");
        isIdChecked = true;
        $("#idFeedback").text("확인 완료").css("color", "blue");
    }

    function checkDupEmail() {
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