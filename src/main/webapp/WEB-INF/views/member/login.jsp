<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>로그인 - Footlog</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/style.css">
    
    <style>
        body {
            background-color: #f8f9fa;
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .login-card {
            width: 100%;
            max-width: 400px;
            padding: 40px;
            border-radius: 20px;
            background: #fff;
            box-shadow: 0 10px 30px rgba(0,0,0,0.05);
        }
        .form-control {
            border-radius: 10px;
            padding: 12px;
            border: 1px solid #eee;
        }
        .form-control:focus {
            box-shadow: none;
            border-color: #000;
        }
        .btn-login {
            background-color: #000;
            color: #fff;
            border-radius: 10px;
            padding: 12px;
            font-weight: bold;
            width: 100%;
            margin-top: 10px;
        }
        .btn-login:hover {
            background-color: #333;
            color: #fff;
        }
        .brand-logo {
            font-size: 2rem;
            font-weight: bold;
            text-align: center;
            margin-bottom: 30px;
            display: block;
            text-decoration: none;
            color: #000;
        }
    </style>
</head>
<body>

    <div class="login-card">
        <a href="${pageContext.request.contextPath}/" class="brand-logo">Footlog</a>
        
        <h5 class="fw-bold mb-4 text-center">로그인을 환영합니다</h5>
        
        <form name="loginForm" action="${pageContext.request.contextPath}/member/login" method="post">
            <div class="mb-3">
                <label class="form-label small text-muted">아이디</label>
                <input type="text" name="userId" class="form-control" placeholder="아이디를 입력하세요" required>
            </div>
            
            <div class="mb-4">
                <label class="form-label small text-muted">비밀번호</label>
                <input type="password" name="userPwd" class="form-control" placeholder="비밀번호를 입력하세요" required>
            </div>
            
            <c:if test="${not empty message}">
                <div class="alert alert-danger p-2 small text-center">
                    ${message}
                </div>
            </c:if>
            
            <div class="mb-4 d-flex justify-content-end gap-2">
                <a href="${pageContext.request.contextPath}/member/findId" class="text-decoration-none small text-muted">아이디 찾기</a>
                <span class="text-muted small">|</span>
                <a href="${pageContext.request.contextPath}/member/findPwd" class="text-decoration-none small text-muted">비밀번호 찾기</a>
            </div>
            
            <button type="button" class="btn btn-login shadow-sm" onclick="sendLogin();">로그인</button>
            
            <div class="mt-4 text-center">
                <p class="small text-muted">계정이 없으신가요? <a href="${pageContext.request.contextPath}/member/signup" class="text-dark fw-bold">회원가입</a></p>
            </div>
        </form>
    </div>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script type="text/javascript">
    function sendLogin() {
        const f = document.loginForm;
        
        if( ! f.userId.value.trim() ) {
            alert("아이디를 입력해주세요."); 
            f.userId.focus();
            return;
        }

        if( ! f.userPwd.value.trim() ) {
            alert("비밀번호를 입력해주세요.");
            f.userPwd.focus();
            return;
        }

        f.submit();
    }
    
    document.addEventListener("keydown", function(event) {
        if (event.key === "Enter") {
            sendLogin();
        }
    });
    </script>
</body>
</html>