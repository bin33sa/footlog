<<<<<<< HEAD
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Spring</title>
<jsp:include page="/WEB-INF/views/layout/headerResources.jsp"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/board.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/paginate.css" type="text/css">
</head>
<body>

<header>
	<jsp:include page="/WEB-INF/views/layout/header.jsp"/>
</header>

<main>
	<div class="container">
		<div class="body-container row justify-content-center">
			<div class="col-md-10 my-3 p-3">
				<div class="body-title">
					<h3><i class="bi bi-app"></i> 자유 게시판 </h3>
				</div>
				
				<div class="body-main">
					
									
					<table class="table table-hover board-list">
						<thead class="table-light">
							<tr>
								<th width="60">번호</th>
								<th>제목</th>
								<th width="100">작성자</th>
								<th width="100">작성일</th>
								<th width="70">조회수</th>
							</tr>
						</thead>
						
						<tbody>
							<c:forEach var="dto" items="${list}" varStatus="status">
								<tr>
									<td>${dto.recruit_id}   </td>
									<td>${dto.team_code}    </td>
									<td>${dto.match_code}   </td>
									<td>${dto.member_code}  </td>
									<td>${dto.created_at}   </td>
									<td>${dto.status}       </td>
									<td>${dto.title}        </td>
									<td>${dto.content}      </td>
									<td>${dto.view_count}   </td>																
								</tr>
							</c:forEach>
						</tbody>
					</table>							
		
					<div class="row board-list-footer">
						<div class="col">
							<button type="button" class="btn btn-light" onclick="location.href='${pageContext.request.contextPath}/bbs/list';" title="새로고침"><i class="bi bi-arrow-counterclockwise"></i></button>
						</div>
						<div class="col-6 d-flex justify-content-center">
							<form class="row" name="searchForm">
								<div class="col-auto p-1">
									<select name="schType" class="form-select">
										<option value="all" ${schType=="all"?"selected":""}>제목+내용</option>
										<option value="userName" ${schType=="userName"?"selected":""}>작성자</option>
										<option value="reg_date" ${schType=="reg_date"?"selected":""}>등록일</option>
										<option value="subject" ${schType=="subject"?"selected":""}>제목</option>
										<option value="content" ${schType=="content"?"selected":""}>내용</option>
									</select>
								</div>
								<div class="col-auto p-1">
									<input type="text" name="kwd" value="${kwd}" class="form-control">
								</div>
								<div class="col-auto p-1">
									<button type="button" class="btn btn-light" onclick="searchList()"> <i class="bi bi-search"></i> </button>
								</div>
							</form>
						</div>
						<div class="col text-end">
							<button type="button" class="btn btn-light" onclick="location.href='${pageContext.request.contextPath}/bbs/write';">글올리기</button>
						</div>
					</div>
					
				</div>
			</div>
		</div>
	</div>
</main>

<script type="text/javascript">
// 검색 키워드 입력란에서 엔터를 누른 경우 서버 전송 막기 
window.addEventListener('DOMContentLoaded', () => {
	const inputEL = document.querySelector('form input[name=kwd]'); 
	inputEL.addEventListener('keydown', function (evt) {
	    if(evt.key === 'Enter') {
	    	evt.preventDefault();
	    	
	    	searchList();
	    }
	});
});

function searchList() {
	const f = document.searchForm;
	if(! f.kwd.value.trim()) {
		return;
	}
	
	// FormData : 키-값 쌍을 저장하며, multipart/form-data 형식으로 데이터를 보낼 수 있도록 만들어졌다.
	// URLSearchParams : URL의 쿼리 문자열(query string)을 쉽게 다루기 위한 내장 객체
	
	// form 요소를 FormData를 이용하여 URLSearchParams 으로 변환
	const formData = new FormData(f);
	let params = new URLSearchParams(formData).toString();
	
	let url = '${pageContext.request.contextPath}/bbs/list';
	location.href = url + '?' + params;
}
</script>

<footer>
	<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
</footer>

<jsp:include page="/WEB-INF/views/layout/footerResources.jsp"/>
=======
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>Footlog - Mercenary Market</title>
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
                        <p class="sidebar-title">매치</p>
                        <div class="list-group">
                            <a href="${pageContext.request.contextPath}/match/list" class="list-group-item list-group-item-action ">내 매치 일정</a>
                            <a href="${pageContext.request.contextPath}/match/list" class="list-group-item list-group-item-action ">전체 매치 리스트</a>
                            <a href="${pageContext.request.contextPath}/match/write" class="list-group-item list-group-item-action ">매치 개설하기</a>
                            <a href="${pageContext.request.contextPath}/mercenary/list" class="list-group-item list-group-item-action active-menu">용병 구하기</a>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-lg-8 col-12">
                
                <div class="modern-card p-0 mb-4 bg-dark text-white overflow-hidden position-relative">
                    <div class="d-flex align-items-center justify-content-between p-4">
                        <button class="btn btn-icon text-white-50 hover-white"><i class="bi bi-chevron-left fs-4"></i></button>
                        
                        <div class="d-flex align-items-center gap-3 cursor-pointer" onclick="location.href='${pageContext.request.contextPath}/team/team'">
                            <div class="bg-white rounded-circle d-flex align-items-center justify-content-center text-dark" style="width: 50px; height: 50px;">
                                <i class="bi bi-shield-fill fs-3"></i>
                            </div>
                            <div>
                                <span class="badge bg-primary text-dark mb-1">MY TEAM</span>
                                <h5 class="fw-bold mb-0">FC 풋로그 (용병 관리)</h5>
                            </div>
                        </div>

                        <button class="btn btn-icon text-white-50 hover-white"><i class="bi bi-chevron-right fs-4"></i></button>
                    </div>
                </div>

                <div class="d-flex flex-column flex-md-row justify-content-between align-items-center mb-4 gap-3">
                    <div class="search-bar-wrapper w-100 position-relative">
                        <i class="bi bi-search position-absolute top-50 start-0 translate-middle-y ms-3 text-muted"></i>
                        <input type="text" class="form-control rounded-pill ps-5 py-2 border-0 shadow-sm" placeholder="지역, 포지션, 팀명 검색">
                    </div>
                    
                    <div class="d-flex gap-2 w-100 w-md-auto justify-content-end">
                        <select class="form-select rounded-pill border-0 shadow-sm" style="width: 130px;">
                            <option selected>최신순</option>
                            <option value="1">경기임박순</option>
                            <option value="2">급구</option>
                        </select>
                        <button class="btn btn-primary rounded-pill px-4 text-nowrap fw-bold shadow-sm" 
                                onclick="location.href='${pageContext.request.contextPath}/mercenary/write'">
                            용병 모집 올리기 +
                        </button>
                    </div>
                </div>

                <div class="row g-4">
                    
                    <div class="col-md-6">
                        <div class="modern-card p-4 h-100 position-relative hover-up cursor-pointer" onclick="alert('상세 페이지로 이동')">
                            <span class="badge bg-danger position-absolute top-0 end-0 m-3">급구</span>
                            <div class="d-flex align-items-center gap-3 mb-3">
                                <div class="rounded-circle bg-light border d-flex align-items-center justify-content-center" style="width: 50px; height: 50px;">
                                    <img src="https://images.unsplash.com/photo-1522770179533-24471fcdba45?w=100" class="rounded-circle w-100 h-100 object-fit-cover" alt="team">
                                </div>
                                <div>
                                    <h6 class="fw-bold mb-0">FC 썬더볼트</h6>
                                    <span class="text-muted small">서울 마포구 | 실력 중</span>
                                </div>
                            </div>
                            <h5 class="fw-bold mb-2">이번 주 토요일 골키퍼(GK) 모십니다!</h5>
                            <div class="d-flex gap-2 mb-3 text-muted small">
                                <span><i class="bi bi-calendar-event me-1"></i>9.20(토) 18:00</span>
                                <span><i class="bi bi-geo-alt me-1"></i>상암 보조</span>
                            </div>
                            <div class="d-flex justify-content-between align-items-center border-top pt-3">
                                <span class="badge bg-light text-dark border">GK 1명</span>
                                <span class="fw-bold text-primary">참가비 무료</span>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-6">
                        <div class="modern-card p-4 h-100 position-relative hover-up cursor-pointer">
                            <span class="badge bg-primary text-dark position-absolute top-0 end-0 m-3">모집중</span>
                            <div class="d-flex align-items-center gap-3 mb-3">
                                <div class="rounded-circle bg-light border d-flex align-items-center justify-content-center" style="width: 50px; height: 50px;">
                                    <i class="bi bi-shield-shaded fs-3 text-secondary"></i>
                                </div>
                                <div>
                                    <h6 class="fw-bold mb-0">개발자 유나이티드</h6>
                                    <span class="text-muted small">경기 성남시 | 실력 하</span>
                                </div>
                            </div>
                            <h5 class="fw-bold mb-2">윙어/수비수 용병 구합니다 (매너필수)</h5>
                            <div class="d-flex gap-2 mb-3 text-muted small">
                                <span><i class="bi bi-calendar-event me-1"></i>9.21(일) 10:00</span>
                                <span><i class="bi bi-geo-alt me-1"></i>백석 구장</span>
                            </div>
                            <div class="d-flex justify-content-between align-items-center border-top pt-3">
                                <span class="badge bg-light text-dark border">필드 2명</span>
                                <span class="fw-bold">10,000원</span>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-6">
                        <div class="modern-card p-4 h-100 position-relative hover-up cursor-pointer">
                            <span class="badge bg-primary text-dark position-absolute top-0 end-0 m-3">모집중</span>
                            <div class="d-flex align-items-center gap-3 mb-3">
                                <div class="rounded-circle bg-light border d-flex align-items-center justify-content-center" style="width: 50px; height: 50px;">
                                    <i class="bi bi-shield-fill fs-3 text-success"></i>
                                </div>
                                <div>
                                    <h6 class="fw-bold mb-0">그린 풋살</h6>
                                    <span class="text-muted small">서울 강남구 | 실력 중상</span>
                                </div>
                            </div>
                            <h5 class="fw-bold mb-2">오늘 저녁 8시 급하게 1분 모셔요</h5>
                            <div class="d-flex gap-2 mb-3 text-muted small">
                                <span><i class="bi bi-calendar-event me-1"></i>오늘 20:00</span>
                                <span><i class="bi bi-geo-alt me-1"></i>코엑스 옥상</span>
                            </div>
                            <div class="d-flex justify-content-between align-items-center border-top pt-3">
                                <span class="badge bg-light text-dark border">무관 1명</span>
                                <span class="fw-bold">5,000원</span>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-6">
                        <div class="modern-card p-4 h-100 position-relative opacity-75 bg-light">
                            <span class="badge bg-secondary position-absolute top-0 end-0 m-3">마감</span>
                            <div class="d-flex align-items-center gap-3 mb-3">
                                <div class="rounded-circle bg-white border d-flex align-items-center justify-content-center" style="width: 50px; height: 50px;">
                                    <i class="bi bi-shield-fill fs-3 text-muted"></i>
                                </div>
                                <div>
                                    <h6 class="fw-bold mb-0 text-muted">새벽반</h6>
                                    <span class="text-muted small">부산 해운대 | 실력 중</span>
                                </div>
                            </div>
                            <h5 class="fw-bold mb-2 text-muted text-decoration-line-through">내일 새벽 용병 모집합니다</h5>
                            <div class="d-flex gap-2 mb-3 text-muted small">
                                <span><i class="bi bi-calendar-event me-1"></i>9.20(토) 06:00</span>
                                <span><i class="bi bi-geo-alt me-1"></i>해운대</span>
                            </div>
                            <div class="d-flex justify-content-between align-items-center border-top pt-3">
                                <span class="badge bg-white text-muted border">완료</span>
                                <span class="fw-bold text-muted">마감됨</span>
                            </div>
                        </div>
                    </div>

                </div>

                <div class="text-center mt-5 mb-5">
                    <button class="btn btn-light rounded-pill px-5 py-2 shadow-sm text-muted fw-bold hover-scale w-50">
                        더보기 <i class="bi bi-chevron-down ms-1"></i>
                    </button>
                </div>

            </div>

            <div class="col-lg-2 d-none d-lg-block">
                <div class="sidebar-menu sticky-top" style="top: 100px;">
                    <div class="mb-4">
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
>>>>>>> branch 'main' of https://github.com/bin33sa/footlog

</body>
</html>