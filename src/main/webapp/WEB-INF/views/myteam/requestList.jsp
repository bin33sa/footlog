<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>구단 가입 신청 현황 | Footlog</title>
    
    <jsp:include page="/WEB-INF/views/layout/headerResources.jsp" />
    
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">

    <style>
        /* [추가] 전체 페이지 폰트 적용 및 Bootstrap 기본 폰트 덮어쓰기 */
        body {
            font-family: 'Noto Sans KR', 'Apple SD Gothic Neo', 'Malgun Gothic', sans-serif !important;
        }

        /* 페이지 전용 스타일 */
        .empty-list { min-height: 300px; display: flex; align-items: center; justify-content: center; flex-direction: column; color: #6c757d; }
        .position-select { min-width: 120px; font-size: 0.9rem; }
        
        /* 테이블 스타일 보완 */
        .table th { background-color: #f8f9fa; vertical-align: middle; font-weight: 600; color: #495057; }
        .table td { vertical-align: middle; }
        
        /* 카드 스타일 개선 */
        .request-card { border: none; box-shadow: 0 0.125rem 0.25rem rgba(0, 0, 0, 0.075); border-radius: 0.5rem; overflow: hidden; }
        
        /* 헤더가 깨지는 것을 방지하기 위한 여백 조정 (필요 시) */
        header { z-index: 1030; } 
    </style>
</head>
<body class="d-flex flex-column min-vh-100 bg-light">

    <header>
        <jsp:include page="/WEB-INF/views/layout/teamheader.jsp" />
    </header>

    <div class="container my-5 flex-grow-1">
        <div class="row mb-4">
            <div class="col">
                <h2 class="fw-bold text-dark"><i class="bi bi-person-plus-fill me-2"></i>가입 신청 현황</h2>
                <p class="text-muted">우리 구단에 가입을 신청한 멤버들을 관리합니다.</p>
            </div>
        </div>

        <div class="row">
            <div class="col-12">
                <div class="card request-card">
                    <div class="card-body p-0">
                        <div class="table-responsive">
                            <table class="table table-hover mb-0">
                                <thead class="table-light border-bottom">
                                    <tr>
                                        <th class="p-3 text-center" style="width: 80px;">번호</th>
                                        <th class="p-3">신청자 정보</th>
                                        <th class="p-3 text-center">신청일</th>
                                        <th class="p-3 text-center" style="width: 200px;">포지션 배정</th> 
                                        <th class="p-3 text-center" style="width: 180px;">관리</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:choose>
                                        <c:when test="${empty list}">
                                            <tr>
                                                <td colspan="5" class="text-center py-5">
                                                    <div class="empty-list">
                                                        <i class="bi bi-inbox fs-1 mb-3"></i>
                                                        <h5>대기 중인 가입 신청이 없습니다.</h5>
                                                    </div>
                                                </td>
                                            </tr>
                                        </c:when>
                                        <c:otherwise>
                                            <c:forEach var="dto" items="${list}" varStatus="status">
                                                <tr>
                                                    <td class="text-center">${status.count}</td>
                                                    <td>
                                                        <div class="d-flex flex-column">
                                                            <span class="fw-bold text-dark">${dto.user_name}</span>
                                                            <span class="text-muted small">(${dto.user_id})</span>
                                                        </div>
                                                    </td>
                                                    <td class="text-center text-muted small">${dto.created_at}</td>
                                                    
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
                                                            <button type="button" class="btn btn-primary btn-sm px-3"
                                                                    onclick="processJoin('${dto.member_code}', 2)">
                                                                승인
                                                            </button>
                                                            <button type="button" class="btn btn-outline-danger btn-sm px-3"
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
                </div>
            </div>
        </div>
    </div>

    <form name="joinProcessForm" action="${pageContext.request.contextPath}/myteam/processJoin" method="post">
        <input type="hidden" name="team_code" value="${team_code}">
        
        <input type="hidden" name="member_code">
        <input type="hidden" name="status">
        <input type="hidden" name="preferred_position">
    </form>

    <jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
    
    <jsp:include page="/WEB-INF/views/layout/footerResources.jsp"/>

    <script>
        /**
         * 가입 승인/거절 처리
         */
        function processJoin(memberCode, status) {
            const f = document.joinProcessForm;

            // [거절] 로직
            if (status === 3) {
                if (!confirm('정말 거절하시겠습니까? \n(이 작업은 되돌릴 수 없습니다)')) {
                    return;
                }
                f.preferred_position.value = ""; // 거절 시 포지션 없음
            } 
            // [승인] 로직
            else if (status === 2) {
                // 해당 멤버의 select 박스 값 가져오기
                const selectBox = document.getElementById("pos_" + memberCode);
                const selectedPosition = selectBox.value;

                if (!confirm('해당 멤버를 [' + selectedPosition + '] 포지션으로 승인하시겠습니까?')) {
                    return;
                }
                f.preferred_position.value = selectedPosition;
            }

            // 폼 데이터 설정 및 전송
            f.member_code.value = memberCode;
            f.status.value = status;
            
            f.submit();
        }
    </script>
</body>
</html>