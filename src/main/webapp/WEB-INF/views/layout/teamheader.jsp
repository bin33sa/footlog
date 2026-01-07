<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>



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
                        <a class="nav-link px-4 " href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            팀 캘린더
                        </a>
                    </li>

                    <li class="nav-item dropdown">
                        <a class="nav-link px-4 dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            팀 게시판
                        </a>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/">공지사항</a></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/" onclick="return checkMyTeam()">자유 게시판</a></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/">문의게시판</a></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/">갤러리</a></li>
                        </ul>
                    </li>


                    <li class="nav-item">
					    <a class="nav-link px-4" href="${pageContext.request.contextPath}/myteam/match">
					        매치 일정/투표
					    </a>
					</li>
                    
                     <li class="nav-item">
					    <a class="nav-link px-4" href="${pageContext.request.contextPath}/myteam/squad">
					        스쿼드
					    </a>
					</li>
                    
                    <li class="nav-item dropdown">
                        <a class="nav-link px-4 dropdown-toggle" href="${pageContext.request.contextPath}" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            구단관리
                        </a>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item" href="#">구단 프로필 수정</a></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/">구단 탈퇴</a></li>
                            <li><a class="dropdown-item" href="#">매치관리</a></li>
                            <li><a class="dropdown-item" href="#">신청현황</a></li>
                        </ul>
                    </li>
                </ul>
                
                <div class="d-flex gap-2">
                    <c:choose>
                        <c:when test="${empty sessionScope.user}">
                            <a href="${pageContext.request.contextPath}" class="btn btn-outline-dark rounded-pill px-4">로그인</a>
                            <a href="${pageContext.request.contextPath}" class="btn btn-dark rounded-pill px-4">회원가입</a>
                        </c:when>
                        <c:otherwise>
                            <span class="d-flex align-items-center fw-bold me-2">
                                손흥민님
                            </span>
                            <a href="${pageContext.request.contextPath}" class="btn btn-outline-dark rounded-pill px-4">로그아웃</a>
                            <a href="${pageContext.request.contextPath}" class="btn btn-dark rounded-pill px-4">마이페이지</a>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </nav>
</header>