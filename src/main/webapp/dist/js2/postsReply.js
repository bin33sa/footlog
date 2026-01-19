window.ajaxFun = function(url, method, params, dataType, fn) {
    $.ajax({
        type: method, 
        url: url, 
        data: params, 
        dataType: dataType,
        success: function(data) {
            fn(data);
        },
        error: function(e) {
            console.log("AJAX 에러: " + e.responseText);
        }
    });
};

(function() { 
    let postsUrl;
    let recruit_id;

    $(function() {
        const replySessionEL = document.querySelector('div#listReply');
        
        if (replySessionEL) {
            postsUrl = replySessionEL.getAttribute('data-postsUrl');
            recruit_id = replySessionEL.getAttribute('data-num');
            
            // 초기 목록 로드
            window.loadContent(1);
            
            $('.btnSendReply').off('click').on('click', function() {
                window.sendReply();
            });
        }
    });

    window.loadContent = function(page) {
        if(!postsUrl) return;
        
        const url = `${postsUrl}/listReply`;
        const params = { recruit_id: recruit_id, pageNo: page };
        
        window.ajaxFun(url, 'get', params, 'json', function(data) {
            const htmlText = renderRepliesLocal(data.listReply, data.pageNo);
            $('#listReply .reply-info .fw-bold').html(`댓글 ${data.replyCount}개`); 
            $('#listReply .list-content').html(`<table class="table table-borderless"><tbody>${htmlText}</tbody></table>`);
            $('#listReply .page-navigation').html(data.paging);
        });
    };

    window.sendReply = function() {
        let content = $('#replyContent').val().trim();
        if(!content) {
            $('#replyContent').focus();
            return false;
        }
        
        const url = `${postsUrl}/insertReply`;
        const params = { recruit_id: recruit_id, content: content }; 
        
        window.ajaxFun(url, 'post', params, 'json', function(data) {
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
})();

function isHidden(el) {
    const styles = window.getComputedStyle(el);
    return styles.display === 'none' || styles.visibility === 'hidden' || styles.opacity === '0';
}
function isImageFile(filename){
    let format = /(\.gif|\.jpg|\.jpeg|\.png)$/i;
    return format.test(filename);
}