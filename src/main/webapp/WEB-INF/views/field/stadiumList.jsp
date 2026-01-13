<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

	<c:forEach var="dto" items="${list}">

		<div class="col-md-6"
			onclick="location.href='${pageContext.request.contextPath}/field/view'">
			<div class="modern-card stadium-card p-0 h-100">
				<div class="stadium-img-wrapper position-relative">
					<img
						src="https://images.unsplash.com/photo-1529900748604-07564a03e7a6?w=500&auto=format&fit=crop&q=60"
						alt="stadium">
				</div>
				<div class="p-4">
					<div class="d-flex justify-content-between align-items-start mb-1">
						<h5 class="fw-bold mb-0">${dto.stadiumName}</h5>
						<span class="text-warning fw-bold"><i
							class="bi bi-star-fill">${dto.rating}</i></span>
					</div>
					<p class="text-muted small mb-3">${dto.region}</p>

					<div class="d-flex gap-2 mb-3">
						<span class="badge bg-light text-secondary border"><i
							class="bi bi-p-square-fill me-1"></i>주차가능</span> <span
							class="badge bg-light text-secondary border"><i
							class="bi bi-droplet-fill me-1"></i>샤워가능</span>
					</div>

					<div
						class="d-flex justify-content-between align-items-end border-top pt-3">
						<div>
							<span class="text-muted small">2시간당</span>
							<h5 class="fw-bold mb-0">${dto.price}원</h5>
						</div>
						<button class="btn btn-sm btn-primary rounded-pill px-4">예약하기</button>
					</div>
				</div>
			</div>
		</div>

	</c:forEach>
