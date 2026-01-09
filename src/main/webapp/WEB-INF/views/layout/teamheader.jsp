<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<header id="header" class="site-header bg-white sticky-top border-bottom">
    <nav id="header-nav" class="navbar navbar-expand-lg py-3">
        <div class="container-fluid px-lg-5">
            <a class="navbar-brand fs-3 fw-bold fst-italic text-dark" href="${pageContext.request.contextPath}/main">Footlog</a>
            
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#bdNavbar">
                <span class="navbar-toggler-icon"></span>
            </button>
            
            <div class="collapse navbar-collapse" id="bdNavbar">
                <ul class="navbar-nav mx-auto mb-2 mb-lg-0">
                    
                    <li class="nav-item">
                        <a class="nav-link px-4 fw-semibold" href="${pageContext.request.contextPath}/myteam/main">
                            팀 페이지
                        </a>
                    </li>
                    
                    <li class="nav-item dropdown">
                        <a class="nav-link px-4 fw-semibold dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            팀 캘린더
                        </a>
                        <ul class="dropdown-menu border-0 shadow-sm">
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/myteam/schedule">전체 일정</a></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/myteam/attendance">참석 여부</a></li>
                        </ul>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link px-4 fw-semibold" href="${pageContext.request.contextPath}/myteam/board/list">
                            팀 게시판
                        </a>
                    </li>
                    
                    <li class="nav-item">
                        <a class="nav-link px-4 fw-semibold" href="${pageContext.request.contextPath}/myteam/gallery/list">
                            갤러리
                        </a>
                    </li>

                    <li class="nav-item dropdown">
                        <a class="nav-link px-4 fw-semibold dropdown-toggle text-primary" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            팀 관리
                        </a>
                        <ul class="dropdown-menu border-0 shadow-sm">
                            
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/myteam/update">구단 프로필 수정</a></li>
                            
                            <c:if test="${myRoleLevel >= 10}">
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/myteam/manage/match">매치관리</a></li>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/myteam/member/requestList">신청현황</a></li>
                            </c:if>

                            <li><hr class="dropdown-divider"></li>
                            
                            <li><a class="dropdown-item text-danger" href="${pageContext.request.contextPath}/myteam/delete">구단 탈퇴</a></li>
                        </ul>
                    </li>
                </ul>
                
                <div class="d-flex gap-2 align-items-center">
                    <span class="d-flex align-items-center fw-bold me-3 text-dark">
                        <c:if test="${not empty sessionScope.member}">
                            ${sessionScope.member.member_name}님
                        </c:if>
                        <c:if test="${empty sessionScope.member}">
                            게스트님 
                        </c:if>
                    </span>
                    
                    <a href="${pageContext.request.contextPath}/member/logout" class="btn btn-outline-dark rounded-pill px-4 btn-sm">
                        로그아웃
                    </a>
                    
                    <a href="${pageContext.request.contextPath}/mypage" class="btn btn-dark rounded-pill px-4 btn-sm">
                        마이페이지
                    </a>
                </div>
            </div>
        </div>
    </nav>
</header>