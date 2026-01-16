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

    <%-- 스타일 추가 --%>
    <style>
        :root {
            --neon-color: #D4F63F;
            --dark-black: #111;
        }

        /* 가로 스크롤 컨테이너 */
        .my-team-scroll-container {
            display: flex;
            gap: 16px;
            overflow-x: auto;
            padding: 10px 5px 25px 5px;
            scroll-behavior: smooth;
        }
        
        /* 스크롤바 커스텀 */
        .my-team-scroll-container::-webkit-scrollbar { height: 6px; }
        .my-team-scroll-container::-webkit-scrollbar-track { background: #f0f0f0; border-radius: 3px; }
        .my-team-scroll-container::-webkit-scrollbar-thumb { background: #d1d1d1; border-radius: 3px; }
        .my-team-scroll-container::-webkit-scrollbar-thumb:hover { background: #888; }

        /* 카드 아이템 스타일 (화이트 버전) */
        .my-team-card-item {
            flex: 0 0 auto;
            width: 200px;
            background: #fff;
            border: 1px solid #e5e5e5;
            border-radius: 20px;
            padding: 24px 16px;
            text-align: center;
            transition: all 0.3s cubic-bezier(0.25, 0.8, 0.25, 1);
            position: relative;
            cursor: pointer;
            text-decoration: none;
            box-shadow: 0 4px 6px rgba(0,0,0,0.02);
        }

        /* 호버 효과 */
        .my-team-card-item:hover {
            transform: translateY(-5px);
            border-color: var(--dark-black);
            box-shadow: 0 12px 20px rgba(0,0,0,0.1);
        }
        .my-team-card-item:hover::after {
            content: '';
            position: absolute;
            bottom: -5px; left: 10%; width: 80%; height: 5px;
            background: var(--neon-color);
            filter: blur(8px);
            opacity: 0.7;
            border-radius: 50%;
        }

        /* 엠블럼 이미지 */
        .my-team-emblem {
            width: 72px; height: 72px;
            border-radius: 50%;
            overflow: hidden;
            border: 2px solid #f0f0f0;
            margin: 0 auto 16px auto;
            transition: 0.3s;
            background: #fff;
            position: relative;
        }
        .my-team-card-item:hover .my-team-emblem {
            border-color: var(--neon-color);
        }
        .my-team-emblem img { width: 100%; height: 100%; object-fit: cover; }

        /* 텍스트 스타일 */
        .my-team-name {
            color: #222;
            font-weight: 800;
            font-size: 1.05rem;
            margin-bottom: 4px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            letter-spacing: -0.5px;
        }
        .my-team-region {
            color: #888;
            font-size: 0.8rem;
            margin-bottom: 18px;
            font-weight: 500;
        }
        
        /* 버튼 스타일 */
        .btn-enter {
            background: #f8f9fa;
            color: #333;
            border: 1px solid #eee;
            border-radius: 12px;
            font-size: 0.8rem;
            padding: 8px 0;
            font-weight: 700;
            transition: 0.2s;
            width: 100%;
            display: block;
        }
        .my-team-card-item:hover .btn-enter {
            background: var(--dark-black);
            color: var(--neon-color);
            border-color: var(--dark-black);
        }

        /* 팀 추가 카드 */
        .add-team-card {
            border: 2px dashed #ddd;
            background: #fafafa;
            color: #aaa;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }
        .add-team-card:hover {
            border-color: var(--dark-black);
            color: var(--dark-black);
            background: #fff;
            transform: translateY(-5px);
        }

        /* 카운트 뱃지 */
        .count-badge {
            background: var(--dark-black);
            color: var(--neon-color);
            font-size: 0.85rem;
            font-weight: 800;
            padding: 2px 10px;
            border-radius: 12px;
            margin-left: 8px;
            vertical-align: middle;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
    </style>
</head>

<jsp:include page="/WEB-INF/views/layout/headerResources.jsp"/>

<body>

    <header>
       <jsp:include page="/WEB-INF/views/layout/header.jsp"/>
    </header>

    <div class="container-fluid px-lg-5 mt-4">
        <div class="row">
            
            <%-- 사이드바 영역 --%>
            <div class="col-lg-2 d-none d-lg-block">
                <div class="sidebar-menu sticky-top" style="top: 100px;">
                    <div class="mb-4">
                        <p class="sidebar-title">구단</p>
                        <div class="list-group">
                            <%-- 1. 기본 메뉴 --%>
                            <a href="${pageContext.request.contextPath}/myteam/main" class="list-group-item list-group-item-action">내 구단 이동</a>
                            <a href="${pageContext.request.contextPath}/team/list" class="list-group-item list-group-item-action active-menu">전체 구단 리스트</a>
                            
                            <%-- 가입 신청 관리 제거됨 --%>
                        </div>
                    </div>
                </div>
            </div>
            
            <%-- 메인 컨텐츠 --%>
            <div class="col-lg-8 col-12">
                
                <%-- ========================================== --%>
                <%-- [1] MY TEAMS 카드 슬라이더 영역 --%>
                <%-- ========================================== --%>
                <div class="mb-5">
                    <%-- 헤더 --%>
                    <div class="d-flex align-items-center justify-content-between mb-2 px-1">
                        <div class="d-flex align-items-center">
                            <h3 class="fw-black mb-0" style="color: #111; font-weight: 900; letter-spacing: -0.5px;">MY TEAMS</h3>
                            <%-- 카운트 뱃지 --%>
                            <c:if test="${not empty myTeams}">
                                <span class="count-badge">${fn:length(myTeams)}</span>
                            </c:if>
                        </div>
                        
                        <%-- 팀이 있을 때만 + 버튼 표시 --%>
                        <c:if test="${not empty myTeams}">
                            <a href="${pageContext.request.contextPath}/team/write" class="text-decoration-none text-muted small fw-bold hover-underline">
                                <i class="bi bi-plus-lg me-1"></i>구단 추가
                            </a>
                        </c:if>
                    </div>

                    <%-- 카드 슬라이더 로직 --%>
                    <c:choose>
                        <c:when test="${not empty myTeams}">
                            <div class="my-team-scroll-container">
                                <c:forEach var="team" items="${myTeams}">
                                    
                                    <%-- 카드 아이템 --%>
                                    <a href="${pageContext.request.contextPath}/myteam/main?teamCode=${team.team_code}" class="my-team-card-item">
									    <div class="my-team-emblem">
									        <img src="${pageContext.request.contextPath}${not empty team.emblem_image ? '/uploads/team/'.concat(team.emblem_image) : '/dist/images/emblem.png'}" 
									             onerror="this.src='${pageContext.request.contextPath}/dist/images/emblem.png'">
									    </div>
									    <div class="my-team-name">${team.team_name}</div>
									    <div class="my-team-region"><i class="bi bi-geo-alt me-1"></i>${team.region}</div>
									    <span class="btn-enter">입장하기</span>
									</a>

                                </c:forEach>
                                
                                <%-- 맨 끝에 구단 추가 카드 배치 --%>
                                <a href="${pageContext.request.contextPath}/team/write" class="my-team-card-item add-team-card">
                                    <div class="mb-2"><i class="bi bi-plus-circle-dotted fs-1"></i></div>
                                    <div style="font-weight: 700; font-size: 0.9rem;">새 구단 만들기</div>
                                </a>
                            </div>
                        </c:when>

                        <c:otherwise>
                            <%-- 팀이 없을 때 --%>
                            <div class="bg-light rounded-4 p-5 text-center border">
                                <i class="bi bi-emoji-smile fs-1 text-secondary opacity-50 mb-3 d-block"></i>
                                <h5 class="fw-bold text-dark mb-2">아직 가입한 구단이 없으시네요!</h5>
                                <p class="text-secondary small mb-4">나만의 팀을 만들거나 멋진 팀에 가입해보세요.</p>
                                
                                <button class="btn btn-dark rounded-pill px-5 py-2 fw-bold shadow-sm" style="color: #D4F63F;" 
                                        onclick="location.href='${pageContext.request.contextPath}/team/write'">
                                    구단 생성 하러 가기 &rarr;
                                </button>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
                <%-- // MY TEAMS 영역 끝 --%>


                <%-- ========================================== --%>
                <%-- [2] 검색 및 정렬 바 --%>
                <%-- ========================================== --%>
                <div class="d-flex flex-column flex-md-row justify-content-between align-items-center mb-4 gap-3">
                    <div class="search-bar-wrapper w-100">
                        <i class="bi bi-search position-absolute ms-3 text-muted"></i>
                        <input type="text" id="searchInput" class="form-control rounded-pill ps-5 py-2 border-0 shadow-sm" placeholder="구단명, 지역으로 검색해보세요">
                    </div>
                    
                    <div class="d-flex gap-2 w-100 w-md-auto justify-content-end">
                        <select id="sortSelect" class="form-select rounded-pill border-0 shadow-sm" style="width: 120px;">
                            <option selected value="">최신순</option>
                            <option value="1">인원 많은순</option>
                            <option value="2">좋아요 순</option>
                        </select>
                        <button class="btn btn-dark rounded-pill px-4 text-nowrap" onclick="location.href='${pageContext.request.contextPath}/team/write'">
                            <i class="bi bi-plus-lg me-1" ></i> 구단 생성
                        </button>
                    </div>
                </div>

                <%-- ========================================== --%>
                <%-- [3] 전체 구단 리스트 (AJAX 로드) --%>
                <%-- ========================================== --%>
                <div class="row g-4" id="teamList"> 
				     <jsp:include page="/WEB-INF/views/team/teamList.jsp"/>
				</div>

                <div class="text-center mt-5 mb-5">
                    <button id="loadMoreBtn" class="btn btn-light rounded-pill px-5 py-2 shadow-sm text-muted fw-bold hover-scale">
                        더보기 <i class="bi bi-chevron-down ms-1"></i>
                    </button>
                </div>

            </div> <%-- // Main Content (col-lg-8) 끝 --%>
            
            <div class="col-lg-2 d-none d-lg-block"></div>
        
        </div> <%-- // row 끝 --%>
    </div> <%-- // container 끝 --%>

    <footer>
       <jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
    </footer>
    
    <jsp:include page="/WEB-INF/views/layout/footerResources.jsp"/>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    
    <script type="text/javascript">
	    // 전역 변수로 현재 페이지와 총 페이지 관리
	    let currentPage = 1;
	    let currentTotalPage = ${totalPage}; // 초기 로딩 시 값
	
	    function getSort(){ return $('#sortSelect').val(); }
	    function getKeyword(){ return $('#searchInput').val().trim(); }
	    
	    // 정렬/검색 시 초기화 함수
	    function resetAndLoad() {
	        $('#teamList').empty(); // 비우기
	        currentPage = 1;        // 1페이지로 리셋
	        $('#loadMoreBtn').hide(); // 로딩 중엔 버튼 숨김
	        
	        loadContent(1);
	    }
	    
	    // 이벤트 리스너
	    $('#sortSelect').on('change', resetAndLoad);
	    $('#searchInput').on('keydown', function(e){
	        if(e.key === 'Enter'){
	            e.preventDefault();
	            resetAndLoad();
	        }
	    });
	
	    // AJAX 로드 함수
	    function loadContent(pageNo) {
	        const keyword = getKeyword();
	        const sort = getSort();
	        
	        $.ajax({
	            url : "${pageContext.request.contextPath}/team/listMore",
	            type : 'get',
	            data : {
	                pageNo : pageNo,
	                keyword : keyword,
	                sort : sort
	            },
	            dataType : 'html',
	            success : function(html) {
	                // 1. 데이터 추가
	                $('#teamList').append(html); 
	                
	                // 2. ★ 중요: AJAX로 받아온 HTML 안에 숨겨진 totalPage 값을 찾아서 업데이트
	                const $newTotal = $('#teamList').find('#ajaxTotalPage').last();
	                if($newTotal.length > 0) {
	                    currentTotalPage = parseInt($newTotal.val());
	                    // 읽은 후 태그는 지워줌 (깔끔하게)
	                    $newTotal.remove(); 
	                }
	                
	                // 3. 더보기 버튼 보이기/숨기기 판단
	                if(pageNo >= currentTotalPage || currentTotalPage === 0) {
	                    $('#loadMoreBtn').hide(); // 더 이상 갈 곳이 없으면 숨김
	                } else {
	                    $('#loadMoreBtn').show(); // 아직 남았으면 보임
	                }
	                
	                // 페이지 번호 업데이트
	                currentPage = pageNo;
	            },
	            error : function() {
	                alert('목록을 불러오는데 실패했습니다.');
	            }
	        });
	    }
	
	    $(function() {
	        // 초기 로딩 시 버튼 처리
	        if(currentTotalPage <= 1) {
	            $('#loadMoreBtn').hide();
	        }
	
	        // 더보기 버튼 클릭
	        $('#loadMoreBtn').click(function() {
	            if (currentPage < currentTotalPage) {
	                loadContent(currentPage + 1);
	            }
	        });
	    });
	
	    // 좋아요 토글 함수 (기존 유지)
	    function toggleLike(element, teamCode, event) {
	        if(event) { event.stopPropagation(); event.preventDefault(); }
	        
	        const $btn = $(element);
	        const $icon = $btn.find('i');
	        const $count = $btn.find('.count');
	        let userLiked = ($btn.attr('data-liked') == "1");
	        
	        $.ajax({
	            type: "POST",
	            url: "${pageContext.request.contextPath}/team/insertTeamLike",
	            data: { team_code: teamCode, user_Liked: userLiked.toString() },
	            dataType: "json",
	            beforeSend: function(xhr) { xhr.setRequestHeader("AJAX", "true"); },
	            success: function(data) {
	                if (data.state === "login_required") {
	                    if(confirm("로그인이 필요합니다. 이동하시겠습니까?")) location.href = "${pageContext.request.contextPath}/member/login";
	                    return;
	                }
	                if (data.state === "true") {
	                    $count.text(data.teamLikeCount);
	                    if (userLiked) {
	                        $btn.attr('data-liked', "0");
	                        $icon.removeClass('text-warning').addClass('text-secondary');
	                    } else {
	                        $btn.attr('data-liked', "1");
	                        $icon.removeClass('text-secondary').addClass('text-warning');
	                    }
	                }
	            },
	            error: function(e) {
	                if(e.status === 403) {
	                     if(confirm("로그인이 필요합니다. 이동하시겠습니까?")) location.href = "${pageContext.request.contextPath}/member/login";
	                }
	            }
	        });
	    }
	</script>
</body>
</html>