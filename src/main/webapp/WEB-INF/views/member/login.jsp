<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <title>로그인 - Footlog</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<jsp:include page="/WEB-INF/views/layout/headerResources.jsp"/>    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" crossorigin href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.8/dist/web/static/pretendard.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/style.css">
    
    <style>
        /* 1. 배경 및 레이아웃 */
        body { 
            background-color: #f8f9fa; 
            min-height: 100vh; /* 화면 중앙 정렬 */
            display: flex; 
            align-items: center; 
            justify-content: center; 
        }

        /* 2. 카드 박스 */
        .login-card { 
            width: 100%; 
            max-width: 400px; 
            padding: 40px; 
            border-radius: 20px; 
            background: #fff; 
            box-shadow: 0 10px 30px rgba(0,0,0,0.05); 
        }

        /* 3. 입력창 스타일 & 클릭 효과  */
        .form-control { 
            border-radius: 10px; 
            padding: 12px; 
            border: 1px solid #eee; 
        }
        
       
        .form-control:focus {
            color: #212529;
            background-color: #fff;
            border-color: #86b7fe; /* 파란색 테두리 */
            outline: 0;
            box-shadow: 0 0 0 .25rem rgba(13, 110, 253, .25); /* 파란색 빛 번짐 */
        }

        /* 4. 버튼 스타일  */
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
        /* 마우스 올렸을 때 네온 라임색 효과 */
        .btn-black:hover { 
            background: #D4F63F; 
            color: #111; 
        }

        /* 5. 로고 스타일  */
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
<header>
	<jsp:include page="/WEB-INF/views/layout/header.jsp"/>
</header>

<main>
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
</main>

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
    
<footer>
	<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
</footer>
    
<jsp:include page="/WEB-INF/views/layout/footerResources.jsp"/>    
    
</body>
</html>