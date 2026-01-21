<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>구단 가입 신청 현황 | Footlog</title>
    
    <jsp:include page="/WEB-INF/views/layout/headerResources.jsp" />
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/style.css?ver=2">
    
    <style>
        /* 테이블 스타일 */
        .table th { 
            background-color: #f8f9fa;
            border-bottom: 2px solid #dee2e6;
            vertical-align: middle; 
            font-weight: 600; 
            color: #495057;
            padding: 15px;
        }
        .table td { 
            vertical-align: middle; 
            padding: 15px;
            background-color: #ffffff;
        }
        
        /* 빈 리스트 안내 */
        .empty-list { 
            min-height: 400px;
            display: flex; 
            align-items: center; 
            justify-content: center; 
            flex-direction: column; 
            color: #adb5bd; 
        }
        
        /* 카드 스타일 */
        .request-card { 
            border: none; 
            box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.15);
            border-radius: 0.35rem; 
            overflow: hidden; 
        }

        .position-select { min-width: 120px; }
        
        .page-title-box {
            border-left: 5px solid #0d6efd;
            padding-left: 15px;
            margin-bottom: 30px;
        }

        /* 사이드바 스타일 */
        .sidebar-title { font-size: 0.85rem; font-weight: 700; color: #6c757d; text-transform: uppercase; letter-spacing: 0.5px; }
    </style>
</head>
<body>

    <header>
        <jsp:include page="/WEB-INF/views/layout/teamheader.jsp" />
    </header>

    <div class="container-fluid px-lg-5 mt-4">
        <div class="row">
            
            <div class="col-lg-2 d-none d-lg-block">
                <div class="sidebar-menu sticky-top" style="top: 100px;">
                    <div class="mb-4">
                        <p class="sidebar-title mb-3">구단 관리</p>
                        <div class="list-group">
                            <a href="${pageContext.request.contextPath}/myteam/update?teamCode=${sessionScope.currentTeamCode}" class="list-group-item list-group-item-action border-0">구단 프로필 수정</a>
                            
                            <c:if test="${myRoleLevel >= 10}">
                                <a href="${pageContext.request.contextPath}/myteam/teamUpdate?teamCode=${sessionScope.currentTeamCode}" class="list-group-item list-group-item-action border-0">구단 정보 수정</a>
                            </c:if>

                            <a href="${pageContext.request.contextPath}/myteam/squad?teamCode=${teamCode}" class="list-group-item list-group-item-action border-0">
                                <c:choose>
                                    <c:when test="${myRoleLevel >= 10}">스쿼드(선수) 관리</c:when>
                                    <c:otherwise>구단 스쿼드</c:otherwise>
                                </c:choose>
                            </a>
                            
                            <c:if test="${myRoleLevel >= 10}">
                                <a href="${pageContext.request.contextPath}/myteam/manage/match?teamCode=${teamCode}" class="list-group-item list-group-item-action border-0">매치 관리</a>
                                
                                <a href="${pageContext.request.contextPath}/myteam/requestList?teamCode=${teamCode}" class="list-group-item list-group-item-action border-0 active fw-bold bg-light text-primary">
                                    가입 신청 관리 
                                    <c:if test="${requestCount > 0}">
                                        <span class="badge bg-danger rounded-pill ms-1">${requestCount}</span>
                                    </c:if>
                                </a>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-lg-10 col-12">
                
                <div class="page-title-box">
                    <h3 class="fw-bold text-dark mb-1">가입 신청 현황</h3>
                    <p class="text-muted mb-0">새로운 멤버의 가입 신청을 확인하고 승인합니다.</p>
                </div>

                <div class="card request-card mb-5">
                    <div class="card-body p-0">
                        <div class="table-responsive">
                            <table class="table table-hover mb-0">
                                <thead>
                                    <tr>
                                        <th class="text-center" style="width: 80px;">번호</th>
                                        <th>신청자 정보</th>
                                        <th class="text-center">신청일</th>
                                        <th class="text-center" style="width: 220px;">포지션 배정</th> 
                                        <th class="text-center" style="width: 200px;">관리</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:choose>
                                        <c:when test="${empty list}">
                                            <tr>
                                                <td colspan="5" class="p-0 border-0">
                                                    <div class="empty-list">
                                                        <i class="bi bi-inbox fs-1 mb-3"></i>
                                                        <h5 class="fw-normal">대기 중인 가입 신청이 없습니다.</h5>
                                                    </div>
                                                </td>
                                            </tr>
                                        </c:when>
                                        <c:otherwise>
                                            <c:forEach var="dto" items="${list}" varStatus="status">
                                                <tr>
                                                    <td class="text-center text-muted">${status.count}</td>
                                                    <td>
                                                        <div class="d-flex align-items-center">
                                                            <div class="bg-light rounded-circle d-flex align-items-center justify-content-center me-3" style="width: 40px; height: 40px;">
                                                                <i class="bi bi-person-fill text-secondary fs-5"></i>
                                                            </div>
                                                            <div>
                                                                <div class="fw-bold text-dark">${dto.user_name}</div>
                                                                <div class="text-muted small">${dto.user_id}</div>
                                                            </div>
                                                        </div>
                                                    </td>
                                                    <td class="text-center text-secondary">${dto.created_at}</td>
                                                    
                                                    <td class="text-center">
                                                        <select class="form-select form-select-sm position-select mx-auto" id="pos_${dto.member_code}">
                                                            <option value="FW">공격수 (FW)</option>
                                                            <option value="MF">미드필더 (MF)</option>
                                                            <option value="DF">수비수 (DF)</option>
                                                            <option value="GK">골키퍼 (GK)</option>
                                                        </select>
                                                    </td>

                                                    <td class="text-center">
                                                        <div class="d-flex gap-2 justify-content-center">
                                                            <button type="button" class="btn btn-primary btn-sm"
                                                                    onclick="processJoin('${dto.member_code}', 2)">
                                                                승인
                                                            </button>
                                                            <button type="button" class="btn btn-outline-secondary btn-sm"
                                                                    onclick="processJoin('${dto.member_code}', 3)">
                                                                거절
                                                            </button>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </c:otherwise>
                                    </c:choose>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div> </div>
        </div>
    </div>

    <form name="joinProcessForm" action="${pageContext.request.contextPath}/myteam/processJoin" method="post">
        <input type="hidden" name="team_code" value="${team_code}">
        <input type="hidden" name="member_code">
        <input type="hidden" name="status">
        <input type="hidden" name="preferred_position">
    </form>

    <footer>
        <jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
    </footer>
    <jsp:include page="/WEB-INF/views/layout/footerResources.jsp"/>

    <script>
        function processJoin(memberCode, status) {
            const f = document.joinProcessForm;
            if (status === 3) {
                if (!confirm('해당 신청을 거절하시겠습니까?')) return;
                f.preferred_position.value = "";
            } else if (status === 2) {
                const selectBox = document.getElementById("pos_" + memberCode);
                const selectedPosition = selectBox.value;
                if (!confirm('해당 멤버를 [' + selectedPosition + '] 포지션으로 승인하시겠습니까?')) return;
                f.preferred_position.value = selectedPosition;
            }
            f.member_code.value = memberCode;
            f.status.value = status;
            f.submit();
        }
    </script>
</body>
</html>