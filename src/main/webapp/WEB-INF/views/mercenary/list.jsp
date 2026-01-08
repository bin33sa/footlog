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

<style>
        /* 1. 게시판 테이블 스타일 */
        .board-table thead th { background-color: #111; color: #fff; border: none; padding: 15px; font-weight: 700; }
        .board-table tbody tr { transition: 0.2s; cursor: pointer; }
        .board-table tbody tr:hover { background-color: rgba(212, 246, 63, 0.1); transform: translateY(-2px); box-shadow: 0 5px 15px rgba(0,0,0,0.05); }
        
        /* 2. 페이지네이션 */
        .pagination .page-link { color: #111; border: none; border-radius: 50%; margin: 0 5px; width: 40px; height: 40px; display: flex; align-items: center; justify-content: center; }
        .pagination .page-item.active .page-link { background-color: #111; color: var(--primary-color); font-weight: bold; }
        
        /* 3. 카테고리 버튼 */
        .btn-category { border: 1px solid #ddd; color: #666; font-size: 0.9rem; font-weight: 600; }
        .btn-category:hover, .btn-category.active { background-color: #111; color: #fff; border-color: #111; }

        /* 4. [수정] 네온 검색창 스타일 (사이즈 축소 및 최적화) */
        .neon-search-box {
            background-color: #111; /* 딥 블랙 */
            border: 2px solid #333;
            transition: 0.3s;
            height: 40px; /* 높이 50px -> 40px로 축소 */
            max-width: 350px; /* 너무 길어지지 않게 너비 제한 */
            font-size: 0.9rem; /* 글자 크기 살짝 줄임 */
        }
        .neon-search-box:hover,
        .neon-search-box:focus-within {
            border-color: var(--primary-color, #D4F63F); /* 호버 시 네온 컬러 */
            box-shadow: 0 0 10px rgba(212, 246, 63, 0.2);
        }
        .neon-search-box input::placeholder { color: #888; }
        
        /* Select 화살표를 흰색으로 변경 */
        .neon-search-box select {
            background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 16 16'%3e%3cpath fill='none' stroke='%23ffffff' stroke-linecap='round' stroke-linejoin='round' stroke-width='2' d='m2 5 6 6 6-6'/%3e%3c/svg%3e");
            background-size: 10px; /* 화살표 크기 조절 */
        }
    </style>
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
					<h3><i class="bi bi-app"></i> 용병 게시판 </h3>
				</div>
				
				<div class="body-main">
					
									
					<table class="table table-hover board-list">
						<thead class="table-light">
							<tr>
								<th width="60">번호</th>
								<th>제목</th>
								<th>내용</th>
								<th width="100">작성일</th>
								<th width="70">조회수</th>
							</tr>
						</thead>
						
						<tbody>
							<c:forEach var="dto" items="${list}" varStatus="status">
								<tr>
									<td>${dto.recruit_id}   </td>
									<td>${dto.title}        </td>
									<td>${dto.content}      </td>																		
									<td>${dto.created_at}   </td>
									<td>${dto.view_count}   </td>																
								</tr>
							</c:forEach>
						</tbody>
					</table>							
		
					<div class="row board-list-footer">
						<div class="col">
							<button type="button" class="btn btn-light" onclick="location.href='${pageContext.request.contextPath}/mercenary/list';" title="새로고침"><i class="bi bi-arrow-counterclockwise"></i></button>
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
							<button type="button" class="btn btn-light" onclick="location.href='${pageContext.request.contextPath}/mercenary/write';">글올리기</button>
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
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>