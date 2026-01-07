<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>Footlog - 1:1 Inquiry</title>
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

            <div class="col-lg-8 col-12">
                
                <div class="d-flex flex-wrap justify-content-between align-items-end mb-4">
                    <div>
                        <h2 class="fw-bold mb-2">문의 게시판</h2>
                        <p class="text-muted mb-0">궁금한 점이나 불편한 사항을 남겨주세요. 관리자가 답변해 드립니다.</p>
                    </div>
                    <button class="btn btn-primary rounded-pill px-4 mt-3 mt-md-0 shadow-sm fw-bold">
                        <i class="bi bi-pencil-fill me-1"></i> 문의하기
                    </button>
                </div>

                <div class="modern-card p-0 overflow-hidden">
                    <div class="table-responsive">
                        <table class="table table-hover mb-0 qna-table">
                            <thead class="bg-light">
                                <tr>
                                    <th scope="col" class="text-center py-3" style="width: 80px;">상태</th>
                                    <th scope="col" class="py-3">제목</th>
                                    <th scope="col" class="text-center py-3" style="width: 120px;">작성자</th>
                                    <th scope="col" class="text-center py-3" style="width: 120px;">작성일</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td class="text-center align-middle">
                                        <span class="badge bg-dark text-primary rounded-pill px-3 py-2">답변완료</span>
                                    </td>
                                    <td class="align-middle">
                                        <a href="#" class="text-decoration-none text-dark fw-bold d-block text-truncate">
                                            <i class="bi bi-lock-fill text-muted me-1"></i>
                                            구장 예약 취소 환불 규정이 궁금합니다.
                                        </a>
                                    </td>
                                    <td class="text-center align-middle text-muted">슛돌이</td>
                                    <td class="text-center align-middle text-muted small">2025.08.15</td>
                                </tr>

                                <tr>
                                    <td class="text-center align-middle">
                                        <span class="badge bg-secondary bg-opacity-25 text-secondary rounded-pill px-3 py-2">답변대기</span>
                                    </td>
                                    <td class="align-middle">
                                        <a href="#" class="text-decoration-none text-dark d-block text-truncate">
                                            <i class="bi bi-lock-fill text-muted me-1"></i>
                                            매치 매칭이 계속 실패하는데 오류인가요?
                                        </a>
                                    </td>
                                    <td class="text-center align-middle text-muted">메시</td>
                                    <td class="text-center align-middle text-muted small">2025.08.14</td>
                                </tr>

                                <tr>
                                    <td class="text-center align-middle">
                                        <span class="badge bg-dark text-primary rounded-pill px-3 py-2">답변완료</span>
                                    </td>
                                    <td class="align-middle">
                                        <a href="#" class="text-decoration-none text-dark d-block text-truncate">
                                            <span class="badge bg-danger me-1">공지</span>
                                            [필독] 문의 게시판 이용 수칙 안내
                                        </a>
                                    </td>
                                    <td class="text-center align-middle text-muted">관리자</td>
                                    <td class="text-center align-middle text-muted small">2025.08.01</td>
                                </tr>
                                
                                <tr>
                                    <td class="text-center align-middle"><span class="badge bg-secondary bg-opacity-25 text-secondary rounded-pill px-3 py-2">답변대기</span></td>
                                    <td class="align-middle"><a href="#" class="text-decoration-none text-dark"><i class="bi bi-lock-fill text-muted me-1"></i> 포인트 충전이 안돼요</a></td>
                                    <td class="text-center align-middle text-muted">호날두</td>
                                    <td class="text-center align-middle text-muted small">2025.08.13</td>
                                </tr>
                                <tr>
                                    <td class="text-center align-middle"><span class="badge bg-dark text-primary rounded-pill px-3 py-2">답변완료</span></td>
                                    <td class="align-middle"><a href="#" class="text-decoration-none text-dark"><i class="bi bi-lock-fill text-muted me-1"></i> 팀 생성 승인은 언제 되나요?</a></td>
                                    <td class="text-center align-middle text-muted">손흥민</td>
                                    <td class="text-center align-middle text-muted small">2025.08.12</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>

                <div class="d-flex justify-content-center mb-4">
                    <div class="input-group w-50">
                        <select class="form-select flex-grow-0" style="width: 100px;">
                            <option selected>제목</option>
                            <option value="1">내용</option>
                            <option value="2">작성자</option>
                        </select>
                        <input type="text" class="form-control" placeholder="검색어를 입력하세요">
                        <button class="btn btn-dark" type="button">검색</button>
                    </div>
                </div>

                <nav aria-label="Page navigation">
                    <ul class="pagination justify-content-center">
                        <li class="page-item disabled">
                            <a class="page-link border-0 rounded-circle mx-1 text-dark" href="#" tabindex="-1">&lt;</a>
                        </li>
                        <li class="page-item"><a class="page-link border-0 rounded-circle mx-1 bg-dark text-primary fw-bold" href="#">1</a></li>
                        <li class="page-item"><a class="page-link border-0 rounded-circle mx-1 text-dark" href="#">2</a></li>
                        <li class="page-item"><a class="page-link border-0 rounded-circle mx-1 text-dark" href="#">3</a></li>
                        <li class="page-item"><a class="page-link border-0 rounded-circle mx-1 text-dark" href="#">4</a></li>
                        <li class="page-item"><a class="page-link border-0 rounded-circle mx-1 text-dark" href="#">5</a></li>
                        <li class="page-item">
                            <a class="page-link border-0 rounded-circle mx-1 text-dark" href="#">&gt;</a>
                        </li>
                    </ul>
                </nav>

            </div>

            <div class="col-lg-2 d-none d-lg-block">
                <div class="sidebar-menu sticky-top" style="top: 100px;">
                    <div class="mb-4">
                        <p class="sidebar-title">Community</p>
                        <div class="list-group">
                            <a href="#" class="list-group-item list-group-item-action">게시판</a>
                            <a href="#" class="list-group-item list-group-item-action">공지사항</a>
                            <a href="#" class="list-group-item list-group-item-action">자유 게시판</a>
                            <a href="#" class="list-group-item list-group-item-action">팀 사진첩</a>
                            <a href="#" class="list-group-item list-group-item-action">이벤트 / 뉴스</a>
                        </div>
                    </div>
                </div>
            </div>

        </div> </div> 
        <footer>
	   <jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
	</footer>
	
	<jsp:include page="/WEB-INF/views/layout/footerResources.jsp"/>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>