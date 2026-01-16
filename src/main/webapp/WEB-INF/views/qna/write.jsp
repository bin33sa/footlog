<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>Footlog - Inquiry</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/style.css">
</head>
<jsp:include page="/WEB-INF/views/layout/headerResources.jsp"/>
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
                            <a href="${pageContext.request.contextPath}/qna/list" class="list-group-item list-group-item-action active-menu">문의 게시판</a>
                            <a href="${pageContext.request.contextPath}/faq/list" class="list-group-item list-group-item-action">자주 묻는 질문 (Q/A)</a>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-lg-10 col-12 px-lg-4">
                <div class="d-flex align-items-center mb-4">
                    <h2 class="fw-bold mb-0">1:1 문의 작성</h2>
                    <span class="ms-3 text-muted small">관리자가 확인 후 신속하게 답변해 드립니다.</span>
                </div>

                <div class="modern-card p-5 bg-white shadow-sm mb-5">
                    <form action="${pageContext.request.contextPath}/qna/write" method="post">
                        <div class="row mb-4">
                            <div class="col-md-4">
                                <label for="category" class="form-label fw-bold">문의 분류</label>
                                <select class="form-select bg-light border-0" id="category" name="category" required>
                                    <option value="" selected disabled>분류 선택</option>
                                    <option value="1">계정 관련</option>
                                    <option value="2">구장 예약/환불</option>
                                    <option value="3">매치/팀 관련</option>
                                    <option value="4">기타 문의</option>
                                </select>
                            </div>
                            <div class="col-md-8">
                                <label for="title" class="form-label fw-bold">제목</label>
                                <input type="text" class="form-control bg-light border-0" id="title" name="title" 
                                       placeholder="문의하실 내용을 요약해서 적어주세요." required>
                            </div>
                        </div>

                        <div class="mb-4">
                            <label class="form-label fw-bold">작성자</label>
                            <input type="text" class="form-control bg-light border-0" 
                                   value="${sessionScope.member.member_name}" readonly disabled>
                        </div>

                        <div class="mb-4">
                            <div class="form-check form-switch">
                                <input class="form-check-input" type="checkbox" role="switch" id="secretCheck" name="isSecret" checked disabled>
                                <label class="form-check-label fw-bold text-muted" for="secretCheck">
                                    <i class="bi bi-lock-fill me-1"></i>비밀글로 작성 (기본 설정)
                                </label>
                            </div>
                        </div>

                        <div class="mb-4">
                            <label for="content" class="form-label fw-bold">내용</label>
                            <textarea class="form-control bg-light border-0" id="content" name="content" rows="10" 
                                      placeholder="구체적인 내용을 적어주시면 더 정확한 답변이 가능합니다." required></textarea>
                        </div>

                        <hr class="my-5">

                        <div class="d-flex justify-content-end gap-2">
                            <button type="button" class="btn btn-light rounded-pill px-4 fw-bold" 
                                    onclick="location.href='${pageContext.request.contextPath}/qna/list';">취소</button>
                            <button type="submit" class="btn btn-dark rounded-pill px-5 fw-bold">문의 등록하기</button>
                        </div>
                    </form>
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