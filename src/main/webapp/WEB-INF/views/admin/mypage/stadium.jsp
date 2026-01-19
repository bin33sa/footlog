<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<div class="modern-card p-4">

    <!-- 상단 타이틀 -->
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h5 class="fw-bold mb-0">🏟️ 구장 관리</h5>
        <button class="btn btn-sm btn-dark rounded-pill px-3">
            + 구장 등록
        </button>
    </div>

    <!-- 리스트 테이블 (테두리 강조) -->
    <div class="table-responsive border rounded-4 overflow-hidden">
        <table class="table align-middle table-hover mb-0">
            <thead class="table-light border-bottom">
                <tr>
                    <th style="width: 10%">지역</th>
                    <th>구장명</th>
                    <th style="width: 10%">평점</th>
                    <th style="width: 20%">가격</th>
                    <th style="width: 15%">예약 관리</th>
                    <th style="width: 15%">구장 관리</th>
                </tr>
            </thead>

            <tbody>
				<c:forEach var="list" items="${stadiumList}">
	                <tr>
	                    <td>${list.region}</td>
	                    <td class="fw-bold">${list.stadiumName}</td>
	                    <td>${list.rating}</td>
	                    <td>${list.price}</td>
	                    <td>
	                        <button class="btn btn-sm btn-outline-dark rounded-pill me-1">
	                            수정
	                        </button>
	                    </td>
	                    <td>
	                        <button class="btn btn-sm btn-outline-dark rounded-pill me-1">
	                            수정
	                        </button>
	                        <button class="btn btn-sm btn-outline-danger rounded-pill">
	                            삭제
	                        </button>
	                    </td>
	                </tr>
				</c:forEach>
            </tbody>
            
        </table>
    </div>
</div>
	