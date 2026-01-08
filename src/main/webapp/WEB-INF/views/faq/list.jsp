<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>Footlog - FAQ</title>
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
                    
                    <div class="d-flex justify-content-center mt-4">
                        <div class="position-relative w-75">
                            <input type="text" class="form-control rounded-pill py-3 ps-5 border-0 shadow-sm bg-white" placeholder="궁금한 내용을 검색해보세요 (예: 환불)">
                            <i class="bi bi-search position-absolute top-50 start-0 translate-middle-y ms-3 text-muted fs-5"></i>
                        </div>
                    </div>
                </div>

                <ul class="nav nav-pills justify-content-center mb-4 gap-2">
                    <li class="nav-item"><button class="btn btn-dark rounded-pill px-3">전체</button></li>
                    <li class="nav-item"><button class="btn btn-outline-secondary border-0 rounded-pill px-3">회원/계정</button></li>
                    <li class="nav-item"><button class="btn btn-outline-secondary border-0 rounded-pill px-3">구단/매치</button></li>
                    <li class="nav-item"><button class="btn btn-outline-secondary border-0 rounded-pill px-3">결제/환불</button></li>
                    <li class="nav-item"><button class="btn btn-outline-secondary border-0 rounded-pill px-3">기타</button></li>
                </ul>

                <div class="accordion custom-accordion" id="faqAccordion">
                    
                    <div class="accordion-item">
                        <h2 class="accordion-header" id="headingOne">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne">
                                <span class="badge bg-primary text-dark me-3 rounded-pill">구단</span>
                                구단을 생성하려면 조건이 필요한가요?
                            </button>
                        </h2>
                        <div id="collapseOne" class="accordion-collapse collapse" data-bs-parent="#faqAccordion">
                            <div class="accordion-body text-muted bg-light rounded-bottom-4">
                                네, 풋로그 회원이라면 누구나 구단을 생성할 수 있습니다.<br>
                                다만 최소 3명의 초기 멤버가 필요합니다.
                            </div>
                        </div>
                    </div>

                    <div class="accordion-item">
                        <h2 class="accordion-header" id="headingTwo">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseTwo">
                                <span class="badge bg-primary text-dark me-3 rounded-pill">매치</span>
                                매치 신청 후 취소하면 환불되나요?
                            </button>
                        </h2>
                        <div id="collapseTwo" class="accordion-collapse collapse" data-bs-parent="#faqAccordion">
                            <div class="accordion-body text-muted bg-light rounded-bottom-4">
                                경기 시작 24시간 전까지는 100% 환불됩니다.<br>
                                이후에는 50%만 환불되니 주의해주세요.
                            </div>
                        </div>
                    </div>

                    <div class="accordion-item">
                        <h2 class="accordion-header" id="headingThree">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseThree">
                                <span class="badge bg-primary text-dark me-3 rounded-pill">회원</span>
                                비밀번호를 잊어버렸어요.
                            </button>
                        </h2>
                        <div id="collapseThree" class="accordion-collapse collapse" data-bs-parent="#faqAccordion">
                            <div class="accordion-body text-muted bg-light rounded-bottom-4">
                                로그인 화면 하단의 '비밀번호 찾기'를 이용해주세요.
                            </div>
                        </div>
                    </div>
                    
                    <div class="accordion-item">
                        <h2 class="accordion-header" id="headingFour">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseFour">
                                <span class="badge bg-primary text-dark me-3 rounded-pill">기타</span>
                                용병 매칭은 어떻게 진행되나요?
                            </button>
                        </h2>
                        <div id="collapseFour" class="accordion-collapse collapse" data-bs-parent="#faqAccordion">
                            <div class="accordion-body text-muted bg-light rounded-bottom-4">
                                메인 화면 하단의 '용병 모집 및 신청' 배너를 이용해 주세요.
                            </div>
                        </div>
                    </div>

                </div>
                
                <div class="text-center mt-5 p-4 rounded-4 border bg-white">
                    <h5 class="fw-bold mb-2">원하는 답변을 찾지 못하셨나요?</h5>
                    <p class="text-muted mb-3">1:1 문의를 남겨주시면 친절하게 안내해 드릴게요.</p>
                    <a href="${pageContext.request.contextPath}/qna" class="btn btn-dark rounded-pill px-4">문의 게시판 바로가기</a>
                </div>

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