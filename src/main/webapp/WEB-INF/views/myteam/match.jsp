<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html>
<head>
    <title>Footlog - 매치 일정</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <jsp:include page="/WEB-INF/views/layout/headerResources.jsp"/>
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/style.css?ver=2">
    
    <style>
        .sidebar-title { font-size: 0.85rem; font-weight: 700; color: #6c757d; text-transform: uppercase; letter-spacing: 0.5px; }
        
        .match-card {
            transition: transform 0.2s, box-shadow 0.2s;
            border: 1px solid #f1f3f5;
        }
        .match-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.05);
            border-color: #e9ecef;
        }
        
        .date-box {
            background-color: #f8f9fa;
            border-radius: 12px;
            width: 80px;
            height: 80px;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
        }
        .date-month { font-size: 0.85rem; font-weight: 700; color: #adb5bd; text-transform: uppercase; }
        .date-day { font-size: 1.8rem; font-weight: 800; color: #212529; line-height: 1; }
        
        .hover-filled:hover {
            background-color: #0d6efd;
            color: #fff !important;
        }
        
        .loading-spinner {
            display: none;
            text-align: center;
            padding: 50px;
        }
    </style>

    <script type="text/javascript">
        let currentTeamCode = "${teamCode}";
        let contextPath = "${pageContext.request.contextPath}";
    </script>
    
    <script src="${pageContext.request.contextPath}/dist/js2/teamMatch.js"></script>
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
                        <p class="sidebar-title mb-3">구단 커뮤니티</p>
                        <div class="list-group">
                            <a href="${pageContext.request.contextPath}/myteam/board?teamCode=${teamCode}" class="list-group-item list-group-item-action border-0">
                                팀 게시판
                            </a>
                            <a href="${pageContext.request.contextPath}/myteam/match?teamCode=${teamCode}" class="list-group-item list-group-item-action border-0 active fw-bold bg-light text-primary">
                                <i class="bi bi-calendar-week me-1"></i> 매치 일정
                            </a>
                            <a href="${pageContext.request.contextPath}/myteam/attendance?teamCode=${teamCode}" class="list-group-item list-group-item-action border-0">
                                참석 여부
                            </a>                            
                            <a href="${pageContext.request.contextPath}/myteam/gallery?teamCode=${teamCode}" class="list-group-item list-group-item-action border-0">
                                팀 갤러리
                            </a>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-lg-10 col-12">
                
                <div class="d-flex justify-content-between align-items-center mb-4 border-bottom pb-3">
                    <div>
                        <h2 class="fw-bold display-6 mb-1 text-dark">MATCH SCHEDULE</h2>
                        <p class="text-muted mb-0">팀의 경기 일정을 확인하고 참여를 신청하세요.</p>
                    </div>

                    <c:if test="${myRoleLevel > 0}">
                        <button type="button" class="btn btn-dark rounded-pill px-4 fw-bold shadow-sm" 
                                onclick="location.href='${pageContext.request.contextPath}/myteam/match_write?teamCode=${teamCode}'">
                            <i class="bi bi-plus-lg me-1"></i> 매치 생성
                        </button>
                    </c:if>
                </div>

                <div class="loading-spinner">
                    <div class="spinner-border text-primary" role="status">
                        <span class="visually-hidden">Loading...</span>
                    </div>
                </div>

                <div id="match-list-container" class="row g-4">
                    </div>

                <div id="list-page" class="d-flex justify-content-center mt-5 mb-5"></div>

            </div>
        </div> 
    </div>

    <footer>
       <jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
    </footer>
    
    <jsp:include page="/WEB-INF/views/layout/footerResources.jsp"/>

    <template id="match-template">
        <div class="col-12">
            <div class="card match-card p-4 border-0 rounded-4 bg-white">
                <div class="d-flex align-items-center flex-wrap gap-3">
                    
                    <div class="date-box shadow-sm">
                        <span class="date-month match-month">OCT</span>
                        <span class="date-day match-day">24</span>
                    </div>

                    <div class="flex-grow-1 ms-2">
                        <div class="mb-1">
                            <span class="status-badge-area badge bg-primary">모집중</span>
                            <span class="text-muted ms-2 small fw-bold">
                                <i class="bi bi-clock me-1"></i><span class="match-time">19:00</span>
                            </span>
                        </div>
                        <h4 class="fw-bold mb-1">
                            vs <span class="opponent-name">상대팀</span>
                        </h4>
                        <div class="text-muted small">
                            <i class="bi bi-geo-alt-fill text-danger me-1"></i>
                            <span class="stadium-name">서울 월드컵 경기장</span>
                        </div>
                    </div>

                    <div class="progress-area flex-grow-1 mx-3" style="min-width: 200px; display: none;">
                        <div class="d-flex justify-content-between mb-1 small">
                            <span class="text-muted fw-bold">참석 현황</span>
                            <span class="attendance-text">0명 / 11명 (0%)</span>
                        </div>
                        <div class="progress" style="height: 8px;">
                            <div class="progress-bar attendance-bar bg-success" role="progressbar" style="width: 0%"></div>
                        </div>
                        <div class="alert-msg mt-2 small text-danger fw-bold" style="display: none;">
                            </div>
                    </div>

                    <div class="btn-area text-end" style="min-width: 150px;">
                        </div>
                </div>
            </div>
        </div>
    </template>

</body>
</html>