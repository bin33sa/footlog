<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <title>이벤트 - Footlog</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/style.css">
    
    <style>
        .badge-event-ing { background-color: var(--primary-color, #D4F63F); color: #111; border: none; font-weight: 800; }
        .content-body img { max-width: 100%; height: auto; border-radius: 8px; margin-bottom: 20px; }
    </style>
</head>
	<jsp:include page="/WEB-INF/views/layout/headerResources.jsp"/>
<body>

    <header>
  	 	<jsp:include page="/WEB-INF/views/layout/header.jsp"/>
	</header>


    <div class="container mt-5 mb-5" style="max-width: 900px;">
        
        <div class="modern-card p-5 mb-4 shadow-sm border-top border-5 border-dark">
            
            <div class="border-bottom pb-3 mb-4">
                <div class="d-flex align-items-center gap-2 mb-3">
                    <span class="badge badge-event-ing px-3 py-2 rounded-pill">🎉 진행중</span>
                    <span class="text-muted small">2026.01.01 ~ 2026.01.31</span>
                </div>
                
                <h2 class="fw-bold mb-3" style="word-break: break-all;">
                    [신년 이벤트] 새해 첫 골(Goal)을 인증하세요!
                </h2>
                
                <div class="d-flex justify-content-between align-items-center text-muted small">
                    <div class="d-flex align-items-center gap-2">
                        <span class="badge bg-dark text-white border">MANAGER</span>
                        <span class="fw-bold text-dark">관리자</span>
                        <span class="mx-1">|</span>
                        <span>2026.01.01 10:00</span>
                    </div>
                    <div>
                        <span class="me-3">조회 5,421</span>
                    </div>
                </div>
            </div>

            <div class="content-body mb-5" style="min-height: 300px; line-height: 1.8; word-break: break-all; font-size: 1.05rem;">
                
                <div class="text-center mb-4">
                    <img src="https://via.placeholder.com/800x400/111/D4F63F?text=Happy+New+Year+Event" alt="이벤트 이미지" class="img-fluid shadow-sm">
                </div>

                <p>안녕하세요, 풋로그 회원 여러분!</p>
                <p>2026년 새해가 밝았습니다. 모두 새해 복 많이 받으세요! 🙇‍♂️</p>
                <br>
                <p>새해를 맞아 풋로그에서 <strong>특별한 이벤트</strong>를 준비했습니다.</p>
                <p>여러분의 2026년 첫 풋살/축구 경기에서 터뜨린 멋진 <strong>'첫 골'</strong> 영상을 자유게시판에 인증해주세요.</p>
                <br>
                <p class="p-3 bg-light rounded border">
                    <strong>🎁 이벤트 기간:</strong> 1월 1일 ~ 1월 31일<br>
                    <strong>🎁 참여 방법:</strong> [이벤트] 말머리를 달고 골 영상 업로드<br>
                    <strong>🎁 경품:</strong><br>
                    - 1등(1명): 25/26 시즌 유니폼 (팀 선택 가능)<br>
                    - 2등(5명): 풋살화 가방<br>
                    - 참가상(전원): 500 포인트 지급
                </p>
                <br>
                <p>많은 참여 부탁드립니다!</p>
            </div>

            <div class="d-flex justify-content-between pt-4 border-top align-items-center">
			    <a href="${pageContext.request.contextPath}/event/list" class="btn btn-outline-dark rounded-pill px-4 fw-bold">
			        &larr; 목록
			    </a>
			    
                <div class="d-flex gap-2">
			        <button type="button" class="btn btn-light rounded-pill px-4 fw-bold" onclick="alert('준비중');">수정</button>
			        <button type="button" class="btn btn-light rounded-pill px-4 fw-bold text-danger" onclick="alert('준비중');">삭제</button>
			    </div>
			</div>
            
            <div class="mt-4">
                <table class="table table-borderless table-sm small">
                    <tr>
                        <td width="60" class="text-secondary fw-bold">이전글 <span class="text-muted">▲</span></td>
                        <td>
                             <a href="#" class="text-decoration-none text-dark">
                                [종료] 크리스마스 매치 매칭 수수료 무료 이벤트
                            </a>
                        </td>
                    </tr>
                    <tr>
                        <td class="text-secondary fw-bold">다음글 <span class="text-muted">▼</span></td>
                        <td>
                            <a href="#" class="text-decoration-none text-dark">
                               풋로그 1주년 기념 포인트 2배 적립 이벤트
                            </a>
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
    
</body>
</html>