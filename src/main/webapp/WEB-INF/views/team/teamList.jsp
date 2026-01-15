<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:forEach var="dto" items="${list}">
    <div class="col-md-6 mb-4">
        <%-- overflow-hidden을 추가해야 상단 배경색이 라운드 처리에 딱 맞게 잘립니다 --%>
        <div class="modern-card bg-white border rounded-4 shadow-sm overflow-hidden" 
             style="transition: transform 0.2s;">
            
            <%-- 1. 엠블럼 영역 (연한 회색 배경: bg-light) --%>
            <div onclick="location.href='${pageContext.request.contextPath}/team/view?team_code=${dto.team_code}'" 
                 class="d-flex justify-content-center align-items-center pt-4 pb-4 bg-light"
                 style="cursor: pointer; border-bottom: 1px solid rgba(0,0,0,0.05);">
                <%-- 엠블럼 크기 180px 유지 --%>
                <div class="rounded-circle bg-white p-1 border shadow-sm" style="width: 180px; height: 180px;">
                    <img src="${pageContext.request.contextPath}${not empty dto.emblem_image ? '/uploads/team/'.concat(dto.emblem_image) : '/dist/images/emblem.png'}" 
                         alt="team"
                         class="rounded-circle"
                         style="width: 100%; height: 100%; object-fit: cover;"
                         onerror="this.src='${pageContext.request.contextPath}/dist/images/emblem.png'">
                </div>
            </div>
            
            <%-- 2. 정보 영역 (여기서부터는 흰색 배경) --%>
            <div class="p-4">
                <%-- 상단: 모집태그 + 팀명 --%>
                <div class="d-flex align-items-center mb-3">
                    <span class="badge bg-black me-2 py-2 px-3">모집중</span>
                    <h4 class="fw-bold mb-0 text-dark text-truncate" onclick="location.href='${pageContext.request.contextPath}/team/view?team_code=${dto.team_code}'" style="cursor: pointer;">
                        ${dto.team_name}
                    </h4>
                </div>
                
                <%-- 구단장 영역 (요청하신 대로 텍스트만 왼쪽 정렬) --%>
                <div class="mb-3">
                    <span class="text-secondary small fw-bold me-2">구단장</span>
                    <span class="fs-5 fw-bolder text-dark">
                        ${not empty dto.leader_name ? dto.leader_name : 'Unknown'}
                    </span>
                </div>

                <%-- 배지 디자인 (건드리지 않음) --%>
                <div class="d-flex gap-2 text-muted small mb-4 align-items-center flex-wrap">
                    <div class="border rounded px-2 py-1 bg-light text-secondary">
                        <i class="bi bi-geo-alt-fill me-1"></i>${empty dto.region ? '지역미정' : dto.region}
                    </div>

                    <div class="border rounded px-2 py-1 bg-light text-secondary d-flex align-items-center">
                        <i class="bi bi-calendar-check me-2"></i>
                        <span class="me-1">창단일:</span> 
                        <span>${fn:substring(dto.created_at, 0, 10)}</span>
                    </div>
                </div>
                
                <hr class="my-3 opacity-25">

                <%-- 하단: 멤버수/좋아요 + 상세보기 버튼 --%>
                <div class="d-flex justify-content-between align-items-center">
                    <div class="d-flex align-items-center gap-3">
                        <div class="text-dark fw-bold fs-5" title="멤버 수">
                            <i class="bi bi-people-fill text-secondary"></i> ${dto.member_count}
                        </div>
                        <div class="fs-5 btn-team-like" 
                             style="cursor: pointer;"
                             data-liked="${dto.user_liked}"
                             onclick="toggleLike(this, '${dto.team_code}', event)">
                            <i class="bi bi-star-fill text-warning"></i> 
                            <span class="fw-bold text-dark count">${dto.like_count}</span>
                        </div>
                    </div>
                    
                    <button class="btn btn-dark fw-bold rounded-pill px-4" 
                            onclick="location.href='${pageContext.request.contextPath}/team/view?team_code=${dto.team_code}'">
                        상세보기
                    </button>
                </div>        
            </div>
        </div>
    </div>
</c:forEach>