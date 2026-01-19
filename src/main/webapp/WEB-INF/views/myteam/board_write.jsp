<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <title>Footlog - 팀 게시판 ${mode == 'update' ? '수정' : '작성'}</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <jsp:include page="/WEB-INF/views/layout/headerResources.jsp"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/style.css?ver=2">
    
    <style>
        .sidebar-title { font-size: 0.85rem; font-weight: 700; color: #6c757d; text-transform: uppercase; letter-spacing: 0.5px; }
        .write-card { border: none; box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.03); border-radius: 15px; }
        .form-label { font-weight: bold; }
    </style>
    
    

    <script type="text/javascript">
        function check() {
            const f = document.boardForm;
            let str;
            
            str = f.title.value.trim();
            if(!str) {
                alert("제목을 입력하세요.");
                f.title.focus();
                return false;
            }

            // 에디터 내용 동기화 확인
            str = f.content.value;
            if(!str || str == "<p>&nbsp;</p>") {
                alert("내용을 입력하세요.");
                f.content.focus();
                return false;
            }

            return true;
        }

        function submitContents(elClickedObj) {
            // 에디터의 내용을 textarea에 적용 (UPDATE_CONTENTS_FIELD)
            oEditors.getById["ir1"].exec("UPDATE_CONTENTS_FIELD", []); 
            
            try {
                if(check()) {
                    elClickedObj.submit();
                }
            } catch(e) {
                console.log(e);
            }
        }
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
                            <a href="${pageContext.request.contextPath}/myteam/board?teamCode=${teamCode}" class="list-group-item list-group-item-action border-0 active fw-bold bg-light text-primary">
                                <i class="bi bi-layout-text-window-reverse me-1"></i> 팀 게시판
                            </a>
                            <a href="${pageContext.request.contextPath}/myteam/schedule?teamCode=${teamCode}" class="list-group-item list-group-item-action border-0">
                                전체 일정
                            </a>
                            <a href="${pageContext.request.contextPath}/myteam/vote?teamCode=${teamCode}" class="list-group-item list-group-item-action border-0">
                                참석 여부
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
                        <h2 class="fw-bold display-6 mb-1 text-dark">BOARD ${mode == 'update' ? 'UPDATE' : 'WRITE'}</h2>
                        <p class="text-muted mb-0">팀원들과 자유롭게 이야기를 나누세요.</p>
                    </div>
                </div>

                <div class="card write-card p-4">
                    <div class="card-body">
                        
                        <form name="boardForm" method="post" action="${pageContext.request.contextPath}/myteam/board_${mode}" onsubmit="return false;">
                            
                            <input type="hidden" name="teamCode" value="${teamCode}">
                            <c:if test="${mode == 'update'}">
                                <input type="hidden" name="board_team_code" value="${dto.board_team_code}">
                                <input type="hidden" name="page" value="${page}">
                            </c:if>
                            
                            <div class="mb-4">
                                <label class="form-label">제목</label>
                                <input type="text" name="title" class="form-control form-control-lg" 
                                       value="${dto.title}" placeholder="제목을 입력하세요">
                            </div>

                            <div class="mb-4">
                                <label class="form-label">작성자</label>
                                <input type="text" class="form-control-plaintext border-bottom" 
                                       value="${sessionScope.member.member_name}" readonly>
                            </div>

                            <div class="mb-5">
                                <label class="form-label">내용</label>
                                <textarea name="content" id="ir1" class="form-control" style="width: 100%; height: 400px;">${dto.content}</textarea>
                            </div>

                            <div class="d-flex justify-content-center gap-2">
                                <button type="button" class="btn btn-primary px-5 py-2 fw-bold" onclick="submitContents(this.form);">
                                    ${mode == 'update' ? '수정완료' : '등록하기'}
                                </button>
                                <button type="button" class="btn btn-light px-5 py-2 border" onclick="location.href='${pageContext.request.contextPath}/myteam/board?teamCode=${teamCode}';">
                                    취소
                                </button>
                            </div>
                        </form>

                    </div>
                </div>

            </div>
        </div> 
    </div>

    <footer>
       <jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
    </footer>
    
    <jsp:include page="/WEB-INF/views/layout/footerResources.jsp"/>
    
	<script type="text/javascript" src="${pageContext.request.contextPath}/dist/vendor/se2/js/service/HuskyEZCreator.js" charset="utf-8"></script>
    
    <script type="text/javascript">
    var oEditors = [];
    nhn.husky.EZCreator.createInIFrame({
        oAppRef: oEditors,
        elPlaceHolder: "ir1",
        sSkinURI: "${pageContext.request.contextPath}/dist/vendor/se2/SmartEditor2Skin.html",
        fCreator: "createSEditor2"
    });
    </script>

</body>
</html>