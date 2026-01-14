<%@ page contentType="application/json; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
[
<c:forEach var="dto" items="${list}" varStatus="status">
    {
        "id": "${dto.board_cal_code}",
        "title": "${dto.title}",
        "start": "${dto.start_date}",
        "end": "${dto.end_date}",
        "description": "${dto.content}"
    }${not status.last ? ',' : ''}
</c:forEach>
]