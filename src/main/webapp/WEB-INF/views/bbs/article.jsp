<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>${dto.title}- Footlog</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/dist/css/style.css">

<style>
.comment-input:focus {
	border-color: var(--primary-color);
	box-shadow: 0 0 0 0.25rem rgba(212, 246, 63, 0.25);
}

.content-body {
	min-height: 300px;
	line-height: 1.8;
}
</style>
</head>
<jsp:include page="/WEB-INF/views/layout/headerResources.jsp" />

<body>
	<header>
		<jsp:include page="/WEB-INF/views/layout/header.jsp" />
	</header>

	<div class="container mt-5 mb-5" style="max-width: 900px;">
		<div class="modern-card p-5 mb-4">
			<div class="border-bottom pb-3 mb-4">
				<div class="d-flex align-items-center gap-2 mb-3">
					<span
						class="badge bg-light text-dark border px-3 py-2 rounded-pill">
						${dto.category == 1 ? '💬 잡담' : (dto.category == 2 ? '💡 정보' : '📝 후기')}
					</span>
				</div>
				<h2 class="fw-bold mb-3">${dto.title}</h2>
				<div
					class="d-flex justify-content-between align-items-center text-muted small">
					<div class="d-flex align-items-center gap-2">
						<span class="fw-bold text-dark">${dto.member_name}</span> <span
							class="mx-1">|</span> <span>${dto.created_at}</span>
					</div>
					<div>
						<span class="me-3">조회 ${dto.view_count}</span>
					</div>
				</div>
			</div>

			<div class="content-body mb-5">
				${dto.content}
				<c:if test="${not empty dto.video_url}">
    <div class="mt-4 ratio ratio-16x9">
        <c:set var="videoUrl" value="${dto.video_url}"/>
        <%-- 유튜브 일반 주소를 embed 주소로 치환 (간이 로직) --%>
        <c:if test="${videoUrl.contains('watch?v=')}">
            <c:set var="videoUrl" value="${videoUrl.replace('watch?v=', 'embed/')}"/>
        </c:if>
        
        <iframe src="${videoUrl}" 
                allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share; fullscreen"
                title="YouTube video player">
        </iframe>
    </div>
</c:if>
			</div>

			<div class="d-flex justify-content-between pt-4 border-top">
				<a
					href="${pageContext.request.contextPath}/bbs/list?page=${page}&category=${category}"
					class="btn btn-outline-dark rounded-pill px-4 fw-bold"> &larr;
					목록 </a>

				<c:if test="${sessionScope.member.member_code == dto.member_code}">
					<div class="d-flex gap-2">
						<a
							href="${pageContext.request.contextPath}/bbs/update?board_main_code=${dto.board_main_code}&page=${page}"
							class="btn btn-light rounded-pill px-4 fw-bold">수정</a>
						<button type="button"
							class="btn btn-light rounded-pill px-4 fw-bold text-danger"
							onclick="deleteOk();">삭제</button>
					</div>
				</c:if>
			</div>
		</div>

		<div class="modern-card p-4 bg-light border-0">
			<h5 class="fw-bold mb-4">
				댓글 <span class="text-primary" id="replyCount">0</span>
			</h5>

			<div class="d-flex gap-3 mb-5">
				<div class="flex-grow-1">
					<textarea id="replyContent"
						class="form-control comment-input rounded-4 border-0 shadow-sm p-3"
						rows="2" placeholder="댓글을 남겨보세요." style="resize: none;"></textarea>
				</div>
				<button class="btn btn-dark rounded-4 px-4 fw-bold"
					onclick="sendReply();" style="color: var(--primary-color);">등록</button>
			</div>

			<div id="listReply" class="vstack gap-3"></div>

			<div id="listReplyPaging" class="mt-4"></div>
		</div>
	</div>

	<footer>
		<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
	</footer>

	<jsp:include page="/WEB-INF/views/layout/footerResources.jsp" />

	<script>
    // 1. ajaxFun 정의 (가장 먼저 선언)
    function ajaxFun(url, method, query, dataType, fn) {
        $.ajax({
            type: method,
            url: url,
            data: query,
            dataType: dataType,
            success: function(data) {
                fn(data);
            },
            beforeSend: function(jqXHR) {
                jqXHR.setRequestHeader("AJAX", true);
            },
            error: function(jqXHR) {
                if (jqXHR.status === 403) {
                    location.href = '${pageContext.request.contextPath}/member/login';
                    return false;
                }
                console.log("AJAX 에러: " + jqXHR.responseText);
            }
        });
    }

    // 2. 게시글 삭제 함수
    function deleteOk() {
        if (confirm("정말로 이 게시글을 삭제하시겠습니까?")) {
            location.href = '${pageContext.request.contextPath}/bbs/delete?board_main_code=${dto.board_main_code}&page=${page}&category=${category}';
        }
    }

    // 3. 페이지 로드 시 실행
    $(function() {
        listPage(1);
    });

    // 4. 댓글 목록 가져오기
    function listPage(page) {
        let url = "${pageContext.request.contextPath}/bbs/listReply";
        let query = "board_main_code=${dto.board_main_code}&pageNo=" + page;

        const fn = function(data) {
            printReply(data);
        };

        ajaxFun(url, "get", query, "json", fn);
    }

    function printReply(data) {
        console.log("받은 데이터:", data); // 브라우저 콘솔(F12)에서 데이터 구조 확인용
        
        let count = data.replyCount || 0;
        $("#replyCount").text(count);

        let out = "";
        if (count > 0 && data.listReply) {
            data.listReply.forEach(function(item) {
                // DB 컬럼명과 DTO 필드명을 확인하여 매칭 (보통 MyBatis는 자동으로 CamelCase 변환을 하거나 필드명을 그대로 씁니다)
                let name = item.member_name || "이름없음"; 
                let content = item.content || "";
                let date = item.created_at || "";
                
                // 404 에러 방지: PROFILE_IMAGE 컬럼명 사용
                let photo = item.profile_image ? item.profile_image : 'default.png';
                let photoPath = "${pageContext.request.contextPath}/uploads/member/" + photo;

                out += '<div class="d-flex gap-3 bg-white p-3 rounded-4 shadow-sm border border-light mb-3">';
                out += '  <div class="flex-shrink-0">';
                out += '    <img src="' + photoPath + '" class="rounded-circle" style="width:40px; height:40px; object-fit:cover;" onerror="this.src=\'https://cdn-icons-png.flaticon.com/512/149/149071.png\'">';
                out += '  </div>';
                out += '  <div class="w-100">';
                out += '    <div class="d-flex justify-content-between align-items-center mb-1">';
                out += '      <h6 class="fw-bold mb-0">' + name + '</h6>';
                out += '      <small class="text-muted">' + date + '</small>';
                out += '    </div>';
                out += '    <p class="mb-0 text-dark" style="white-space:pre-wrap;">' + content + '</p>';
                out += '  </div>';
                out += '</div>';
            });
        } else {
            out = '<div class="text-center p-4 text-muted">등록된 댓글이 없습니다.</div>';
        }
        
        $("#listReply").html(out);
        $("#listReplyPaging").html(data.paging || "");
    }

    // 6. 댓글 등록 함수
    function sendReply() {
        let content = $("#replyContent").val().trim();
        if (!content) {
            $("#replyContent").focus();
            return;
        }

        let url = "${pageContext.request.contextPath}/bbs/insertReply";
        let query = {
            board_main_code: "${dto.board_main_code}",
            content: content
        };

        const fn = function(data) {
            if (data.state === "true") {
                $("#replyContent").val("");
                listPage(1);
            } else if(data.state === "loginFail") {
                alert("로그인이 필요합니다.");
                location.href = "${pageContext.request.contextPath}/member/login";
            } else {
                alert("댓글 등록에 실패했습니다.");
            }
        };
        ajaxFun(url, "post", query, "json", fn);
    }
</script>
</body>
</html>