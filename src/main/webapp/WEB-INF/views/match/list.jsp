<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>Footlog - Match List</title>
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
                            <a href="${pageContext.request.contextPath}/match/myMatch" class="list-group-item list-group-item-action ">내 매치 일정</a>
                            <a href="${pageContext.request.contextPath}/match/list" class="list-group-item list-group-item-action  active-menu">전체 매치 리스트</a>
                             <c:if test="${sessionScope.member.role_level == 1 ||sessionScope.member.role_level ==60 }">
                            	<a href="${pageContext.request.contextPath}/match/write" class="list-group-item list-group-item-action ">매치 개설하기</a>
                            </c:if>
                            <a href="${pageContext.request.contextPath}/mercenary/list" class="list-group-item list-group-item-action ">용병 구하기</a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-8 col-12 ">
                <div class="modern-card p-4 d-flex justify-content-between align-items-center bg-dark text-white mb-4">
                    <div>
                        <h4 class="fw-bold mb-1">원하는 매치가 없나요?</h4>
                        <p class="text-white-50 mb-0 small">직접 매치를 개설하고 팀원을 모집해보세요.</p>
                    </div>
                    <c:if test="${sessionScope.member.role_level == 1 ||sessionScope.member.role_level ==60 }">
                    	<button class="btn btn-primary rounded-pill px-4 fw-bold" onclick="location.href='${pageContext.request.contextPath}/match/write'">매치 개설하기 +</button>
              		</c:if>
                </div>

                <div class="d-flex flex-wrap gap-2 mb-4 justify-content-between align-items-center">
                    <div class="d-flex gap-2 flex-grow-1">
                        <input type="date" id="searchDate" class="form-control rounded-pill border-0 shadow-sm" style="max-width: 160px;"> 
                        <select name="region" class="form-select rounded-pill border-0 shadow-sm" style="max-width: 120px;">
                            <option value="" ${schType=="all"? "selected":"" }>지역 전체</option>
                            <option value="서울" ${schType=="서울"? "selected":"" }>서울</option>
                            <option value="경기" ${schType=="경기"? "selected":"" }>경기</option>
                            <option value="인천" ${schType=="인천"? "selected":"" }>인천</option>
                            <option value="강원" ${schType=="강원"? "selected":"" }>강원</option>
                            <option value="충북" ${schType=="충북"? "selected":"" }>충북</option>
                            <option value="충남" ${schType=="충남"? "selected":"" }>충남</option>
                            <option value="전북" ${schType=="전북"? "selected":"" }>전북</option>
                            <option value="전남" ${schType=="전남"? "selected":"" }>전남</option>
                            <option value="경북" ${schType=="경북"? "selected":"" }>경북</option>
                            <option value="경남" ${schType=="경남"? "selected":"" }>경남</option>
                            <option value="제주" ${schType=="제주"? "selected":"" }>제주</option>
                        </select>
                        <div class="position-relative flex-grow-1">
                            <input type="text" id="keyword" class="form-control rounded-pill ps-5 border-0 shadow-sm" placeholder="구장명, 팀명 검색"> 
                            <input type="hidden" id="searchKeyword" value="">
                            <i class="bi bi-search position-absolute top-50 start-0 translate-middle-y ms-3 text-muted"></i>
                        </div>
                    </div>

                    <div class="btn-group shadow-sm rounded-pill" role="group">
                        <input type="radio" class="btn-check" name="btnradio" id="btnradio1" autocomplete="off" checked> 
                        <label class="btn btn-outline-dark border-0 rounded-start-pill px-3" for="btnradio1">최신순</label>
                        <input type="radio" class="btn-check" name="btnradio" id="btnradio2" autocomplete="off"> 
                        <label class="btn btn-outline-dark border-0 rounded-end-pill px-3" for="btnradio2">임박순</label>
                    </div>
                </div>
                
				<div class="list-content" data-pageNo="0" data-totalPage="0"></div>
				
               <div class="list-footer text-center mt-5 mb-5">
					<button id="loadMoreBtn" class="btn btn-light rounded-pill px-5 py-3 shadow-sm text-muted fw-bold hover-scale w-50">
						더 많은 매치 보기 <i class="bi bi-arrow-down-circle ms-2"></i>
					</button>
				</div>
            </div>

        </div>
    </div>
    <footer>
	   <jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
	</footer>
	
	<jsp:include page="/WEB-INF/views/layout/footerResources.jsp"/>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

	<script type="text/javascript">
	$(function(){
		$('div.list-footer').hide();
		loadContent(1);
		
		$('#keyword').keydown(function(e){
			if(e.key == 13||e.key=='Enter'){
				e.preventDefault();
				searchStart();
				}
		});
		$('#searchDate').change(function(){
			searchStart();
		});
		
		$('select[name=region]').change(function(){
			searchStart();
		})
		
		function searchStart(){
			$('div.list-content').empty();
			$('.list-content').attr('data-pageNo',0);
			
			let keyword = $('#keyword').val().trim();
			$('#searchKeyword').val(keyword);
			
			loadContent(1);
		}
		
		$('#loadMoreBtn').click(function(){
			let pageNo = Number($('.list-content').attr('data-pageNo')) || 0;
			loadContent(pageNo + 1);
		});
		
		function loadContent(page) {
			let keyword = $('#searchKeyword').val();
			let dateVal = $('#searchDate').val();
			let regionVal = $('select[name=region]').val();
			
			let url = '${pageContext.request.contextPath}/match/listAjax';
			
			let schType = 'all';
			let kwd = keyword;
			
			
			let params = {page:page, schType:'all', kwd:kwd, region:regionVal, matchDate:dateVal};
			
			
			const fn = function(data) {
				if(! data || data.trim() === ""){
					$('div.list-footer').hide();
					
					if(page === 1){
						$('.list-content').html('<div class="text-center p-5">등록된 매치가 없습니다.</div>');

						$('.list-content').attr('data-pageNo', 0);
						$('.list-content').attr('data-totalPage', 0);
					}
					return;
				}
				
				$('.list-content').append(data);
				// $('.list-content').attr('data-pageNo',page);
				
				let pageNo = Number($('.list-content').attr('data-pageNo')) || 0;
				let totalPage = Number($('.list-content').attr('data-totalPage')) || 0;
				
				if(pageNo < totalPage) {
					$('div.list-footer').show();
				} else {
					$('div.list-footer').hide();
				}
			};
			
			ajaxRequest(url, 'get', params, 'text', fn);
		}
	});
		
	</script>
</body>
</html>