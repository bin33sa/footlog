<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <title>로그인 - Footlog</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" as="style" crossorigin href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.8/dist/web/static/pretendard.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/style.css">
    
    <style>
        /* 로그인 페이지 전용 스타일 */
        body {
            /* 헤더와 푸터가 있으므로 body에 flex를 주지 않습니다. */
            background-color: #f8f9fa;
        }

        /* 헤더/푸터 사이에서 로그인 박스를 중앙 정렬하기 위한 래퍼 */
        .login-wrapper {
            width: 100%;
            /* 화면 높이(100vh)에서 헤더(약 80px)+푸터(약 300px) 높이를 뺀 만큼 최소 높이 확보 */
            min-height: calc(100vh - 380px); 
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 60px 0;
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
            color: #212529;
            background-color: #fff;
            border-color: #86b7fe;
            outline: 0;
            box-shadow: 0 0 0 .25rem rgba(13, 110, 253, .25);
        }

        .btn-black {
            background: #111;
            color: #fff;
            border-radius: 10px;
            width: 100%;
            padding: 12px;
            font-weight: bold;
            border: none;
            transition: 0.3s;
        }
        
        .btn-black:hover {
            background: #D4F63F;
            color: #111;
        }

        .brand-logo {
            font-family: 'Pretendard', sans-serif;
            font-size: 2rem;
            font-weight: 900;
            font-style: italic;
            text-align: center;
            margin-bottom: 20px;
            display: block;
            text-decoration: none;
            color: #000;
        }
    </style>
</head>
<body>

    <jsp:include page="/WEB-INF/views/layout/header.jsp" />

    <div class="login-wrapper">
        <div class="login-card">
            <a href="${pageContext.request.contextPath}/main" class="brand-logo">Footlog</a>
            
            <h5 class="fw-bold mb-4 text-center">로그인을 환영합니다</h5>
            
            <form name="loginForm" action="${pageContext.request.contextPath}/member/login" method="post" onsubmit="return sendLogin();">
                
                <div class="mb-3">
                    <label class="form-label small fw-bold text-secondary">아이디</label>
                    <input type="text" name="userId" id="userId" class="form-control" placeholder="아이디를 입력하세요" required>
                </div>
                
                <div class="mb-4">
                    <label class="form-label small fw-bold text-secondary">비밀번호</label>
                    <input type="password" name="userPwd" id="userPwd" class="form-control" placeholder="비밀번호를 입력하세요" required>
                </div>
                
                <c:if test="${not empty message}">
                    <div class="alert alert-danger p-2 small text-center mb-3">
                        ${message}
                    </div>
                </c:if>
                
                <div class="mb-4 d-flex justify-content-end gap-2">
                    <a href="${pageContext.request.contextPath}/member/findInfo" class="text-decoration-none small text-muted">아이디 찾기</a>
                    <span class="text-muted small">|</span>
                    <a href="${pageContext.request.contextPath}/member/findInfo" class="text-decoration-none small text-muted">비밀번호 찾기</a>
                </div>
                
                <button type="submit" class="btn-black shadow-sm">로그인</button>
                
                <div class="mt-4 text-center">
                    <p class="small text-muted">계정이 없으신가요? <a href="${pageContext.request.contextPath}/member/signup" class="text-dark fw-bold text-decoration-underline">회원가입</a></p>
                </div>
            </form>
        </div>
    </div>

    <jsp:include page="/WEB-INF/views/layout/footer.jsp" />

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    
    <script type="text/javascript">
    function sendLogin() {
        const userId = document.getElementById("userId");
        const userPwd = document.getElementById("userPwd");
        
        if( ! userId.value.trim() ) {
            alert("아이디를 입력해주세요."); 
            userId.focus();
            return false;
        }

        if( ! userPwd.value.trim() ) {
            alert("비밀번호를 입력해주세요.");
            userPwd.focus();
            return false;
        }

        return true;
    }
    
    // 서버 메시지 alert 띄우기 (옵션)
    <c:if test="${not empty message}">
        alert("${message}");
    </c:if>
    </script>
</body>
</html>