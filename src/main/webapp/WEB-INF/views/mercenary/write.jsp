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

					<form name="boardForm" method="post">
						<table class="table mt-5 write-form">
							<tr>
								<td class="bg-light col-sm-2" scope="row">제 목</td>
								<td>
									<input type="text" name="title" maxlength="100" class="form-control" value="${dto.title}">
								</td>
							</tr>

							<tr>
								<td class="bg-light col-sm-2" scope="row">소속팀</td>
		 						<td>
									<select name="team_code" class="form-select">
										<c:forEach var="vo" items="${listTeam}">
											<option value="${vo.team_code}" ${dto.team_code == vo.team_code ? "selected":""}>${vo.team_name}</option>
										</c:forEach>
									</select>
								</td>
							</tr>
		        
							<tr>
								<td class="bg-light col-sm-2" scope="row">작성자명</td>
		 						<td>
									<p class="form-control-plaintext">${sessionScope.member.member_code}</p>
								</td>
							</tr>
		
							<tr>
								<td class="bg-light col-sm-2" scope="row">내 용</td>
								<td>
									<textarea name="content" class="form-control">${dto.content}</textarea>
								</td>
							</tr>
						</table>
						
						<table class="table table-borderless">
		 					<tr>
								<td class="text-center">
									<button type="button" class="btn btn-dark" onclick="sendOk();">${mode=='update'?'수정완료':'등록완료'}&nbsp;<i class="bi bi-check2"></i></button>
									<button type="reset" class="btn btn-light">다시입력</button>
									<button type="button" class="btn btn-light" onclick="location.href='${pageContext.request.contextPath}/mercenary/list';">${mode=='update'?'수정취소':'등록취소'}&nbsp;<i class="bi bi-x"></i></button>
									<c:if test="${mode=='update'}">
										<input type="hidden" name="num" value="${dto.num}">
										<input type="hidden" name="page" value="${page}">
									</c:if>
								</td>
							</tr>
						</table>
					</form>

				</div>
			</div>
		</div>
	</div>
</main>

<script type="text/javascript">
function sendOk() {
	const f = document.boardForm;
	let str;
	
	str = f.title.value.trim();
	if( ! str ) {
		alert('제목을 입력하세요. ');
		f.title.focus();
		return;
	}

	str = f.team_code.value.trim();
	if( ! str ) {
		alert('팀을 선택하세요!. ');
		f.team_code.focus();
		return;
	}
	
	str = f.content.value.trim();
	if( ! str ) {
		alert('내용을 입력하세요. ');
		f.content.focus();
		return;
	}

	f.action = '${pageContext.request.contextPath}/mercenary/${mode}';
	f.submit();
}
</script>

<footer>
	<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
</footer>

<jsp:include page="/WEB-INF/views/layout/footerResources.jsp"/>

</body>
</html>