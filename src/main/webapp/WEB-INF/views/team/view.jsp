<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 

<!DOCTYPE html>
<html lang="ko">
<head>
    <title>Footlog - ${dto.team_name}</title> <meta charset="utf-8">
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
                            <a href="${pageContext.request.contextPath}/team/write" class="list-group-item list-group-item-action">구단 생성하기</a>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-lg-8 col-12 ">
                
                <div class="modern-card p-5 bg-light">
                    
                    <%-- 1. 상단 정보 영역 --%>
                    <div class="row align-items-center mb-5">
                        
                        <%-- 엠블럼 영역 (액자 스타일) --%>
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
                            <%-- 텍스트 정보 영역 --%>
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

                    <%-- 2. 구단 소개 텍스트 --%>
                    <div class="row mb-5">
                        <div class="col-12">
                            <h5 class="fw-bold mb-3 text-dark">구단 소개</h5>
                            <div class="bg-white p-4 rounded-3 border shadow-sm" style="min-height: 150px; line-height: 1.8;">
                                <p class="mb-0 text-secondary">
                                    ${dto.description.replaceAll("\\n", "<br>")}
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

                    <%-- 4. 통계 정보 (좋아요 버튼 수정됨) --%>
                    <div class="row g-3 mb-5">
                        <div class="col-md-6">
                            <div class="bg-white p-3 rounded-3 border d-flex justify-content-between align-items-center">
                                <span class="text-secondary">현재 인원</span>
                                <span class="fw-bold fs-5 text-dark">${dto.member_count} / 30명</span>
                            </div>
                        </div>
                        
                        <div class="col-md-6">
						    <div class="bg-white p-3 rounded-3 border d-flex justify-content-between align-items-center">
						        <span class="text-secondary">매너 점수 / 좋아요</span>
						        
						        <%-- onclick에 event 추가 --%>
						        <span class="fw-bold fs-5 btn-team-like" style="cursor: pointer;" onclick="toggleLike(this, '${dto.team_code}', event)">
						            <c:choose>
						                <%-- 1. 내가 눌렀으면 -> 노란색 (text-warning) --%>
						                <c:when test="${dto.user_liked == 1}">
						                    <i class="bi bi-star-fill text-warning"></i> 
						                </c:when>
						                <%-- 2. 안 눌렀으면 -> 회색 (text-secondary) --%>
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
                                <c:when test="${empty sessionScope.member}">
                                    <button class="btn btn-dark rounded-pill px-5 fw-bold" onclick="alert('로그인이 필요합니다.'); location.href='${pageContext.request.contextPath}/member/login';">
                                        로그인 후 가입
                                    </button>
                                </c:when>
                                <c:otherwise>
                                    <button class="btn btn-dark rounded-pill px-5 fw-bold" 
                                            onclick="alert('가입 신청이 구단장에게 전송되었습니다!')">
                                        가입 신청하기
                                    </button>
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
	function toggleLike(element, teamCode, event) {
	    // 1. 이벤트 전파 방지 (카드 클릭 등 다른 이벤트 방지)
	    if(event) {
	        event.stopPropagation();
	        event.preventDefault(); // a 태그나 button 기본 동작도 막음
	    }

	    const $btn = $(element);
	    const $icon = $btn.find('i');
	    const $count = $btn.find('.count');
	    
	    // 현재 노란색(text-warning)이면 -> 이미 좋아요 누른 상태 -> 취소 요청해야 함
	    let userLiked = $icon.hasClass('text-warning');
	    
	    let params = {
	        team_code: teamCode,
	        user_Liked: userLiked.toString() // "true" or "false" 문자열로 전송
	    };
	    
	    $.ajax({
	        type: "POST",
	        url: "${pageContext.request.contextPath}/team/insertTeamLike",
	        data: params,
	        dataType: "json",
	        success: function(data) {
	            // A. 비로그인 상태 처리
	            if (data.state === "login_required") {
	                if(confirm("로그인이 필요한 서비스입니다.\n로그인 페이지로 이동하시겠습니까?")) {
	                    location.href = "${pageContext.request.contextPath}/member/login"; 
	                }
	                return;
	            }
	            
	            // B. 성공 처리
	            if (data.state === "true") {
	                
	                // ★ [추가] 최종적으로 좋아요가 된 건지 취소된 건지 저장할 변수
	                let isNowLiked = false;

	                if (userLiked) {
	                    // 좋아요 취소 성공: 노란색 -> 회색
	                    $icon.removeClass('text-warning').addClass('text-secondary');
	                    isNowLiked = false; // 취소됨
	                } else {
	                    // 좋아요 등록 성공: 회색 -> 노란색
	                    $icon.removeClass('text-secondary').addClass('text-warning');
	                    isNowLiked = true; // 좋아요됨
	                }
	                // 숫자 업데이트
	                $count.text(data.teamLikeCount);

	                // ★★★ [여기 추가됨] 브라우저에 변경 사항 메모 (뒤로가기 반영용) ★★★
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
	            console.log(e);
	            alert("서버 통신 오류가 발생했습니다.");
	        }
	    });
	}
	</script>
	

	
	
</body>
</html>