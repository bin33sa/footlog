<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<c:forEach var="dto" items="${list}">
    <div class="col-4 mb-2">
        <button type="button"
            class="btn 
            ${dto.availableYn == 'Y'
                ? 'btn-outline-primary'
                : 'btn-outline-secondary text-decoration-line-through'}
            w-100 py-2 rounded-3 time-btn"
            ${dto.availableYn == 'Y' ? '' : 'disabled'}
            data-time-code="${dto.timeCode}"
            data-time-label="${dto.timeLabel}">
            ${dto.timeLabel}
        </button>
    </div>
</c:forEach>
