<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>정보 찾기 - Footlog</title>
    <meta charset="utf-8">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/style.css">
    <style>
        body { background-color: #f8f9fa; height: 100vh; display: flex; align-items: center; justify-content: center; }
        .find-card { width: 100%; max-width: 450px; padding: 40px; border-radius: 20px; background: #fff; box-shadow: 0 10px 30px rgba(0,0,0,0.05); }
        .nav-pills .nav-link { color: #666; border-radius: 10px; font-weight: bold; }
        .nav-pills .nav-link.active { background-color: #000; color: #fff; }
        .form-control { border-radius: 10px; padding: 12px; margin-bottom: 15px; }
        .btn-black { background: #000; color: #fff; border-radius: 10px; width: 100%; padding: 12px; font-weight: bold; border: none; }
        .brand-logo { font-size: 2rem; font-weight: bold; text-align: center; margin-bottom: 20px; display: block; text-decoration: none; color: #000; }
    </style>
</head>
<body>

<div class="find-card">
    <a href="${pageContext.request.contextPath}/main" class="brand-logo">Footlog</a>
    
    <ul class="nav nav-pills nav-fill mb-4" id="pills-tab" role="tablist">
        <li class="nav-item">
            <button class="nav-link active" id="id-tab" data-bs-toggle="pill" data-bs-target="#find-id">아이디 찾기</button>
        </li>
        <li class="nav-item">
            <button class="nav-link" id="pw-tab" data-bs-toggle="pill" data-bs-target="#find-pw">비밀번호 찾기</button>
        </li>
    </ul>

    <div class="tab-content">
        <div class="tab-pane fade show active" id="find-id">
            <p class="small text-muted mb-4 text-center">가입 시 등록한 이름과 이메일을 입력하세요.</p>
            <form action="${pageContext.request.contextPath}/findIdDo" method="post">
                <input type="text" name="name" class="form-control" placeholder="이름" required>
                <input type="email" name="email" class="form-control" placeholder="가입한 이메일 주소" required>
                <button type="submit" class="btn-black mt-3">아이디 찾기</button>
            </form>
        </div>

        <div class="tab-pane fade" id="find-pw">
        <p class="small text-muted mb-4 text-center">아이디와 이메일을 입력하시면 임시 비밀번호를 전송해 드립니다.</p>
        <form action="${pageContext.request.contextPath}/findPwDo" method="post">
            <input type="text" name="userId" class="form-control" placeholder="로그인 아이디" required>
            <input type="email" name="email" class="form-control" placeholder="가입한 이메일 주소" required>
            <button type="submit" class="btn-black mt-3">임시 비밀번호 발송</button>
        </form>
   		</div>
	</div>

    <div class="mt-4 text-center">
        <a href="${pageContext.request.contextPath}/login" class="text-muted small text-decoration-none">로그인 화면으로 돌아가기</a>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>