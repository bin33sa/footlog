<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>Footlog - FAQ</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <jsp:include page="/WEB-INF/views/layout/headerResources.jsp"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/style.css">
</head>
<body>

    <header>
       <jsp:include page="/WEB-INF/views/layout/header.jsp"/>
    </header>

    <div class="container-fluid px-lg-5 mt-4">
        <div class="row">
            
            <div class="col-lg-2 d-none d-lg-block">
                <div class="sidebar-menu sticky-top" style="top: 100px;">
                    <div class="mb-4">
                        <p class="sidebar-title">사이트 소개</p>
                        <div class="list-group">
                            <a href="${pageContext.request.contextPath}/introduction" class="list-group-item list-group-item-action">사이트 기능 소개</a>
                            <a href="${pageContext.request.contextPath}/qna/list" class="list-group-item list-group-item-action">문의 게시판</a>
                            <a href="${pageContext.request.contextPath}/faq/list" class="list-group-item list-group-item-action active-menu">자주 묻는 질문 (FAQ)</a>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-lg-8 col-12">
                
                <div class="text-center mb-5">
                    <h2 class="fw-bold mb-3">자주 묻는 질문 (FAQ)</h2>
                    <p class="text-muted">사용자분들이 자주 궁금해하시는 내용을 모았습니다.</p>
                </div>

                <ul class="nav nav-pills justify-content-center mb-4 gap-2">
                    <li class="nav-item">
                        <a href="list?category=0" class="btn ${category == 0 ? 'btn-dark' : 'btn-outline-secondary border-0'} rounded-pill px-3">전체</a>
                    </li>
                    <li class="nav-item">
                        <a href="list?category=1" class="btn ${category == 1 ? 'btn-dark' : 'btn-outline-secondary border-0'} rounded-pill px-3">회원/계정</a>
                    </li>
                    <li class="nav-item">
                        <a href="list?category=2" class="btn ${category == 2 ? 'btn-dark' : 'btn-outline-secondary border-0'} rounded-pill px-3">구단/매치</a>
                    </li>
                    <li class="nav-item">
                        <a href="list?category=3" class="btn ${category == 3 ? 'btn-dark' : 'btn-outline-secondary border-0'} rounded-pill px-3">결제/환불</a>
                    </li>
                    <li class="nav-item">
                        <a href="list?category=4" class="btn ${category == 4 ? 'btn-dark' : 'btn-outline-secondary border-0'} rounded-pill px-3">기타</a>
                    </li>
                </ul>

                <div class="accordion custom-accordion" id="faqAccordion">
                    
                    <c:forEach var="dto" items="${list}">
                        <div class="accordion-item">
                            <h2 class="accordion-header">
                                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapse${dto.board_faq_code}">
                                    <span class="badge bg-primary text-dark me-3 rounded-pill">
                                        <c:choose>
                                            <c:when test="${dto.category == 1}">회원</c:when>
                                            <c:when test="${dto.category == 2}">구단</c:when>
                                            <c:when test="${dto.category == 3}">결제</c:when>
                                            <c:otherwise>기타</c:otherwise>
                                        </c:choose>
                                    </span>
                                    ${dto.title}
                                </button>
                            </h2>
                            <div id="collapse${dto.board_faq_code}" class="accordion-collapse collapse" data-bs-parent="#faqAccordion">
                                <div class="accordion-body text-muted bg-light rounded-bottom-4">
                                    <div style="white-space: pre-wrap;">${dto.content}</div>
                                    
                                    <c:if test="${sessionScope.member.role_level >= 50}">
                                        <div class="text-end mt-2">
                                            <button type="button" class="btn btn-sm btn-outline-danger" onclick="deleteFaq('${dto.board_faq_code}')">삭제</button>
                                        </div>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                    </c:forEach>

                    <c:if test="${empty list}">
                        <div class="text-center py-5 text-muted">등록된 질문이 없습니다.</div>
                    </c:if>

                </div>
                
                <c:if test="${sessionScope.member.role_level >= 50}">
                    <div class="text-end mt-4">
                        <button type="button" class="btn btn-primary rounded-pill px-4" data-bs-toggle="modal" data-bs-target="#writeModal">FAQ 등록</button>
                    </div>
                </c:if>

                <div class="text-center mt-5 p-4 rounded-4 border bg-white">
                    <h5 class="fw-bold mb-2">원하는 답변을 찾지 못하셨나요?</h5>
                    <p class="text-muted mb-3">1:1 문의를 남겨주시면 친절하게 안내해 드릴게요.</p>
                    <a href="${pageContext.request.contextPath}/qna/list" class="btn btn-dark rounded-pill px-4">문의 게시판 바로가기</a>
                </div>

            </div>
        </div>
    </div>

    <div class="modal fade" id="writeModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content border-0 shadow rounded-4">
                <form action="${pageContext.request.contextPath}/faq/write" method="post">
                    <div class="modal-header border-0">
                        <h5 class="modal-title fw-bold">새 FAQ 등록</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body p-4">
                        <div class="mb-3">
                            <label class="form-label fw-semibold">카테고리</label>
                            <select name="category" class="form-select border-0 bg-light rounded-3">
                                <option value="1">회원/계정</option>
                                <option value="2">구단/매치</option>
                                <option value="3">결제/환불</option>
                                <option value="4">기타</option>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-semibold">질문 제목</label>
                            <input type="text" name="title" class="form-control border-0 bg-light rounded-3" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-semibold">답변 내용</label>
                            <textarea name="content" class="form-control border-0 bg-light rounded-3" rows="5" required></textarea>
                        </div>
                    </div>
                    <div class="modal-footer border-0 p-4">
                        <button type="submit" class="btn btn-dark w-100 py-3 rounded-pill fw-bold">등록하기</button>
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
    function deleteFaq(code) {
        if(confirm("이 FAQ를 삭제하시겠습니까?")) {
            location.href = "${pageContext.request.contextPath}/faq/delete?board_faq_code=" + code;
        }
    }
    </script>
</body>
</html>