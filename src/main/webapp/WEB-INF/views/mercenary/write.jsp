<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Footlog - 용병 게시판</title>
<jsp:include page="/WEB-INF/views/layout/headerResources.jsp" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/style.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

<style>
    /* 자유게시판 스타일 적용을 위한 추가 CSS */
    .form-control:focus { border-color: #D4F63F; box-shadow: 0 0 0 0.25rem rgba(212, 246, 63, 0.25); }
    .title-input { font-size: 1.5rem; font-weight: 700; background: transparent; }
    .title-input::placeholder { color: #ccc; }
    .modern-card { background: #fff; border-radius: 20px; }
</style>
</head>
<body>

<header>
	<jsp:include page="/WEB-INF/views/layout/header.jsp"/>
</header>

<main>
    <div class="container mt-5 mb-5" style="max-width: 900px;">
        
        <div class="d-flex align-items-center justify-content-between mb-4 border-bottom pb-3">
            <div>
                <h2 class="fw-bold display-6 mb-1">
                    <i class="bi bi-person-badge"></i> ${mode=='update'?'EDIT RECRUIT':'MERCENARY POST'}
                </h2>
                <p class="text-muted mb-0">용병 모집/지원 내용을 작성해 주세요.</p>
            </div>
        </div>

        <div class="modern-card p-5 shadow-lg">
            <form name="boardForm" method="post">
                
                <div class="mb-4">
                    <label class="d-block text-muted fw-bold small mb-2 ms-1">제 목</label>
                    <input type="text" name="title" value="${dto.title}" 
                           class="form-control title-input border-0 border-bottom rounded-0 px-0 py-2" 
                           placeholder="제목을 입력하세요" required>
                </div>

                <div class="row mb-4">
                    <div class="col-md-6">
                        <label class="d-block text-muted fw-bold small mb-2 ms-1">소속팀 선택</label>
                        <select name="team_code" class="form-select rounded-pill bg-light border-0 px-3" style="height: 45px;">
                            <option value="">소속팀 없음 (개인 지원)</option>
                            <c:forEach var="vo" items="${listTeam}">
                                <option value="${vo.team_code}" ${dto.team_code == vo.team_code ? "selected":""}>${vo.team_name}</option>
                            </c:forEach>
                        </select>
                    </div>
                    
                    <div class="col-md-6">
                        <label class="d-block text-muted fw-bold small mb-2 ms-1">작성자</label>
                        <input type="text" class="form-control rounded-pill bg-light border-0 px-3" 
                               value="${sessionScope.member.member_name}" readonly style="height: 45px;">
                    </div>
                </div>

                <div class="mb-5">
                    <label class="d-block text-muted fw-bold small mb-2 ms-1">모집/지원 상세 내용</label>
                    <textarea name="content" class="form-control border-0 bg-light rounded-4 p-4" 
                              rows="12" placeholder="활동 가능 시간, 지역, 포지션 등 상세 정보를 입력하세요." 
                              style="resize: none;" required>${dto.content}</textarea>
                </div>

                <div class="d-flex justify-content-between align-items-center">
                    <a href="${pageContext.request.contextPath}/mercenary/list" class="text-decoration-none text-muted fw-bold">
                        &larr; 목록으로 돌아가기
                    </a>
                    <div class="d-flex gap-2">
                        <button type="reset" class="btn btn-light rounded-pill px-4 fw-bold">다시쓰기</button>
                        <button type="button" class="btn btn-dark rounded-pill px-5 fw-bold" 
                                style="color: #D4F63F; background-color: #111;" onclick="sendOk();">
                            ${mode=='update'?'수정완료':'등록하기'}
                        </button>
                    </div>
                </div>

                <c:if test="${mode=='update'}">
                    <input type="hidden" name="recruit_id" value="${dto.recruit_id}">
                    <input type="hidden" name="page" value="${page}">
                </c:if>
            </form>
        </div>
    </div>
</main>

<script type="text/javascript">
function sendOk() {
	const f = document.boardForm;
	
	if(!f.title.value.trim()) {
		alert('제목을 입력하세요.');
		f.title.focus();
		return;
	}

	// 팀 선택 여부 검사 로직 삭제 (빈 값인 '소속팀 없음'도 허용)
	
	if(!f.content.value.trim()) {
		alert('내용을 입력하세요.');
		f.content.focus();
		return;
	}

	f.action = '${pageContext.request.contextPath}/mercenary/${mode}';
	f.submit();
}
</script>

<footer>
	<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
</footer>

<jsp:include page="/WEB-INF/views/layout/footerResources.jsp"/>

</body>
</html>