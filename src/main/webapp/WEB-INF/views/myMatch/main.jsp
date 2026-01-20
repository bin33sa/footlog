<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<title>Footlog - 내 매치 일정</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/style.css">

<style>
    .nav-pills .nav-link { cursor: pointer; color: #6c757d; font-weight: 600; padding: 12px 25px; border-radius: 50px; background-color: #fff; border: 1px solid #dee2e6; margin-right: 10px; }
    .nav-pills .nav-link.active { background-color: #212529; color: #fff; border-color: #212529; box-shadow: 0 4px 10px rgba(0,0,0,0.2); }
</style>
</head>

<jsp:include page="/WEB-INF/views/layout/headerResources.jsp" />

<body class="bg-light">

    <header>
        <jsp:include page="/WEB-INF/views/layout/header.jsp" />
    </header>

    <div class="container-fluid px-lg-5 mt-5">
        <div class="row">
            
            <div class="col-lg-2 d-none d-lg-block">
                <div class="sidebar-menu sticky-top" style="top: 100px;">
                    <div class="mb-4">
                        <p class="sidebar-title">매치</p>
                        <div class="list-group">
                            <a href="${pageContext.request.contextPath}/myMatch/main" class="list-group-item list-group-item-action ">내 매치 일정</a>
                            <a href="${pageContext.request.contextPath}/match/list" class="list-group-item list-group-item-action  active-menu">전체 매치 리스트</a>
                            
                            <c:if test="${canCreate}">
                                <a href="${pageContext.request.contextPath}/match/write" class="list-group-item list-group-item-action ">매치 개설하기</a>
                            </c:if>
                            
                            <a href="${pageContext.request.contextPath}/mercenary/list" class="list-group-item list-group-item-action ">용병 구하기</a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-9 col-12 ms-lg-4">
                
                <div class="d-flex justify-content-between align-items-end mb-5">
                    <div>
                        <h2 class="fw-bold mb-1">내 매치 관리</h2>
                        <p class="text-muted mb-0">참여 예정인 경기와 지난 기록을 관리하세요.</p>
                    </div>
                    <button class="btn btn-dark rounded-pill px-4 shadow-sm" onclick="location.href='${pageContext.request.contextPath}/match/write'">
                        <i class="bi bi-plus-lg me-1"></i> 매치 만들기
                    </button>
                </div>

                <ul class="nav nav-pills mb-4">
                    <li class="nav-item">
                        <a class="nav-link active" id="tab-future" onclick="loadMatchList('future')">🔥 예정된 매치</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" id="tab-past" onclick="loadMatchList('past')">🏁 지난 매치</a>
                    </li>
                </ul>

                <div id="list-container"></div>

            </div>
        </div>
    </div>

    <footer>
        <jsp:include page="/WEB-INF/views/layout/footer.jsp" />
    </footer>

    <jsp:include page="/WEB-INF/views/layout/footerResources.jsp" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

    <script>
        $(function(){
            loadMatchList('future'); // 페이지 열리면 '미래' 탭 자동 로딩
        });

        function loadMatchList(tabType) {
            // 탭 스타일 변경
            $(".nav-link").removeClass("active");
            $("#tab-" + tabType).addClass("active");
            
            // 로딩 스피너
            $("#list-container").html('<div class="text-center py-5"><div class="spinner-border"></div></div>');

            // AJAX 요청 (list.jsp 파일의 HTML을 받아옴)
            $.ajax({
                type: "get",
                url: "${pageContext.request.contextPath}/match/myMatchList",
                data: { tab: tabType },
                success: function(data) {
                    $("#list-container").html(data); // 받아온 HTML 꽂아넣기
                },
                error: function(e) {
                    console.log(e);
                    alert("리스트 로딩 실패");
                }
            });
        }
        
        function deleteMatch(matchCode) {
            if(confirm("정말로 이 매치를 취소하시겠습니까?")) {
                location.href = "${pageContext.request.contextPath}/match/delete?match_code=" + matchCode;
            }
        }
    </script>
</body>
</html>