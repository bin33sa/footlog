<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<style>
    @media (min-width: 992px) {
        .dropdown:hover .dropdown-menu {
            display: block;
            margin-top: 0;
            animation: fadeInDown 0.3s ease;
        }
    }
    @keyframes fadeInDown {
        from { opacity: 0; transform: translateY(-10px); }
        to { opacity: 1; transform: translateY(0); }
    }
    .dropdown-menu {
        background-color: #111;
        border: 1px solid #333;
        border-radius: 15px;
        padding: 10px 0;
        box-shadow: 0 10px 30px rgba(0,0,0,0.5);
    }
    .dropdown-item {
        color: #fff;
        font-weight: 500;
        padding: 10px 20px;
        transition: 0.2s;
    }
    .dropdown-item:hover {
        background-color: transparent;
        color: var(--primary-color, #D4F63F);
        padding-left: 25px;
    }
</style>

<script>
    function checkMyTeam() {
        // [수정] 세션에 member가 없으면 경고창 띄우기
        const isLogin = '${not empty sessionScope.member}';
        
        if (isLogin === 'false') {
            alert("로그인이 필요한 서비스입니다.");
            location.href = '${pageContext.request.contextPath}/member/login';
            return false;
        }
        
        // TODO: 실제 팀 가입 여부는 나중에 DB 체크 필요
        // alert("아직 소속된 구단이 없습니다."); 
        // return false;
        
        return true;
    }
</script>

<header id="header" class="site-header bg-white sticky-top border-bottom">
    <nav id="header-nav" class="navbar navbar-expand-lg py-3">
        <div class="container-fluid px-lg-5">
            <a class="navbar-brand fs-3" href="${pageContext.request.contextPath}/main">Footlog</a>
            
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#bdNavbar">
                <span class="navbar-toggler-icon"></span>
            </button>
            
            <div class="collapse navbar-collapse" id="bdNavbar">
                <ul class="navbar-nav mx-auto mb-2 mb-lg-0">
                    
                    <li class="nav-item dropdown">
                        <a class="nav-link px-4 dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">사이트소개</a>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item" href="#">사이트 기능 소개</a></li>
                            <li><a class="dropdown-item" href="#">문의 게시판</a></li>
                            <li><hr class="dropdown-divider bg-secondary opacity-25"></li>
                            <li><a class="dropdown-item" href="#">자주 묻는 질문 (Q/A)</a></li>
                        </ul>
                    </li>

                    <li class="nav-item dropdown">
                        <a class="nav-link px-4 dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">구단</a>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item" href="#" onclick="return checkMyTeam()">내 구단으로 이동</a></li>
                            <li><a class="dropdown-item" href="#">전체 구단 리스트</a></li>
                            <li><hr class="dropdown-divider bg-secondary opacity-25"></li>
                            <li><a class="dropdown-item" href="#">구단 생성하기</a></li>
                        </ul>
                    </li>

                    <li class="nav-item dropdown">
                        <a class="nav-link px-4 dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">구장</a>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item" href="#">전체 구장 리스트</a></li>
                            <li><a class="dropdown-item" href="#">구장 예약</a></li>
                        </ul>
                    </li>

                    <li class="nav-item dropdown">
                        <a class="nav-link px-4 dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">매치</a>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item" href="#">내 매치 일정</a></li>
                            <li><a class="dropdown-item" href="#">전체 매치 리스트</a></li>
                            <li><a class="dropdown-item" href="#">매치 생성하기</a></li>
                            <li><hr class="dropdown-divider bg-secondary opacity-25"></li>
                            <li><a class="dropdown-item text-primary" href="#">🔥 용병 모집</a></li>
                        </ul>
                    </li>
                    
                    <li class="nav-item dropdown">
                        <a class="nav-link px-4 dropdown-toggle" href="${pageContext.request.contextPath}/bbs/list" role="button" data-bs-toggle="dropdown" aria-expanded="false">게시판</a>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/notice/list">공지사항</a></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/bbs/list">자유 게시판</a></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/photo/list">갤러리</a></li>
                            <li><a class="dropdown-item" href="#">이벤트 / 뉴스</a></li>
                        </ul>
                    </li>
                </ul>
                
                <div class="d-flex gap-2 align-items-center">
                    <c:choose>
                        <c:when test="${empty sessionScope.member}">
                            <a href="${pageContext.request.contextPath}/member/login" class="btn btn-outline-dark rounded-pill px-4">로그인</a>
                            <a href="${pageContext.request.contextPath}/member/signup" class="btn btn-dark rounded-pill px-4">회원가입</a>
                        </c:when>
                        
                        <c:otherwise>
                            <div class="dropdown">
                                <a href="#" class="d-flex align-items-center text-decoration-none dropdown-toggle text-dark fw-bold me-3" data-bs-toggle="dropdown">
                                    <img src="${pageContext.request.contextPath}/dist/images/avatar.png" class="rounded-circle border me-2" width="32" height="32" style="object-fit: cover;">
                                    ${sessionScope.member.userName}님
                                </a>
                                <ul class="dropdown-menu dropdown-menu-end text-small shadow" style="background-color: white; border-color: #eee;">
                                    <li><a class="dropdown-item text-dark" href="${pageContext.request.contextPath}/member/mypage">마이페이지</a></li>
                                    <li><a class="dropdown-item text-dark" href="#">내 정보 수정</a></li>
                                    <li><hr class="dropdown-divider"></li>
                                    <li><a class="dropdown-item text-danger" href="${pageContext.request.contextPath}/member/logout">로그아웃</a></li>
                                </ul>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </nav>
</header>