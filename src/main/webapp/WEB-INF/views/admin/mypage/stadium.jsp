<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<div class="modern-card p-4">

    <!-- 상단 타이틀 -->
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h5 class="fw-bold mb-0">🏟️ 구장 관리</h5>
        <button class="btn btn-sm btn-dark rounded-pill px-3">
            + 구단 등록
        </button>
    </div>

    <!-- 리스트 테이블 (테두리 강조) -->
    <div class="table-responsive border rounded-4 overflow-hidden">
        <table class="table align-middle table-hover mb-0">
            <thead class="table-light border-bottom">
                <tr>
                    <th style="width: 8%">번호</th>
                    <th>구단명</th>
                    <th style="width: 20%">지역</th>
                    <th style="width: 15%">등급</th>
                    <th style="width: 20%">관리</th>
                </tr>
            </thead>

            <tbody>
                <!-- 더미 데이터 -->
                <tr>
                    <td>1</td>
                    <td class="fw-bold">Footlog FC</td>
                    <td>서울</td>
                    <td>
                        <span class="badge bg-success">활성</span>
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

                <tr class="table-light">
                    <td>2</td>
                    <td class="fw-bold">Night Wolves</td>
                    <td>경기</td>
                    <td>
                        <span class="badge bg-secondary">비활성</span>
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

                <tr>
                    <td>3</td>
                    <td class="fw-bold">Red Tigers</td>
                    <td>부산</td>
                    <td>
                        <span class="badge bg-success">활성</span>
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
            </tbody>
        </table>
    </div>
</div>
	