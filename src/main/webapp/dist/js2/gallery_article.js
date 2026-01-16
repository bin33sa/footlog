
$(function(){
    loadContent(1);
    
    $(".btn-like").click(function(){
        sendLikeAction($(this));
    });
    
    $(".btnSendReply").click(function(){
        sendReply();
    });
});


function loadContent(page) {
    const url = contextPath + "/myteam/listReply";
    
    const params = { 
        gallery_code: galleryCode, 
        teamCode: teamCode,     
        pageNo: page 
    };
    
    const fn = function(data) {
        addNewContent(data);
    };
    
    ajaxRequest(url, "get", params, "json", fn);
}


function addNewContent(data) {
    const listReply = data.listReply;
    const replyCount = data.replyCount;
    const pageNo = data.pageNo;
    const total_page = data.total_page;
    
    $("#listReply .reply-count").text("댓글 " + replyCount);
    
    if(replyCount > 0) {
        $("#listReply .reply-page").text(`[목록, ${pageNo}/${total_page} 페이지]`);
    } else {
        $("#listReply .reply-page").text("");
    }
    
    const htmlText = renderReplies(listReply);
    
    if(replyCount === 0) {
        $("#listReply .list-content tbody").html("<tr><td class='text-center py-4 text-muted'>등록된 댓글이 없습니다.</td></tr>");
        $("#listReply .page-navigation").html(""); 
        return;
    }
    
    $("#listReply .list-content tbody").html(htmlText);
    
    createPagingButtons(pageNo, total_page);
}

function createPagingButtons(current_page, total_page) {
    const $pagingArea = $("#listReply .page-navigation");
    $pagingArea.empty();

    if(total_page <= 1) return;

    for(let i = 1; i <= total_page; i++) {
        let $btn;

        if(i === current_page) {
            $btn = $("<span>").text(i).addClass("active mx-1"); 
        } else {
            $btn = $("<a>").attr("href", "#")
                           .text(i)
                           .addClass("mx-1")
                           .on("click", function(e){
                               e.preventDefault(); 
                               loadContent(i);    
                           });
        }
        $pagingArea.append($btn);
    }
}

function renderReplies(listReply) {
    if(!listReply) return "";
    
    return listReply.map(vo => {
        // 본인 글인지 확인
        const isWriter = (String(sessionMemberCode) === String(vo.member_code));
        
        let btnHTML = "";
        if(isWriter) {
            btnHTML = `
                <div class="reply-menu">
                    <button type="button" class="btn btn-link btn-sm text-decoration-none updateReplyBtn" 
                            data-commentId="${vo.comment_id}">수정</button>
                    <button type="button" class="btn btn-link btn-sm text-danger text-decoration-none deleteReply" 
                            data-commentId="${vo.comment_id}">삭제</button>
                </div>
            `;
        }
        
        const profileSrc = vo.profile_image 
            ? `${contextPath}/uploads/profile/${vo.profile_image}`
            : `${contextPath}/dist/images/avatar.png`;

        return `
            <tr class="border-bottom">
                <td class="py-3">
                    <div class="d-flex justify-content-between align-items-center mb-2">
                        <div class="d-flex align-items-center">
                            <div class="rounded-circle bg-light d-flex align-items-center justify-content-center me-2 overflow-hidden" style="width: 35px; height: 35px;">
                                <img src="${profileSrc}" style="width:100%; height:100%; object-fit:cover;" onerror="this.src='${contextPath}/dist/images/avatar.png'">
                            </div>
                            <div>
                                <span class="fw-bold d-block" style="font-size:0.9rem;">${vo.member_name}</span>
                                <span class="text-muted small">${vo.created_at}</span>
                            </div>
                        </div>
                        <div>${btnHTML}</div>
                    </div>
                    <div class="text-break original-content" style="white-space:normal;">${vo.content}</div>
                </td>
            </tr>
        `;
    }).join('');
}

function sendReply() {
    if(!sessionMemberCode) {
        alert("로그인이 필요합니다.");
        return;
    }

    const content = $("#replyContent").val().trim();
    if(!content) {
        alert("내용을 입력하세요.");
        $("#replyContent").focus();
        return;
    }
    
    const url = contextPath + "/myteam/insertReply";
    const params = { gallery_code: galleryCode, content: content };
    
    const fn = function(data) {
        if(data.state === "true") {
            $("#replyContent").val("");
            loadContent(1);
        } else if(data.state === "login_required") {
            alert("로그인이 필요합니다.");
        } else {
            alert("댓글 등록에 실패했습니다.");
        }
    };
    
    ajaxRequest(url, "post", params, "json", fn);
}

$(function(){
    $("body").on("click", ".updateReplyBtn", function(){
        const $tr = $(this).closest("tr");
        const $contentDiv = $tr.find(".original-content");
        const $menuDiv = $tr.find(".reply-menu");
        
        let content = $contentDiv.html().replace(/<br\s*\/?>/gi, "\n");
        
        $contentDiv.hide(); 
        $menuDiv.hide();    
        
        const editHtml = `
            <div class="edit-form mt-2">
                <textarea class="form-control mb-2" rows="3">${content}</textarea>
                <div class="text-end">
                    <button type="button" class="btn btn-sm btn-secondary btnCancelUpdate me-1">취소</button>
                    <button type="button" class="btn btn-sm btn-dark btnSaveUpdate" 
                            data-commentId="${$(this).attr("data-commentId")}">저장</button>
                </div>
            </div>
        `;
        
        $tr.find("td").append(editHtml);
    });

    $("body").on("click", ".btnCancelUpdate", function(){
        const $tr = $(this).closest("tr");
        $tr.find(".edit-form").remove();
        $tr.find(".original-content").show();
        $tr.find(".reply-menu").show();
    });

    $("body").on("click", ".btnSaveUpdate", function(){
        const $tr = $(this).closest("tr");
        const commentId = $(this).attr("data-commentId");
        const content = $tr.find("textarea").val().trim();
        
        if(!content) {
            alert("내용을 입력하세요.");
            return;
        }
        
        const url = contextPath + "/myteam/updateReply";
        const params = { comment_id: commentId, content: content };
        
        const fn = function(data) {
            if(data.state === "true") {
                loadContent(1); 
            } else {
                alert("수정에 실패했습니다.");
            }
        };
        
        ajaxRequest(url, "post", params, "json", fn);
    });
});

$(function(){
    $("body").on("click", ".deleteReply", function(){
        if(!confirm("댓글을 삭제하시겠습니까?")) return;
        
        const commentId = $(this).attr("data-commentId");
        const url = contextPath + "/myteam/deleteReply";
        const params = { comment_id: commentId };
        
        const fn = function(data) {
            if(data.state === "true") {
                loadContent(1);
            } else {
                alert("삭제 실패했습니다.");
            }
        };
        
        ajaxRequest(url, "post", params, "json", fn);
    });
});

function sendLikeAction($btn) {
    if(!sessionMemberCode) {
        alert("로그인이 필요합니다.");
        return;
    }

    const url = contextPath + "/myteam/updateGalleryLike"; 
    const params = { gallery_code: galleryCode };
     
    const fn = function(data) {
        if(data.state === "true") {
            $btn.find("i").removeClass("bi-heart").addClass("bi-heart-fill");
        } else if(data.state === "false") {
            $btn.find("i").removeClass("bi-heart-fill").addClass("bi-heart");
        } else if(data.state === "login_required") {
            alert("로그인이 필요합니다.");
            return;
        } else {
            alert("오류가 발생했습니다.");
            return;
        }
        $("#likeCount").text(data.likeCount);
    };
    
    ajaxRequest(url, "post", params, "json", fn);
}

function deleteGallery(galleryCode, teamCode) {
    if(confirm("정말로 이 게시글을 삭제하시겠습니까?")) {
        location.href = contextPath + "/myteam/galleryDelete?gallery_code=" + galleryCode + "&teamCode=" + teamCode;
    }
}