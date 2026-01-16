<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>마이페이지 - Footlog</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/style.css">
    
    <style>
        body { background-color: #f8f9fa; font-family: 'Pretendard', sans-serif; }
        
        .modern-card {
            background: #fff;
            border-radius: 24px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.04);
            border: 1px solid rgba(0,0,0,0.02);
            overflow: hidden;
        }

        .dashboard-header { background: #111; color: #fff; padding: 2rem; border-radius: 20px; margin-bottom: 24px; }
        
        /* 매치 카드 스타일 */
        .match-card { border-left: 5px solid #ddd; transition: transform 0.2s, box-shadow 0.2s; }
        .match-card:hover { transform: translateY(-3px); box-shadow: 0 5px 15px rgba(0,0,0,0.05); }
        .match-card.upcoming { border-left-color: #D4F63F; } /* 네온 라임색 */
        .match-card.end { border-left-color: #555; background: #f8f9fa; opacity: 0.8; }
        
        /* 프로필 이미지 스타일 */
        .profile-img-style {
            width: 110px; 
            height: 110px; 
            object-fit: cover; 
            border: 3px solid #fff; 
            background-color: #f8f9fa;
        }

        /* 수정된 버튼 스타일: 주변 레이아웃을 깨트리지 않음 */
        .btn-mypage {
            background-color: #212529 !important;
            color: #fff !important;
            border: none !important;
            transition: all 0.2s ease-in-out !important;
            display: block !important;
            text-align: center;
            text-decoration: none;
        }

        .btn-mypage:hover {
            background-color: #000 !important;
            transform: scale(1.03); /* 적당한 확대 */
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
            color: #fff !important;
        }

        .btn-mypage:active {
            transform: scale(0.97);
        }
    </style>
</head>
<body>

    <header>
       <jsp:include page="/WEB-INF/views/layout/header.jsp"/>
    </header>
    
    <!-- 관리자 -->
    <div class="container mt-5 mb-5" style="max-width: 1100px;">
        <div class="row g-4">
            <div class="col-lg-3">
                <div class="modern-card p-4 text-center mb-3">
                    <div class="position-relative d-inline-block mb-3">
                        <c:choose>
                            <c:when test="${not empty dto.profile_image && dto.profile_image != 'avatar.png'}">
                                <img src="${pageContext.request.contextPath}/uploads/member/${dto.profile_image}" 
                                     class="rounded-circle shadow-sm profile-img-style" 
                                     onerror="this.src='${pageContext.request.contextPath}/dist/images/avatar.png'">
                            </c:when>
                            <c:otherwise>
                                <img src="${pageContext.request.contextPath}/dist/images/avatar.png" 
                                     class="rounded-circle shadow-sm profile-img-style">
                            </c:otherwise>
                        </c:choose>
                        <span class="position-absolute bottom-0 end-0 badge rounded-pill bg-dark text-white border border-2 border-white shadow-sm" 
                              style="font-size: 0.75rem; padding: 5px 8px;">
                            ${empty dto.preferred_position ? '미설정' : dto.preferred_position}
                        </span>
                    </div>
                    <h5 class="fw-bold mb-1" style="letter-spacing: -0.5px;">${dto.member_name}</h5>
                    
                    <p class="text-muted small mb-4">
                        <i class="bi bi-geo-alt-fill text-secondary"></i> ${empty dto.region ? '지역 미설정' : dto.region}
                    </p>
                    
                    <a href="${pageContext.request.contextPath}/member/updateInfo" 
                       class="btn btn-mypage btn-sm rounded-pill w-100 fw-bold py-2">
                        회원정보 수정
                    </a>
                </div>
                <div class="list-group shadow-sm rounded-4 overflow-hidden border-0 modern-card">
                    <a href="${pageContext.request.contextPath}/admin/mypage" class="list-group-item list-group-item-action py-3 fw-bold bg-light border-0">🚀 관리메뉴</a>
                    <a href="${pageContext.request.contextPath}/admin/mypage?menu=team" class="list-group-item list-group-item-action py-3 border-light">구단 관리</a>
                    <a href="${pageContext.request.contextPath}/admin/mypage?menu=stadium" class="list-group-item list-group-item-action py-3 border-light">구장 관리</a>
                    <a href="${pageContext.request.contextPath}/admin/mypage?menu=member" class="list-group-item list-group-item-action py-3 border-light">회원 관리</a>
                    <a href="${pageContext.request.contextPath}/member/logout" class="list-group-item list-group-item-action py-3 border-0 text-danger fw-bold">로그아웃</a>
                </div>
            </div>
            
            
            
            <div class="col-lg-9">
            
            <c:choose>
            	<c:when test="${param.menu == 'team'}">
  			          <jsp:include page="/WEB-INF/views/admin/mypage/team.jsp" />
            	</c:when>
            	<c:when test="${param.menu == 'stadium'}">
  			          <jsp:include page="/WEB-INF/views/admin/mypage/stadium.jsp" />
            	</c:when>
            	<c:when test="${param.menu == 'member'}">
  			          <jsp:include page="/WEB-INF/views/admin/mypage/member.jsp" />
            	</c:when>
            	
            	
            	<c:otherwise>
                <div class="row g-3 mb-4">
                    <div class="col-md-4">
                        <div class="modern-card p-3 h-100 text-center d-flex flex-column justify-content-center">
                            <span class="text-muted small fw-bold mb-1">전체 구단 수</span>
                            <h3 class="fw-bold m-0">${team.size()} <span class="fs-6 text-muted">개 구단</span></h3>
                        </div>
                    </div>

                    <div class="col-md-4">
                        <div class="modern-card p-3 h-100 text-center d-flex flex-column justify-content-center">
                            <span class="text-muted small fw-bold mb-1">전체 구장 수</span>
                            <h3 class="fw-bold m-0">${stadium.size()} <span class="fs-6 text-muted">개 구장</span></h3>
                        </div>
                    </div>

                    <div class="col-md-4">
                        <div class="modern-card p-3 h-100 text-center d-flex flex-column justify-content-center">
                            <span class="text-muted small fw-bold mb-1">전체 회원 수</span>
                            <h3 class="fw-bold m-0">${member.size()} <span class="fs-6 text-muted">명</span></h3>
                        </div>
                    </div>
                </div>

                <h5 class="fw-bold mb-3 ms-1">📅 문의게시판 "미답변" 게시글</h5>
                
                <jsp:include page="/WEB-INF/views/admin/mypage/qna.jsp" />
                
                </c:otherwise>
            
            </c:choose>
                
            </div> 
            </div> </div> 
           
            
    <footer>
       <jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
    </footer>

    <jsp:include page="/WEB-INF/views/layout/footerResources.jsp"/>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    
    <script type="text/javascript">
    
    
    
    </script>
    
    
</body>
</html>