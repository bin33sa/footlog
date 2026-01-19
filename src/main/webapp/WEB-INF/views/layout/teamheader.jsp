<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

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
    .dropdown-divider {
        border-top: 1px solid rgba(255,255,255,0.1);
    }
</style>

<header id="header" class="site-header bg-white sticky-top border-bottom">
    <nav id="header-nav" class="navbar navbar-expand-lg py-3">
        <div class="container-fluid px-lg-5">
            <a class="navbar-brand fs-3" href="${pageContext.request.contextPath}/main">Footlog</a>
            
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#bdNavbar">
                <span class="navbar-toggler-icon"></span>
            </button>
            
            <div class="collapse navbar-collapse" id="bdNavbar">
                <ul class="navbar-nav mx-auto mb-2 mb-lg-0">
                    
                    <li class="nav-item">
                        <a class="nav-link px-4" href="${pageContext.request.contextPath}/myteam/main">
                            팀 페이지
                        </a>
                    </li>
                    
                    <li class="nav-item dropdown">
                        <a class="nav-link px-4 dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            팀 캘린더
                        </a>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/myteam/schedule">전체 일정</a></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/myteam/attendance">참석 여부</a></li>
                        </ul>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link px-4" href="${pageContext.request.contextPath}/myteam/board">
                            팀 게시판
                        </a>
                    </li>
                    
                    <li class="nav-item">
                        <a class="nav-link px-4" href="${pageContext.request.contextPath}/myteam/gallery?teamCode=${teamCode}">
                            갤러리
                        </a>
                    </li>

                    <li class="nav-item dropdown">
                        <a class="nav-link px-4 dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            팀 관리
                        </a>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/myteam/update?teamCode=${sessionScope.currentTeamCode}">구단 프로필 수정</a></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/myteam/squad">스쿼드 관리</a></li>
                            
                            <c:if test="${myRoleLevel >= 10}">
                            	<li><a class="dropdown-item" href="${pageContext.request.contextPath}/myteam/teamUpdate?teamCode=${sessionScope.currentTeamCode}">구단 정보 수정</a></li>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/myteam/match">매치관리</a></li>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/myteam/requestList">신청현황</a></li>
                            </c:if>

                            <li><hr class="dropdown-divider"></li>
                            <li>
							    <a class="dropdown-item text-danger" 
							       href="${pageContext.request.contextPath}/myteam/selfLeave?teamCode=${sessionScope.currentTeamCode}"
							       onclick="return confirm('정말로 이 구단을 탈퇴하시겠습니까?\n탈퇴 후에는 복구할 수 없습니다.');">
							       구단 탈퇴
							    </a>
							</li>
                        </ul>
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