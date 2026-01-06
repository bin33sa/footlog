<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<style>
    /* [1] 드롭다운 호버 애니메이션 (ID 선택자로 우선순위 높임) */
    @media (min-width: 992px) {
        #header .dropdown:hover .dropdown-menu {
            display: block;
            animation: fadeInDown 0.3s ease;
        }
    }
    
    @keyframes fadeInDown {
        from { opacity: 0; transform: translateY(10px); }
        to { opacity: 1; transform: translateY(0); }
    }

    /* [2] 사용자 메뉴 전용 스타일 (ID + Class 조합으로 !important 없이 이김) */
    /* 배경색 투명 문제와 위치 문제 해결 */
    #header .navbar .user-menu {
        background-color: #ffffff; /* 흰색 배경 */
        border: 1px solid #e5e5e5;
        border-radius: 12px;
        box-shadow: 0 10px 25px rgba(0,0,0,0.15);
        
        /* 위치 잡기 */
        position: absolute;
        top: 100%;
        right: 0;
        left: auto;
        
        /* z-index: 사이드바보다 높아야 함 (보통 사이드바가 1020~1030) */
        z-index: 2000;
        
        /* 여백 및 크기 */
        margin-top: 10px;
        padding: 8px 0;
        min-width: 170px;
    }

    /* [3] 끊김 방지용 투명 다리 (Bridge) */
    /* 메뉴 박스 위쪽에 보이지 않는 영역을 추가해 마우스 경로를 확보 */
    #header .navbar .user-menu::before {
        content: "";
        display: block;
        position: absolute;
        top: -15px; /* 메뉴 위 15px 공간 확보 */
        left: 0;
        width: 100%;
        height: 15px;
        background-color: transparent; /* 투명 */
    }

    /* 아이템 스타일 */
    #header .dropdown-item {
        color: #333;
        font-weight: 500;
        padding: 8px 20px;
        transition: all 0.2s;
    }

    #header .dropdown-item:hover {
        background-color: #f8f9fa;
        color: #000;
        padding-left: 25px;
    }
    
    .dropdown-divider {
        border-top: 1px solid #eee;
        margin: 4px 0;
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
            <a class="navbar-brand fs-3" href="${pageContext.request.contextPath}/main">Footlog</a>
            
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#bdNavbar">
                <span class="navbar-toggler-icon"></span>
            </button>
            
            <div class="collapse navbar-collapse" id="bdNavbar">
                <ul class="navbar-nav mx-auto mb-2 mb-lg-0">
                    <li class="nav-item dropdown">
                        <a class="nav-link px-4 dropdown-toggle" href="#" data-bs-toggle="dropdown">사이트소개</a>
                        <ul class="dropdown-menu user-menu">
                            <li><a class="dropdown-item" href="#">사이트 기능 소개</a></li>
                            <li><a class="dropdown-item" href="#">문의 게시판</a></li>
                            <li><hr class="dropdown-divider"></li>
                            <li><a class="dropdown-item" href="#">자주 묻는 질문 (Q/A)</a></li>
                        </ul>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link px-4 dropdown-toggle" href="#" data-bs-toggle="dropdown">구단</a>
                        <ul class="dropdown-menu user-menu">
                            <li><a class="dropdown-item" href="#" onclick="return checkMyTeam()">내 구단으로 이동</a></li>
                            <li><a class="dropdown-item" href="#">전체 구단 리스트</a></li>
                            <li><hr class="dropdown-divider"></li>
                            <li><a class="dropdown-item" href="#">구단 생성하기</a></li>
                        </ul>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link px-4 dropdown-toggle" href="#" data-bs-toggle="dropdown">구장</a>
                        <ul class="dropdown-menu user-menu">
                            <li><a class="dropdown-item" href="#">전체 구장 리스트</a></li>
                            <li><a class="dropdown-item" href="#">구장 예약</a></li>
                        </ul>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link px-4 dropdown-toggle" href="#" data-bs-toggle="dropdown">매치</a>
                        <ul class="dropdown-menu user-menu">
                            <li><a class="dropdown-item" href="#">내 매치 일정</a></li>
                            <li><a class="dropdown-item" href="#">전체 매치 리스트</a></li>
                            <li><a class="dropdown-item" href="#">매치 생성하기</a></li>
                            <li><hr class="dropdown-divider"></li>
                            <li><a class="dropdown-item text-primary" href="#">🔥 용병 모집</a></li>
                        </ul>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link px-4 dropdown-toggle" href="${pageContext.request.contextPath}/bbs/list" data-bs-toggle="dropdown">게시판</a>
                        <ul class="dropdown-menu user-menu">
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
                            <div class="dropdown" style="position: relative;">
                                <a href="#" class="d-flex align-items-center text-decoration-none dropdown-toggle text-dark fw-bold me-3" data-bs-toggle="dropdown" style="padding: 10px 0;">
                                    <img src="${pageContext.request.contextPath}/dist/images/avatar.png" class="rounded-circle border me-2" width="32" height="32" style="object-fit: cover;">
                                    ${sessionScope.member.memberName}님
                                </a>
                                
                                <ul class="dropdown-menu dropdown-menu-end shadow user-menu">
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/member/mypage">마이페이지</a></li>
                                    <li><a class="dropdown-item" href="#">내 정보 수정</a></li>
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