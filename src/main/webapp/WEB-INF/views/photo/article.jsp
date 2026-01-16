<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <title>갤러리 상세 - Footlog</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/style.css">
</head>
	<jsp:include page="/WEB-INF/views/layout/headerResources.jsp"/>
<body>

    <header>
	   <jsp:include page="/WEB-INF/views/layout/header.jsp"/>
	</header>

    <div class="container mt-5 mb-5" style="max-width: 500px;">
        
        <div class="modern-card p-5 mb-4 shadow-sm">
            
            <div class="border-bottom pb-3 mb-4">
                <span class="badge bg-dark text-white border px-3 py-2 rounded-pill mb-2">📷 Gallery</span>
                <h2 class="fw-bold mb-3">새 유니폼 도착했습니다! 실착샷 공유</h2>
                <div class="d-flex justify-content-between align-items-center text-muted small">
                    <div>
                        <span class="fw-bold text-dark me-2">손흥민</span>
                        <span>2026.01.07 18:30</span>
                    </div>
                     <div>
                        <span class="me-3">조회 1,520</span>
                    </div>
                </div>
            </div>

            <div class="text-center mb-5 bg-light rounded-4 p-2">
                <img src="https://via.placeholder.com/800x600/111/D4F63F?text=Best+Uniform+Shot" class="gallery-main-img" alt="본문 이미지">
            </div>

            <div class="content-body mb-5" style="font-size: 1.05rem; line-height: 1.8;">
                <p>이번 시즌 팀 유니폼이 드디어 도착해서 바로 입어봤습니다.</p>
                <p>생각보다 색감이 훨씬 쨍하고 예쁘네요! 재질도 가볍고 땀 배출이 잘 될 것 같습니다.</p>
                <br>
                <p>이번 주말 경기 때 입고 뛸 생각하니 벌써 설레네요 ㅎㅎ</p>
                <p>다들 즐거운 풋살 하세요!</p>
            </div>

            <div class="d-flex justify-content-between pt-4 border-top align-items-center">
                <a href="${pageContext.request.contextPath}/photo/list" class="btn btn-outline-dark rounded-pill px-4 fw-bold">
                    &larr; 목록
                </a>
                
                <div class="d-flex gap-2">
                    <button type="button" class="btn btn-light rounded-pill px-4 fw-bold" onclick="alert('수정 기능 준비중');">수정</button>
                    <button type="button" class="btn btn-light rounded-pill px-4 fw-bold text-danger" onclick="deletePhoto();">삭제</button>
                </div>
            </div>
            
            <div class="mt-4">
                <table class="table table-borderless table-sm small">
                    <tr>
                        <td width="60" class="text-secondary fw-bold">이전글 <span class="text-muted">▲</span></td>
                        <td>
                            <a href="#" class="text-decoration-none text-dark">주말 상암 원정 경기 단체사진</a>
                        </td>
                    </tr>
                    <tr>
                        <td class="text-secondary fw-bold">다음글 <span class="text-muted">▼</span></td>
                        <td>
                            <span class="text-muted">다음글이 없습니다.</span>
                        </td>
                    </tr>
                </table>
            </div>

        </div>
    </div>
    
    <footer>
	   <jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
	</footer>

	<jsp:include page="/WEB-INF/views/layout/footerResources.jsp"/>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        function deletePhoto() {
            if(confirm("정말 이 사진을 삭제하시겠습니까?")) {
                alert("삭제되었습니다 (DB 연동 필요)");
                location.href = "${pageContext.request.contextPath}/photo/list";
            }
        }
    </script>
    
</body>
</html>