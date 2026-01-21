<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>Footlog - Match Detail</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/style.css?v=<%=System.currentTimeMillis()%>">
</head>
<jsp:include page="/WEB-INF/views/layout/headerResources.jsp" />
<body class="bg-light">

	<header>
		<jsp:include page="/WEB-INF/views/layout/header.jsp" />
	</header>

	<div class="container-fluid px-lg-5 mt-4">
		<div class="row">
			<div class="col-lg-2 d-none d-lg-block">
				<div class="sidebar-menu sticky-top" style="top: 100px;">
					<div class="mb-4">
						<p class="sidebar-title">매치</p>
						<div class="list-group">
							<a href="${pageContext.request.contextPath}/match/myMatch"
								class="list-group-item list-group-item-action ">내 매치 일정</a> <a
								href="${pageContext.request.contextPath}/match/list"
								class="list-group-item list-group-item-action  active-menu">전체
								매치 리스트</a> <a href="${pageContext.request.contextPath}/match/write"
								class="list-group-item list-group-item-action ">매치 개설하기</a> <a
								href="${pageContext.request.contextPath}/mercenary/list"
								class="list-group-item list-group-item-action ">용병 구하기</a>
						</div>
					</div>
				</div>
			</div>

			<div class="col-lg-8 col-12">

				<div class="d-flex align-items-center justify-content-between mb-4">
					<div>
						<c:choose>
							<c:when test="${dto.status == '모집중'}">
								<span class="badge bg-primary text-dark rounded-pill mb-2 px-3 py-2 fw-bold">${dto.status}</span>
							</c:when>
							<c:when test="${dto.status == '마감임박'}">
								<span class="badge bg-danger text-white rounded-pill mb-2 px-3 py-2 fw-bold">${dto.status}</span>
							</c:when>
							<c:otherwise>
								<span class="badge bg-secondary text-white rounded-pill mb-2 px-3 py-2 fw-bold">${dto.status}</span>
							</c:otherwise>
						</c:choose>
						
						<h2 class="fw-bold mb-1">${dto.title}</h2>
						<div class="d-flex align-items-center text-muted gap-2">
							<span><i class="bi bi-eye me-1"></i> ${dto.view_count}</span> <span>•</span> 
							
							<span>주최팀: 
								<a href="${pageContext.request.contextPath}/team/view?team_code=${dto.home_code}" 
								   class="text-decoration-none fw-bold text-muted hover-underline">
									${dto.home_team_name}
								</a>
							</span>
						</div>
					</div>
					
					<button class="btn btn-light rounded-circle shadow-sm" onclick="openShareModal()">
						<i class="bi bi-share-fill"></i>
					</button>
				</div>

				<div class="card border-0 shadow-sm p-4 mb-4 bg-white">
					<table class="table table-borderless match-info-table mb-0">
						<tbody>
							<tr>
								<td class="text-muted fw-bold" style="width: 100px;">일시</td>
								<td class="fw-bold fs-5">${dto.match_date}</td>
							</tr>
							<tr>
							    <td class="text-muted fw-bold">구장</td>
							    <td class="fw-bold">
							    	<a href="${pageContext.request.contextPath}/field/view?stadiumCode=${dto.stadium_code}" 
							           class="text-primary text-decoration-underline">
							            ${dto.stadiumName}
							        </a>
							    </td>
							</tr>
							<tr>
								<td class="text-muted fw-bold">진행방식</td>
								<td class="fw-bold">${dto.matchType}</td>
							</tr>
							<tr>
								<td class="text-muted fw-bold">참가비</td>
								<td class="fw-bold text-primary"><fmt:formatNumber value="${dto.fee}"/>원</td>
							</tr>
							<tr>
								<td class="text-muted fw-bold">실력/성별</td>
								<td class="fw-bold">${dto.matchLevel} / ${dto.gender}</td>
							</tr>
						</tbody>
					</table>
				</div>

				<div class="card border-0 shadow-sm p-5 bg-white" style="min-height: 300px;">

					<h5 class="fw-bold mb-3">매치 소개</h5>
					<p class="text-muted mb-5" style="line-height: 1.8;">
						${dto.content}</p>

					<h5 class="fw-bold mb-3">위치 안내</h5>
					<div id="map" class="rounded-4 border shadow-sm w-100"
						style="height: 400px;"></div>

					<div class="d-flex justify-content-between align-items-center mt-5">
						<div class="d-flex gap-2">
							<c:if test="${sessionScope.member.member_code == dto.member_code || sessionScope.member.role_level > 0}">
								<button type="button" class="btn btn-outline-dark rounded-pill px-4 py-2 fw-bold hover-scale"
									onclick="location.href='${pageContext.request.contextPath}/match/update?match_code=${dto.match_code}&page=${page}'">
									수정</button>
								<button type="button" class="btn btn-outline-danger rounded-pill px-4 py-2 fw-bold hover-scale"
									onclick="deleteOk()">삭제</button>
							</c:if>
						</div>

						<div class="d-flex gap-2">
							<button type="button" class="btn btn-light rounded-pill px-4 py-2 fw-bold hover-scale"
								onclick="location.href='${pageContext.request.contextPath}/match/list?${query}'">
								목록으로</button>

							<c:if test="${sessionScope.member.member_code != dto.member_code}">
								<button type="button" class="btn btn-primary rounded-pill px-5 py-2 fw-bold shadow-sm hover-scale"
									onclick="apply()" ${dto.status=='모집완료'||dto.status=='매칭완료'? 'disabled':''}>
									<c:choose>
        								<c:when test="${dto.status == '모집완료' || dto.status == '매칭완료'}">
								            마감된 매치 <i class="bi bi-lock-fill ms-1"></i>
								        </c:when>
								        <c:otherwise>
								            매치 신청하기 <i class="bi bi-check-lg ms-1"></i>
								        </c:otherwise>
								    </c:choose>
								</button>
							</c:if>
						</div>
					</div>
				</div> 
				
				<c:if test="${sessionScope.member.member_code == dto.member_code}">
					<div class="card border-0 shadow-sm mt-4 bg-white">
						<div class="card-header bg-white border-bottom fw-bold py-3">
					        <i class="bi bi-people-fill me-2"></i>매치 신청 현황
					    </div>
					    
					    <div class="card-body p-0">
					        <div class="list-group list-group-flush">
					            
					            <c:if test="${empty applicantList}">
					                <div class="list-group-item text-center py-5 text-muted">
					                    <i class="bi bi-info-circle d-block fs-3 mb-2"></i>
					                    아직 신청한 팀이 없습니다.
					                </div>
					            </c:if>
			
					            <c:forEach var="apply" items="${applicantList}">
					                <div class="list-group-item d-flex justify-content-between align-items-center py-3">
					                    <div class="d-flex align-items-center">
					                        <div class="rounded-circle bg-light d-flex justify-content-center align-items-center me-3" style="width: 45px; height: 45px;">
					                            <i class="bi bi-shield-shaded text-secondary fs-5"></i>
					                        </div>
					                        <div>
					                        	<a href="${pageContext.request.contextPath}/team/view?team_code=${apply.team_code}" 
  												 class="fw-bold d-block text-decoration-none link-dark hover-underline">
												    ${apply.team_name}
												</a>
					                        </div>
					                    </div>
					                    
					                  <div class="ms-auto"> 
						                    <c:choose>
						                        <c:when test="${dto.status == '모집중'}">
						                            <button type="button" class="btn btn-primary btn-sm px-3 rounded-pill" 
						                                    onclick="confirmMatch('${apply.team_code}', '${apply.team_name}');">
						                                수락하기
						                            </button>
						                        </c:when>
						                        
						                        <c:otherwise>
						                        	 <c:if test="${apply.status == '수락'}"> 
						                            <button type="button" class="btn btn-secondary btn-sm px-3 rounded-pill" disabled>
						                                매칭완료 <i class="bi bi-check-all"></i>
						                            </button>
						                            </c:if>
						                        </c:otherwise>
						                    </c:choose>
					                    </div>
					                </div>
					            </c:forEach>
					        </div>
					    </div>
					</div>
				</c:if>
			</div>
		</div>
	</div>

	<div class="modal fade" id="teamSelectModal" tabindex="-1" aria-hidden="true">
	    <div class="modal-dialog modal-dialog-centered">
	        <div class="modal-content rounded-4 border-0 shadow-lg">
	            <div class="modal-header border-0 pb-0 pt-4 px-4">
	                <h5 class="modal-title fw-bold">매치 신청 팀 선택</h5>
	                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	            </div>
	            
	            <div class="modal-body p-4">
	                <p class="text-muted small mb-3">신청할 팀을 선택해주세요. (팀 운영진만 신청 가능)</p>
	                <div class="list-group">
	                    <c:choose>
	                        <c:when test="${not empty myTeams}">
	                            <c:set var="canApplyCount" value="0" />
	                            <c:forEach var="team" items="${myTeams}">
	                                <c:choose>
	                                    <c:when test="${team.role_level >= 10}">
	                                        <c:set var="canApplyCount" value="${canApplyCount + 1}" />
	                                        <label class="list-group-item d-flex gap-3 align-items-center cursor-pointer list-group-item-action border rounded-3 mb-2 p-3">
	                                            <input class="form-check-input flex-shrink-0" type="radio" name="selectedTeam" 
	                                                   value="${team.team_code}" data-name="${team.team_name}" style="font-size: 1.2em;">
	                                            <span class="fw-bold text-dark">${team.team_name}</span>
	                                            <span class="badge bg-primary ms-auto">신청가능</span>
	                                        </label>
	                                    </c:when>
	                                    <c:otherwise>
	                                        <label class="list-group-item d-flex gap-3 align-items-center bg-light text-muted border rounded-3 mb-2 p-3" style="cursor: not-allowed; opacity: 0.6;">
	                                            <input class="form-check-input flex-shrink-0" type="radio" disabled>
	                                            <span class="fw-bold text-decoration-line-through">${team.team_name}</span>
	                                            <span class="badge bg-secondary ms-auto">권한부족</span>
	                                        </label>
	                                    </c:otherwise>
	                                </c:choose>
	                            </c:forEach>
	                            
	                            <c:if test="${canApplyCount == 0}">
	                                 <div class="alert alert-warning text-center mt-3 p-2 small">
	                                    <i class="bi bi-exclamation-triangle-fill"></i><br>
	                                    매치 신청은 <b>팀 운영진(매니저 이상)</b>만 가능합니다.<br>
	                                    소속된 팀에서 권한을 확인해주세요.
	                                 </div>
	                                 <script>$(function(){ $('#btnApplySubmit').hide(); });</script>
	                            </c:if>
	                        </c:when>
	                        <c:otherwise>
	                            <div class="text-center py-3">
	                                <p>소속된 팀이 없습니다.</p>
	                                <a href="${pageContext.request.contextPath}/team/write" class="btn btn-sm btn-outline-primary">팀 생성하러 가기</a>
	                            </div>
	                        </c:otherwise>
	                    </c:choose>
	                </div>
	            </div>
	            
	            <div class="modal-footer border-0 pt-0 pb-4 px-4">
	                <button type="button" class="btn btn-light rounded-pill px-4" data-bs-dismiss="modal">취소</button>
	                <c:if test="${not empty myTeams}">
	                    <button type="button" class="btn btn-primary rounded-pill px-4" id="btnApplySubmit" onclick="submitApply()">매치 신청</button>
	                </c:if>
	            </div>
	        </div>
	    </div>
	</div>
	
	<div class="modal fade" id="shareModal" tabindex="-1" aria-hidden="true">
	    <div class="modal-dialog modal-dialog-centered">
	        <div class="modal-content rounded-4 border-0 shadow-lg">
	            <div class="modal-header border-0 pb-0 pt-4 px-4">
	                <h5 class="modal-title fw-bold">매치 공유하기</h5>
	                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	            </div>
	            <div class="modal-body p-4">
	                <p class="text-muted small mb-3">아래 주소를 복사하여 팀원들에게 공유하세요.</p>
	                <div class="input-group">
	                    <span class="input-group-text bg-light border-end-0"><i class="bi bi-link-45deg"></i></span>
	                    <input type="text" id="shareUrlInput" class="form-control bg-light border-start-0" readonly>
	                    <button class="btn btn-dark" type="button" onclick="copyToClipboard()">복사</button>
	                </div>
	            </div>
	        </div>
	    </div>
	</div>
	
	<footer>
		<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
	</footer>

	<jsp:include page="/WEB-INF/views/layout/footerResources.jsp" />
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
	<script src="${pageContext.request.contextPath}/dist/api/map.js"></script>
	
	<script type="text/javascript">
		function openShareModal() {
			const currentUrl = window.location.href;
			document.getElementById('shareUrlInput').value = currentUrl;
			const shareModal = new bootstrap.Modal(document.getElementById('shareModal'));
			shareModal.show();
		}

		function copyToClipboard() {
			const urlInput = document.getElementById('shareUrlInput');
			
			urlInput.select();
			urlInput.setSelectionRange(0, 99999); // 모바일 호환성

			navigator.clipboard.writeText(urlInput.value).then(() => {
				alert('주소가 복사되었습니다!');
			}).catch(err => {
				document.execCommand('copy');
				alert('주소가 복사되었습니다!');
			});
		}

		function apply(){
			let myTeamCode = "${sessionScope.member_team.team_code}";
			
			if(${empty myTeams}){
				if(confirm("소속된 팀이 없습니다. 팀을 생성하거나 가입하시겠습니까?")){
					location.href="${pageContext.request.contextPath}/team/list";
				}
				return;	
			}
			
			let hasAuth = false;
			<c:if test="${not empty myTeams}">
				<c:forEach var="team" items="${myTeams}">
					if(${team.role_level}>=10 ){hasAuth=true;}
				</c:forEach>
			</c:if>
			
			if(!hasAuth){
				alert("매치 신청은 팀의 운영진(매니저 이상)만 가능합니다.");
				return;
			}
			
			var myModal = new bootstrap.Modal(document.getElementById('teamSelectModal'));
	        myModal.show();
		}
		
		function submitApply(){
			let selectedInput = $('input[name="selectedTeam"]:checked');
			
			if(selectedInput.length===0){
				alert('신청할 팀을 선택해주세요.');
				return;
			}
			let teamCode = selectedInput.val();
			let teamName = selectedInput.attr("data-name");
			
			if(!confirm("["+teamName+"]팀으로 매치를 신청하시겠습니까?")){
				return;
			}
			
			let url = '${pageContext.request.contextPath}/match/insertApply';
			let params = {match_code:${dto.match_code},team_code:teamCode}
			
			ajaxRequest(url,'post',params,'json',function(data){
				if(data.state==="true"){
					alert('매치신청이 완료되었습니다.');
					location.reload();
				}else if(data.state==="duplicated"){
					alert('매치신청내역이 존재합니다.')
				}
				else {
					alert('신청에 실패했습니다.(이미 신청한 내역이 있거나 오류 발생)');
				}
			});
		}
		
		function confirmMatch(applyTeamCode,applyTeamName){
			if(!confirm("[" + applyTeamName + "] 팀과의 매치를 수락하시겠습니까?\n수락 시 모집이 마감됩니다.")) {
                return;
            }
			
			let url = '${pageContext.request.contextPath}/match/confirmMatch';
			let params = {match_code:${dto.match_code}, team_code:applyTeamCode}
			
			ajaxRequest(url,'post',params,'json',function(data){
				if(data.state==='true'){
					alert('매치가 수락되었습니다!');
					location.reload();
				}else{
					alert('매치가 실패했습니다.');
				}
			})
		}
	</script>
	
	<c:if test="${sessionScope.member.member_code == dto.member_code || sessionScope.member_team.role_level>=10 }">
		<script type="text/javascript">
			function deleteOk(){
				if(confirm('매치 게시글을 삭제하시겠습니까?')){
					let params = 'match_code=${dto.match_code}&${query}';
					let url = '${pageContext.request.contextPath}/match/delete?'+params;
					location.href=url;
				}
			}
		</script>
	</c:if>

</body>
</html>