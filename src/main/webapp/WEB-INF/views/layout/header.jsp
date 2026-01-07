<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<style>
    /* 네비게이션 링크 호버 효과 */
    .nav-link {
        font-weight: 500;
        transition: color 0.2s;
    }
    .nav-link:hover {
        color: #D4F63F !important; /* 포인트 컬러 */
    }
</style>

<script>
    function checkMyTeam() {
        const isLogin = '${not empty sessionScope.member}';
        if (isLogin === 'false') {
            alert("로그인이 필요한 서비스입니다.");
            location.href = '${pageContext.request.contextPath}/member/login';
            return false;
        }
        return true;
    }
</script>

<header id="header" class="site-header bg-white sticky-top border-bottom">
    <nav id="header-nav" class="navbar navbar-expand-lg py-3">
        <div class="container-fluid px-lg-5">
            <a class="navbar-brand fs-3 fst-italic fw-bold" href="${pageContext.request.contextPath}/main">Footlog</a>
            
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#bdNavbar">
                <span class="navbar-toggler-icon"></span>
            </button>
            
            <div class="collapse navbar-collapse" id="bdNavbar">
                <ul class="navbar-nav mx-auto mb-2 mb-lg-0">
                    
                    <li class="nav-item">
                        <a class="nav-link px-4" href="${pageContext.request.contextPath}/notice/list">공지사항</a>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link px-4" href="${pageContext.request.contextPath}/team/list">구단 리스트</a>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link px-4" href="${pageContext.request.contextPath}/stadium/list">구장 예약</a>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link px-4" href="${pageContext.request.contextPath}/match/list">매치 찾기</a>
                    </li>
                    
                    <li class="nav-item">
                        <a class="nav-link px-4" href="${pageContext.request.contextPath}/bbs/list">커뮤니티</a>
                    </li>
                </ul>
                
                <div class="d-flex gap-2 align-items-center">
                    <c:choose>
                        <c:when test="${empty sessionScope.member}">
                            <a href="${pageContext.request.contextPath}/member/login" class="btn btn-outline-dark rounded-pill px-4 btn-sm">로그인</a>
                            <a href="${pageContext.request.contextPath}/member/signup" class="btn btn-dark rounded-pill px-4 btn-sm">회원가입</a>
                        </c:when>
                        
                        <c:otherwise>
                            <div class="d-flex align-items-center">
                                <div class="d-flex align-items-center me-3">
                                    <img src="${pageContext.request.contextPath}/dist/images/avatar.png" class="rounded-circle border me-2" width="32" height="32" style="object-fit: cover;">
                                    <span class="fw-bold">${sessionScope.member.member_name}님</span>
                                </div>
                                
                                <a href="${pageContext.request.contextPath}/member/mypage" class="btn btn-outline-secondary rounded-pill btn-sm me-2">마이페이지</a>
                                <a href="${pageContext.request.contextPath}/member/logout" class="btn btn-dark rounded-pill btn-sm">로그아웃</a>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </nav>
</header>