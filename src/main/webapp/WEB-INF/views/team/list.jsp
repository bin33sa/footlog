<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <title>Footlog - Find Your Team</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/style.css">
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

    <style>
        :root { --neon-color: #D4F63F; --dark-black: #111; }
        
        /* 스크롤 및 카드 스타일 */
        .my-team-scroll-container { display: flex; gap: 16px; overflow-x: auto; padding: 10px 5px 25px 5px; scroll-behavior: smooth; }
        .my-team-scroll-container::-webkit-scrollbar { height: 6px; }
        .my-team-scroll-container::-webkit-scrollbar-track { background: #f0f0f0; border-radius: 3px; }
        .my-team-scroll-container::-webkit-scrollbar-thumb { background: #d1d1d1; border-radius: 3px; }
        
        .my-team-card-item { flex: 0 0 auto; width: 200px; background: #fff; border: 1px solid #e5e5e5; border-radius: 20px; padding: 24px 16px; text-align: center; transition: all 0.3s; position: relative; cursor: pointer; text-decoration: none; box-shadow: 0 4px 6px rgba(0,0,0,0.02); }
        .my-team-card-item:hover { transform: translateY(-5px); border-color: var(--dark-black); box-shadow: 0 12px 20px rgba(0,0,0,0.1); }
        .my-team-emblem { width: 72px; height: 72px; border-radius: 50%; overflow: hidden; border: 2px solid #f0f0f0; margin: 0 auto 16px auto; background: #fff; }
        .my-team-card-item:hover .my-team-emblem { border-color: var(--neon-color); }
        .my-team-emblem img { width: 100%; height: 100%; object-fit: cover; }
        .my-team-name { color: #222; font-weight: 800; font-size: 1.05rem; margin-bottom: 4px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }
        .my-team-region { color: #888; font-size: 0.8rem; margin-bottom: 18px; font-weight: 500; }
        
        .btn-enter { background: #f8f9fa; color: #333; border: 1px solid #eee; border-radius: 12px; font-size: 0.8rem; padding: 8px 0; font-weight: 700; width: 100%; display: block; }
        .my-team-card-item:hover .btn-enter { background: var(--dark-black); color: var(--neon-color); border-color: var(--dark-black); }
        .add-team-card { border: 2px dashed #ddd; background: #fafafa; color: #aaa; display: flex; flex-direction: column; justify-content: center; }
        .add-team-card:hover { border-color: var(--dark-black); color: var(--dark-black); background: #fff; }
        .count-badge { background: var(--dark-black); color: var(--neon-color); font-size: 0.85rem; font-weight: 800; padding: 2px 10px; border-radius: 12px; margin-left: 8px; vertical-align: middle; }
    </style>
</head>

<jsp:include page="/WEB-INF/views/layout/headerResources.jsp"/>

<body>

    <header>
       <jsp:include page="/WEB-INF/views/layout/header.jsp"/>
    </header>

    <div class="container-fluid px-lg-5 mt-4">
        <div class="row">
            
            <%-- 사이드바 --%>
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
            
            <%-- 메인 컨텐츠 --%>
            <div class="col-lg-8 col-12">
                
                <%-- [1] MY TEAMS 영역 --%>
                <div class="mb-5">
                    <div class="d-flex align-items-center justify-content-between mb-2 px-1">
                        <div class="d-flex align-items-center">
                            <h3 class="fw-black mb-0" style="color: #111; font-weight: 900; letter-spacing: -0.5px;">MY TEAMS</h3>
                            <c:if test="${not empty myTeams}"><span class="count-badge">${fn:length(myTeams)}</span></c:if>
                        </div>
                        <c:if test="${not empty myTeams}">
                            <a href="${pageContext.request.contextPath}/team/write" class="text-decoration-none text-muted small fw-bold hover-underline"><i class="bi bi-plus-lg me-1"></i>구단 추가</a>
                        </c:if>
                    </div>

                    <c:choose>
                        <c:when test="${not empty myTeams}">
                            <div class="my-team-scroll-container">
                                <c:forEach var="team" items="${myTeams}">
                                    <a href="${pageContext.request.contextPath}/myteam/main?teamCode=${team.team_code}" class="my-team-card-item">
                                        <div class="my-team-emblem">
                                            <img src="${pageContext.request.contextPath}${not empty team.emblem_image ? '/uploads/team/'.concat(team.emblem_image) : '/dist/images/emblem.png'}" onerror="this.src='${pageContext.request.contextPath}/dist/images/emblem.png'">
                                        </div>
                                        <div class="my-team-name">${team.team_name}</div>
                                        <div class="my-team-region"><i class="bi bi-geo-alt me-1"></i>${team.region}</div>
                                        <span class="btn-enter">입장하기</span>
                                    </a>
                                </c:forEach>
                                <a href="${pageContext.request.contextPath}/team/write" class="my-team-card-item add-team-card">
                                    <div class="mb-2"><i class="bi bi-plus-circle-dotted fs-1"></i></div>
                                    <div style="font-weight: 700; font-size: 0.9rem;">새 구단 만들기</div>
                                </a>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="bg-light rounded-4 p-5 text-center border">
                                <i class="bi bi-emoji-smile fs-1 text-secondary opacity-50 mb-3 d-block"></i>
                                <h5 class="fw-bold text-dark mb-2">아직 가입한 구단이 없으시네요!</h5>
                                <p class="text-secondary small mb-4">나만의 팀을 만들거나 멋진 팀에 가입해보세요.</p>
                                <button class="btn btn-dark rounded-pill px-5 py-2 fw-bold shadow-sm" style="color: #D4F63F;" onclick="location.href='${pageContext.request.contextPath}/team/write'">구단 생성 하러 가기 &rarr;</button>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>

                <%-- [2] 검색 및 정렬 바 --%>
                <div class="d-flex flex-column flex-md-row justify-content-between align-items-center mb-4 gap-3">
                    <div class="search-bar-wrapper w-100 position-relative">
                        <%-- 돋보기 아이콘에 클릭 ID 추가됨 --%>
                        <i class="bi bi-search position-absolute ms-3 text-muted" 
                           id="btnSearchIcon" 
                           style="cursor: pointer; top: 50%; transform: translateY(-50%); z-index: 10;"></i>
                        <input type="text" id="searchInput" class="form-control rounded-pill ps-5 py-2 border-0 shadow-sm" placeholder="구단명, 지역으로 검색해보세요">
                    </div>
                    
                    <div class="d-flex gap-2 w-100 w-md-auto justify-content-end">
                        <%-- 정렬 Select --%>
                        <select id="sortSelect" class="form-select rounded-pill border-0 shadow-sm" style="width: 140px; cursor: pointer;">
                            <option selected value="">최신순</option>
                            <option value="1">인원 많은순</option>
                            <option value="2">좋아요 순</option>
                        </select>
                        <button class="btn btn-dark rounded-pill px-4 text-nowrap" onclick="location.href='${pageContext.request.contextPath}/team/write'">
                            <i class="bi bi-plus-lg me-1" ></i> 구단 생성
                        </button>
                    </div>
                </div>

                <%-- [3] 전체 구단 리스트 (AJAX) --%>
                <div class="row g-4" id="teamList"> 
                     <jsp:include page="/WEB-INF/views/team/teamList.jsp"/>
                </div>

                <%-- 더보기 버튼 --%>
                <div class="text-center mt-5 mb-5">
                    <button id="loadMoreBtn" class="btn btn-light rounded-pill px-5 py-2 shadow-sm text-muted fw-bold hover-scale">
                        더보기 <i class="bi bi-chevron-down ms-1"></i>
                    </button>
                </div>

            </div>
            <div class="col-lg-2 d-none d-lg-block"></div>
        </div>
    </div>

    <footer><jsp:include page="/WEB-INF/views/layout/footer.jsp"/></footer>
    <jsp:include page="/WEB-INF/views/layout/footerResources.jsp"/>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    
    <script type="text/javascript">
    // [1] 뒤로가기로 왔을 때 페이지 강제 새로고침 (좋아요 숫자 최신화)
    window.addEventListener('pageshow', function(event) {
        if (event.persisted || (window.performance && window.performance.navigation.type === 2)) {
            location.reload();
        }
    });
    
    // 전역 변수
    let currentPage = 1;
    let currentTotalPage = ${totalPage}; 

    function getSort(){ return $('#sortSelect').val(); }
    function getKeyword(){ return $('#searchInput').val().trim(); }
    
    // [2] 리스트 초기화 및 로드 함수 (정렬, 검색 시 호출)
    function resetAndLoad() {
        $('#teamList').empty();   // 기존 리스트 삭제
        currentPage = 1;          // 1페이지로 초기화
        $('#loadMoreBtn').hide(); 
        loadContent(1);           // 데이터 요청
    }
    
    $(function() {
        // 정렬 값 변경 시 -> resetAndLoad 실행 (여기가 정렬 트리거입니다!)
        $('#sortSelect').on('change', function() {
            resetAndLoad();
        });
        
        // 검색 엔터키
        $('#searchInput').on('keydown', function(e){
            if(e.key === 'Enter'){
                e.preventDefault();
                resetAndLoad();
            }
        });

        // 돋보기 아이콘 클릭
        $('#btnSearchIcon').on('click', function() {
            resetAndLoad();
        });

        // 더보기 버튼
        $('#loadMoreBtn').click(function() {
            if (currentPage < currentTotalPage) {
                loadContent(currentPage + 1);
            }
        });

        if(currentTotalPage <= 1) {
            $('#loadMoreBtn').hide();
        }
    });

    // [3] AJAX 데이터 요청 (정렬 값 sort를 서버로 전송)
    function loadContent(pageNo) {
        const keyword = getKeyword();
        const sort = getSort(); // 선택된 정렬값 (1, 2) 가져오기
        
        $.ajax({
            url : "${pageContext.request.contextPath}/team/listMore", 
            type : 'get',
            data : {
                pageNo : pageNo,
                keyword : keyword,
                sort : sort // ★ 컨트롤러로 정렬 기준(1 또는 2) 전송
            },
            dataType : 'html',
            success : function(html) {
                if(html.indexOf('name="member_id"') > -1 && html.indexOf('<title>Footlog</title>') > -1) {
                     alert("로그인이 필요합니다.");
                     location.href = "${pageContext.request.contextPath}/member/login";
                     return;
                }

                $('#teamList').append(html); 
                
                const $newTotal = $('#teamList').find('#ajaxTotalPage').last();
                if($newTotal.length > 0) {
                    currentTotalPage = parseInt($newTotal.val());
                    $newTotal.remove(); 
                }
                
                if(pageNo >= currentTotalPage || currentTotalPage === 0) {
                    $('#loadMoreBtn').hide();
                } else {
                    $('#loadMoreBtn').show();
                }
                currentPage = pageNo;
            },
            error : function() {
                alert('데이터를 불러오지 못했습니다.');
            }
        });
    }

    // 좋아요
    function toggleLike(element, teamCode, event) {
        if(event) { event.stopPropagation(); event.preventDefault(); }
        
        const $btn = $(element);
        const $count = $btn.find('.count');
        let userLiked = ($btn.attr('data-liked') == "1");
        
        $.ajax({
            type: "POST",
            url: "${pageContext.request.contextPath}/team/insertTeamLike",
            data: { team_code: teamCode, user_Liked: userLiked.toString() },
            dataType: "json",
            success: function(data) {
                if (data.state === "login_required") {
                    if(confirm("로그인이 필요합니다. 이동하시겠습니까?")) location.href = "${pageContext.request.contextPath}/member/login";
                    return;
                }
                if (data.state === "true") {
                    // 숫자만 업데이트
                    $count.text(data.teamLikeCount);
                    
                    
                    if (userLiked) {
                        $btn.attr('data-liked', "0");
                    } else {
                        $btn.attr('data-liked', "1");
                    }
                }
            },
            error: function(e) { console.log(e); }
        });
    }
    </script>
</body>
</html>