<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<div class="modern-card p-4">

    <!-- 상단 타이틀 -->
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h5 class="fw-bold mb-0">👥 회원 관리</h5>
        <button class="btn btn-sm btn-dark rounded-pill px-3">
            + 구단 등록
        </button>
    </div>

    <!-- 리스트 테이블 (테두리 강조) -->
    <div class="table-responsive border rounded-4 overflow-hidden">
        <table class="table align-middle table-hover mb-0">
            <thead class="table-light border-bottom">
                <tr>
                    <th style="width: 15%">아이디</th>
                    <th>회원명</th>
                    <th style="width: 25%">이메일</th>
                    <th style="width: 25%">전화번호</th>
                    <th style="width: 10%">탈퇴여부</th>
                </tr>
            </thead>

            <tbody>
				<c:forEach var="member" items="${memberList}">
	                <tr>
	                    <td>${member.member_id}</td>
	                    <td class="fw-bold">${member.member_name}</td>
	                    <td>${member.email}</td>
	                    <td>${member.phone_number}</td>
	                    <td>${member.is_deleted == 0 ? '이용 회원':'탈퇴 회원'}</td>
	                </tr>
				</c:forEach>
            </tbody>
        </table>
    </div>
</div>
	