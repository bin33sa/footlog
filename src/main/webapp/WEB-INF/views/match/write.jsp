<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>Footlog - Create Match</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/style.css">
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
                        <p class="sidebar-title">매치</p>
                        <div class="list-group">
                            <a href="${pageContext.request.contextPath}/match/myMatch" class="list-group-item list-group-item-action ">내 매치 관리</a>
                            <a href="${pageContext.request.contextPath}/match/list" class="list-group-item list-group-item-action ">전체 매치 리스트</a>
                            <a href="${pageContext.request.contextPath}/match/write" class="list-group-item list-group-item-action  active-menu">${mode=='write'?'매치 개설하기' : '매치 수정하기' }</a>
                            <a href="${pageContext.request.contextPath}/mercenary/list" class="list-group-item list-group-item-action ">용병 구하기</a>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-lg-8 col-12">
                
                <div class="d-flex align-items-center mb-4">
                    <h2 class="fw-bold mb-0">${mode=='write'?'매치 개설하기' : '매치 수정하기' }</h2>
                    <span class="ms-3 text-muted small">팀원 모집을 위한 매치 정보를 입력해주세요.</span>
                </div>

                <form name="matchForm" method="post">
                    <input type="hidden" name="mode" value="${mode}">
                    <input type="hidden" name="page" value="${page}">
                    
                    <c:if test="${mode=='update'}">
                    	<input type="hidden" name="match_code" value="${dto.match_code}">
                    	<input type="hidden" name="status" value="${dto.status}">
                    	
                    </c:if>
                    
                    <div class="modern-card p-5">
					    <div class="mb-3">
						    <label class="form-label fw-bold">주최 팀 선택</label>
						    <select name="home_code" id="teamSelect" class="form-select rounded-pill shadow-sm" onchange="loadReservations()">
						        <c:choose>
						            <c:when test="${empty myTeams}">
						                <option value="" disabled selected>소속된 팀이 없습니다.</option>
						            </c:when>
						            <c:otherwise>
						                <option value="" disabled selected>팀을 선택하세요</option>
						                <c:forEach var="team" items="${myTeams}">
						                    <option value="${team.team_code}" ${dto.home_code==team.team_code? "selected":""}>${team.team_name}</option>
						                </c:forEach>
						            </c:otherwise>
						        </c:choose>
						    </select>
						</div>
                        <div class="mb-4">
                            <label for="title" class="form-label fw-bold">매치 제목</label>
                            <input type="text" class="form-control form-control-lg bg-light border-0" id="title" name="title" placeholder="예) 9월 20일 상암 3파전 모집합니다!" value="${dto.title }">
                        </div>

                        <div class="row g-3 mb-4">
						    <div class="col-md-6">
						        <label for="match_date" class="form-label fw-bold">경기 일시 (자동 입력)</label>
						        <input type="text" class="form-control bg-light border-0" id="match_date" name="match_date" 
						               placeholder="예약된 구장을 선택하면 자동 입력됩니다." value="${dto.match_date}" readonly>
						    </div>
						
						    <div class="col-md-6">
						        <label for="stadiumSelect" class="form-label fw-bold">구장 예약 선택</label>
						        <select class="form-select bg-light border-0" id="stadiumSelect" name="stadium_code" onchange="setMatchInfo()">
						            <option value="">팀을 먼저 선택해주세요</option>
						            </select>
						    </div>
						</div>

                        <div class="row g-3 mb-4">
                            <div class="col-md-4">
                                <label for="matchType" class="form-label fw-bold">경기 방식</label>
                                <select class="form-select bg-light border-0" id="matchType" name="matchType" >
                                    <option value="5vs5" ${dto.matchType== '5vs5'?'selected':''}>5 vs 5</option>
                                    <option value="6vs6" ${dto.matchType== '6vs6' || empty dto.matchType ?'selected':''}>6 vs 6</option>
                                    <option value="11vs11" ${dto.matchType== '11vs11'?'selected':''}>11 vs 11</option>
                                </select>
                            </div>
                            <div class="col-md-4">
                                <label for="gender" class="form-label fw-bold">성별</label>
                                <select class="form-select bg-light border-0" id="gender" name="gender" >
                                    <option value="남성" ${dto.gender=='남성'|| empty dto.gender?'selected':''}>남성</option>
                                    <option value="여성" ${dto.gender=='여성'?'selected':''}>여성</option>
                                    <option value="남녀무관(혼성)" ${dto.gender=='남녀무관(혼성)'?'selected':''}>남녀무관(혼성)</option>
                                </select>
                            </div>
                            <div class="col-md-4">
                                <label for="level" class="form-label fw-bold">실력</label>
                                <select class="form-select bg-light border-0" id="matchLevel" name="matchLevel" >
                                    <option value="하 (초보)" ${dto.matchLevel=='하 (초보)'? 'selected':''}>하 (초보)</option>
                                    <option value="중 (아마추어)" ${dto.matchLevel=='중 (아마추어)'|| empty dto.matchLevel? 'selected':''}>중 (아마추어)</option>
                                    <option value="상 (선출포함)" ${dto.matchLevel=='상 (선출포함)'? 'selected':''}>상 (선출포함)</option>
                                </select>
                            </div>
                        </div>

                        <div class="mb-4">
                            <label for="fee" class="form-label fw-bold">참가비 (1인당)</label>
                            <div class="input-group">
                                <input type="number" class="form-control bg-light border-0" id="fee" name="fee" placeholder="10000" value="${dto.fee}">
                                <span class="input-group-text bg-light border-0">원</span>
                            </div>
                            <div class="form-text text-muted small">* 무료 매치일 경우 0을 입력하세요.</div>
                        </div>

                        <div class="mb-4">
                            <label for="content" class="form-label fw-bold">상세 내용</label>
                            <textarea class="form-control bg-light border-0" id="content" name="content" rows="6" placeholder="경기 규칙, 준비물, 진행 방식 등을 자유롭게 적어주세요." >${dto.content}</textarea>
                        </div>

                        <hr class="my-5">

                        <div class="d-flex justify-content-end gap-2">
                            <button type="button" class="btn btn-light rounded-pill px-4 fw-bold" onclick="location.href='${pageContext.request.contextPath}/match/list'">취소</button>
                            <button type="button" class="btn btn-dark rounded-pill px-5 fw-bold" onclick="matchOk()">${mode=="write"?"등록하기":"수정하기"}</button>
                        </div>

                    </div>
                </form>

            </div>

            <div class="col-lg-2 d-none d-lg-block">
                <div class="sidebar-menu sticky-top" style="top: 100px;">
                    <div class="mb-4">
                    </div>
                </div>
            </div>

        </div> 
    </div>
	<script type="text/javascript">
$(function(){
    if($("#teamSelect").val()){
        loadReservations();
    }
});

function loadReservations(){
    let teamCode = $("#teamSelect").val();
    let $stadiumSelect = $("#stadiumSelect");
    
    let currentStadiumCode = "${dto.stadium_code}";
    let currentMatchDate = "${dto.match_date}"; 
    let mode = "${mode}"; 
    
    $stadiumSelect.empty();
    $stadiumSelect.append('<option value="">구장 예약을 선택해주세요.</option>');
    
    if(!teamCode) return;
    
    let url = "${pageContext.request.contextPath}/match/listTeamReservations";
    let method = "get";
    let params = { team_code: teamCode }; 
    let dataType = "json";
    
    const fn = function(data){
        let list = data.list;
        
        if(!list || list.length === 0){
            $stadiumSelect.empty();
            $stadiumSelect.append('<option value="" disabled> 예약된 내역이 없습니다.</option>');
            return;
        }
        
        $.each(list, function(index, item){
            let text = `[\${item.playDate}] \${item.stadiumName} (\${item.timeLabel})`;
            let disabled = "";
            let note = "";
            let mode = "${mode}";

            if(mode === 'write' && item.matchCount > 0) {
                disabled = "disabled";
                note = " (이미 등록됨)";
            }
            let selected = (currentStadiumCode == item.stadiumCode) ? "selected" : "";
            
            let option  = `<option value="\${item.stadium_code}" 
                data-date="\${item.match_date}" 
                data-time="\${item.timeLabel}" 
                \${selected} \${disabled}>
          		\${text}\${note}
        		</option>`;
            $stadiumSelect.append(option);
        });
        
        if(currentStadiumCode){
            setMatchInfo();
        }
    };
    
    ajaxRequest(url, method, params, dataType, fn);
}

function setMatchInfo(){
    let selectedOption = $("#stadiumSelect option:selected");
    
    let date = selectedOption.attr("data-date");
    let timeLabel = selectedOption.attr("data-time");
    
    let $dateInput = $("#match_date");
    
    if(date && timeLabel){
        let startTime = timeLabel.split('~')[0].trim();
        
        if(startTime === "24:00") {
            startTime = "00:00";
        }
        
        $dateInput.val(date + " " + startTime); 
    } else {
        $dateInput.val("");
    }
}

function matchOk(){
    const f = document.matchForm;
    let str;
    
    str = f.title.value.trim();
    if(!str){ alert('제목을 입력하세요.'); f.title.focus(); return; }
    
    str = f.match_date.value.trim();
    if(!str){ alert('구장을 선택하여 경기일자를 입력하세요.'); return; }
    
    str = f.stadium_code.value.trim();
    if(!str){ alert('구장을 선택하세요.'); f.stadium_code.focus(); return; }
    
    str = f.matchType.value.trim();
    if(!str){ alert('경기방식을 선택하세요.'); f.matchType.focus(); return; }
    
    str = f.gender.value.trim();
    if(!str){ alert('성별을 선택하세요.'); f.gender.focus(); return; }
    
    str = f.matchLevel.value.trim();
    if(!str){ alert('실력을 선택하세요.'); f.matchLevel.focus(); return; }
    
    str = f.fee.value.trim();
    if(!str){ alert('참가비를 입력하세요.'); f.fee.focus(); return; }
    
    str = f.content.value.trim();
    if(!str){ alert('내용을 입력하세요.'); f.content.focus(); return; }
    
    f.action = '${pageContext.request.contextPath}/match/${mode}';
    f.submit();
}
</script>
    <footer>
	   <jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
	</footer>
	
	<jsp:include page="/WEB-INF/views/layout/footerResources.jsp"/>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>