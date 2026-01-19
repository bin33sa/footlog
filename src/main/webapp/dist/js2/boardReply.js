$(function(){

    listPage(1);
    
    $('.btnSendReply').click(function(){
        sendReply();
    });

    $('#btnLike').click(function(){
        sendLike();
    });
    
    $('#listReply').on('click', '.deleteReply', function(){
        let replyCode = $(this).attr('data-replyCode');
        let page = $(this).attr('data-pageNo');
        deleteReply(replyCode, page);
    });

    $('#listReply').on('click', '.updateReply', function(){
        let replyCode = $(this).attr('data-replyCode');
        let content = $(this).attr('data-content'); 
        
        $('#listReply .reply-edit-form').remove();
        $('#listReply .reply-content').show();

        let $div = $(this).closest('.reply-item');
        $div.find('.reply-content').hide();

        let out = "";
        out += "<div class='reply-edit-form p-3 bg-light border rounded mt-2'>";
        out += "  <textarea class='form-control mb-2' rows='2'>" + content + "</textarea>";
        out += "  <div class='text-end'>";
        out += "    <button type='button' class='btn btn-sm btn-outline-secondary me-1 btnCancelEdit'>취소</button>";
        out += "    <button type='button' class='btn btn-sm btn-primary btnSaveEdit' data-replyCode='" + replyCode + "'>수정완료</button>";
        out += "  </div>";
        out += "</div>";

        $div.find('.reply-content').after(out);
    });

    $('#listReply').on('click', '.btnCancelEdit', function(){
        let $div = $(this).closest('.reply-item');
        $div.find('.reply-edit-form').remove();
        $div.find('.reply-content').show();
    });

    $('#listReply').on('click', '.btnSaveEdit', function(){
        let replyCode = $(this).attr('data-replyCode');
        let content = $(this).closest('.reply-edit-form').find('textarea').val().trim();
        
        if(!content) {
            alert("내용을 입력하세요.");
            return;
        }
        updateReply(replyCode, content);
    });
});

function listPage(page) {
    if(! boardTeamCode) return; 
    
    let url = contextPath + "/myteam/listBoardReply";
    let query = "board_team_code=" + boardTeamCode + "&pageNo=" + page;
    
    const fn = function(data) {
        printReply(data);
    };
    
    ajaxRequest(url, "GET", query, "json", fn);
}

function printReply(data) {
    let list = data.listReply;
    let replyCount = data.replyCount;
    let paging = data.paging;
    
    $('.reply-info .fw-bold').html('댓글 ' + replyCount + '개');
    
    let out = "";
    if(! list || list.length === 0) {
        out = "<div class='p-5 text-center text-muted'>등록된 댓글이 없습니다. 첫 댓글을 남겨보세요!</div>";
    } else {
        for(let item of list) {
            out += "<div class='border-bottom py-3 reply-item'>"; 
            out += "  <div class='d-flex justify-content-between align-items-center mb-1'>";
            out += "    <div>";
            
            out += "      <span class='fw-bold me-2'>" + item.member_name + "</span>";
            out += "      <span class='text-muted small'>" + item.created_at + "</span>";
            out += "    </div>";
            
            if(myMemberCode && (String(myMemberCode) === String(item.member_code))) {
                out += "    <div class='reply-btn-area'>";
                let safeContent = item.content.replace(/"/g, '&quot;'); 
                
                out += "      <span class='updateReply text-primary' data-replyCode='" + item.comment_id + "' data-content='" + safeContent + "'>수정</span>";
                out += "      <span class='deleteReply text-danger' data-replyCode='" + item.comment_id + "' data-pageNo='" + data.pageNo + "'>삭제</span>";
                out += "    </div>";
            }
            out += "  </div>";
            out += "  <div class='reply-content text-break' style='white-space: pre-wrap;'>" + item.content + "</div>";
            out += "</div>";
        }
    }
    
    $('#listReply .list-content').html(out);
    $('#listReply .page-navigation').html(paging);
}

function sendReply() {
    let content = $('#replyContent').val().trim();
    if(! content) {
        $('#replyContent').focus();
        return;
    }
    
    let url = contextPath + "/myteam/insertBoardReply";
    let query = "board_team_code=" + boardTeamCode + "&content=" + encodeURIComponent(content);
    
    const fn = function(data) {
        if(data.state === "true") {
            $('#replyContent').val("");
            listPage(1); 
        } else if(data.state === "false") {
            alert("댓글을 등록하지 못했습니다.");
        } else if(data.state === "login_required") {
            alert("로그인이 필요합니다.");
        }
    };
    
    ajaxRequest(url, "POST", query, "json", fn);
}

// 댓글 삭제
function deleteReply(replyCode, page) {
    if(! confirm("댓글을 삭제하시겠습니까?")) {
        return;
    }
    
    let url = contextPath + "/myteam/deleteBoardReply";
    let query = "reply_code=" + replyCode;
    
    const fn = function(data) {
        if(data.state === "true") {
            listPage(page); 
        } else if(data.state === "false") {
            alert("댓글을 삭제하지 못했습니다.");
        }
    };
    
    ajaxRequest(url, "POST", query, "json", fn);
}

function updateReply(replyCode, content) {
    let url = contextPath + "/myteam/updateBoardReply"; 

    let query = "comment_id=" + replyCode + "&content=" + encodeURIComponent(content);
    
    const fn = function(data) {
        if(data.state === "true") {
            listPage(1); 
        } else if(data.state === "false") {
            alert("댓글을 수정하지 못했습니다.");
        }
    };
    
    ajaxRequest(url, "POST", query, "json", fn);
}

function sendLike() {
    if(! boardTeamCode) return;

    let url = contextPath + "/myteam/updateBoardLike";
    let query = "board_team_code=" + boardTeamCode;
    
    const fn = function(data) {
        if(data.state === "true") {
            $('#btnLike').removeClass('btn-outline-danger').addClass('btn-danger');
            $('#btnLike i').removeClass('bi-heart').addClass('bi-heart-fill');
        } else if(data.state === "false") {
            $('#btnLike').removeClass('btn-danger').addClass('btn-outline-danger');
            $('#btnLike i').removeClass('bi-heart-fill').addClass('bi-heart');
        } else if(data.state === "login_required") {
            alert("로그인이 필요합니다.");
            return;
        }
        
        $('#likeCount').text(data.likeCount);
    };
    
    ajaxRequest(url, "POST", query, "json", fn);
}