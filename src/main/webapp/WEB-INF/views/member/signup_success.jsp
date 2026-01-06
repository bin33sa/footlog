<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>가입 완료 - Footlog</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" as="style" crossorigin href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.8/dist/web/static/pretendard.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/style.css">
    
    <style>
        /* 1. 배경 및 중앙 정렬 (login.jsp 스타일 참고) */
        body { 
            background-color: #f8f9fa;
            min-height: 100vh; 
            display: flex;
            align-items: center; 
            justify-content: center; 
            font-family: 'Pretendard', sans-serif;
        }

        /* 2. 카드 박스 스타일 */
        .success-card { 
            width: 100%;
            max-width: 400px; 
            padding: 50px 30px; 
            border-radius: 20px; 
            background: #fff; 
            box-shadow: 0 10px 30px rgba(0,0,0,0.05);
            text-align: center;
        }

        /* 3. 브랜드 로고 */
        .brand-logo { 
            font-family: 'Pretendard', sans-serif;
            font-size: 2rem; 
            font-weight: 900; 
            font-style: italic; 
            margin-bottom: 30px; 
            display: block; 
            text-decoration: none; 
            color: #000;
        }

        /* 4. 완료 아이콘 애니메이션 */
        .check-icon-circle {
            width: 80px;
            height: 80px;
            background-color: #111;
            color: #D4F63F; /* 네온 라임 */
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 25px;
            font-size: 40px;
            animation: popIn 0.5s cubic-bezier(0.175, 0.885, 0.32, 1.275);
        }

        @keyframes popIn {
            0% { transform: scale(0); opacity: 0; }
            100% { transform: scale(1); opacity: 1; }
        }

        /* 5. 버튼 스타일 (signup.jsp의 btn-black 재사용) */
        .btn-black { 
            background: #111;
            color: #fff; 
            border-radius: 10px; 
            width: 100%; 
            padding: 12px; 
            font-weight: bold; 
            border: none; 
            transition: 0.3s;
            text-decoration: none;
            display: block;
        }
        .btn-black:hover { 
            background: #D4F63F;
            color: #111; 
        }

        .btn-outline {
            background: #fff;
            color: #666;
            border: 1px solid #ddd;
            border-radius: 10px;
            width: 100%;
            padding: 12px;
            font-weight: 600;
            text-decoration: none;
            display: block;
            transition: 0.2s;
        }
        .btn-outline:hover {
            background: #f1f1f1;
            color: #333;
        }
    </style>
</head>
<body>

    <div class="success-card">
        <a href="${pageContext.request.contextPath}/main" class="brand-logo">Footlog</a>
        
        <div class="check-icon-circle">
            <svg xmlns="http://www.w3.org/2000/svg" width="40" height="40" fill="currentColor" class="bi bi-check-lg" viewBox="0 0 16 16">
                <path d="M12.736 3.97a.733.733 0 0 1 1.047 0c.286.289.29.756.01 1.05L7.88 12.01a.733.733 0 0 1-1.065.02L3.217 8.384a.757.757 0 0 1 0-1.06.733.733 0 0 1 1.047 0l3.052 3.093 5.4-6.425a.247.247 0 0 1 .02-.022Z"/>
            </svg>
        </div>

        <h4 class="fw-bold mb-3">회원가입 완료!</h4>
        <p class="text-muted mb-4 small">
            풋로그의 회원이 되신 것을 환영합니다.<br>
            이제 구단을 찾고 매치를 시작해보세요.
        </p>

        <div class="d-grid gap-2">
            <a href="${pageContext.request.contextPath}/member/login" class="btn-black">
                로그인하러 가기
            </a>
            
            <a href="${pageContext.request.contextPath}/main" class="btn-outline">
                메인으로 이동
            </a>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>