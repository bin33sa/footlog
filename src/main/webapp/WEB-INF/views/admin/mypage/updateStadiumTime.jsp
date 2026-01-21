<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>구장 운영시간 선택 - Footlog</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

<style>
@import
	url('https://cdn.jsdelivr.net/gh/orioncactus/pretendard/dist/web/static/pretendard.css')
	;

body {
	background-color: #f8f9fa;
	padding: 60px 0;
	font-family: 'Pretendard', sans-serif;
	color: #222;
}

.update-card {
	width: 100%;
	max-width: 480px;
	padding: 50px 40px;
	border-radius: 24px;
	background: #fff;
	box-shadow: 0 15px 35px rgba(0, 0, 0, 0.06);
	margin: auto;
	border: 1px solid rgba(0, 0, 0, 0.02);
}

.brand-logo {
	font-size: 2.4rem;
	font-weight: 900;
	font-style: italic;
	text-align: center;
	display: block;
	text-decoration: none;
	color: #111;
	letter-spacing: -1.5px;
	margin-bottom: 30px;
}

.page-header {
	text-align: center;
	margin-bottom: 40px;
}

.page-title {
	font-size: 1.5rem;
	font-weight: 800;
	color: #111;
	margin-bottom: 5px;
}

.sub-title {
	font-size: 0.9rem;
	color: #888;
	font-weight: 500;
	letter-spacing: -0.2px;
}

.form-label {
	font-size: 0.8rem;
	font-weight: 700;
	color: #555;
	margin-bottom: 6px;
	margin-left: 2px;
}

.form-control, .form-select {
	border-radius: 12px;
	padding: 13px 16px;
	border: 1px solid #e1e1e1;
	background-color: #fcfcfc;
	font-size: 0.95rem;
	transition: all 0.2s ease;
}

.form-control:focus, .form-select:focus {
	border-color: #111;
	background-color: #fff;
	box-shadow: 0 0 0 3px rgba(0, 0, 0, 0.05);
}

.form-control[readonly] {
	background-color: #f8f9fa;
	color: #adb5bd;
	cursor: default;
	border-color: #f1f3f5;
}

.btn-black {
	background: #111;
	color: #fff;
	border-radius: 12px;
	width: 100%;
	padding: 15px;
	font-weight: 700;
	font-size: 1rem;
	border: none;
	transition: all 0.2s;
	margin-top: 10px;
}

.btn-black:hover {
	background: #000;
	transform: translateY(-2px);
	box-shadow: 0 5px 15px rgba(0, 0, 0, 0.15);
}

.btn-cancel {
	background: #fff;
	color: #666;
	border: 1px solid #e1e1e1;
	border-radius: 12px;
	width: 100%;
	padding: 15px;
	font-weight: 700;
	font-size: 1rem;
	margin-top: 10px;
	transition: all 0.2s;
}

.btn-cancel:hover {
	background: #f8f9fa;
	color: #333;
	border-color: #d1d1d1;
}

.profile-section {
	display: flex;
	justify-content: center;
	margin-bottom: 40px;
	position: relative;
}

.profile-wrapper {
	position: relative;
	width: 120px;
	height: 120px;
}

.profile-img {
	width: 100%;
	height: 100%;
	border-radius: 50%;
	object-fit: cover;
	border: 4px solid #fff;
	box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
	background-color: #f8f9fa;
}

.profile-btn {
	position: absolute;
	bottom: 0;
	right: 0;
	background: #111;
	color: #fff;
	width: 36px;
	height: 36px;
	border-radius: 50%;
	display: flex;
	align-items: center;
	justify-content: center;
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.15);
	border: 2px solid #fff;
	cursor: pointer;
	z-index: 2;
	transition: transform 0.2s;
}

.delete-btn {
	position: absolute;
	bottom: 0;
	left: 0;
	background: #ff4757;
	color: #fff;
	width: 36px;
	height: 36px;
	border-radius: 50%;
	display: flex;
	align-items: center;
	justify-content: center;
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.15);
	border: 2px solid #fff;
	cursor: pointer;
	z-index: 2;
	transition: transform 0.2s;
}

.msg-box {
	font-size: 0.8rem;
	margin-top: 8px;
	font-weight: 600;
	display: flex;
	align-items: center;
	gap: 5px;
	min-height: 20px;
}

.msg-success {
	color: #00b894;
}

.msg-error {
	color: #ff7675;
}

.btn-group-position {
	display: flex;
	gap: 8px;
}

.btn-check+.btn-outline-custom {
	flex: 1;
	border: 1px solid #e1e1e1;
	border-radius: 12px;
	color: #888;
	padding: 12px;
	background: #fff;
	transition: 0.2s;
}

.btn-check:checked+.btn-outline-custom {
	background-color: #111;
	color: #D4F63F;
	border-color: #111;
	font-weight: 800;
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
}
</style>
</head>
<body>

	<div class="update-card">
		<a href="${pageContext.request.contextPath}/main" class="brand-logo">Footlog</a>

		<div class="page-header">
			<div class="page-title">${stadiumName.stadiumName} 운영시간 선택</div>
			<div class="sub-title">새로운 시즌, 새로운 모습으로</div>
		</div>

		<c:if test="${not empty message}">
			<div class="alert alert-danger alert-dismissible fade show mb-4"
				role="alert"
				style="border-radius: 12px; font-size: 0.9rem; font-weight: 600;">
				<i class="bi bi-exclamation-triangle-fill me-2"></i> ${message}
				<button type="button" class="btn-close" data-bs-dismiss="alert"
					aria-label="Close"></button>
			</div>
		</c:if>

		<form name="memberForm" method="post" enctype="multipart/form-data">
			<input type="hidden" name="stadiumCode" value="${stadiumName.stadiumCode}">

			<div class="mb-5">

				<label class="form-label">평일 운영시간</label>
				<div class="row g-2 mb-4">
					<c:forEach var="time" items="${timeCodes}">
						<div class="col-6">
							<input type="checkbox" class="btn-check" name="weekday_times"
								id="wd_${time.time_code}" value="${time.time_code}"> <label
								class="btn btn-outline-custom w-100" for="wd_${time.time_code}">
								${time.label} </label>
						</div>
					</c:forEach>
				</div>

				<label class="form-label">주말 운영시간</label>
				<div class="row g-2">
					<c:forEach var="time" items="${timeCodes}">
						<div class="col-6">
							<input type="checkbox" class="btn-check" name="weekend_times"
								id="we_${time.time_code}" value="${time.time_code}"> <label
								class="btn btn-outline-custom w-100" for="we_${time.time_code}">
								${time.label} </label>
						</div>
					</c:forEach>
				</div>

				</div>

				<div class="row g-2">
					<div class="col-6">
						<button type="button" class="btn-cancel"
							onclick="location.href='${pageContext.request.contextPath}/admin/mypage?menu=stadium'">취소</button>
					</div>
					<div class="col-6">
						<button type="button" class="btn-black" onclick="updateOk()">수정 완료</button>
					</div>
				</div>
				
		</form>
	</div>

	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
	<script>
// [성공 알림 및 페이지 이동]
$(function() {
    if ("${updateComplete}" === "true") {
        alert("회원 정보 수정이 완료되었습니다!\n확인을 누르면 마이페이지로 이동합니다.");
        location.href = "${pageContext.request.contextPath}/member/mypage";
    }
});



function updateOk() {
    const f = document.memberForm;
    // 유효성 검사 생략 (기존 코드와 동일)
    f.action = '${pageContext.request.contextPath}/admin/updateTimeDo';
    f.submit();
}


</script>
</body>
</html>