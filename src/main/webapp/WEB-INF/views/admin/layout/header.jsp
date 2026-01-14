<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<style>
    .img-person {
        width: 35px;
        height: 35px;
        border-radius: 50%;
        object-fit: cover;  /* 이미지가 찌그러지지 않게 설정 */
        border: 1px solid #eee;
        display: block;
    }
</style>

<header class="container-fluid header-top fixed-top">
	<div class="container-fluid p-2">
		<div class="row">
			<div class="col-auto d-lg-none align-self-center">
				<button type="button" id="toggleMenu" class="toggle_menu">
					<i class="bi bi-list"></i>
				</button>
			</div>
			<div class="col align-self-center">
				<h2 class="fs-4 fw-bold">관리자 페이지</h2>
			</div>
			<div class="col-auto">
				<div class="row">
					<div class="col-3 align-self-center">
						<c:choose>
							<%-- 파일명이 존재할 때만 img 태그 생성 --%>
							<c:when
								test="${not empty sessionScope.member.avatar && sessionScope.member.avatar.trim().length() > 0}">
								<img
									src="${pageContext.request.contextPath}/uploads/member/${sessionScope.member.avatar}"
									class="img-person" alt="Profile"
									onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/dist/images/avatar.png';">
							</c:when>
							<%-- 파일명이 없으면 처음부터 기본 이미지 출력 --%>
							<c:otherwise>
								<img
									src="${pageContext.request.contextPath}/dist/images/avatar.png"
									class="img-person" alt="Default Profile">
							</c:otherwise>
						</c:choose>
					</div>

					<div class="col-auto text-end align-self-center ps-3">
						<div class="text-start">
							<span class="fw-semibold" style="font-size: 10px;">관리자</span>
						</div>
						<div class="text-start">
							<span>${sessionScope.member.userName} 님</span> &nbsp;<a
								href="${pageContext.request.contextPath}/"><i
								class="bi bi-box-arrow-right"></i></a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</header>