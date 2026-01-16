<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 

<!DOCTYPE html>
<html lang="ko">
<head>
    <title>Footlog - ${dto.team_name}</title> 
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/style.css">
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>

<jsp:include page="/WEB-INF/views/layout/headerResources.jsp"/>

<body>

    <header>
       <jsp:include page="/WEB-INF/views/layout/header.jsp"/>
    </header>

    <div class="container-fluid px-lg-5 mt-4">
        <div class="row">
             <div class="col-lg-2 d-none d-lg-block">
                <div class="sidebar-menu sticky-top" style="top: 100px;">
                    <div class="mb-4">
                        <p class="sidebar-title">구단</p>
                        <div class="list-group">
                            <a href="${pageContext.request.contextPath}/myteam/main" class="list-group-item list-group-item-action">내 구단 이동</a>
                            <a href="${pageContext.request.contextPath}/team/list" class="list-group-item list-group-item-action active-menu">전체 구단 리스트</a>                        
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-lg-8 col-12">
                <div class="modern-card p-5 bg-light">
                    
                    <%-- 1. 상단 정보 영역 --%>
                    <div class="row align-items-center mb-5">
                        <div class="col-md-3 text-center mb-4 mb-md-0">
                            <div class="rounded-circle bg-white p-1 border d-flex align-items-center justify-content-center mx-auto overflow-hidden position-relative" 
                                 style="width: 160px; height: 160px;">
                                <div class="rounded-circle overflow-hidden w-100 h-100">
                                    <img src="${pageContext.request.contextPath}${not empty dto.emblem_image ? '/uploads/team/'.concat(dto.emblem_image) : '/dist/images/emblem.png'}" 
                                         alt="emblem" 
                                         style="width: 100%; height: 100%; object-fit: cover;"
                                         onerror="this.src='${pageContext.request.contextPath}/dist/images/emblem.png'">
                                </div>
                            </div>
                        </div>
                        
                        <div class="col-md-9">
                            <div class="d-flex justify-content-between align-items-center mb-3 border-bottom pb-3">
                                <div>
                                    <span class="badge bg-dark text-white mb-2 fw-normal">모집중</span>
                                    <h2 class="fw-bold mb-0 text-dark">${dto.team_name}</h2>
                                </div>
                                <div class="text-end">
                                    <span class="d-block text-secondary small mb-1">구단장</span>
                                    <span class="fw-bold text-dark fs-5">${dto.leader_name}</span>
                                </div>
                            </div>
                            
                            <div class="d-flex gap-2 flex-wrap">
                                <span class="badge bg-white text-secondary border px-3 py-2 fw-normal">
                                    <i class="bi bi-geo-alt me-1"></i> ${dto.region}
                                </span>
                                <span class="badge bg-white text-secondary border px-3 py-2 fw-normal">
                                    <i class="bi bi-telephone me-1"></i> 
                                    ${not empty dto.contact_number ? dto.contact_number : '연락처 미공개'}
                                </span>
                                <span class="badge bg-white text-secondary border px-3 py-2 fw-normal">
                                    <i class="bi bi-calendar me-1"></i> 
                                    창단일: ${fn:substring(dto.created_at, 0, 10)}
                                </span>
                            </div>
                        </div>
                    </div>

                    <%-- 2. 구단 소개 --%>
                    <div class="row mb-5">
                        <div class="col-12">
                            <h5 class="fw-bold mb-3 text-dark">구단 소개</h5>
                            <div class="bg-white p-4 rounded-3 border shadow-sm" style="min-height: 150px; line-height: 1.8;">
                                <p class="mb-0 text-secondary">
                                    ${dto.description}
                                </p>
                            </div>
                        </div>
                    </div>

                    <%-- 3. 유튜브 영상 --%>
                    <c:if test="${not empty dto.intro_video_url}">
                        <div class="row mb-5">
                            <div class="col-12">
                                <h5 class="fw-bold mb-3 text-dark">팀 홍보 영상</h5>
                                <div class="bg-white p-2 rounded-3 border shadow-sm">
                                    <div class="ratio ratio-16x9 rounded overflow-hidden">
                                        <iframe id="introVideoFrame" src="" title="YouTube video" allowfullscreen></iframe>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <script>
                            (function(){
                                var url = "${dto.intro_video_url}";
                                var videoId = "";
                                if(url.indexOf("v=") !== -1) {
                                    videoId = url.split('v=')[1];
                                    var ampersandPosition = videoId.indexOf('&');
                                    if(ampersandPosition !== -1) { videoId = videoId.substring(0, ampersandPosition); }
                                } else if(url.indexOf("youtu.be/") !== -1) {
                                    videoId = url.split('youtu.be/')[1];
                                }
                                
                                if(videoId) {
                                    document.getElementById('introVideoFrame').src = "https://www.youtube.com/embed/" + videoId;
                                } else {
                                    document.getElementById('introVideoFrame').parentElement.innerHTML = 
                                        '<div class="d-flex align-items-center justify-content-center h-100 bg-light">' +
                                        '<a href="' + url + '" target="_blank" class="btn btn-outline-dark btn-sm"><i class="bi bi-play-btn me-2"></i>영상 보러가기</a></div>';
                                }
                            })();
                        </script>
                    </c:if>

                    <%-- 4. 통계 및 좋아요 --%>
                    <div class="row g-3 mb-5">
                        <div class="col-md-6">
                            <div class="bg-white p-3 rounded-3 border d-flex justify-content-between align-items-center">
                                <span class="text-secondary">현재 인원</span>
                                <span class="fw-bold fs-5 text-dark">${dto.member_count} / 30명</span>
                            </div>
                        </div>
                        
                        <div class="col-md-6">
                            <div class="bg-white p-3 rounded-3 border d-flex justify-content-between align-items-center">
                                <span class="text-secondary">좋아요</span>
                                <span class="fw-bold fs-5 btn-team-like" style="cursor: pointer;" onclick="toggleLike(this, '${dto.team_code}', event)">
                                    <c:choose>
                                        <c:when test="${dto.user_liked == 1}">
                                            <i class="bi bi-star-fill text-warning"></i> 
                                        </c:when>
                                        <c:otherwise>
                                            <i class="bi bi-star-fill text-secondary"></i> 
                                        </c:otherwise>
                                    </c:choose>
                                    <span class="count text-dark ms-1">${dto.like_count}</span>
                                </span>
                            </div>
                        </div>
                    </div>

                    <%-- 5. 하단 버튼 영역 --%>
                    <div class="d-flex justify-content-between align-items-end border-top pt-4">
                        <div class="text-center d-none d-md-block">
                            <div class="btn-group shadow-sm">
                                <button class="btn btn-light border" title="이전 구단"><i class="bi bi-chevron-left"></i></button>
                                <button class="btn btn-light border" title="다음 구단"><i class="bi bi-chevron-right"></i></button>
                            </div>
                        </div>
                    
                        <div class="d-flex gap-2 w-100 w-md-auto justify-content-end">
                            <button class="btn btn-secondary rounded-pill px-4 fw-bold" 
                                    onclick="location.href='${pageContext.request.contextPath}/team/list'">
                                목록으로
                            </button>
                            
                            <c:choose>
                                <%-- 로그인 안 했을 때 --%>
                                <c:when test="${empty sessionScope.member}">
                                    <button class="btn btn-dark rounded-pill px-5 fw-bold" 
                                            onclick="if(confirm('로그인이 필요한 서비스입니다.\n로그인 페이지로 이동하시겠습니까?')) location.href='${pageContext.request.contextPath}/member/login';">
                                        가입 신청하기 
                                    </button>
                                </c:when>
                    
                                <%-- 로그인 했을 때 --%>
                                <c:otherwise>
                                    <c:choose>
                                        <c:when test="${isLeader}">
                                            <%-- 구단장일 때 --%>
                                            <button class="btn btn-outline-danger rounded-pill px-4 fw-bold" 
                                                    onclick="if(confirm('정말 구단을 삭제 하시겠습니까?')) location.href='${pageContext.request.contextPath}/team/delete?team_code=${dto.team_code}'">
                                                구단 삭제
                                            </button>
                                            <button class="btn btn-dark rounded-pill px-5 fw-bold" 
                                                    onclick="location.href='${pageContext.request.contextPath}/myteam/main?teamCode=${dto.team_code}'">
                                                나의 구단 이동
                                            </button>
                                        </c:when>
                                        
                                        <c:when test="${joinStatus == 15}">
                                            <%-- 이미 팀 멤버일 때 --%>
                                            <button class="btn btn-success rounded-pill px-5 fw-bold" 
                                                    onclick="location.href='${pageContext.request.contextPath}/myteam/main?teamCode=${dto.team_code}'">
                                                나의 구단 이동
                                            </button>
                                        </c:when>
                                        
                                        <c:when test="${joinStatus == 1}">
                                            <%-- 가입 대기중일 때 --%>
                                             <button class="btn btn-warning text-white rounded-pill px-5 fw-bold" disabled>
                                                승인 대기중
                                            </button>
                                        </c:when>
                                        
                                        <c:otherwise>
                                            <%-- ★ 여기가 문제였음! 남의 구단일 때 가입신청 버튼 복구 --%>
                                            <button id="btnJoin" class="btn btn-dark rounded-pill px-5 fw-bold" 
                                                    onclick="sendJoinRequest('${dto.team_code}')">
                                                가입 신청하기
                                            </button>
                                        </c:otherwise>
                                    </c:choose>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-2 d-none d-lg-block"></div>
        </div> 
    </div>

    <footer>
       <jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
    </footer>
    
    <jsp:include page="/WEB-INF/views/layout/footerResources.jsp"/>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    
    <script type="text/javascript">
    // 좋아요 처리 함수
    function toggleLike(element, teamCode, event) {
        if(event) {
            event.stopPropagation();
            event.preventDefault();
        }

        const $btn = $(element);
        const $icon = $btn.find('i');
        const $count = $btn.find('.count');
        
        let userLiked = $icon.hasClass('text-warning');
        
        let params = {
            team_code: teamCode,
            user_Liked: userLiked.toString()
        };
        
        $.ajax({
            type: "POST",
            url: "${pageContext.request.contextPath}/team/insertTeamLike",
            data: params,
            dataType: "json",
            beforeSend: function(xhr) {
                xhr.setRequestHeader("AJAX", "true"); 
            },
            success: function(data) {
                if (data.state === "login_required") {
                    if(confirm("로그인이 필요한 서비스입니다.\n로그인 페이지로 이동하시겠습니까?")) {
                        location.href = "${pageContext.request.contextPath}/member/login"; 
                    }
                    return;
                }
                
                if (data.state === "true") {
                    let isNowLiked = false;
                    if (userLiked) {
                        $icon.removeClass('text-warning').addClass('text-secondary');
                    } else {
                        $icon.removeClass('text-secondary').addClass('text-warning');
                        isNowLiked = true;
                    }
                    $count.text(data.teamLikeCount);

                    sessionStorage.setItem("likeUpdate", JSON.stringify({
                        team_code: teamCode,
                        user_liked: isNowLiked,
                        count: data.teamLikeCount
                    }));
                } else {
                    alert("처리에 실패했습니다.");
                }
            },
            error: function(e) {
                if(e.status === 403) {
                    if(confirm("로그인이 필요한 서비스입니다.\n로그인 페이지로 이동하시겠습니까?")) {
                        location.href = "${pageContext.request.contextPath}/member/login";
                    }
                    return;
                }
                console.log(e);
                alert("서버 통신 오류가 발생했습니다.");
            }
        });
    }
    
    // ★ [복구] 가입 신청 스크립트
    function sendJoinRequest(teamCode) {
        if(!confirm("이 구단에 가입 신청을 보내시겠습니까?")) return;
        
        $.ajax({
            type: "POST",
            url: "${pageContext.request.contextPath}/team/joinRequest",
            data: { team_code: teamCode },
            dataType: "json",
            beforeSend: function(xhr) {
                xhr.setRequestHeader("AJAX", "true"); 
            },
            success: function(data) {
                if(data.state === "true") {
                    alert("가입 신청이 완료되었습니다!\n구단장의 승인을 기다려주세요.");
                    location.reload();
                } 
                else if(data.state === "duplicate") {
                    alert("이미 가입 신청을 완료한 구단입니다.\n승인 결과를 조금만 더 기다려주세요!");
                } 
                else if(data.state === "login_required") {
                    if(confirm("로그인이 필요한 서비스입니다.\n로그인 페이지로 이동하시겠습니까?")) {
                        location.href = "${pageContext.request.contextPath}/member/login";
                    }
                } 
                else {
                    alert("가입 신청 중 오류가 발생했습니다. 잠시 후 다시 시도해주세요.");
                }
            },
            error: function(e) {
                if(e.status === 403) {
                    if(confirm("로그인이 필요한 서비스입니다.\n로그인 페이지로 이동하시겠습니까?")) {
                        location.href = "${pageContext.request.contextPath}/member/login";
                    }
                    return;
                }
                console.log(e);
                alert("서버 통신 오류가 발생했습니다.");
            }
        });
    }
    </script>
</body>
</html>