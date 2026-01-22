<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<!DOCTYPE html>
<html>
<head>
    <title>Footlog - 팀 투표/출석</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <jsp:include page="/WEB-INF/views/layout/headerResources.jsp"/>
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/style.css?ver=2">
    
    <style>
        .sidebar-title { font-size: 0.85rem; font-weight: 700; color: #6c757d; text-transform: uppercase; letter-spacing: 0.5px; }
        
        .board-table { width: 100%; border-collapse: separate; border-spacing: 0; }
        .board-table th { border-bottom: 2px solid #111; padding: 15px 10px; font-weight: 700; color: #333; background-color: #fff; text-align: center; }
        .board-table td { padding: 15px 10px; border-bottom: 1px solid #f1f3f5; color: #555; vertical-align: middle; text-align: center; }
        .board-table tr:hover td { background-color: #f8f9fa; cursor: pointer; }
        
        .subject-text { color: #333; font-weight: 600; text-align: left; }
        .board-table tr:hover .subject-text { text-decoration: underline; text-underline-offset: 4px; }
        
        /* 투표 버튼 스타일 */
        .btn-check:checked + .btn-outline-success { background-color: #198754; color: #fff; }
        .btn-check:checked + .btn-outline-danger { background-color: #dc3545; color: #fff; }
        .btn-check:checked + .btn-outline-secondary { background-color: #6c757d; color: #fff; }
        
        /* 페이징 스타일 */
        .page-navigation { display: flex; justify-content: center; align-items: center; gap: 5px; margin-top: 30px; }
        .page-navigation li { list-style: none; }
        .page-navigation a { display: inline-flex; justify-content: center; align-items: center; min-width: 32px; height: 32px; padding: 0 6px; border-radius: 50%; text-decoration: none; color: #888; font-size: 0.9rem; font-weight: 600; cursor: pointer; }
        .page-navigation a:hover { background-color: #f1f3f5; color: #333; }
        .page-navigation .active a { background-color: #111; color: #D4F63F !important; cursor: default; }
    </style>
    
    <script type="text/javascript">
        let teamCode = "${teamCode}";
    </script>
    
    <script src="${pageContext.request.contextPath}/dist/js2/attendance.js"></script>

    <script type="text/javascript">
        $(function() {
            const urlParams = new URLSearchParams(window.location.search);
            const matchCode = urlParams.get('matchCode');
            const targetTeamCode = urlParams.get('teamCode');

            if (matchCode) {
                let url = "${pageContext.request.contextPath}/myteam/read_match_info";
                let query = "match_code=" + matchCode + "&team_code=" + targetTeamCode;

                ajaxRequest(url, "get", query, "json", function(data) {
                    if (data.state === "true") {
                        let dto = data.dto;
                        
                        $("#matchModalTitle").text("VS " + dto.opponent_name + " 경기 투표");
                        $("#matchModalDate").text(dto.match_date);
                        $("#matchModalPlace").text(dto.stadiumName ? dto.stadiumName : "장소 미정");
                        
                        const matchModal = new bootstrap.Modal(document.getElementById('matchVoteModal'));
                        matchModal.show();
                    } else {
                        alert("매치 정보를 불러올 수 없습니다.");
                    }
                });
            }

            // 매치 투표 전송 함수
            window.sendMatchVote = function(status) {
                if(!confirm(status + " 상태로 투표하시겠습니까?")) return;

                let url = "${pageContext.request.contextPath}/myteam/vote_match";
                let query = "match_code=" + matchCode + "&status=" + status + "&team_code=" + targetTeamCode;

                ajaxRequest(url, "post", query, "json", function(data) {
                    if (data.state === "true") {
                        alert("투표가 완료되었습니다.");
                        location.href = "${pageContext.request.contextPath}/myteam/match?teamCode=" + targetTeamCode;
                    } else {
                        alert(data.msg || "투표 처리에 실패했습니다.");
                    }
                });
            };
        });
    </script>
</head>

<body>

    <header>
       <jsp:include page="/WEB-INF/views/layout/teamheader.jsp"/>
    </header>

    <div class="container-fluid px-lg-5 mt-4">
        <div class="row">
            
            <div class="col-lg-2 d-none d-lg-block">
                <div class="sidebar-menu sticky-top" style="top: 100px;">
                    <div class="mb-4">
                        <p class="sidebar-title mb-3">구단 커뮤니티</p>
                        <div class="list-group">
                            <a href="${pageContext.request.contextPath}/myteam/board?teamCode=${teamCode}" class="list-group-item list-group-item-action border-0">
                                팀 게시판
                            </a>
                            <a href="${pageContext.request.contextPath}/myteam/schedule?teamCode=${teamCode}" class="list-group-item list-group-item-action border-0">
                                전체 일정
                            </a>
                            <a href="${pageContext.request.contextPath}/myteam/attendance?teamCode=${teamCode}" class="list-group-item list-group-item-action border-0 active fw-bold bg-light text-primary">
                                <i class="bi bi-check2-square me-1"></i> 참석 여부
                            </a>                            
                            <a href="${pageContext.request.contextPath}/myteam/gallery?teamCode=${teamCode}" class="list-group-item list-group-item-action border-0">
                                팀 갤러리
                            </a>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-lg-10 col-12">
                
                <div class="d-flex justify-content-between align-items-center mb-4 border-bottom pb-3">
                    <div>
                        <h2 class="fw-bold display-6 mb-1 text-dark">TEAM VOTE</h2>
                        <p class="text-muted mb-0">경기 및 모임 참석 여부를 투표해주세요.</p>
                    </div>
                </div>

                <div class="d-flex justify-content-end align-items-center mb-4">
                    <button type="button" class="btn btn-dark rounded-pill px-4 fw-bold" onclick="showWriteModal()">
                        <i class="bi bi-pencil-fill me-1"></i> 투표 생성
                    </button>
                </div>

                <div class="card border-0 shadow-sm" style="border-radius: 15px; overflow: hidden; min-height: 500px;">
                    <div class="card-body p-0">
                        <div id="voteListContainer"></div>
                    </div>
                </div>

                <div id="list-paging" class="page-navigation mb-5"></div>

            </div>
        </div> 
    </div>

    <footer>
       <jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
    </footer>
    
    <jsp:include page="/WEB-INF/views/layout/footerResources.jsp"/>

    <div class="modal fade" id="voteWriteModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content border-0 shadow">
                <div class="modal-header border-bottom-0 pb-0">
                    <h5 class="modal-title fw-bold fs-4">투표 만들기</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body p-4">
                    <form name="voteWriteForm" id="voteWriteForm">
                        <input type="hidden" name="team_code" value="${teamCode}">
                        
                        <div class="mb-3">
                            <label class="form-label fw-bold">제목</label>
                            <input type="text" name="title" class="form-control" placeholder="예: 1월 24일 회식">
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-bold">내용</label>
                            <textarea name="content" class="form-control" rows="3" placeholder="내용을 입력하세요"></textarea>
                        </div>
                        <div class="row">
                            <div class="col-6 mb-3">
                                <label class="form-label fw-bold">투표 시작일</label>
                                <input type="date" name="start_date" class="form-control">
                            </div>
                            <div class="col-6 mb-3">
                                <label class="form-label fw-bold">투표 종료일</label>
                                <input type="date" name="end_date" class="form-control">
                            </div>
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-bold text-primary">경기/모임 날짜 (중요)</label>
                            <input type="datetime-local" name="event_date" class="form-control">
                        </div>
                        <div class="d-grid mt-4">
                            <button type="button" class="btn btn-primary fw-bold py-2" onclick="insertVote()">등록하기</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="voteDetailModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content border-0 shadow">
                <div class="modal-header border-bottom-0 pb-0">
                    <h5 class="modal-title fw-bold fs-4" id="detailTitle"></h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body p-4">
                    <input type="hidden" id="detail_board_vote_code" value="">
                    <p class="text-primary fw-bold mb-3" id="detailEventDate"></p>
                    <div class="bg-light p-3 rounded mb-4" id="detailContent" style="min-height: 100px; color: #555;"></div>
    
                    <hr class="my-4">
                    <h6 class="text-center mb-3 fw-bold text-dark">참석 여부를 선택해주세요</h6>
                    <div class="btn-group w-100" role="group">
                        <input type="radio" class="btn-check" name="status" id="v1" value="1" onclick="sendVote(1)">
                        <label class="btn btn-outline-success py-3 fw-bold" for="v1"><i class="bi bi-check-circle me-1"></i> 참석</label>
    
                        <input type="radio" class="btn-check" name="status" id="v2" value="2" onclick="sendVote(2)">
                        <label class="btn btn-outline-danger py-3 fw-bold" for="v2"><i class="bi bi-x-circle me-1"></i> 불참</label>
    
                        <input type="radio" class="btn-check" name="status" id="v3" value="3" onclick="sendVote(3)">
                        <label class="btn btn-outline-secondary py-3 fw-bold" for="v3"><i class="bi bi-question-circle me-1"></i> 미정</label>
                    </div>
                </div>
                <div class="modal-footer justify-content-between border-top-0 pt-0">
                    <button type="button" class="btn btn-link text-danger text-decoration-none btn-sm" onclick="deleteVote()">
                        <i class="bi bi-trash"></i> 삭제
                    </button>
                    <button type="button" class="btn btn-secondary btn-sm px-3" data-bs-dismiss="modal">닫기</button>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="matchVoteModal" tabindex="-1" aria-hidden="true" data-bs-backdrop="static">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content border-0 shadow">
                <div class="modal-header border-bottom-0 pb-0">
                    <h5 class="modal-title fw-bold fs-4" id="matchVoteModalTitle">⚽ 매치 참석 투표</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" onclick="history.back()"></button>
                </div>
                
                <div class="modal-body p-4 text-center">
                    <div class="mb-4">
                        <p class="text-primary fw-bold mb-1" style="font-size: 1.1rem;">
                            <i class="bi bi-calendar-check me-1"></i> <span id="matchModalDate">경기 일시</span>
                        </p>
                        <p class="text-muted">
                            <i class="bi bi-geo-alt-fill me-1"></i> <span id="matchModalPlace">경기 장소</span>
                        </p>
                    </div>

                    <div class="bg-light p-3 rounded mb-4 text-start" style="color: #555;">
                        리스트에서 선택한 경기에 대해 투표를 진행합니다.<br>
                        <strong>정확한 인원 파악을 위해 신중히 선택해주세요!</strong>
                    </div>
    
                    <hr class="my-4">
    
                    <h6 class="text-center mb-3 fw-bold text-dark">참석 여부를 선택해주세요</h6>
                    <div class="btn-group w-100" role="group">
                        <input type="radio" class="btn-check" name="matchStatus" id="mv1" onclick="sendMatchVote('참석')">
                        <label class="btn btn-outline-success py-3 fw-bold" for="mv1">
                            <i class="bi bi-check-circle me-1"></i> 참석
                        </label>
    
                        <input type="radio" class="btn-check" name="matchStatus" id="mv2" onclick="sendMatchVote('불참')">
                        <label class="btn btn-outline-danger py-3 fw-bold" for="mv2">
                            <i class="bi bi-x-circle me-1"></i> 불참
                        </label>
    
                        <input type="radio" class="btn-check" name="matchStatus" id="mv3" onclick="sendMatchVote('미정')">
                        <label class="btn btn-outline-secondary py-3 fw-bold" for="mv3">
                            <i class="bi bi-question-circle me-1"></i> 미정
                        </label>
                    </div>
                </div>
                
                <div class="modal-footer border-top-0 pt-0 justify-content-end">
                    <button type="button" class="btn btn-secondary btn-sm px-3" data-bs-dismiss="modal" onclick="history.back()">목록으로 돌아가기</button>
                </div>
            </div>
        </div>
    </div>

</body>
</html>