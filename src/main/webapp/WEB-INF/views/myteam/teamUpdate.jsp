<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<!DOCTYPE html>
<html>
<head>
    <title>Footlog - 구단 정보 수정</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <jsp:include page="/WEB-INF/views/layout/headerResources.jsp"/>
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/style.css?ver=2">
    
    <style>
        .modern-card { border: none; box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.15); border-radius: 0.35rem; }
        .sidebar-title { font-size: 0.85rem; font-weight: 700; color: #6c757d; text-transform: uppercase; letter-spacing: 0.5px; }
        .emblem-preview-box {
            width: 150px; height: 150px; border-radius: 50%; border: 3px solid #dee2e6;
            overflow: hidden; background-color: #f8f9fa; position: relative;
            margin: 0 auto 15px auto; display: flex; align-items: center; justify-content: center;
        }
        .emblem-preview-box img { width: 100%; height: 100%; object-fit: cover; }
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
                        <p class="sidebar-title mb-3">구단 관리</p>
                        <div class="list-group">
                            <a href="${pageContext.request.contextPath}/myteam/update?teamCode=${teamCode}" class="list-group-item list-group-item-action border-0">구단 프로필 수정</a>
                            
                            <c:if test="${myRoleLevel >= 10}">
                                <a href="${pageContext.request.contextPath}/myteam/teamUpdate?teamCode=${teamCode}" class="list-group-item list-group-item-action border-0 active fw-bold bg-light text-primary">구단 정보 수정</a>
                            </c:if>

                            <a href="${pageContext.request.contextPath}/myteam/squad?teamCode=${teamCode}" class="list-group-item list-group-item-action border-0">
                                <c:choose>
                                    <c:when test="${myRoleLevel >= 10}">스쿼드(선수) 관리</c:when>
                                    <c:otherwise>구단 스쿼드</c:otherwise>
                                </c:choose>
                            </a>
                            
                            <c:if test="${myRoleLevel >= 10}">
                                <a href="${pageContext.request.contextPath}/myteam/manage/match?teamCode=${teamCode}" class="list-group-item list-group-item-action border-0">매치 관리</a>
                                <a href="${pageContext.request.contextPath}/myteam/requestList?teamCode=${teamCode}" class="list-group-item list-group-item-action border-0">
                                    가입 신청 관리 
                                </a>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-lg-10 col-12">
                
                <div class="page-title-box mb-4">
                    <h3 class="fw-bold text-dark mb-1">구단 정보 수정</h3>
                    <p class="text-muted mb-0">팀명, 엠블럼, 소개글 등 구단의 기본 정보를 변경합니다.</p>
                </div>

                <form name="teamUpdateForm" action="${pageContext.request.contextPath}/myteam/teamUpdate" method="post" enctype="multipart/form-data">
                    
                    <input type="hidden" name="team_code" value="${teamCode}">
                    
                    <div class="row">
                        <div class="col-lg-4 mb-4">
                            <div class="modern-card p-4 h-100 text-center">
                                <h5 class="fw-bold mb-4 text-start border-bottom pb-2">팀 엠블럼</h5>
                                
                                <div class="emblem-preview-box">
                                    <img id="emblemPreview" 
                                         src="${pageContext.request.contextPath}/uploads/team/${dto.emblem_image}" 
                                         onerror="this.src='${pageContext.request.contextPath}/resources/images/default_team.png'">
                                </div>
                                
                                <div class="mb-3">
                                    <label for="uploadEmblem" class="btn btn-outline-primary btn-sm rounded-pill px-3">
                                        <i class="bi bi-camera-fill me-1"></i> 이미지 변경
                                    </label>
                                    <input type="file" id="uploadEmblem" name="selectFile" class="d-none" accept="image/*" onchange="previewImage(this);">
                                </div>
                                <p class="text-muted small">권장 사이즈: 500x500px<br>지원 파일: JPG, PNG</p>
                            </div>
                        </div>

                        <div class="col-lg-8 mb-4">
                            <div class="modern-card p-4 h-100">
                                <h5 class="fw-bold mb-4 border-bottom pb-2">기본 정보</h5>
                                
                                <div class="mb-3">
                                    <label class="form-label fw-bold">팀 이름 <span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" name="team_name" value="${dto.team_name}" placeholder="팀 이름을 입력하세요">
                                </div>

                                <div class="mb-3">
                                    <label class="form-label fw-bold">활동 지역</label>
                                    <select class="form-select" name="region">
                                        <option value="서울" ${dto.region == '서울' ? 'selected' : ''}>서울</option>
                                        <option value="경기" ${dto.region == '경기' ? 'selected' : ''}>경기</option>
                                        <option value="인천" ${dto.region == '인천' ? 'selected' : ''}>인천</option>
                                        <option value="부산" ${dto.region == '부산' ? 'selected' : ''}>부산</option>
                                        <option value="기타" ${dto.region == '기타' ? 'selected' : ''}>기타</option>
                                    </select>
                                </div>
                                
                                <div class="mb-3">
                                    <label class="form-label fw-bold">팀 소개</label>
                                    <textarea class="form-control" name="description" rows="5" placeholder="팀에 대한 간단한 소개를 적어주세요.">${dto.description}</textarea>
                                </div>
                                
                                <div class="alert alert-light border text-center mt-5 mb-0 p-4">
                                    <i class="bi bi-info-circle text-primary me-2"></i>
                                    수정된 정보는 즉시 구단 페이지에 반영됩니다.
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="text-center mt-3 mb-5">
                        <button type="button" class="btn btn-secondary px-4 me-2" onclick="location.href='${pageContext.request.contextPath}/myteam/main?teamCode=${teamCode}'">취소</button>
                        <button type="button" class="btn btn-primary px-4 fw-bold" onclick="sendOk();">수정 내용 저장</button>
                    </div>
                </form>

            </div>
        </div> 
    </div>

    <footer>
	   <jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
	</footer>
	
    <jsp:include page="/WEB-INF/views/layout/footerResources.jsp"/>

    <script>
        function previewImage(input) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.onload = function(e) {
                    document.getElementById('emblemPreview').src = e.target.result;
                };
                reader.readAsDataURL(input.files[0]);
            }
        }

        function sendOk() {
            const f = document.teamUpdateForm;

            if(!f.team_name.value.trim()) {
                alert("팀 이름은 필수 입력 항목입니다.");
                f.team_name.focus();
                return;
            }

            // description은 필수는 아닐 수 있으나 체크 원하면 추가 가능
            
            if(confirm("입력한 내용으로 구단 정보를 수정하시겠습니까?")) {
                f.submit();
            }
        }
    </script>

</body>
</html>