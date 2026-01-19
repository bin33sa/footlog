<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>정보 찾기 - Footlog</title>
    <meta charset="utf-8">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/style.css">
    <style>
        body { background-color: #f8f9fa; height: 100vh; display: flex; align-items: center; justify-content: center; }
        .find-card { width: 100%; max-width: 450px; padding: 40px; border-radius: 20px; background: #fff; box-shadow: 0 10px 30px rgba(0,0,0,0.05); }
        .nav-pills .nav-link { color: #666; border-radius: 10px; font-weight: bold; }
        .nav-pills .nav-link.active { background-color: #000; color: #fff; }
        .form-control { border-radius: 10px; padding: 12px; margin-bottom: 15px; }
        .btn-black { background: #000; color: #fff; border-radius: 10px; width: 100%; padding: 12px; font-weight: bold; border: none; }
       	.btn-black:hover { background: #D4F63F; color: #111; }
       	.brand-logo { 
            font-family: 'Pretendard', sans-serif; 
            font-size: 2rem; 
            font-weight: 900; 
            font-style: italic; 
            text-align: center; 
            margin-bottom: 20px; 
            display: block; 
            text-decoration: none; 
            color: #000; 
       	 }
         /* 모달 커스텀 */
         .modal-content { border-radius: 20px; border: none; }
         .modal-header { border-bottom: none; padding-bottom: 0; }
         .modal-footer { border-top: none; padding-top: 0; }
		         
        /* 로딩 오버레이 스타일 (비번 찾기용) */
		#loadingOverlay {
		    display: none; 
		    position: fixed;
		    top: 0; left: 0;
		    width: 100%; height: 100%;
		    background: rgba(0, 0, 0, 0.5); 
		    z-index: 9999;
		    justify-content: center;
		    align-items: center;
		    flex-direction: column;
		    color: white;
		}
		.spinner-border { width: 3rem; height: 3rem; }
    </style>
</head>
<body>

<div class="find-card">
    <a href="${pageContext.request.contextPath}/main" class="brand-logo">Footlog</a>
    
    <ul class="nav nav-pills nav-fill mb-4" id="pills-tab" role="tablist">
        <li class="nav-item">
            <button class="nav-link ${empty activeTab or activeTab == 'id' ? 'active' : ''}" 
                    id="id-tab" data-bs-toggle="pill" data-bs-target="#find-id">아이디 찾기</button>
        </li>
        <li class="nav-item">
            <button class="nav-link ${activeTab == 'pw' ? 'active' : ''}" 
                    id="pw-tab" data-bs-toggle="pill" data-bs-target="#find-pw">비밀번호 찾기</button>
        </li>
    </ul>

    <div class="tab-content">
        <div class="tab-pane fade ${empty activeTab or activeTab == 'id' ? 'show active' : ''}" id="find-id">
            <p class="small text-muted mb-4 text-center">가입 시 등록한 이름과 이메일을 입력하세요.</p>
            <form action="${pageContext.request.contextPath}/member/findIdDo" method="post">
                <input type="text" name="name" class="form-control" placeholder="이름" required>
                <input type="email" name="email" class="form-control" placeholder="가입한 이메일 주소" required>
                <button type="submit" class="btn-black mt-3">아이디 찾기</button>
            </form>
        </div>

        <div class="tab-pane fade ${activeTab == 'pw' ? 'show active' : ''}" id="find-pw">
            <p class="small text-muted mb-4 text-center">아이디와 이메일을 입력하시면 임시 비밀번호를 전송해 드립니다.</p>
            <form action="${pageContext.request.contextPath}/member/findPwDo" method="post" onsubmit="document.getElementById('loadingOverlay').style.display='flex'">
                <input type="text" name="userId" class="form-control" placeholder="로그인 아이디" required>
                <input type="email" name="email" class="form-control" placeholder="가입한 이메일 주소" required>
                <button type="submit" class="btn-black mt-3">임시 비밀번호 발송</button>
            </form>
   		</div>
	</div>

    <div class="mt-4 text-center">
        <a href="${pageContext.request.contextPath}/member/login" class="text-muted small text-decoration-none">로그인 화면으로 돌아가기</a>
    </div>
</div>

<div class="modal fade" id="resultModal" tabindex="-1" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content p-3">
      <div class="modal-header justify-content-center">
        <h5 class="modal-title fw-bold">알림</h5>
      </div>
      <div class="modal-body text-center" id="modalMessageBody">
         </div>
      <div class="modal-footer justify-content-center">
        <button type="button" class="btn btn-black w-100" data-bs-dismiss="modal">확인</button>
      </div>
    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<script>
    document.addEventListener("DOMContentLoaded", function() {
        // 컨트롤러(findIdDo)에서 보낸 메시지가 있으면 모달을 띄움
        const msg = `${message}`;
        
        if(msg && msg.trim() !== "") {
            const modalBody = document.getElementById("modalMessageBody");
            modalBody.innerHTML = msg; // HTML 태그(<b> 등) 적용
            
            const myModal = new bootstrap.Modal(document.getElementById('resultModal'));
            myModal.show();
        }
    });
</script>
	
<div id="loadingOverlay">
    <div class="spinner-border text-light mb-3" role="status">
        <span class="visually-hidden">Loading...</span>
    </div>
    <h5 class="fw-bold">메일 전송 중입니다...</h5>
    <p class="small">잠시만 기다려주세요.</p>
</div>

</body>
</html>