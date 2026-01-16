<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:forEach var="dto" items="${list}">
    <fmt:parseDate value="${dto.match_date}" var="tempDate" pattern="yyyy-MM-dd HH:mm"/>

    <div class="match-item modern-card p-3 mb-0 d-flex align-items-center gap-4 border-bottom" 
         onclick="location.href='${articleUrl }&match_code=${dto.match_code}'" 
         style="cursor: pointer;">
        
        <div class="match-time-box text-center rounded-3 p-2 bg-light flex-shrink-0" style="min-width: 80px;">
            <span class="d-block small text-muted">
                <fmt:formatDate value="${tempDate}" pattern="MM.dd(E)"/>
            </span> 
            <span class="d-block fw-bold fs-5">
                <fmt:formatDate value="${tempDate}" pattern="HH:mm"/>
            </span>
        </div>

        <div class="flex-grow-1" style="min-width: 0;">
            <div class="d-flex align-items-center gap-2 mb-1">
                <c:choose>
                    <c:when test="${dto.status == '모집중'}">
                        <span class="badge bg-primary text-dark rounded-pill">${dto.status}</span>
                    </c:when>
                    <c:otherwise>
                        <span class="badge bg-secondary text-white rounded-pill">${dto.status}</span>
                    </c:otherwise>
                </c:choose>
                
                <span class="badge bg-light text-secondary border">${dto.matchType}</span> 
                <span class="badge bg-light text-secondary border">${dto.gender}</span>
                <span class="badge bg-light text-secondary border">${dto.matchLevel}</span>
            </div>

            <h5 class="fw-bold mb-1 text-truncate" style="max-width:380px">
                ${dto.title}
            </h5>
            
            <p class="text-muted small mb-0 text-truncate">
                <i class="bi bi-geo-alt-fill me-1"></i>${dto.region} | 호스트: ${dto.home_team_name}
            </p>
        </div>

        <div class="text-end d-none d-md-block flex-shrink-0" style="min-width: 100px;">
            <span class="d-block fw-bold text-primary mb-1">
                <fmt:formatNumber value="${dto.fee}" type="currency"/>
            </span>
            
            <button class="btn btn-sm ${dto.status == '모집중' ? 'btn-outline-dark' : 'btn-secondary'} rounded-pill px-3"
                    ${dto.status != '모집중' ? 'disabled' : ''} 
                    onclick="event.stopPropagation(); location.href='${pageContext.request.contextPath}/match/article';">
                ${dto.status == '모집중' ? '신청가능' : '마감됨'}
            </button>
        </div>
    </div>
</c:forEach>

<script>
    $('.list-content').attr('data-pageNo', '${page}');
    $('.list-content').attr('data-totalPage', '${total_page}');
</script>
