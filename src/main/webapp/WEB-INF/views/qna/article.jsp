<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>Footlog - Inquiry Detail</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/style.css">
    <style>
        .qna-content { min-height: 200px; white-space: pre-wrap; line-height: 1.8; }
        .answer-box { background-color: #f8f9fa; border-left: 5px solid #111; border-radius: 0 15px 15px 0; }
        .active-menu { background-color: #111 !important; color: #D4F63F !important; border-color: #111 !important; font-weight: bold; }
        .btn-edit-answer { color: #666; font-size: 0.85rem; text-decoration: none; cursor: pointer; }
        .btn-edit-answer:hover { color: #111; text-decoration: underline; }
    </style>
</head>
<jsp:include page="/WEB-INF/views/layout/headerResources.jsp"/>
<body>
    <header>
        <jsp:include page="/WEB-INF/views/layout/header.jsp"/>
    </header>

    <div class="container-fluid px-lg-5 mt-4 mb-5">
        <div class="row">
            <div class="col-lg-2 d-none d-lg-block">
                <div class="sidebar-menu sticky-top" style="top: 100px;">
                    <div class="mb-4">
                        <p class="sidebar-title">사이트 소개</p>
                        <div class="list-group">
                            <a href="${pageContext.request.contextPath}/introduction" class="list-group-item list-group-item-action">사이트 기능 소개</a>
                            <a href="${pageContext.request.contextPath}/qna/list" class="list-group-item list-group-item-action active-menu">문의 게시판</a>
                            <a href="${pageContext.request.contextPath}/faq/list" class="list-group-item list-group-item-action">자주 묻는 질문 (Q/A)</a>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-lg-10 col-12 px-lg-4">
                <div class="d-flex justify-content-between align-items-center mb-4 border-bottom pb-3">
                    <div>
                        <span class="badge ${dto.status == 2 ? 'bg-dark text-primary' : 'bg-secondary bg-opacity-25 text-secondary'} rounded-pill px-3 py-2 mb-2">
                            ${dto.status == 2 ? '답변완료' : '답변대기'}
                        </span>
                        <h2 class="fw-bold d-block">${dto.title}</h2>
                        <div class="text-muted small mt-2">
                            <span class="me-3"><i class="bi bi-person me-1"></i>${dto.member_name}</span>
                            <span class="me-3"><i class="bi bi-calendar3 me-1"></i>${dto.created_at}</span>
                            <span><i class="bi bi-tag me-1"></i>${dto.category==1?'계정':(dto.category==2?'구장관련':'기타')}</span>
                        </div>
                    </div>
                </div>

                <%-- 질문 내용 영역 --%>
                <div class="modern-card p-4 p-md-5 bg-white shadow-sm mb-4">
                    <div class="qna-content text-dark">
                        ${dto.content}
                    </div>
                    
                    <div class="text-end mt-4">
                        <c:if test="${sessionScope.member.member_code == dto.member_code || sessionScope.member.role_level >= 50}">
                            <button type="button" class="btn btn-outline-danger btn-sm rounded-pill px-3" 
                                    onclick="if(confirm('정말 삭제하시겠습니까?')) location.href='${pageContext.request.contextPath}/qna/delete?board_qna_code=${dto.board_qna_code}&page=${page}';">
                                삭제하기
                            </button>
                        </c:if>
                    </div>
                </div>

                <%-- 답변 영역 --%>
                <div id="answerSection">
                    <c:choose>
                        <%-- 1. 답변이 이미 있는 경우 --%>
                        <c:when test="${not empty dto.answer}">
                            <div class="answer-box p-4 p-md-5 mb-4 shadow-sm" id="answerDisplay">
                                <div class="d-flex align-items-center justify-content-between mb-4">
                                    <div class="d-flex align-items-center">
                                        <div class="bg-dark text-primary rounded-circle p-2 me-3" style="width: 40px; height: 40px; display: flex; align-items: center; justify-content: center;">
                                            <i class="bi bi-chat-dots-fill"></i>
                                        </div>
                                        <h4 class="fw-bold mb-0">관리자 답변</h4>
                                    </div>
                                    
                                    <%-- 관리자 전용 수정/삭제 버튼 --%>
                                    <c:if test="${sessionScope.member.role_level >= 50}">
                                        <div class="small">
                                            <span class="btn-edit-answer me-2" onclick="showUpdateForm()"><i class="bi bi-pencil me-1"></i>수정</span>
                                            <span class="btn-edit-answer text-danger" onclick="deleteAnswer()"><i class="bi bi-trash me-1"></i>삭제</span>
                                        </div>
                                    </c:if>
                                </div>
                                <div class="qna-content text-secondary">${dto.answer}</div>
                            </div>
                        </c:when>
                        
                        <%-- 2. 답변이 없고 관리자인 경우 (작성 폼) --%>
                        <c:when test="${sessionScope.member.role_level >= 50 && empty dto.answer}">
                            <div class="modern-card p-4 p-md-5 border-primary shadow-sm mb-4" style="border-top: 5px solid #D4F63F;">
                                <h4 class="fw-bold mb-4"><i class="bi bi-pencil-square me-2"></i>답변 작성 (관리자 전용)</h4>
                                <form action="${pageContext.request.contextPath}/qna/answer" method="post" name="answerForm">
                                    <input type="hidden" name="board_qna_code" value="${dto.board_qna_code}">
                                    <input type="hidden" name="page" value="${page}">
                                    <textarea name="answer" class="form-control mb-3" rows="6" placeholder="답변 내용을 입력하세요..." required></textarea>
                                    <div class="text-end">
                                        <button type="submit" class="btn btn-dark rounded-pill px-5 fw-bold">답변 등록</button>
                                    </div>
                                </form>
                            </div>
                        </c:when>
                    </c:choose>
                </div>

                <%-- 답변 수정 폼 (기본 숨김) --%>
                <c:if test="${sessionScope.member.role_level >= 50 && not empty dto.answer}">
                    <div id="answerUpdateForm" class="modern-card p-4 p-md-5 border-primary shadow-sm mb-4 d-none" style="border-top: 5px solid #D4F63F;">
                        <h4 class="fw-bold mb-4"><i class="bi bi-pencil-square me-2"></i>답변 수정</h4>
                        <form action="${pageContext.request.contextPath}/qna/answer" method="post">
                            <input type="hidden" name="board_qna_code" value="${dto.board_qna_code}">
                            <input type="hidden" name="page" value="${page}">
                            <textarea name="answer" id="updateTextarea" class="form-control mb-3" rows="6" required>${dto.answer}</textarea>
                            <div class="text-end">
                                <button type="button" class="btn btn-light rounded-pill px-4 me-2" onclick="hideUpdateForm()">취소</button>
                                <button type="submit" class="btn btn-dark rounded-pill px-5 fw-bold">수정 완료</button>
                            </div>
                        </form>
                    </div>
                </c:if>

                <div class="text-center mt-5">
                    <button type="button" class="btn btn-outline-dark rounded-pill px-5 fw-bold" 
                            onclick="location.href='${pageContext.request.contextPath}/qna/list?page=${page}';">목록으로 돌아가기</button>
                </div>
            </div>
        </div>
    </div>

    <footer>
        <jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
    </footer>
    <jsp:include page="/WEB-INF/views/layout/footerResources.jsp"/>

    <script>
        // 답변 수정 폼 보이기
        function showUpdateForm() {
            document.getElementById('answerDisplay').classList.add('d-none');
            document.getElementById('answerUpdateForm').classList.remove('d-none');
            document.getElementById('updateTextarea').focus();
        }

        // 답변 수정 취소
        function hideUpdateForm() {
            document.getElementById('answerDisplay').classList.remove('d-none');
            document.getElementById('answerUpdateForm').classList.add('d-none');
        }

        // 답변 삭제 로직
        function deleteAnswer() {
            if(confirm('답변을 삭제하시겠습니까? \n삭제 시 질문 상태가 [답변대기]로 변경됩니다.')) {
                // Controller에 추가할 deleteAnswer 매핑 주소
                location.href = '${pageContext.request.contextPath}/qna/deleteAnswer?board_qna_code=${dto.board_qna_code}&page=${page}';
            }
        }
    </script>
</body>
</html>