<%@ page contentType="application/json; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
[
<c:forEach var="dto" items="${list}" varStatus="status">
    {
        "id": "${dto.board_cal_code}",
        "board_cal_code": "${dto.board_cal_code}",
        "title": "${fn:escapeXml(dto.title)}",
        "start": "${dto.start_date}",
        "end": "${dto.end_date}",
        "start_date": "${dto.start_date}",
        "end_date": "${dto.end_date}",
        "content": "${fn:escapeXml(dto.content)}",
        "description": "${fn:escapeXml(dto.content)}",
        "match_code": "${dto.match_code}",
        "team_code": "${dto.team_code}",
        "member_code": "${dto.member_code}"
    }${not status.last ? ',' : ''}
</c:forEach>
]