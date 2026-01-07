<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>Footlog - Create Match</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/style.css">
</head>
	<jsp:include page="/WEB-INF/views/layout/headerResources.jsp"/>
<body>

    <header>
	   <jsp:include page="/WEB-INF/views/layout/header.jsp"/>
	</header>

    <div class="container-fluid px-lg-5 mt-4">
        <div class="row">
            <div class="col-lg-2 d-none d-lg-block">
                <div class="sidebar-menu sticky-top" style="top: 100px;">
                    <div class="mb-4">
                        <p class="sidebar-title">매치</p>
                        <div class="list-group">
                            <a href="${pageContext.request.contextPath}/match/list" class="list-group-item list-group-item-action ">내 매치 일정</a>
                            <a href="${pageContext.request.contextPath}/match/list" class="list-group-item list-group-item-action ">전체 매치 리스트</a>
                            <a href="${pageContext.request.contextPath}/match/write" class="list-group-item list-group-item-action  active-menu">매치 개설하기</a>
                            <a href="${pageContext.request.contextPath}/mercenary/list" class="list-group-item list-group-item-action ">용병 구하기</a>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-lg-8 col-12">
                
                <div class="d-flex align-items-center mb-4">
                    <h2 class="fw-bold mb-0">매치 개설하기</h2>
                    <span class="ms-3 text-muted small">팀원 모집을 위한 매치 정보를 입력해주세요.</span>
                </div>

                <form action="${pageContext.request.contextPath}/match/register" method="post">
                    
                    <div class="modern-card p-5">
                        
                        <div class="mb-4">
                            <label for="title" class="form-label fw-bold">매치 제목</label>
                            <input type="text" class="form-control form-control-lg bg-light border-0" id="title" name="title" placeholder="예) 9월 20일 상암 3파전 모집합니다!">
                        </div>

                        <div class="row g-3 mb-4">
                            <div class="col-md-6">
                                <label for="matchDate" class="form-label fw-bold">경기 일시</label>
                                <input type="datetime-local" class="form-control bg-light border-0" id="matchDate" name="matchDate">
                            </div>
                            <div class="col-md-6">
                                <label for="stadium" class="form-label fw-bold">구장 선택</label>
                                <select class="form-select bg-light border-0" id="stadium" name="stadiumId">
                                    <option selected>구장을 선택해주세요</option>
                                    <option value="1">상암 월드컵 보조경기장</option>
                                    <option value="2">용산 아이파크몰 풋살장</option>
                                    <option value="3">잠실 유수지 풋살장</option>
                                    <option value="4">고양 백석 구장</option>
                                </select>
                            </div>
                        </div>

                        <div class="row g-3 mb-4">
                            <div class="col-md-4">
                                <label for="matchType" class="form-label fw-bold">경기 방식</label>
                                <select class="form-select bg-light border-0" id="matchType" name="matchType">
                                    <option value="5">5 vs 5</option>
                                    <option value="6" selected>6 vs 6</option>
                                    <option value="11">11 vs 11</option>
                                </select>
                            </div>
                            <div class="col-md-4">
                                <label for="gender" class="form-label fw-bold">성별</label>
                                <select class="form-select bg-light border-0" id="gender" name="gender">
                                    <option value="M" selected>남성</option>
                                    <option value="F">여성</option>
                                    <option value="X">남녀무관(혼성)</option>
                                </select>
                            </div>
                            <div class="col-md-4">
                                <label for="level" class="form-label fw-bold">실력</label>
                                <select class="form-select bg-light border-0" id="level" name="level">
                                    <option value="LOW">하 (초보)</option>
                                    <option value="MID" selected>중 (아마추어)</option>
                                    <option value="HIGH">상 (선출포함)</option>
                                </select>
                            </div>
                        </div>

                        <div class="mb-4">
                            <label for="fee" class="form-label fw-bold">참가비 (1인당)</label>
                            <div class="input-group">
                                <input type="number" class="form-control bg-light border-0" id="fee" name="fee" placeholder="10000">
                                <span class="input-group-text bg-light border-0">원</span>
                            </div>
                            <div class="form-text text-muted small">* 무료 매치일 경우 0을 입력하세요.</div>
                        </div>

                        <div class="mb-4">
                            <label for="content" class="form-label fw-bold">상세 내용</label>
                            <textarea class="form-control bg-light border-0" id="content" name="content" rows="6" placeholder="경기 규칙, 준비물, 진행 방식 등을 자유롭게 적어주세요."></textarea>
                        </div>

                        <hr class="my-5">

                        <div class="d-flex justify-content-end gap-2">
                            <button type="button" class="btn btn-light rounded-pill px-4 fw-bold" onclick="history.back()">취소</button>
                            <button type="submit" class="btn btn-dark rounded-pill px-5 fw-bold">매치 등록하기</button>
                        </div>

                    </div>
                </form>

            </div>

            <div class="col-lg-2 d-none d-lg-block">
                <div class="sidebar-menu sticky-top" style="top: 100px;">
                    <div class="mb-4">
                    </div>
                </div>
            </div>

        </div> 
    </div>

    <footer>
	   <jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
	</footer>
	
	<jsp:include page="/WEB-INF/views/layout/footerResources.jsp"/>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>