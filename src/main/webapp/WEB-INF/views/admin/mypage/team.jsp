<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<div class="modern-card p-4">

    <!-- 상단 타이틀 -->
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h5 class="fw-bold mb-0">⚽ 구단 관리</h5>
    </div>

    <!-- 리스트 테이블 (테두리 강조) -->
    <div class="table-responsive border rounded-4 overflow-hidden">
        <table class="table align-middle table-hover mb-0">
            <thead class="table-light border-bottom">
                <tr>
                    <th style="width: 8%">지역</th>
                    <th>구단명</th>
                    <th style="width: 15%">구단주</th>
                    <th style="width: 25%">대표 연락처</th>
                    <th style="width: 12%">멤버 수</th>
                </tr>
            </thead>

            <tbody>
                
                <c:forEach var="team" items="${teamList}">
                
                <tr>
                    <td>${ team.region == null ? '미입력' : team.region }</td>
                    <td class="fw-bold">${team.team_name}</td>
                    <td>${team.leader_name}</td>
                    <td>${team.contact_number}</td>
                    <td>${team.member_count}</td>
                </tr>
                
                </c:forEach>

                
            </tbody>
        </table>
    </div>
</div>