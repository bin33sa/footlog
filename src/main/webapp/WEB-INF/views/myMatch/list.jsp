<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<c:if test="${empty list}">
	<div class="text-center py-5 border rounded bg-white mt-2">
		<i class="bi bi-exclamation-circle fs-1 text-muted opacity-50"></i>
		<p class="text-muted mt-3 fw-bold">
			${tab == 'future' ? '예정된 매치 일정이 없습니다.' : '지난 매치 기록이 없습니다.'}
		</p>
	</div>
</c:if>

<c:forEach var="dto" items="${list}">
	<fmt:parseDate value="${dto.match_date}" var="tempDate" pattern="yyyy-MM-dd HH:mm"/>

	<div class="match-item modern-card p-3 mb-3 d-flex align-items-center gap-4 border rounded shadow-sm bg-white" 
		 onclick="location.href='${pageContext.request.contextPath}/match/article?match_code=${dto.match_code}&page=1'" 
		 style="cursor: pointer; transition: transform 0.2s;">
		
		<div class="match-time-box text-center rounded-3 p-2 bg-light flex-shrink-0 border" style="min-width: 80px;">
			<span class="d-block small text-muted fw-bold">
				<fmt:formatDate value="${tempDate}" pattern="MM.dd(E)"/>
			</span> 
			<span class="d-block fw-bold fs-5 text-dark">
				<fmt:formatDate value="${tempDate}" pattern="HH:mm"/>
			</span>
		</div>

		<div class="flex-grow-1" style="min-width: 0;">
			<div class="d-flex align-items-center gap-2 mb-1">
				<c:choose>
					<c:when test="${dto.status == '모집중'}">
						<span class="badge bg-primary text-dark rounded-pill border border-primary-subtle">모집중</span>
					</c:when>
					<c:when test="${dto.status == '매칭완료'}">
						<span class="badge bg-success text-white rounded-pill">매칭완료</span>
					</c:when>
					<c:otherwise>
						<span class="badge bg-secondary text-white rounded-pill">${dto.status}</span>
					</c:otherwise>
				</c:choose>
				
				<span class="badge bg-light text-secondary border">${dto.matchType}</span> 
				<span class="badge bg-light text-secondary border">${dto.gender}</span>
			</div>

			<h5 class="fw-bold mb-1 text-truncate" style="max-width:380px">${dto.title}</h5>
			<p class="text-muted small mb-0 text-truncate">
				<i class="bi bi-geo-alt-fill me-1 text-danger"></i>${dto.stadiumName} | 호스트: ${dto.home_team_name}
			</p>
		</div>

		<div class="text-end d-none d-md-block flex-shrink-0" style="min-width: 120px;">
			<c:choose>
				<c:when test="${tab == 'future'}">
					<div class="d-block fw-bold text-primary mb-2">
						<c:if test="${dto.fee > 0}"><fmt:formatNumber value="${dto.fee}" type="currency"/></c:if>
						<c:if test="${dto.fee == 0}">무료</c:if>
					</div>
					<c:if test="${sessionScope.member.member_code == dto.member_code}">
						<button class="btn btn-sm btn-outline-danger rounded-pill px-3 fw-bold"
								onclick="event.stopPropagation(); deleteMatch('${dto.match_code}');">매치 취소</button>
					</c:if>
				</c:when>

				<c:when test="${tab == 'past'}">
					<div class="mb-2">
						<span class="badge bg-dark fs-6 px-3 py-1">${dto.home_score} : ${dto.away_score}</span>
					</div>
					<button class="btn btn-sm btn-dark rounded-pill px-3 fw-bold"
							onclick="event.stopPropagation(); location.href='${pageContext.request.contextPath}/match/article?match_code=${dto.match_code}&page=1';">결과 입력</button>
				</c:when>
			</c:choose>
		</div>
	</div>
</c:forEach>