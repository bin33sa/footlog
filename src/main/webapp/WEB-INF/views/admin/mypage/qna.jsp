<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>



<div class="modern-card p-4">

    <!-- 리스트 테이블 (테두리 강조) -->
    <div class="table-responsive border rounded-4 overflow-hidden">
        <table class="table align-middle table-hover mb-0">
            <thead class="table-light border-bottom">
                <tr>
                    <th style="width: 12%">상태</th>
                    <th style="width: 12%">분류</th>
                    <th>제목</th>
                    <th style="width: 15%">작성자</th>
                    <th style="width: 12%">날짜</th>
                </tr>
            </thead>

            <tbody>
               
 	            <c:set var="allAnswered" value="true" />
                <c:forEach var="dto" items="${list}">
                	<c:if test="${dto.status != 2}">
		 	            <c:set var="allAnswered" value="false" />
                	
                                <tr onclick="location.href='${pageContext.request.contextPath}/qna/article?board_qna_code=${dto.board_qna_code}&page=${page}'">
                                    <td>
                                                <span class="badge bg-light text-muted badge-qna border">답변대기</span>
                                    </td>
                                    <td>
                                        <span class="text-muted small">
                                            ${dto.category==1?'계정':(dto.category==2?'구장':'기타')}
                                        </span>
                                    </td>
                                    <td class="text-start fw-bold">
                                        <i class="bi bi-lock-fill text-muted me-1"></i> ${dto.title}
                                    </td>
                                    <td>${dto.member_name}</td>
                                    <td class="text-muted small">${dto.created_at}</td>
                                </tr>
                     </c:if>
                </c:forEach>
                	
                <c:if test="${allAnswered}">
    				<tr>
        				<td colspan="5" class="text-center py-5 text-muted fw-bold">
				            ✅ 모든 문의가 답변 완료되었습니다.
				        </td>
				    </tr>
				</c:if>
				
			
                	
            </tbody>
        </table>
    </div>
</div>
	