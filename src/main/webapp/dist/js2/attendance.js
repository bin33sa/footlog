let currentTargetVoteCode = 0; 

document.addEventListener("DOMContentLoaded", function() {
    listPage(1);
});

function listPage(page) {
    let url = "vote_list"; 
    let query = "teamCode=" + teamCode + "&pageNo=" + page;
    ajaxRequest(url, "get", query, "json", function(data) {
        printVoteList(data);
    });
}

function printVoteList(data) {
    let list = data.list;
    let out = "";

    if (!list || list.length === 0) {
        out = "<div class='text-center p-5'>등록된 투표가 없습니다.</div>";
    } else {
        out += '<table class="board-table table-hover">';
        out += '  <thead class="table-light text-center"><tr>';
        out += '    <th width="10%">상태</th><th width="50%">제목</th>';
        out += '    <th width="15%">마감일</th><th width="15%">작성자</th><th width="10%">참여</th>';
        out += '  </tr></thead><tbody>';

        for (let item of list) {
            let vCode = item.boardVoteCode || item.board_vote_code; 
            let writer = item.writerName || item.writer_name || "익명";
            let vCount = item.voteCount || item.vote_count || 0;
            let eDate = item.endDate || item.end_date || "날짜 미정";
            if(eDate.length > 10) eDate = eDate.substring(0, 10);

            let badge = item.status == 0 ? '<span class="badge bg-success">진행중</span>' : '<span class="badge bg-secondary">마감</span>';

            out += '<tr onclick="readVote(' + vCode + ')" class="text-center cursor-pointer">';
            out += '  <td>' + badge + '</td>';
            out += '  <td class="text-start fw-bold ps-3 subject-text">' + item.title + '</td>';
            out += '  <td>' + eDate + '</td><td>' + writer + '</td><td>' + vCount + '명</td>';
            out += '</tr>';
        }
        out += '  </tbody></table>';
    }

    const container = document.querySelector("#voteListContainer");
    if (container) container.innerHTML = out;

    const pagingContainer = document.querySelector("#list-paging");
    if (pagingContainer) {
        pagingContainer.innerHTML = (data.total_page && data.total_page > 0) ? paging(data.pageNo, data.total_page, "listPage") : "";
    }
}

function readVote(boardVoteCode) {
    let url = "vote_read";
    let query = "board_vote_code=" + boardVoteCode;

    ajaxRequest(url, "get", query, "json", function(data) {
        if (data.state === "true") {
            let dto = data.dto;
            currentTargetVoteCode = dto.boardVoteCode;

            document.querySelector("#detailTitle").textContent = dto.title;
            let contentHtml = dto.content ? dto.content.replace(/\n/g, "<br>") : "";
            document.querySelector("#detailContent").innerHTML = contentHtml;
            document.querySelector("#detailEventDate").textContent = "📅 일정: " + dto.eventDate;

            let radios = document.getElementsByName("status");
            for (let r of radios) {
                r.checked = false;
                r.onclick = function() {
                    sendVote(this.value);
                };
                
                if (r.value == dto.myVoteStatus) {
                    r.checked = true;
                }
            }

            var myModal = new bootstrap.Modal(document.getElementById('voteDetailModal'));
            myModal.show();
        }
    });
}

function sendVote(status) {
    if(!currentTargetVoteCode) return;
    
    let url = "vote_do";
    let query = "board_vote_code=" + currentTargetVoteCode + "&status=" + status;
    
    ajaxRequest(url, "post", query, "json", function(data) {
        if (data.state === "true") {
            const modalElement = document.getElementById('voteDetailModal');
            const modalInstance = bootstrap.Modal.getInstance(modalElement);
            if(modalInstance) modalInstance.hide();
            
            listPage(1);
        } else {
            alert("투표 처리에 실패했습니다.");
        }
    });
}

function deleteVote() {
    if (!confirm("정말 이 투표를 삭제하시겠습니까?")) return;
    if(!currentTargetVoteCode) return;
    
    let url = "vote_delete";
    let query = "board_vote_code=" + currentTargetVoteCode;
    ajaxRequest(url, "post", query, "json", function(data) {
        if (data.state === "true") {
            bootstrap.Modal.getInstance(document.getElementById('voteDetailModal')).hide();
            listPage(1);
        } else {
            alert("삭제 실패했습니다.");
        }
    });
}

function insertVote() {
    const f = document.voteWriteForm;
    if (!f.title.value.trim()) {
        alert("제목을 입력하세요.");
        f.title.focus();
        return;
    }

    let url = "vote_insert";
    let query = $(f).serialize() + "&team_code=" + teamCode; 
    
    ajaxRequest(url, "post", query, "json", function(data) {
        if (data.state === "true") {
            const modalElement = document.getElementById('voteWriteModal');
            const modalInstance = bootstrap.Modal.getInstance(modalElement);
            if(modalInstance) modalInstance.hide();
            
            listPage(1); 
        } else {
            alert(data.message || "등록에 실패했습니다.");
        }
    });
}

function showWriteModal() {
    document.voteWriteForm.reset();
    document.voteWriteForm.team_code.value = teamCode;
    new bootstrap.Modal(document.getElementById('voteWriteModal')).show();
}