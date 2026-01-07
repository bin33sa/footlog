 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>게시글 보기 - Footlog</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/style.css">
    
    <style>
        /* 댓글 입력창 네온 포커스 효과 */
        .comment-input:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 0.25rem rgba(212, 246, 63, 0.25);
        }
    </style>
</head>
<jsp:include page="/WEB-INF/views/layout/headerResources.jsp"/>

<body>

   <header>
   <jsp:include page="/WEB-INF/views/layout/header.jsp"/>
   </header>

    <div class="container mt-5 mb-5" style="max-width: 900px;">
        
        <div class="modern-card p-5 mb-4">
            
            <div class="border-bottom pb-3 mb-4">
                <div class="d-flex align-items-center gap-2 mb-3">
                    <span class="badge bg-light text-dark border px-3 py-2 rounded-pill">💬 잡담</span>
                </div>
                
                <h2 class="fw-bold mb-3" style="word-break: break-all;">집가고싶다 호호우</h2>
                
                <div class="d-flex justify-content-between align-items-center text-muted small">
                    <div class="d-flex align-items-center gap-2">
                        <img src="${pageContext.request.contextPath}/dist/images/hoho.jpg" class="rounded-circle border" width="30" height="30" style="object-fit: cover;">
                        <span class="fw-bold text-dark">호날두</span>
                        <span class="mx-1">|</span>
                        <span>2025.05.20 14:30</span>
                    </div>
                    <div>
                        <span class="me-3">조회 124</span>
                        <span>댓글 5</span>
                    </div>
                </div>
            </div>

            <div class="content-body mb-5" style="min-height: 200px; line-height: 1.8; word-break: break-all;">
                <p>아 집가고싶다<br>
                저는 그냥 컨디션이 안좋았을뿐이라고요.</p>
                
                </div>

            <div class="d-flex justify-content-between pt-4 border-top">
                <a href="${pageContext.request.contextPath}/bbs/list" class="btn btn-outline-dark rounded-pill px-4 fw-bold">
                    &larr; 목록
                </a>
                
                <div class="d-flex gap-2">
                    <a href="#" class="btn btn-light rounded-pill px-4 fw-bold">수정</a>
                    <button type="button" class="btn btn-light rounded-pill px-4 fw-bold text-danger" onclick="confirmDelete()">삭제</button>
                </div>
            </div>
        </div>

        <div class="modern-card p-4 bg-light border-0">
            <h5 class="fw-bold mb-4">댓글 <span class="text-primary">5</span></h5>
            
            <div class="d-flex gap-3 mb-5">
                <div class="flex-grow-1">
                    <textarea class="form-control comment-input rounded-4 border-0 shadow-sm p-3" rows="2" placeholder="댓글을 남겨보세요. 매너 있는 댓글이 아름다운 커뮤니티를 만듭니다." style="resize: none;"></textarea>
                </div>
                <button class="btn btn-dark rounded-4 px-4 fw-bold" style="color: var(--primary-color);">등록</button>
            </div>

            <div class="vstack gap-3">
                <div class="d-flex gap-3 bg-white p-3 rounded-4 shadow-sm border border-light">
                    <img src="${pageContext.request.contextPath}/dist/images/avatar.png" class="rounded-circle border" style="width:45px; height:45px; object-fit: cover;">
                    <div class="w-100">
                        <div class="d-flex justify-content-between align-items-center mb-1">
                            <h6 class="fw-bold mb-0">손흥민</h6>
                            <small class="text-muted">10분 전</small>
                        </div>
                        <p class="mb-0 text-dark">형, 그래도 훈련은 나오셔야죠.. 감독님 화나셨어요.</p>
                        
                        <div class="mt-2">
                            <button class="btn btn-sm btn-link text-decoration-none text-muted p-0 small">답글</button>
                        </div>
                    </div>
                </div>

                <div class="d-flex gap-3 bg-white p-3 rounded-4 shadow-sm border border-light">
                    <img src="${pageContext.request.contextPath}/dist/images/avatar.png" class="rounded-circle border" style="width:45px; height:45px; object-fit: cover;">
                    <div class="w-100">
                        <div class="d-flex justify-content-between align-items-center mb-1">
                            <h6 class="fw-bold mb-0">메시</h6>
                            <small class="text-muted">30분 전</small>
                        </div>
                        <p class="mb-0 text-dark">Si.</p>
                    </div>
                </div>
            </div>
        </div>

    </div>
    
    <footer>
    	<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
	</footer>

	<jsp:include page="/WEB-INF/views/layout/footerResources.jsp"/>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        function confirmDelete() {
            if(confirm("정말로 이 게시글을 삭제하시겠습니까?")) {
                // 삭제 처리 로직 이동
                // location.href = '...';
            }
        }
    </script>
    
</body>
</html>