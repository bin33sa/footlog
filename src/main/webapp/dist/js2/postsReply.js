// postsReply.js 전체를 아래 내용으로 교체하세요.

(function() { // 즉시 실행 함수로 감싸서 변수 충돌 방지
    let postsUrl;
    let recruit_id;

    $(function() {
        const replySessionEL = document.querySelector('div#listReply');
        
        if (replySessionEL) {
            postsUrl = replySessionEL.getAttribute('data-postsUrl');
            recruit_id = replySessionEL.getAttribute('data-num');
            
            // 초기 목록 로드
            loadContent(1);
            
            // 등록 버튼 이벤트 (중복 연결 방지)
            $('.btnSendReply').off('click').on('click', function() {
                sendReply();
            });
        }
    });

    // 전역에서 pagingMethod가 찾을 수 있도록 윈도우 객체에 할당
    window.loadContent = function(page) {
        if(!postsUrl) return;
        
        const url = `${postsUrl}/listReply`;
        const params = { recruit_id: recruit_id, pageNo: page };
        
        ajaxRequestLocal(url, 'get', params, 'json', function(data) {
            const htmlText = renderRepliesLocal(data.listReply, data.pageNo);
            $('#listReply .reply-info .fw-bold').html(`댓글 ${data.replyCount}개`); 
            $('#listReply .list-content').html(`<table class="table table-borderless"><tbody>${htmlText}</tbody></table>`);
            $('#listReply .page-navigation').html(data.paging);
        });
    };

    function sendReply() {
        let content = $('#replyContent').val().trim();
        if(!content) {
            $('#replyContent').focus();
            return false;
        }
        
        const url = `${postsUrl}/insertReply`;
        const params = { recruit_id: recruit_id, content: content }; 
        
        ajaxRequestLocal(url, 'post', params, 'json', function(data) {
            if(data.state === 'true') {
                $('#replyContent').val('');
                window.loadContent(1); 
            } else if(data.state === 'loginFail') {
                alert("로그인이 필요한 서비스입니다.");
            } else {
                alert('댓글 등록에 실패했습니다.');
            }
        });
    }

    function renderRepliesLocal(listReply, pageNo) {
        if(!listReply || listReply.length === 0) return "<tr><td class='text-center p-5 text-muted'>등록된 댓글이 없습니다.</td></tr>";
        return listReply.map(vo => `
            <tr class="border-bottom">
                <td class="p-3">
                    <div class="d-flex justify-content-between align-items-center mb-2">
                        <div>
                            <span class="fw-bold me-2">${vo.member_name}</span>
                            <span class="text-muted small">${vo.created_at}</span>
                        </div>
                        <div class="deleteReply text-danger small" style="cursor:pointer;" data-comment_id="${vo.comment_id}" data-pageNo="${pageNo}">삭제</div>
                    </div>
                    <div class="py-2" style="white-space: pre-wrap;">${vo.content}</div>
                </td>
            </tr>`).join('');
    }

    // 함수 이름 충돌 방지를 위해 이름을 변경함
    function ajaxRequestLocal(url, method, params, dataType, fn) {
        $.ajax({
            type: method, url: url, data: params, dataType: dataType,
            success: data => fn(data),
            error: e => console.log("AJAX 에러: " + e.responseText)
        });
    }
})();