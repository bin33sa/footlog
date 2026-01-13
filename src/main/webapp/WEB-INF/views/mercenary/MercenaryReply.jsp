<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<div class="reply-info mb-2">
    <span class="fw-bold text-dark">💬 댓글 ${dataCount}개</span>
</div>

<table class="table table-borderless board-list"> <tbody>
        <c:forEach var="vo" items="${listReply}">
            <tr class="border-bottom">
                <td class="p-3">
                    <div class="d-flex justify-content-between align-items-center mb-2">
                        <div>
                            <span class="fw-bold me-2" style="font-size: 0.95rem; color: #333;">${vo.member_name}</span>
                            <span class="text-muted" style="font-size: 0.85rem;">${vo.created_at}</span>
                        </div>
                        
                        <div class="reply-menu">
                            <c:if test="${sessionScope.member.member_code == vo.member_code || sessionScope.member.userLevel >= 51}">
                                <a href="javascript:void(0);" class="text-danger btnDeleteReply" 
                                   data-comment_id="${vo.comment_id}" style="font-size: 0.85rem; text-decoration: none;">삭제</a>
                            </c:if>
                        </div>
                    </div>

                    <div class="reply-content py-1" style="white-space: pre-wrap; font-size: 0.95rem;">${vo.content}</div>

                    <div class="mt-2">
                        <button type="button" class="btn btn-sm btn-outline-secondary btnReplyAnswerLayout" 
                                data-comment_id="${vo.comment_id}">
                            답글 <span class="badge bg-secondary">${vo.answerCount}</span>
                        </button>
                    </div>
                    
                    <div id="replyAnswerList${vo.comment_id}" class="reply-answer-list mt-2" style="display: none;">
                        <div class="border rounded p-3 bg-light">
                            <div class="answer-form mb-3">
                                <textarea class="form-control mb-2" placeholder="답글을 입력하세요" style="height: 60px; resize: none;"></textarea>
                                <div class="text-end">
                                    <button type="button" class="btn btn-sm btn-dark btnSendReplyAnswer" data-comment_id="${vo.comment_id}">답글 등록</button>
                                </div>
                            </div>
                            
                            <div class="answer-content"></div>
                        </div>
                    </div>
                </td>
            </tr>
        </c:forEach>
    </tbody>
</table>

<c:if test="${dataCount > 0}">
    <div class="page-navigation mt-4 mb-2 text-center">
        ${paging}
    </div>
</c:if>