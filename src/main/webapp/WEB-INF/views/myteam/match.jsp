<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html>
<head>
    <title>Footlog - Match Schedule</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <jsp:include page="/WEB-INF/views/layout/headerResources.jsp"/>
    
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/style.css?ver=1">
    
    <style>
        .modern-card {
            border: none;
            border-radius: 20px;
            background: #fff;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
            transition: transform 0.2s ease;
            margin-bottom: 20px;
            overflow: hidden;
        }
        .modern-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
        }

        .match-date-box { 
            background-color: #f8f9fa;
            border: 1px solid #eee;
            border-radius: 15px;
            padding: 15px 10px;
            text-align: center;
            min-width: 90px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.03);
        }
        .match-month { display: block; font-size: 0.9rem; color: #666; margin-bottom: 2px; }
        .match-day { display: block; font-size: 1.6rem; font-weight: 800; color: #333; line-height: 1; }
        
        .match-time { 
            display: block; 
            font-size: 0.95rem; 
            font-weight: 800; 
            color: #0d6efd;
            margin-top: 5px;
            background: #e7f1ff; 
            border-radius: 8px;
            padding: 3px 0;
        }

        .hover-filled:hover { background-color: var(--bs-primary); color: white; }
        .grayscale { filter: grayscale(100%); opacity: 0.7; }
        
        .paginate { display: flex; justify-content: center; gap: 5px; margin-top: 20px; }
        .paginate a, .paginate span { 
            padding: 8px 12px; border-radius: 50%; cursor: pointer; text-decoration: none; color: #333; 
            transition: background-color 0.2s;
        }
        .paginate span { background-color: var(--bs-primary); color: white; font-weight: bold; cursor: default; }
        .paginate a:hover { background-color: #e9ecef; }
        
        .status-badge-area { padding: 5px 12px; border-radius: 30px; font-size: 0.8rem; font-weight: 600; }
    </style>
</head>

<body>

    <header>
       <jsp:include page="/WEB-INF/views/layout/teamheader.jsp"/>
    </header>

    <div class="container-fluid px-lg-5 mt-4">
        <div class="row">
            <div class="col-lg-2 d-none d-lg-block">
                <div class="sidebar-menu sticky-top" style="top: 100px;">
                    <div class="mb-4">
                        <p class="sidebar-title">구단 관리</p>
                        <div class="list-group">
                            <a href="${pageContext.request.contextPath}/myteam/update?teamCode=${sessionScope.currentTeamCode}" class="list-group-item list-group-item-action">구단 프로필 수정</a>
                            <c:if test="${myRoleLevel >= 10}">
                                <a href="${pageContext.request.contextPath}/myteam/teamUpdate?teamCode=${sessionScope.currentTeamCode}" class="list-group-item list-group-item-action">구단 정보 수정</a>
                            </c:if>
                            <a href="${pageContext.request.contextPath}/myteam/squad?teamCode=${teamCode}" class="list-group-item list-group-item-action">
                                <c:choose>
                                    <c:when test="${myRoleLevel >= 10}">스쿼드(선수) 관리</c:when>
                                    <c:otherwise>구단 스쿼드</c:otherwise>
                                </c:choose>
                            </a>
                            <a href="${pageContext.request.contextPath}/myteam/match?teamCode=${teamCode}" class="list-group-item list-group-item-action active-menu fw-bold bg-light text-primary">매치 관리</a>
                            <c:if test="${myRoleLevel >= 10}">
                                <a href="${pageContext.request.contextPath}/myteam/requestList?teamCode=${teamCode}" class="list-group-item list-group-item-action">가입 신청 관리</a>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-lg-10 col-12">
                <div class="d-flex justify-content-between align-items-end mb-4">
                    <div>
                        <h2 class="fw-bold mb-1">매치 일정 / 투표</h2>
                        <span class="text-muted">다가오는 경기 일정을 확인하고 참석 여부를 투표해주세요.</span>
                    </div>
                    <button class="btn btn-dark rounded-pill px-4 fw-bold" onclick="location.href='${pageContext.request.contextPath}/match/write'">
                        <i class="bi bi-plus-lg me-1"></i> 매치 등록
                    </button>
                </div>

                <ul class="nav nav-tabs border-bottom-0 mb-3 gap-2">
                    <li class="nav-item">
                        <a class="nav-link active bg-dark text-white rounded-pill px-4 fw-bold" href="#">전체 일정</a>
                    </li>
                </ul>

                <div class="row g-3" id="match-list-container"></div>
                
                <div id="list-page" class="paginate text-center mt-5 mb-5"></div>

            </div>
        </div> 
    </div>

    <footer>
       <jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
    </footer>
    
    <jsp:include page="/WEB-INF/views/layout/footerResources.jsp"/>

    <template id="match-template">
        <div class="col-12 match-item">
            <div class="modern-card p-4 hover-scale transition-card bg-white match-card-body">
                <div class="d-flex flex-column flex-md-row gap-4 align-items-center">
                    
                    <div class="match-date-box">
                        <span class="match-month"></span>
                        <span class="match-day"></span>
                        <span class="match-time"></span>
                    </div>

                    <div class="flex-grow-1 text-center text-md-start w-100">
                        <div class="mb-2">
                            <span class="status-badge-area badge"></span>
                            <h4 class="fw-bold mb-1 mt-2">VS <span class="opponent-name"></span></h4>
                            <p class="text-muted small mb-0">
                                <i class="bi bi-geo-alt-fill me-1 text-danger"></i> <span class="stadium-name"></span>
                            </p>
                        </div>
                        
                        <div class="progress-area mt-3" style="display:none;">
                            <div class="d-flex justify-content-between small text-muted mb-1">
                                <span class="fw-bold">📢 참석 현황</span>
                                <span class="text-primary fw-bold attendance-text">진행중</span>
                            </div>
                            <div class="progress" style="height: 10px; border-radius: 5px;">
                                <div class="progress-bar bg-success progress-bar-striped progress-bar-animated attendance-bar" role="progressbar" style="width: 0%;"></div>
                            </div>
                            <div class="alert-msg text-danger mt-1 small fw-bold" style="display:none;">
                                <i class="bi bi-exclamation-circle"></i> 11명까지 <span class="remain-count"></span>명 남음!
                            </div>
                        </div>
                    </div>

                    <div class="d-flex w-100 w-md-auto justify-content-center mt-3 mt-md-0 btn-area" style="min-width: 200px; justify-content: flex-end;"></div>
                </div>
            </div>
        </div>
    </template>

    <script>
        const contextPath = "${pageContext.request.contextPath}";
        const currentTeamCode = "${teamCode}";
    </script>
    
    <script>
        function pagingMethod(current_page, total_page, methodName) {
            if(total_page === 0) return "";

            let html = "";
            
            for(let i = 1; i <= total_page; i++) {
                if(i === current_page) {
                    html += "<span>" + i + "</span>";
                } else {
                    html += "<a onclick='" + methodName + "(" + i + ")'>" + i + "</a>";
                }
            }
            return html;
        }
    </script>

    <script src="${pageContext.request.contextPath}/dist/js2/teamMatch.js"></script>

</body>
</html>