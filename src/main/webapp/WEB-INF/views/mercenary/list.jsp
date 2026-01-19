<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<title>Footlog - 용병 게시판</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<jsp:include page="/WEB-INF/views/layout/headerResources.jsp" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/style.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

<style>
:root {
   --mc-neon: #D4F63F;
   --mc-dark: #111;
   --mc-border: #ddd;
   --primary-color: #D4F63F;
}

#mercenary-wrapper table {
   width: 100%;
   border-collapse: collapse;
   background-color: #fff;
   table-layout: fixed;
}

#mercenary-wrapper thead th {
   background-color: var(--mc-dark);
   color: #fff;
   padding: 15px;
   font-weight: 700;
   text-align: center;
   border: none;
}

#mercenary-wrapper tbody tr:hover {
   background-color: rgba(212, 246, 63, 0.1);
   cursor: pointer;
}

#mercenary-wrapper tbody td {
   padding: 12px;
   vertical-align: middle;
   color: #333;
   border-bottom: 1px solid #eee;
   white-space: nowrap;
   overflow: hidden;
   text-overflow: ellipsis;
}

/* 인기글 강조 스타일 */
.top-rank-row {
   background-color: rgba(212, 246, 63, 0.08) !important;
   border-left: 4px solid #D4F63F;
}

.badge-hot {
   background-color: #ff4757;
   color: white;
   font-size: 0.7rem;
   padding: 4px 8px;
}

#mercenary-wrapper .neon-search-box {
   background-color: var(--mc-dark);
   border: 2px solid #333;
   height: 40px;
   max-width: 350px;
   display: flex;
   align-items: center;
   border-radius: 50px;
   overflow: hidden;
}

#mercenary-wrapper .neon-search-box select, #mercenary-wrapper .neon-search-box input {
   background-color: transparent !important;
   color: #fff !important;
   border: none !important;
   box-shadow: none !important;
}

#mercenary-wrapper .btn-category {
   border: 1px solid #ccc;
   background-color: #fff;
   color: #555;
   font-weight: 600;
   font-size: 0.9rem;
}

#mercenary-wrapper .btn-category:hover, #mercenary-wrapper .btn-category.active {
   background-color: var(--mc-dark);
   color: #fff;
   border-color: var(--mc-dark);
}

.page-navigation {
    display: flex;
    justify-content: center;
    align-items: center;
    gap: 8px;
    margin-top: 40px;
    margin-bottom: 20px;
}

.page-navigation a, .page-navigation b { 
    display: inline-flex;
    align-items: center;
    justify-content: center;
    width: 38px;
    height: 38px;
    border-radius: 12px;
    text-decoration: none;
    font-size: 0.95rem;
    font-weight: 600;
    color: #666;
    background-color: #f8f9fa;
    border: 1px solid #eee;
}

.page-navigation b {
    background-color: #111 !important;
    color: #D4F63F !important;
}

.badge-recruit { background-color: #0d6efd; color: white; }
.badge-seek { background-color: #198754; color: white; }
</style>
</head>
<body>

   <jsp:include page="/WEB-INF/views/layout/header.jsp" />

   <main class="container-fluid px-lg-5 mt-5 mb-5">
      <div class="row justify-content-center">
         <div class="col-lg-10">

            <div id="mercenary-wrapper">

               <div class="d-flex justify-content-between align-items-end mb-4 border-bottom pb-3">
                  <div>
                     <h2 class="fw-bold display-6 mb-1">MERCENARY</h2>
                     <p class="text-muted mb-0">함께 뛸 용병을 찾거나 지원하세요.</p>
                  </div>
                  <button type="button"
                     class="btn btn-dark rounded-pill px-4 fw-bold shadow-sm"
                     style="color: #D4F63F;"
                     onclick="location.href='${pageContext.request.contextPath}/mercenary/write';">
                     🖊️ 용병 등록</button>
               </div>

               <div class="row g-2 align-items-center mb-4">
                  <div class="col-md-6">
                     <div class="d-flex gap-2">
                        <a href="${pageContext.request.contextPath}/mercenary/list"
                           class="btn btn-category rounded-pill px-3 ${empty category ? 'active' : ''}">전체</a>
                        <a href="${pageContext.request.contextPath}/mercenary/list?category=RECRUIT"
                           class="btn btn-category rounded-pill px-3 ${category == 'RECRUIT' ? 'active' : ''}">구인</a>
                        <a href="${pageContext.request.contextPath}/mercenary/list?category=SEEK"
                           class="btn btn-category rounded-pill px-3 ${category == 'SEEK' ? 'active' : ''}">구직</a>
                     </div>
                  </div>

                  <div class="col-md-6">
                     <form name="searchForm" class="d-flex justify-content-md-end" onsubmit="return false;">
                        <div class="neon-search-box px-3 w-100">
                           <select name="schType" style="width: auto;">
                              <option value="all" ${schType=="all"?"selected":""}>전체</option>
                              <option value="title" ${schType=="title"?"selected":""}>제목</option>
                              <option value="content" ${schType=="content"?"selected":""}>내용</option>
                           </select> 
                           <input type="text" name="kwd" value="${kwd}" class="w-100 px-2" placeholder="검색어...">
                           <button type="button" class="btn btn-link p-0 text-decoration-none" onclick="searchList()">
                              <i class="bi bi-search"></i>
                           </button>
                        </div>
                     </form>
                  </div>
               </div>

               <div class="shadow-sm border rounded-3 overflow-hidden">
                  <table>
                     <colgroup>
                        <col width="80">
                        <col width="*">
                        <col width="150">
                        <col width="80">
                     </colgroup>
                     <thead>
                        <tr>
                           <th>번호</th>
                           <th>제목</th>
                           <th>작성일</th>
                           <th>조회수</th>
                        </tr>
                     </thead>
                     <tbody>
                        <c:if test="${empty category and empty kwd}">
                           <c:forEach var="tdto" items="${topList}">
                              <tr class="top-rank-row" onclick="location.href='${pageContext.request.contextPath}/mercenary/article?recruit_id=${tdto.recruit_id}&page=${page}';">
                                 <td class="text-center">
                                    <span class="badge rounded-pill badge-hot">HOT</span>
                                 </td>
                                 <td class="fw-bold ps-3">
                                    <i class="bi bi-fire text-danger me-1"></i>
                                    <c:choose>
                                       <c:when test="${tdto.category == 'RECRUIT'}"><span class="text-primary small">[구인]</span></c:when>
                                       <c:otherwise><span class="text-success small">[구직]</span></c:otherwise>
                                    </c:choose>
                                    ${tdto.title}
                                 </td>
                                 <td class="text-center text-muted">${tdto.created_at}</td>
                                 <td class="text-center">
                                    <span class="fw-bold text-danger">${tdto.view_count}</span>
                                 </td>
                              </tr>
                           </c:forEach>
                           <c:if test="${not empty topList}">
                              <tr style="height: 10px; background-color: #f8f9fa;"><td colspan="4"></td></tr>
                           </c:if>
                        </c:if>

                        <c:forEach var="dto" items="${list}">
                           <tr onclick="location.href='${pageContext.request.contextPath}/mercenary/article?recruit_id=${dto.recruit_id}&page=${page}${not empty category ? '&category='.concat(category) : ''}';">
                              <td class="text-center">${dto.recruit_id}</td>
                              <td class="fw-bold ps-3">
                                 <c:choose>
                                    <c:when test="${dto.category == 'RECRUIT'}">
                                       <span class="badge badge-recruit me-1">구인</span>
                                    </c:when>
                                    <c:when test="${dto.category == 'SEEK'}">
                                       <span class="badge badge-seek me-1">구직</span>
                                    </c:when>
                                 </c:choose>
                                 ${dto.title}
                              </td>
                              <td class="text-center text-muted">${dto.created_at}</td>
                              <td class="text-center">
                                 <span class="badge rounded-pill bg-light text-dark border">${dto.view_count}</span>
                              </td>
                           </tr>
                        </c:forEach>

                        <c:if test="${empty list and empty topList}">
                           <tr>
                              <td colspan="4" class="py-5 text-center text-muted">등록된 게시글이 없습니다.</td>
                           </tr>
                        </c:if>
                     </tbody>
                  </table>
               </div>

               <div class="page-nav-wrap page-navigation">
                  <c:if test="${dataCount != 0}">
                     ${paging}
                   </c:if>
               </div>

            </div>
         </div>
      </div>
   </main>

   <script>
      function searchList() {
         const f = document.searchForm;
         if (!f.kwd.value.trim()) {
            f.kwd.focus();
            return;
         }
         f.method = "get";
         f.action = "${pageContext.request.contextPath}/mercenary/list";
         f.submit();
      }

      const inputEL = document.querySelector("#mercenary-wrapper input[name=kwd]");
      if (inputEL) {
         inputEL.addEventListener('keydown', function(evt) {
            if (evt.key === 'Enter') {
               evt.preventDefault();
               searchList();
            }
         });
      }
   </script>

   <footer>
      <jsp:include page="/WEB-INF/views/layout/footer.jsp" />
   </footer>
   <jsp:include page="/WEB-INF/views/layout/footerResources.jsp" />
</body>
</html>