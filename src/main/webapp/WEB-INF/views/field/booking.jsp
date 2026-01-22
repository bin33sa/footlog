<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>
	    예약 구장 내역
	</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    
    <style>
        @import url('https://cdn.jsdelivr.net/gh/orioncactus/pretendard/dist/web/static/pretendard.css');
        body { background-color: #f8f9fa; padding: 60px 0; font-family: 'Pretendard', sans-serif; color: #222; }
        .update-card { width: 100%; max-width: 960px; padding: 50px 40px; border-radius: 24px; background: #fff; box-shadow: 0 15px 35px rgba(0,0,0,0.06); margin: auto; border: 1px solid rgba(0,0,0,0.02); }
        .brand-logo { font-size: 2.4rem; font-weight: 900; font-style: italic; text-align: center; display: block; text-decoration: none; color: #111; letter-spacing: -1.5px; margin-bottom: 30px; }
        .page-header { text-align: center; margin-bottom: 40px; }
        .page-title { font-size: 1.5rem; font-weight: 800; color: #111; margin-bottom: 5px; }
        .sub-title { font-size: 0.9rem; color: #888; font-weight: 500; letter-spacing: -0.2px; }
        .form-label { font-size: 0.8rem; font-weight: 700; color: #555; margin-bottom: 6px; margin-left: 2px; }
        .form-control, .form-select { border-radius: 12px; padding: 13px 16px; border: 1px solid #e1e1e1; background-color: #fcfcfc; font-size: 0.95rem; transition: all 0.2s ease; }
        .form-control:focus, .form-select:focus { border-color: #111; background-color: #fff; box-shadow: 0 0 0 3px rgba(0, 0, 0, 0.05); }
        .form-control[readonly] { background-color: #f8f9fa; color: #adb5bd; cursor: default; border-color: #f1f3f5; }
        .btn-black { background: #111; color: #fff; border-radius: 12px; width: 100%; padding: 15px; font-weight: 700; font-size: 1rem; border: none; transition: all 0.2s; margin-top: 10px; }
        .btn-black:hover { background: #000; transform: translateY(-2px); box-shadow: 0 5px 15px rgba(0,0,0,0.15); }
        .btn-cancel { background: #fff; color: #666; border: 1px solid #e1e1e1; border-radius: 12px; width: 100%; padding: 15px; font-weight: 700; font-size: 1rem; margin-top: 10px; transition: all 0.2s; }
        .btn-cancel:hover { background: #f8f9fa; color: #333; border-color: #d1d1d1; }
        .profile-section { display: flex; justify-content: center; margin-bottom: 40px; position: relative; }
        .profile-wrapper { position: relative; width: 120px; height: 120px; }
        .profile-img { width: 100%; height: 100%; border-radius: 50%; object-fit: cover; border: 4px solid #fff; box-shadow: 0 8px 20px rgba(0,0,0,0.1); background-color: #f8f9fa; }
        .profile-btn { position: absolute; bottom: 0; right: 0; background: #111; color: #fff; width: 36px; height: 36px; border-radius: 50%; display: flex; align-items: center; justify-content: center; box-shadow: 0 4px 10px rgba(0,0,0,0.15); border: 2px solid #fff; cursor: pointer; z-index: 2; transition: transform 0.2s; }
        .delete-btn { position: absolute; bottom: 0; left: 0; background: #ff4757; color: #fff; width: 36px; height: 36px; border-radius: 50%; display: flex; align-items: center; justify-content: center; box-shadow: 0 4px 10px rgba(0,0,0,0.15); border: 2px solid #fff; cursor: pointer; z-index: 2; transition: transform 0.2s; }
        .msg-box { font-size: 0.8rem; margin-top: 8px; font-weight: 600; display: flex; align-items: center; gap: 5px; min-height: 20px; }
        .msg-success { color: #00b894; }
        .msg-error { color: #ff7675; }
        .btn-group-position { display: flex; gap: 8px; }
        .btn-check + .btn-outline-custom { flex: 1; border: 1px solid #e1e1e1; border-radius: 12px; color: #888; padding: 12px; background: #fff; transition: 0.2s; }
        .btn-check:checked + .btn-outline-custom { background-color: #111; color: #D4F63F; border-color: #111; font-weight: 800; box-shadow: 0 4px 12px rgba(0,0,0,0.1); }
    </style>
</head>
<body>

<div class="update-card">
    <a href="${pageContext.request.contextPath}/main" class="brand-logo">Footlog</a>
    
    <div class="page-header">
        <div class="page-title">
	        예약 구장 관리
        </div>
        <div class="sub-title">새로운 시즌, 새로운 모습으로</div>
    </div>

    <c:if test="${not empty message}">
        <div class="alert alert-danger alert-dismissible fade show mb-4" role="alert" 
             style="border-radius: 12px; font-size: 0.9rem; font-weight: 600;">
            <i class="bi bi-exclamation-triangle-fill me-2"></i> ${message}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>
    
    	 <div class="table-responsive border rounded-4 overflow-hidden">
        <table class="table align-middle table-hover mb-0">
            <thead class="table-light border-bottom">
                <tr>
                    <th style="width: 20%">구장명</th>
                    <th style="width: 20%">예약구단</th>
                    <th style="width: 20%">예약자</th>
                    <th style="width: 15%">예약날짜</th>
                    <th style="width: 15%">예약시간</th>
                    <th style="width: 10%">관리</th>
                </tr>
            </thead>

            <tbody>
				<c:forEach var="list" items="${bookingList}">
	                <tr>
	                    <td>${list.stadiumName}</td>
	                    <td>${list.teamName}</td>
	                    <td>${list.memberName}</td>
	                    <td>${list.playDate}</td>
	                    <td>${list.timeLabel}</td>
	                    <td>
	            			<form method="post" action="${pageContext.request.contextPath}/field/deleteTimeSlot" style="display:inline;"
							      onsubmit="return confirm('정말 삭제하시겠습니까?');">
							    <input type="hidden" name="reservationId" value="${list.reservationId}">
							    <button type="submit" class="btn btn-sm btn-outline-danger rounded-pill">
							        삭제
							    </button>
							</form>
	                    </td>
	                </tr>
				</c:forEach>
            </tbody>
            
        </table>
        
    </div>

            <div class="col-6"><button type="button" class="btn-cancel" onclick="location.href='${pageContext.request.contextPath}/field/list'">이전화면</button></div>

		
        
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>


</script>
</body>
</html>