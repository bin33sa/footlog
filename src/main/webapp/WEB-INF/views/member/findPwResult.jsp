<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>비밀번호 찾기 결과 - Footlog</title>
    <meta charset="utf-8">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/style.css">
    <style>
        body { background-color: #f8f9fa; height: 100vh; display: flex; align-items: center; justify-content: center; }
        .find-card { width: 100%; max-width: 450px; padding: 40px; border-radius: 20px; background: #fff; box-shadow: 0 10px 30px rgba(0,0,0,0.05); text-align: center; }
        .btn-black { background: #000; color: #fff; border-radius: 10px; width: 100%; padding: 12px; font-weight: bold; border: none; }
       	.btn-black:hover { background: #D4F63F; color: #111; }
        .icon-box { font-size: 4rem; margin-bottom: 20px; }
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
    </style>
</head>
<body>

<div class="find-card">
    <a href="${pageContext.request.contextPath}/main" class="brand-logo">Footlog</a>

    <div class="icon-box">
        <c:choose>
            <c:when test="${isSuccess}">
                <i class="bi bi-envelope-check text-primary"></i>
            </c:when>
            <c:otherwise>
                <i class="bi bi-exclamation-circle text-danger"></i>
            </c:otherwise>
        </c:choose>
    </div>

    <h4 class="fw-bold mb-3">
        <c:choose>
            <c:when test="${isSuccess}">발송 완료</c:when>
            <c:otherwise>발송 실패</c:otherwise>
        </c:choose>
    </h4>
    
    <p class="text-muted mb-5">
        ${message}
    </p>

    <div class="d-grid gap-2">
        <button type="button" class="btn btn-black" onclick="location.href='${pageContext.request.contextPath}/member/login';">
            로그인 하러 가기
        </button>
        
        <c:if test="${!isSuccess}">
            <button type="button" class="btn btn-outline-secondary" onclick="location.href='${pageContext.request.contextPath}/member/findInfo?activeTab=pw';" style="border-radius: 10px; padding: 12px;">
                다시 시도하기
            </button>
        </c:if>
    </div>
</div>

</body>
