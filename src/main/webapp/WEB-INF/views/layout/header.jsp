<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="canCreate" value="false"/>
	<c:if test="${not empty myTeams}">
	    <c:forEach var="team" items="${myTeams}">
	        <c:if test="${team.role_level >= 10}">
	            <c:set var="canCreate" value="true"/>
	        </c:if>
	    </c:forEach>
	</c:if>

<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/style.css">

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
                        <a class="nav-link px-4 dropdown-toggle" href="#" id="navIntro">사이트소개</a>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/introduction">사이트 기능 소개</a></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/qna/list">문의 게시판</a></li>
                            <li><hr class="dropdown-divider bg-secondary opacity-25"></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/faq/list">자주 묻는 질문 (Q/A)</a></li>
                        </ul>
                    </li>

                    <li class="nav-item dropdown">
                        <a class="nav-link px-4 dropdown-toggle" href="#" id="navTeam">구단</a>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item" href="#" onclick="openHeaderMyTeamModal(); return false;">내 구단으로 이동</a></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/team/list">전체 구단 리스트</a></li>
                            <li><hr class="dropdown-divider bg-secondary opacity-25"></li>
                           	 <li><a class="dropdown-item" href="${pageContext.request.contextPath}/team/write">구단 생성하기</a></li>
                        </ul>
                    </li>

                    <li class="nav-item dropdown">
                        <a class="nav-link px-4 dropdown-toggle" href="#" id="navField">구장</a>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/field/list">구장 검색/예약</a></li>
                        </ul>
                    </li>

                    <li class="nav-item dropdown">
                        <a class="nav-link px-4 dropdown-toggle" href="#" id="navMatch">매치</a>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item" href="#">내 매치 일정</a></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/match/list">전체 매치 리스트</a></li>
                            <c:if test="${canCreate }">
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/match/write">매치 개설하기</a></li>
                            </c:if>
                            <li><hr class="dropdown-divider bg-secondary opacity-25"></li>
                            <li><a class="dropdown-item text-primary" href="${pageContext.request.contextPath}/mercenary/list">🔥 용병 모집</a></li>
                        </ul>
                    </li>
                    
                    <li class="nav-item dropdown">
                        <a class="nav-link px-4 dropdown-toggle" href="#" id="navBoard">게시판</a>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/bbs/list?category=1">공지사항</a></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/bbs/list?category=2">자유 게시판</a></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/bbs/list?category=4">갤러리</a></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/bbs/list?category=3">이벤트 / 뉴스</a></li>
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
						    <div class="d-flex align-items-center me-3">
                                <c:choose>
                                    <c:when test="${not empty sessionScope.member.profile_image}">
                                        <img src="${pageContext.request.contextPath}/uploads/member/${sessionScope.member.profile_image}" 
                                             class="rounded-circle border me-2" 
                                             width="32" height="32" 
                                             style="object-fit: cover;"
                                             onerror="this.src='${pageContext.request.contextPath}/dist/images/avatar.png'">
                                    </c:when>
                                    <c:otherwise>
                                        <img src="${pageContext.request.contextPath}/dist/images/avatar.png" 
                                             class="rounded-circle border me-2" 
                                             width="32" height="32" 
                                             style="object-fit: cover;">
                                    </c:otherwise>
                                </c:choose>
                                <span class="fw-bold">${sessionScope.member.member_name}님</span>
                            </div>
                            <c:if test="${not empty sessionScope.member and sessionScope.member.role_level < 50}">
                                <a href="${pageContext.request.contextPath}/member/mypage" class="btn btn-outline-secondary rounded-pill btn-sm me-2">마이페이지</a>
                            </c:if>
                            <c:if test="${not empty sessionScope.member and sessionScope.member.role_level > 50}">
                                <a href="${pageContext.request.contextPath}/admin/mypage" class="btn btn-outline-secondary rounded-pill btn-sm me-2">관리페이지</a>
                            </c:if>
                            <a href="${pageContext.request.contextPath}/member/logout" class="btn btn-dark rounded-pill btn-sm">로그아웃</a>
						</c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </nav>
</header>

<div class="modal fade" id="headerMyTeamModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content rounded-4 border-0 shadow-lg">
            
            <div class="modal-header border-0 pb-0 pt-4 px-4">
                <h1 class="modal-title fs-5 fw-bold">내 구단 선택</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            
            <div class="modal-body p-4" id="headerMyTeamListArea">
                <div class="text-center text-secondary">
                    <div class="spinner-border spinner-border-sm mb-2" role="status"></div>
                    <p class="small">구단 목록을 불러오는 중...</p>
                </div>
            </div>
            
        </div>
    </div>
</div>


<script>
    $(document).ready(function() {
        $('.navbar-nav .dropdown-toggle').click(function(e) {
            // 화면 너비가 991px 이하일 때만 작동 (모바일)
            if ($(window).width() <= 991) {
                e.preventDefault(); 
                e.stopPropagation();

                var $dropdownMenu = $(this).next('.dropdown-menu');

                if ($dropdownMenu.is(':visible')) {
                    $dropdownMenu.slideUp(200);
                } else {
                    $('.dropdown-menu').slideUp(200);
                    $dropdownMenu.slideDown(200);
                }
            }
        });
    });

    // 로그인 체크
    function checkMyTeam() {
        const isLogin = '${not empty sessionScope.member}';
        if (isLogin === 'false') {
            alert("로그인이 필요한 서비스입니다.");
            location.href = '${pageContext.request.contextPath}/member/login';
            return false;
        }
        return true;
    }

    // 내 구단 이동 클릭 시 모달 열기
    function openHeaderMyTeamModal() {
        if (!checkMyTeam()) return; 

        if (typeof jQuery !== 'undefined') {
            jQuery.fn.center = function () {
                this.css("position","absolute");
                this.css("top", Math.max(0, (($(window).height() - $(this).outerHeight()) / 2) + $(window).scrollTop()) + "px");
                this.css("left", Math.max(0, (($(window).width() - $(this).outerWidth()) / 2) + $(window).scrollLeft()) + "px");
                return this;
            }
        }

        if (typeof bootstrap === 'undefined') {
            alert("잠시 후 다시 시도해주세요.");
            return;
        }

        // 로딩바 표시 
        const loadingHtml = `
            <div class="text-center text-secondary py-4">
                <div class="spinner-border spinner-border-sm mb-2" role="status"></div>
                <p class="small mb-0">구단 목록을 불러오는 중...</p>
            </div>`;
        $('#headerMyTeamListArea').html(loadingHtml);

        const modalEl = document.getElementById('headerMyTeamModal');
        const modal = bootstrap.Modal.getOrCreateInstance(modalEl);
        modal.show();

        // AJAX 요청
        $.ajax({
            url: '${pageContext.request.contextPath}/team/myList',
            type: 'get',
            dataType: 'json',
            success: function(list) {
                let html = '';

                if (list && list.length > 0) {
                    html += '<div class="list-group list-group-flush">';
                    
                    $.each(list, function(index, team) {
                        let imgSrc = '${pageContext.request.contextPath}/dist/images/emblem.png';
                        if(team.emblem_image) {
                            imgSrc = '${pageContext.request.contextPath}/uploads/team/' + team.emblem_image;
                        }

                        html += '<a href="${pageContext.request.contextPath}/myteam/main?teamCode=' + team.team_code + '"';
                        html += '   class="list-group-item list-group-item-action d-flex align-items-center py-3 px-2 border-0 rounded-3 mb-1"';
                        html += '   style="transition: background 0.2s;">';
                        html += '   <div class="rounded-circle border me-3 overflow-hidden bg-light d-flex justify-content-center align-items-center" style="width: 48px; height: 48px; min-width: 48px;">';
                        html += '       <img src="' + imgSrc + '" class="w-100 h-100 object-fit-cover" onerror="this.src=\'${pageContext.request.contextPath}/dist/images/emblem.png\'">';
                        html += '   </div>';
                        html += '   <div>';
                        html += '       <div class="fw-bold text-dark" style="font-size: 1rem;">' + team.team_name + '</div>';
                        html += '       <div class="small text-secondary mt-1"><i class="bi bi-geo-alt me-1"></i>' + (team.region ? team.region : '지역미정') + '</div>';
                        html += '   </div>';
                        html += '   <i class="bi bi-chevron-right ms-auto text-muted opacity-50"></i>';
                        html += '</a>';
                    });
                    
                    html += '</div>';

                } else {
                    html += '<div class="text-center pt-5 pb-0">';
                    html += '   <i class="bi bi-exclamation-circle text-secondary fs-1 mb-3 d-block opacity-25"></i>';
                    html += '   <p class="text-secondary mb-4">아직 가입된 구단이 없습니다.</p>';
                    html += '   <a href="${pageContext.request.contextPath}/team/write" class="btn btn-dark rounded-pill w-100 py-2 fw-bold mt-5">새 구단 만들기</a>';
                    html += '</div>';
                }

                setTimeout(() => {
                    $('#headerMyTeamListArea').html(html);
                }, 200);
            },
            error: function(xhr) {
                console.log(xhr);
                let msg = '<div class="text-center py-4 text-danger"><i class="bi bi-exclamation-triangle mb-2 d-block fs-4"></i>목록을 불러오지 못했습니다.</div>';
                if(xhr.status === 404) msg = '<div class="text-center py-4 text-danger">서버 재시작이 필요합니다.</div>';
                $('#headerMyTeamListArea').html(msg);
            }
        });
    }
</script>