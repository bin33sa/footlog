<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<!DOCTYPE html>
<html>
<head>
    <title>Footlog - 프로필 사진 수정</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <jsp:include page="/WEB-INF/views/layout/headerResources.jsp"/>
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/style.css?ver=2">
    
    <style>
        .sidebar-title { font-size: 0.85rem; font-weight: 700; color: #6c757d; text-transform: uppercase; letter-spacing: 0.5px; }
        
        .profile-preview-box {
            width: 150px;
            height: 150px;
            border-radius: 50%;
            overflow: hidden;
            border: 3px solid #dee2e6;
            margin: 0 auto 20px;
            position: relative;
            background-color: #f8f9fa;
        }
        
        .profile-preview-box img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .update-card {
            max-width: 500px;
            margin: 0 auto;
            border: none;
            box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.05);
            border-radius: 15px;
        }
    </style>
    
    <script type="text/javascript">
        function previewImage(input) {
            if (input.files && input.files[0]) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    const previewImg = document.getElementById('previewImg');
                    previewImg.src = e.target.result;
                }
                reader.readAsDataURL(input.files[0]);
            }
        }

        function sendOk() {
            const f = document.profileForm;
            const fileInput = f.selectFile;
            if(!fileInput.value) {
                alert("변경할 프로필 사진을 선택해주세요.");
                return;
            }
            f.action = "${pageContext.request.contextPath}/myteam/update";
            f.submit();
        }
    </script>
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
                            <a href="${pageContext.request.contextPath}/myteam/update?teamCode=${teamCode}" class="list-group-item list-group-item-action border-0 active fw-bold bg-light text-primary">구단 프로필 수정</a>
                            
                            <c:if test="${myRoleLevel >= 10}">
                                <a href="${pageContext.request.contextPath}/myteam/teamUpdate?teamCode=${teamCode}" class="list-group-item list-group-item-action border-0">구단 정보 수정</a>
                            </c:if>

                            <a href="${pageContext.request.contextPath}/myteam/squad?teamCode=${teamCode}" class="list-group-item list-group-item-action border-0">
                                <c:choose>
                                    <c:when test="${myRoleLevel >= 10}">스쿼드(선수) 관리</c:when>
                                    <c:otherwise>구단 스쿼드</c:otherwise>
                                </c:choose>
                            </a>
                            <c:if test="${myRoleLevel >= 10}">
                                <a href="${pageContext.request.contextPath}/myteam/match?teamCode=${teamCode}" class="list-group-item list-group-item-action border-0">매치 관리</a>
                                <a href="${pageContext.request.contextPath}/myteam/requestList?teamCode=${teamCode}" class="list-group-item list-group-item-action border-0">
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
                <div class="container py-5">
                    <div class="text-center mb-5">
                        <h2 class="fw-bold">프로필 사진 변경</h2>
                        <p class="text-muted">우리 팀 스쿼드에 표시될 나의 사진을 설정하세요.</p>
                    </div>

                    <div class="card update-card p-4">
                        <div class="card-body">
                            <form name="profileForm" method="post" enctype="multipart/form-data">
                                <input type="hidden" name="teamCode" value="${teamCode}">
                                <input type="hidden" name="team_code" value="${teamCode}">
                                
                                <div class="profile-preview-box">
                                    <c:choose>
                                        <c:when test="${not empty dto.profile_image}">
                                            <img id="previewImg" src="${pageContext.request.contextPath}/uploads/profile/${dto.profile_image}" alt="Profile Image">
                                        </c:when>
                                        <c:otherwise>
                                            <img id="previewImg" src="${pageContext.request.contextPath}/dist/images/avatar.png" alt="Default Image">
                                        </c:otherwise>
                                    </c:choose>
                                </div>

                                <div class="text-center mb-4">
                                    <h5 class="fw-bold mb-1">${sessionScope.member.member_name}</h5>
                                    <p class="text-secondary small">
                                        No. ${dto.back_number} | ${dto.position}
                                    </p>
                                </div>

                                <div class="mb-4">
                                    <label for="selectFile" class="form-label fw-bold">새로운 사진 선택</label>
                                    <input type="file" name="selectFile" id="selectFile" class="form-control" 
                                           accept="image/*" onchange="previewImage(this);">
                                    <div class="form-text">JPG, PNG, GIF 파일만 업로드 가능합니다.</div>
                                </div>

                                <div class="d-grid gap-2">
                                    <button type="button" class="btn btn-primary py-2 fw-bold" onclick="sendOk();">
                                        <i class="bi bi-check-lg me-1"></i> 변경 내용 저장
                                    </button>
                                    
                                    <button type="button" class="btn btn-light py-2" onclick="location.href='${pageContext.request.contextPath}/myteam/main?teamCode=${teamCode}';">
                                        취소하고 돌아가기
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div> 
    </div>

    <footer>
       <jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
    </footer>
    
    <jsp:include page="/WEB-INF/views/layout/footerResources.jsp"/>

</body>
</html>