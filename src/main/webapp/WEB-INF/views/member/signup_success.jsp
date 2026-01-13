<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>가입 완료 - Footlog</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" as="style" crossorigin href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.8/dist/web/static/pretendard.css" />
    
    <style>
        body { 
            background-color: #f8f9fa;
            min-height: 100vh; 
            display: flex;
            align-items: center; 
            justify-content: center; 
            font-family: 'Pretendard', sans-serif;
        }

        .success-card { 
            width: 100%;
            max-width: 420px; 
            padding: 60px 40px; 
            border-radius: 24px; 
            background: #fff; 
            box-shadow: 0 20px 40px rgba(0,0,0,0.06);
            text-align: center;
            border: 1px solid rgba(0,0,0,0.03);
        }

        .brand-logo { 
            font-size: 1.8rem; 
            font-weight: 900; 
            font-style: italic; 
            margin-bottom: 40px; 
            display: block; 
            text-decoration: none; 
            color: #111;
            letter-spacing: -1px;
        }

        /* 체크 아이콘 */
        .check-icon-circle {
            width: 70px;
            height: 70px;
            background-color: #111;
            color: #D4F63F; 
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 30px;
            box-shadow: 0 10px 20px rgba(0,0,0,0.15);
            animation: popIn 0.6s cubic-bezier(0.34, 1.56, 0.64, 1);
        }

        @keyframes popIn {
            0% { transform: scale(0.5); opacity: 0; }
            100% { transform: scale(1); opacity: 1; }
        }

        /* 메인 메시지 (크고 진하게) */
        .success-msg {
            font-size: 1.4rem;
            font-weight: 700;
            color: #222;
            margin-bottom: 15px;
            line-height: 1.4;
        }
        
        /* 이름 강조 스타일 */
        .success-msg b {
            color: #000;
            font-weight: 800;
            border-bottom: 3px solid #D4F63F; 
        }

        /* 서브 메시지 (작고 흐리게) */
        .sub-msg {
            color: #6c757d;
            font-size: 0.95rem;
            margin-bottom: 40px;
            line-height: 1.6;
        }

        /* 버튼 */
        .btn-black { 
            background: #111; color: #fff; 
            border-radius: 12px; width: 100%; padding: 16px; 
            font-weight: 700; border: none; transition: all 0.2s;
            text-decoration: none; display: block; margin-bottom: 10px;
        }
        .btn-black:hover { background: #000; color: #fff; transform: translateY(-2px); box-shadow: 0 5px 15px rgba(0,0,0,0.1); }

        .btn-outline {
            background: #fff; color: #555; 
            border: 1px solid #e1e1e1; border-radius: 12px; 
            width: 100%; padding: 16px; font-weight: 600; 
            text-decoration: none; display: block; transition: all 0.2s;
        }
        .btn-outline:hover { background: #f8f9fa; color: #111; border-color: #ccc; }
    </style>
</head>
<body>

    <div class="success-card">
        <a href="${pageContext.request.contextPath}/main" class="brand-logo">Footlog</a>
        
        <div class="check-icon-circle">
            <svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" fill="currentColor" class="bi bi-check-lg" viewBox="0 0 16 16">
                <path d="M12.736 3.97a.733.733 0 0 1 1.047 0c.286.289.29.756.01 1.05L7.88 12.01a.733.733 0 0 1-1.065.02L3.217 8.384a.757.757 0 0 1 0-1.06.733.733 0 0 1 1.047 0l3.052 3.093 5.4-6.425a.247.247 0 0 1 .02-.022Z"/>
            </svg>
        </div>

        <div class="success-msg">
            <c:out value="${message}" escapeXml="false" />
        </div>
        
        <p class="sub-msg">
            풋로그의 멤버가 되신 것을 환영합니다.<br>
            지금 바로 로그인해서 팀을 찾아보세요!
        </p>

        <div class="d-grid">
            <a href="${pageContext.request.contextPath}/member/login" class="btn-black">
                로그인하러 가기
            </a>
            
            <a href="${pageContext.request.contextPath}/main" class="btn-outline">
                메인으로 이동
            </a>
        </div>
    </div>

</body>
</html>