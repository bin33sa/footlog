<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%-- 중요: AJAX 로딩 시 totalPage 값을 갱신하기 위한 숨겨진 태그 --%>
<input type="hidden" id="ajaxTotalPage" value="${totalPage}">

<c:forEach var="dto" items="${list}">
    <%-- 카드 1개 시작 --%>
    <div class="col-md-6 mb-4">
        <div class="modern-card bg-white border rounded-4 shadow-sm overflow-hidden" 
             style="transition: transform 0.2s; height: 100%;">
            
            <%-- 1. 엠블럼 영역 --%>
            <div onclick="location.href='${pageContext.request.contextPath}/team/view?team_code=${dto.team_code}'" 
                 class="d-flex justify-content-center align-items-center pt-4 pb-4 bg-light"
                 style="cursor: pointer; border-bottom: 1px solid rgba(0,0,0,0.05);">
                <div class="rounded-circle bg-white p-1 border shadow-sm" style="width: 120px; height: 120px;">
                    <img src="${pageContext.request.contextPath}${not empty dto.emblem_image ? '/uploads/team/'.concat(dto.emblem_image) : '/dist/images/emblem.png'}" 
                         alt="team" class="rounded-circle"
                         style="width: 100%; height: 100%; object-fit: cover;"
                         onerror="this.src='${pageContext.request.contextPath}/dist/images/emblem.png'">
                </div>
            </div>
            
            <%-- 2. 정보 영역 --%>
            <div class="p-3">
                <div class="d-flex align-items-center mb-2">
                    <span class="badge bg-black me-2">모집중</span>
                    <h5 class="fw-bold mb-0 text-dark text-truncate" style="max-width: 150px;">
                        ${dto.team_name}
                    </h5>
                </div>
                
                <div class="mb-2 text-secondary small">
                    <span class="fw-bold me-1">구단장</span> ${dto.leader_name}
                </div>

                <div class="d-flex gap-2 text-muted small mb-3">
                    <span class="border rounded px-2 bg-light"><i class="bi bi-geo-alt me-1"></i>${empty dto.region ? '미정' : dto.region}</span>
                    <span class="border rounded px-2 bg-light"><i class="bi bi-calendar me-1"></i>${fn:substring(dto.created_at, 0, 10)}</span>
                </div>
                
                <hr class="my-2 opacity-25">

                <div class="d-flex justify-content-between align-items-center">
                    <div class="d-flex gap-3 text-dark fw-bold">
                        <span><i class="bi bi-people-fill text-secondary"></i> ${dto.member_count}</span>
                        
                        <%-- ★ 여기 수정됨: 무조건 노란색 별로 고정 --%>
                        <span class="btn-team-like" style="cursor: pointer;" 
                              data-liked="${dto.user_liked}"
                              onclick="toggleLike(this, '${dto.team_code}', event)">
                            <i class="bi bi-star-fill text-warning"></i> 
                            <span class="count">${dto.like_count}</span>
                        </span>
                    </div>
                    <button class="btn btn-dark btn-sm rounded-pill px-3" onclick="location.href='${pageContext.request.contextPath}/team/view?team_code=${dto.team_code}'">
                        상세보기
                    </button>
                </div>        
            </div>
        </div>
    </div>
    <%-- 카드 끝 --%>
</c:forEach>

<c:if test="${empty list}">
    <div class="col-12 text-center py-5">
        <p class="text-muted">검색 결과가 없습니다.</p>
    </div>
</c:if>