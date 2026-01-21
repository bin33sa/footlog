<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<title>Footlog - 내 매치 일정</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/style.css">

<style>
    /* 탭 스타일 */
    .nav-pills .nav-link { 
        color: #6c757d; font-weight: 600; padding: 12px 25px; border-radius: 50px; 
        background-color: #fff; border: 1px solid #dee2e6; margin-right: 10px; 
    }
    /* 활성화된 탭 스타일 */
    .nav-pills .nav-link.active { 
        background-color: #212529; color: #fff; border-color: #212529; box-shadow: 0 4px 10px rgba(0,0,0,0.2); 
    }
    .match-item { transition: transform 0.2s; }
    .match-item:hover { transform: translateY(-3px); }
</style>
</head>

<jsp:include page="/WEB-INF/views/layout/headerResources.jsp" />

<body class="bg-light">

    <header>
        <jsp:include page="/WEB-INF/views/layout/header.jsp" />
    </header>

    <div class="container-fluid px-lg-5 mt-5">
        <div class="row">
            
           <div class="col-lg-2 d-none d-lg-block">
                <div class="sidebar-menu sticky-top" style="top: 100px;">
                    <div class="mb-4">
                        <p class="sidebar-title">매치</p>
                        <div class="list-group">
                            <a href="${pageContext.request.contextPath}/match/myMatch" class="list-group-item list-group-item-action active-menu">내 매치 일정</a>
                            <a href="${pageContext.request.contextPath}/match/list" class="list-group-item list-group-item-action  ">전체 매치 리스트</a>
                            <c:if test="${canCreate}">
                                <a href="${pageContext.request.contextPath}/match/write" class="list-group-item list-group-item-action ">매치 개설하기</a>
                            </c:if>
                            
                            <a href="${pageContext.request.contextPath}/mercenary/list" class="list-group-item list-group-item-action ">용병 구하기</a>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-lg-9 col-12 ms-lg-4">
                
                <div class="d-flex justify-content-between align-items-end mb-5">
                    <div>
                        <h2 class="fw-bold mb-1">내 매치 관리</h2>
                        <p class="text-muted mb-0">참여 예정인 경기와 지난 기록을 관리하세요.</p>
                    </div>
                    <button class="btn btn-dark rounded-pill px-4 shadow-sm" onclick="location.href='${pageContext.request.contextPath}/match/write'">
                        <i class="bi bi-plus-lg me-1"></i> 매치 만들기
                    </button>
                </div>

                <ul class="nav nav-pills mb-4">
                    <li class="nav-item">
                        <a href="${pageContext.request.contextPath}/match/myMatch?tab=future" class="nav-link ${tab == 'future' ? 'active' : ''}">
                           🔥 예정된 매치
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="${pageContext.request.contextPath}/match/myMatch?tab=past" class="nav-link ${tab == 'past' ? 'active' : ''}">
                           🏁 지난 매치
                        </a>
                    </li>
                </ul>

                <div id="list-container">
                    
                    <c:if test="${empty list}">
                        <div class="text-center py-5 border rounded bg-white mt-2">
                            <i class="bi bi-exclamation-circle fs-1 text-muted opacity-50"></i>
                            <p class="text-muted mt-3 fw-bold">
                                ${tab == 'future' ? '예정된 매치 일정이 없습니다.' : '지난 매치 기록이 없습니다.'}
                            </p>
                        </div>
                    </c:if>

                    <c:forEach var="dto" items="${list}">
                        <fmt:parseDate value="${dto.match_date}" var="tempDate" pattern="yyyy-MM-dd HH:mm"/>

                        <div class="match-item modern-card p-3 mb-3 d-flex align-items-center gap-4 border rounded shadow-sm bg-white" 
                             onclick="location.href='${pageContext.request.contextPath}/match/article?match_code=${dto.match_code}&page=1'" 
                             style="cursor: pointer;">
                            
                            <div class="match-time-box text-center rounded-3 p-2 bg-light flex-shrink-0 border" style="min-width: 80px;">
                                <span class="d-block small text-muted fw-bold">
                                    <fmt:formatDate value="${tempDate}" pattern="MM.dd(E)"/>
                                </span> 
                                <span class="d-block fw-bold fs-5 text-dark">
                                    <fmt:formatDate value="${tempDate}" pattern="HH:mm"/>
                                </span>
                            </div>

                            <div class="flex-grow-1" style="min-width: 0;">
                                <div class="d-flex align-items-center gap-2 mb-1">
                                    <c:choose>
                                        <c:when test="${dto.status == '모집중'}">
                                            <span class="badge bg-primary text-dark rounded-pill border border-primary-subtle">모집중</span>
                                        </c:when>
                                        <c:when test="${dto.status == '매칭완료'}">
                                            <span class="badge bg-success text-white rounded-pill">매칭완료</span>
                                        </c:when>
                                        <c:when test="${tab=='past' &&  (empty dto.away_code ||dto.away_code==0)}">
                                        	<span class="badge bg-secondary text-white rounded-pill">매칭실패</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-secondary text-white rounded-pill">${dto.status}</span>
                                        </c:otherwise>
                                    </c:choose>
                                    <span class="badge bg-light text-secondary border">${dto.matchType}</span> 
                                    <span class="badge bg-light text-secondary border">${dto.gender}</span>
                                </div>
                                <h5 class="fw-bold mb-1 text-truncate" style="max-width:380px">${dto.title}</h5>
                                <p class="text-muted small mb-0 text-truncate">
                                    <i class="bi bi-geo-alt-fill me-1 text-danger"></i>${dto.stadiumName} | 호스트: ${dto.home_team_name}
                                </p>
                            </div>

                            <div class="text-end d-none d-md-block flex-shrink-0" style="min-width: 120px;">
                                <c:choose>
                                    <c:when test="${tab == 'future'}">
                                        <div class="d-block fw-bold text-primary mb-2">
                                            <c:if test="${dto.fee > 0}"><fmt:formatNumber value="${dto.fee}" type="currency"/></c:if>
                                            <c:if test="${dto.fee == 0}">무료</c:if>
                                        </div>
                                        <c:if test="${sessionScope.member.member_code == dto.member_code}">
                                            <button class="btn btn-sm btn-outline-danger rounded-pill px-3 fw-bold"
                                                    onclick="event.stopPropagation(); deleteMatch('${dto.match_code}');">매치 취소</button>
                                        </c:if>
                                    </c:when>

                                    <c:when test="${tab == 'past' &&(not empty dto.away_code && dto.away_code!=0)}">
                                        <div class="mb-2">
                                            <span class="badge bg-dark fs-6 px-3 py-1">${dto.home_score} : ${dto.away_score}</span>
                                        </div>
                                        <button class="btn btn-sm btn-dark rounded-pill px-3 fw-bold"
										    onclick="event.stopPropagation(); openScoreModal('${dto.match_code}', '${dto.home_score}', '${dto.away_score}', '${dto.home_team_name}', '${dto.away_team_name}');">
										    결과 입력
										</button>
                                    </c:when>
                                   
                                </c:choose>
                            </div>
                        </div>
                    </c:forEach>
                    
                </div>
            </div>
        </div>
    </div>

   <footer>
        <jsp:include page="/WEB-INF/views/layout/footer.jsp" />
    </footer>

    <div class="modal fade" id="scoreModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title fw-bold">경기 결과 입력</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                
                <form action="${ pageContext.request.contextPath}/match/updateScore" method="post">
                    <div class="modal-body text-center p-4">
                        <input type="hidden" name="match_code" id="modalMatchCode">
                        
                        <div class="d-flex justify-content-center align-items-center gap-3">
                            <div class="text-center">
                                <label class="form-label fw-bold d-block text-truncate" style="max-width: 100px;" id="modalHomeName">HOME</label>
                                <input type="number" name="home_score" id="modalHomeScore" class="form-control text-center fs-3 fw-bold" style="width: 80px;" min="0" value="0">
                            </div>
                            
                            <span class="fs-3 fw-bold text-muted px-2">:</span>
                            
                            <div class="text-center">
                                <label class="form-label fw-bold d-block text-truncate" style="max-width: 100px;" id="modalAwayName">AWAY</label>
                                <input type="number" name="away_score" id="modalAwayScore" class="form-control text-center fs-3 fw-bold" style="width: 80px;" min="0" value="0">
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer border-0 justify-content-center pb-4">
                        <button type="button" class="btn btn-light rounded-pill px-4" data-bs-dismiss="modal">취소</button>
                        <button type="button" class="btn btn-dark rounded-pill px-4" onclick="submitScore()">결과 저장</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <jsp:include page="/WEB-INF/views/layout/footerResources.jsp" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

    <script>
        function deleteMatch(matchCode) {
            if(confirm("정말로 이 매치를 취소하시겠습니까?")) {
                location.href = "${pageContext.request.contextPath}/match/delete?match_code=" + matchCode;
            }
        }

        function openScoreModal(matchCode, homeScore, awayScore, homeName, awayName) {
            $("#modalMatchCode").val(matchCode);
            $("#modalHomeScore").val(homeScore);
            $("#modalAwayScore").val(awayScore);
            $("#modalHomeName").text(homeName);
            $("#modalAwayName").text(awayName);

            var myModal = new bootstrap.Modal(document.getElementById('scoreModal'));
            myModal.show();
        }
        
        function submitScore(){
        	let home = $("#modalHomeScore").val();
        	let away = $("#modalAwayScore").val();
        	
        	if(home===""||away===""||parseInt(home)<0 || parseInt(away)<0){
        		alert('점수를 올바르게 입력해주세요. ');
        		return;
        	}
        	
        	if(!confirm("경기 결과를["+home+":"+away+"] 로 저장하시겠습니까?")){
        		return;
        	}
        	
        	
        	$("#scoreModal form").submit();
        	
        	
        	
        }
    </script>
    
</body>
</html>