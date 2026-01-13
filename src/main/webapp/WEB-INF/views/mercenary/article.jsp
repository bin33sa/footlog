
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>게시글 보기 - Footlog</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/style.css">

<style>
.comment-input:focus {
	border-color: var(--primary-color);
	box-shadow: 0 0 0 0.25rem rgba(212, 246, 63, 0.25);
}
</style>
</head>
<jsp:include page="/WEB-INF/views/layout/headerResources.jsp" />

<body>

	<header>
		<jsp:include page="/WEB-INF/views/layout/header.jsp" />
	</header>

	<div class="container mt-5 mb-5" style="max-width: 900px;">
		<div class="modern-card p-5 mb-4 shadow-sm border rounded-4">
			<div class="border-bottom pb-3 mb-4">
				<div class="d-flex align-items-center gap-2 mb-3">
					<span class="badge bg-dark text-white px-3 py-2 rounded-pill"
						style="color: var(--primary-color) !important;">
						${dto.status} </span> 
					<span class="badge bg-light text-dark border px-3 py-2 rounded-pill">${dto.region}</span>
				</div>

				<h2 class="fw-bold mb-3" style="word-break: break-all;">${dto.title}</h2>

				<div class="d-flex justify-content-between align-items-center text-muted small">
					<div class="d-flex align-items-center gap-2">
						<span class="fw-bold text-dark">${dto.member_name}</span>
						<span class="mx-1">|</span> <span>${dto.created_at}</span>
					</div>
					<div>
						<span class="me-3">조회 ${dto.view_count}</span>
					</div>
				</div>
			</div>

			<div class="content-body mb-5"
				style="min-height: 250px; line-height: 1.8; word-break: break-all; white-space: pre-wrap;">${dto.content}</div>

			<div class="d-flex justify-content-between pt-4 border-top">
                <a href="${pageContext.request.contextPath}/mercenary/list?page=${page}" class="btn btn-outline-dark rounded-pill px-4 fw-bold">
                    &larr; 목록
                </a>

                <div class="d-flex gap-2">
                    <%-- 권한 확인: 세션의 member_code와 작성자의 member_code 비교 --%>
                    <c:choose>
                        <c:when test="${sessionScope.member.member_code == dto.member_code}">
            			<a href="${pageContext.request.contextPath}/mercenary/update?recruit_id=${dto.recruit_id}&page=${page}" 
               			class="btn btn-light rounded-pill px-4 fw-bold">수정</a>
                            
                            <%-- 삭제 버튼: JavaScript 함수 호출 --%>
                            <button type="button" class="btn btn-light rounded-pill px-4 fw-bold text-danger" 
                                onclick="deleteOk();">삭제</button>
                        </c:when>
                        <c:otherwise>
                            <%-- 권한이 없을 경우 버튼을 비활성화하거나 숨김 (참조 코드 방식) --%>
                            <button type="button" class="btn btn-light rounded-pill px-4 fw-bold" disabled>수정</button>
                            <button type="button" class="btn btn-light rounded-pill px-4 fw-bold text-danger" disabled>삭제</button>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </div>
		
		<div class="reply-container mt-3 p-3">
            <div class="reply-form-box border rounded p-4 bg-light shadow-sm">
                <form name="replyForm" method="post">
                    <div class="form-header mb-2">
                        <span class="fw-bold"><i class="bi bi-chat-dots"></i> 댓글 작성</span>
                        <span class="text-muted ms-2" style="font-size: 0.8rem;">- 타인 비방 시 삭제될 수 있습니다.</span>
                    </div>
                    
                    <div class="d-flex gap-2">
                        <div class="flex-grow-1">
                            <textarea class="form-control border-0 shadow-none" name="content" id="replyContent" 
                                      placeholder="매너 있는 댓글을 남겨주세요." rows="3" 
                                      style="resize: none; border-radius: 10px;"></textarea>
                        </div>
                        <div class="d-flex align-items-stretch">
                            <button type="button" class="btn btn-dark btnSendReply px-4 fw-bold" 
                                    style="border-radius: 10px; background-color: #212529;">등록</button>
                        </div>
                    </div>
                </form>
            </div>

            <div id="listReply" class="mt-4" 
                 data-contextPath="${pageContext.request.contextPath}" 
                 data-postsUrl="${pageContext.request.contextPath}/mercenary"
                 data-num="${dto.recruit_id}">
                 <div class="reply-info mb-2"><span class="fw-bold"></span></div>
                <div class="list-content"></div>
                <div class="list-footer mt-3">
                    <div class="page-navigation text-center"></div>
                </div>
            </div>

        
    <script>
		// 삭제 로직: 참조하신 코드의 방식을 적용
		function deleteOk() {
			if (confirm("정말로 이 게시글을 삭제하시겠습니까?")) {
				// recruit_id와 현재 페이지 정보를 함께 전달
				let url = "${pageContext.request.contextPath}/mercenary/delete?recruit_id=${dto.recruit_id}&page=${page}";
				location.href = url;
			}
		}
	</script>   
	 
	
        
	<footer>
		<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
	</footer>
	
	<jsp:include page="/WEB-INF/views/layout/footerResources.jsp" />

	<script type="text/javascript" src="${pageContext.request.contextPath}/dist/js2/postsReply.js"></script>
	
</body>
</html>