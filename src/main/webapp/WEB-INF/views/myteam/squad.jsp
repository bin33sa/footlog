<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<!DOCTYPE html>
<html>
<head>
    <title>Footlog - Team Squad</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <jsp:include page="/WEB-INF/views/layout/headerResources.jsp"/>
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/style.css?ver=2">
    
    <style>
        /* 포지션별 배지 스타일 */
        .badge-position { font-size: 0.8rem; padding: 0.4em 0.8em; }
        .pos-fw { background-color: #ffe3e3; color: #c92a2a; } 
        .pos-mf { background-color: #e3fafc; color: #0c8599; }
        .pos-df { background-color: #eebefa; color: #862e9c; } 
        .pos-gk { background-color: #fff9db; color: #e67700; }
        
        /* 카드 디자인 */
        .modern-card { transition: transform 0.2s; border: none; box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.15); border-radius: 0.35rem; position: relative; }
        .modern-card:hover { transform: translateY(-5px); box-shadow: 0 0.5rem 2rem 0 rgba(58, 59, 69, 0.2); }
        .player-card { min-height: 260px; display: flex; flex-direction: column; justify-content: center; }

        /* 탭 메뉴 스타일 */
        .squad-tab-item { cursor: pointer; padding: 10px 20px; font-weight: 600; color: #adb5bd; text-decoration: none; border-bottom: 3px solid transparent; }
        .squad-tab-item.active { color: #0d6efd; border-bottom-color: #0d6efd; }
        .squad-tabs { display: flex; gap: 10px; margin-bottom: 30px; border-bottom: 1px solid #dee2e6; }
        
        /* 프로필 이미지 영역 스타일 */
        .profile-placeholder { 
            width: 80px; 
            height: 80px; 
            background-color: #f8f9fa; 
            display: flex; 
            align-items: center; 
            justify-content: center; 
            border-radius: 50%; 
            margin: 10px auto; 
            overflow: hidden; 
            border: 1px solid #dee2e6;
        }
        
        .profile-img-fit {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        
        /* 사이드바 스타일 */
        .sidebar-title { font-size: 0.85rem; font-weight: 700; color: #6c757d; text-transform: uppercase; letter-spacing: 0.5px; }
        
        /* 수정 버튼 스타일 (카드 호버 시 등장) */
        .btn-edit-player { position: absolute; top: 10px; right: 10px; z-index: 10; opacity: 0; transition: opacity 0.2s; background-color: rgba(255,255,255,0.8); }
        .modern-card:hover .btn-edit-player { opacity: 1; }
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
                            <a href="${pageContext.request.contextPath}/myteam/update?teamCode=${sessionScope.currentTeamCode}" class="list-group-item list-group-item-action border-0">구단 프로필 수정</a>
                            
                            <c:if test="${myRoleLevel >= 10}">
                                <a href="${pageContext.request.contextPath}/myteam/teamUpdate?teamCode=${sessionScope.currentTeamCode}" class="list-group-item list-group-item-action border-0">구단 정보 수정</a>
                            </c:if>

                            <a href="${pageContext.request.contextPath}/myteam/squad" class="list-group-item list-group-item-action border-0 active fw-bold bg-light text-primary">
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
                
                <c:set var="defaultProfile" value="${pageContext.request.contextPath}/dist/images/avatar.png" />

                <div class="d-flex justify-content-between align-items-end mb-5 border-bottom pb-4">
                    <div>
                        <h2 class="fw-bold display-6 mb-1 text-dark">
                            <c:choose>
                                <c:when test="${not empty myTeamName}">${myTeamName}</c:when>
                                <c:otherwise>구단 스쿼드</c:otherwise>
                            </c:choose>
                        </h2>
                        <span class="text-muted fs-5">
                            선수 명단 
                            <c:if test="${not empty list}">(총 <span class="fw-bold text-primary">${list.size()}</span>명)</c:if>
                        </span>
                    </div>
                    
                    <c:if test="${myRoleLevel >= 10}">
                        <button class="btn btn-dark rounded-pill px-4 fw-bold shadow-sm" onclick="alert('초대 링크가 복사되었습니다! (준비중)')">
                            <i class="bi bi-link-45deg me-1"></i> 팀원 초대하기
                        </button>
                    </c:if>
                </div>

                <div class="squad-tabs">
                    <a class="squad-tab-item active" onclick="filterSquad('all', this)">ALL</a>
                    <a class="squad-tab-item" onclick="filterSquad('coach', this)">STAFFS</a>
                    <a class="squad-tab-item" onclick="filterSquad('fw', this)">FORWARDS</a>
                    <a class="squad-tab-item" onclick="filterSquad('mf', this)">MIDFIELDERS</a>
                    <a class="squad-tab-item" onclick="filterSquad('df', this)">DEFENDERS</a>
                    <a class="squad-tab-item" onclick="filterSquad('gk', this)">GOALKEEPERS</a>
                </div>

                <div id="section-coach" class="squad-section">
                    <h4 class="fw-bold text-primary border-bottom pb-2 mb-4">운영진 (Staffs)</h4>
                    <div class="row g-3 mb-5">
                        <c:forEach var="dto" items="${list}">
                            <c:if test="${dto.role_level >= 10}">
                                <div class="col-xl-3 col-lg-4 col-md-6">
                                    <div class="modern-card p-3 d-flex align-items-center gap-3 bg-light ${dto.role_level >= 99 ? 'border border-warning' : ''}" style="height: 120px;">
                                        
                                        <c:if test="${myRoleLevel >= 10}">
                                            <button type="button" class="btn btn-sm btn-light border btn-edit-player" 
                                                    onclick="openEditModal('${dto.member_code}', '${dto.member_name}', '${dto.position}', '${dto.back_number}', '${dto.role_level}')">
                                                <i class="bi bi-pencil-fill small"></i>
                                            </button>
                                        </c:if>

                                        <div class="position-relative">
                                            <div class="bg-white rounded-circle d-flex align-items-center justify-content-center shadow-sm overflow-hidden" style="width:60px; height:60px;">
                                                <c:choose>
                                                    <c:when test="${not empty dto.profile_image}">
                                                        <img src="${pageContext.request.contextPath}/uploads/profile/${dto.profile_image}" class="profile-img-fit" onerror="this.src='${defaultProfile}'">
                                                    </c:when>
                                                    <c:otherwise>
                                                        <img src="${defaultProfile}" class="profile-img-fit">
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                            <c:if test="${dto.role_level >= 99}">
                                                <span class="position-absolute bottom-0 end-0 badge rounded-pill bg-dark border border-white" title="구단주">C</span>
                                            </c:if>
                                        </div>
                                        <div>
                                            <span class="badge ${dto.role_level >= 99 ? 'bg-warning text-dark' : 'bg-secondary'} mb-1">
                                                ${dto.role_level >= 99 ? '구단주' : '매니저'}
                                            </span>
                                            <h6 class="fw-bold mb-0 text-truncate" style="max-width: 120px;">${dto.member_name}</h6>
                                            <small class="text-muted text-truncate d-block" style="max-width: 120px;">@${dto.member_id}</small>
                                           <div class="bg-light rounded-3 p-2">
                                               <small class="text-muted">가입일</small>
                                               <div class="fw-bold small">${empty dto.join_date ? '-' : dto.join_date}</div>
                                             </div>
                                        </div>
                                    </div>
                                </div>
                            </c:if>
                        </c:forEach>
                    </div>
                </div>

                <div id="section-fw" class="squad-section">
                    <h4 class="fw-bold border-bottom pb-2 mb-4">FORWARDS</h4>
                    <div class="row g-3 mb-5">
                        <c:forEach var="dto" items="${list}">
                            <c:if test="${dto.position eq 'FW'}">
                                <div class="col-xl-3 col-lg-4 col-md-6">
                                    <div class="modern-card player-card p-3 text-center">
                                        <c:if test="${myRoleLevel >= 10}">
                                            <button type="button" class="btn btn-sm btn-light border btn-edit-player" 
                                                    onclick="openEditModal('${dto.member_code}', '${dto.member_name}', '${dto.position}', '${dto.back_number}', '${dto.role_level}')">
                                                <i class="bi bi-pencil-fill small"></i>
                                            </button>
                                        </c:if>
                                        
                                        <div class="d-flex justify-content-between mb-2">
                                            <span class="badge badge-position pos-fw rounded-pill">FW</span>
                                            <span class="fw-bold text-muted fs-5">등번호 ${empty dto.back_number ? '-' : dto.back_number}번</span>
                                        </div>
                                        
                                        <div class="profile-placeholder shadow-sm">
                                            <c:choose>
                                                <c:when test="${not empty dto.profile_image}">
                                                    <img src="${pageContext.request.contextPath}/uploads/profile/${dto.profile_image}" class="profile-img-fit" onerror="this.src='${defaultProfile}'">
                                                </c:when>
                                                <c:otherwise>
                                                    <img src="${defaultProfile}" class="profile-img-fit">
                                                </c:otherwise>
                                            </c:choose>
                                        </div>

                                        <h5 class="fw-bold mb-1 text-truncate">${dto.member_name}</h5>
                                        <p class="text-muted small mb-3 text-truncate">@${dto.member_id}</p>
                                        <div class="bg-light rounded-3 p-2">
                                            <small class="text-muted">가입일</small>
                                            <div class="fw-bold small">${empty dto.join_date ? '-' : dto.join_date}</div>
                                        </div>
                                    </div>
                                </div>
                            </c:if>
                        </c:forEach>
                    </div>
                </div>

                <div id="section-mf" class="squad-section">
                    <h4 class="fw-bold border-bottom pb-2 mb-4">MIDFIELDERS</h4>
                    <div class="row g-3 mb-5">
                        <c:forEach var="dto" items="${list}">
                            <c:if test="${dto.position eq 'MF'}">
                                <div class="col-xl-3 col-lg-4 col-md-6">
                                    <div class="modern-card player-card p-3 text-center">
                                        <c:if test="${myRoleLevel >= 10}">
                                            <button type="button" class="btn btn-sm btn-light border btn-edit-player" 
                                                    onclick="openEditModal('${dto.member_code}', '${dto.member_name}', '${dto.position}', '${dto.back_number}', '${dto.role_level}')">
                                                <i class="bi bi-pencil-fill small"></i>
                                            </button>
                                        </c:if>
                                        
                                        <div class="d-flex justify-content-between mb-2">
                                            <span class="badge badge-position pos-mf rounded-pill">MF</span>
                                            <span class="fw-bold text-muted fs-5">등번호 ${empty dto.back_number ? '-' : dto.back_number}번</span>
                                        </div>
                                        
                                        <div class="profile-placeholder shadow-sm">
                                            <c:choose>
                                                <c:when test="${not empty dto.profile_image}">
                                                    <img src="${pageContext.request.contextPath}/uploads/profile/${dto.profile_image}" class="profile-img-fit" onerror="this.src='${defaultProfile}'">
                                                </c:when>
                                                <c:otherwise>
                                                    <img src="${defaultProfile}" class="profile-img-fit">
                                                </c:otherwise>
                                            </c:choose>
                                        </div>

                                        <h5 class="fw-bold mb-1 text-truncate">${dto.member_name}</h5>
                                        <p class="text-muted small mb-3 text-truncate">@${dto.member_id}</p>
                                        <div class="bg-light rounded-3 p-2">
                                            <small class="text-muted">가입일</small>
                                            <div class="fw-bold small">${empty dto.join_date ? '-' : dto.join_date}</div>
                                        </div>
                                    </div>
                                </div>
                            </c:if>
                        </c:forEach>
                    </div>
                </div>

                <div id="section-df" class="squad-section">
                    <h4 class="fw-bold border-bottom pb-2 mb-4">DEFENDERS</h4>
                    <div class="row g-3 mb-5">
                        <c:forEach var="dto" items="${list}">
                            <c:if test="${dto.position eq 'DF'}">
                                <div class="col-xl-3 col-lg-4 col-md-6">
                                    <div class="modern-card player-card p-3 text-center">
                                        <c:if test="${myRoleLevel >= 10}">
                                            <button type="button" class="btn btn-sm btn-light border btn-edit-player" 
                                                    onclick="openEditModal('${dto.member_code}', '${dto.member_name}', '${dto.position}', '${dto.back_number}', '${dto.role_level}')">
                                                <i class="bi bi-pencil-fill small"></i>
                                            </button>
                                        </c:if>
                                        
                                        <div class="d-flex justify-content-between mb-2">
                                            <span class="badge badge-position pos-df rounded-pill">DF</span>
                                            <span class="fw-bold text-muted fs-5">등번호 ${empty dto.back_number ? '-' : dto.back_number}번</span>
                                        </div>
                                        
                                        <div class="profile-placeholder shadow-sm">
                                            <c:choose>
                                                <c:when test="${not empty dto.profile_image}">
                                                    <img src="${pageContext.request.contextPath}/uploads/profile/${dto.profile_image}" class="profile-img-fit" onerror="this.src='${defaultProfile}'">
                                                </c:when>
                                                <c:otherwise>
                                                    <img src="${defaultProfile}" class="profile-img-fit">
                                                </c:otherwise>
                                            </c:choose>
                                        </div>

                                        <h5 class="fw-bold mb-1 text-truncate">${dto.member_name}</h5>
                                        <p class="text-muted small mb-3 text-truncate">@${dto.member_id}</p>
                                        <div class="bg-light rounded-3 p-2">
                                            <small class="text-muted">가입일</small>
                                            <div class="fw-bold small">${empty dto.join_date ? '-' : dto.join_date}</div>
                                        </div>
                                    </div>
                                </div>
                            </c:if>
                        </c:forEach>
                    </div>
                </div>

                <div id="section-gk" class="squad-section">
                    <h4 class="fw-bold border-bottom pb-2 mb-4">GOALKEEPERS</h4>
                    <div class="row g-3 mb-5">
                        <c:forEach var="dto" items="${list}">
                            <c:if test="${dto.position eq 'GK'}">
                                <div class="col-xl-3 col-lg-4 col-md-6">
                                    <div class="modern-card player-card p-3 text-center">
                                        <c:if test="${myRoleLevel >= 10}">
                                            <button type="button" class="btn btn-sm btn-light border btn-edit-player" 
                                                    onclick="openEditModal('${dto.member_code}', '${dto.member_name}', '${dto.position}', '${dto.back_number}', '${dto.role_level}')">
                                                <i class="bi bi-pencil-fill small"></i>
                                            </button>
                                        </c:if>
                                        
                                        <div class="d-flex justify-content-between mb-2">
                                            <span class="badge badge-position pos-gk rounded-pill">GK</span>
                                            <span class="fw-bold text-muted fs-5">등번호 ${empty dto.back_number ? '-' : dto.back_number}번</span>
                                        </div>
                                        
                                        <div class="profile-placeholder shadow-sm">
                                            <c:choose>
                                                <c:when test="${not empty dto.profile_image}">
                                                    <img src="${pageContext.request.contextPath}/uploads/profile/${dto.profile_image}" class="profile-img-fit" onerror="this.src='${defaultProfile}'">
                                                </c:when>
                                                <c:otherwise>
                                                    <img src="${defaultProfile}" class="profile-img-fit">
                                                </c:otherwise>
                                            </c:choose>
                                        </div>

                                        <h5 class="fw-bold mb-1 text-truncate">${dto.member_name}</h5>
                                        <p class="text-muted small mb-3 text-truncate">@${dto.member_id}</p>
                                        <div class="bg-light rounded-3 p-2">
                                            <small class="text-muted">가입일</small>
                                            <div class="fw-bold small">${empty dto.join_date ? '-' : dto.join_date}</div>
                                        </div>
                                    </div>
                                </div>
                            </c:if>
                        </c:forEach>
                    </div>
                </div>

            </div>
        </div> 
    </div>

    <div class="modal fade" id="editMemberModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <form action="${pageContext.request.contextPath}/myteam/updateSquad" method="post">
                    <input type="hidden" name="team_code" value="${team_code}">
                    <input type="hidden" name="member_code" id="modalMemberCode">
                    
                    <div class="modal-header">
                        <h5 class="modal-title fw-bold">선수 정보 수정</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="mb-3">
                            <label class="form-label fw-bold">선수 이름</label>
                            <input type="text" class="form-control" id="modalMemberName" readonly style="background-color: #f8f9fa;">
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label fw-bold">팀 내 권한</label>
                            <select class="form-select" name="role_level" id="modalRoleLevel">
                                <option value="1">팀원 (General)</option>
                                <option value="10">매니저 (Manager)</option>
                                <c:if test="${myRoleLevel >= 99}">
                                    <option value="99">구단주 (Owner)</option>
                                </c:if>
                            </select>
                        </div>
                        
                        <div class="row">
                            <div class="col-6">
                                <label class="form-label fw-bold">포지션</label>
                                <select class="form-select" name="position" id="modalPosition">
                                    <option value="FW">공격수 (FW)</option>
                                    <option value="MF">미드필더 (MF)</option>
                                    <option value="DF">수비수 (DF)</option>
                                    <option value="GK">골키퍼 (GK)</option>
                                </select>
                            </div>
                            <div class="col-6">
                                <label class="form-label fw-bold">등번호</label>
                                <input type="number" class="form-control" name="back_number" id="modalBackNumber" min="0" max="99">
                            </div>
                        </div>
                    </div>
                    
                    <div class="modal-footer">
                        <button type="button" class="btn btn-outline-danger me-auto" onclick="deleteMember()">
                            <i class="bi bi-person-x-fill"></i> 내보내기
                        </button>
                        
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                        <button type="submit" class="btn btn-primary">수정 완료</button>
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
        function filterSquad(position, element) {
            document.querySelectorAll('.squad-tab-item').forEach(tab => tab.classList.remove('active'));
            element.classList.add('active');

            const sections = document.querySelectorAll('.squad-section');
            sections.forEach(sec => {
                if (position === 'all') {
                    sec.style.display = 'block';
                } else {
                    if (sec.id === 'section-' + position) {
                        sec.style.display = 'block';
                    } else {
                        sec.style.display = 'none';
                    }
                }
            });
        }

        // 모달 열기
        function openEditModal(code, name, pos, num, role) {
            document.getElementById('modalMemberCode').value = code;
            document.getElementById('modalMemberName').value = name;
            document.getElementById('modalRoleLevel').value = role;

            const select = document.getElementById('modalPosition');
            if(pos) { select.value = pos.trim(); }
            
            if(num == '0' || num == '') {
                document.getElementById('modalBackNumber').value = "";
            } else {
                document.getElementById('modalBackNumber').value = num;
            }
            
            const modal = new bootstrap.Modal(document.getElementById('editMemberModal'));
            modal.show();
        }

        function deleteMember() {
            const teamCode = document.querySelector("input[name=team_code]").value;
            const memberCode = document.getElementById("modalMemberCode").value;
            const memberName = document.getElementById("modalMemberName").value;
            
            if(confirm("[" + memberName + "] 님을 정말로 구단에서 내보내시겠습니까?\n이 작업은 취소할 수 없습니다.")) {
                location.href = "${pageContext.request.contextPath}/myteam/deleteMember?teamCode=" + teamCode + "&memberCode=" + memberCode;
            }
        }
    </script>

</body>
</html>