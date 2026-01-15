<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>Footlog - Create Team</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/style.css?ver=2">

    <style>
        /* 엠블럼 미리보기 원형 스타일 */
        .emblem-preview-box {
            width: 150px;
            height: 150px;
            background-color: #f8f9fa;
            border: 2px dashed #ddd;
            border-radius: 50%; /* 동그라미 */
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
            position: relative;
            margin: 0 auto 15px auto;
            cursor: pointer;
            transition: all 0.2s;
        }
        .emblem-preview-box:hover {
            border-color: var(--primary-color, #D4F63F);
            background-color: #fff;
        }
        .emblem-preview-box img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        .emblem-upload-icon {
            font-size: 2rem;
            color: #ccc;
        }
    </style>
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
                        <p class="sidebar-title">구단</p>
                        <div class="list-group">
                            <a href="${pageContext.request.contextPath}/myteam/main" class="list-group-item list-group-item-action">내 구단 이동</a>
                            <a href="${pageContext.request.contextPath}/team/list" class="list-group-item list-group-item-action">전체 구단 리스트</a>
                            
                            <a href="${pageContext.request.contextPath}/team/write" class="list-group-item list-group-item-action active-menu">구단 창단하기</a>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-lg-10 col-12">
                
                <div class="mb-4 border-bottom pb-3">
                    <h2 class="fw-bold display-6 mb-1">TEAM FOUNDING</h2>
                    <p class="text-muted mb-0">새로운 구단을 창단하고 팀원들을 모집해보세요.</p>
                </div>

                <div class="modern-card p-5 shadow-lg bg-white">
                    <form name="teamForm" action="${pageContext.request.contextPath}/team/write" method="post" enctype="multipart/form-data" onsubmit="return sendOk();">
                        
                        <div class="row">
                            <div class="col-md-4 text-center border-end mb-4 mb-md-0">
                                <label class="form-label fw-bold d-block">팀 엠블럼 <span class="text-danger">*</span></label>
                                
                                <div class="emblem-preview-box" onclick="document.getElementById('uploadFile').click();">
                                    <span id="emblemPlaceholder">
                                        <i class="bi bi-camera-fill emblem-upload-icon"></i>
                                    </span>
                                    <img id="previewImg" src="" style="display:none;">
                                </div>
                                
                                <input type="file" id="uploadFile" name="uploadFile" class="d-none" accept="image/*" onchange="previewImage(this);">
                                <button type="button" class="btn btn-sm btn-outline-dark rounded-pill px-3" onclick="document.getElementById('uploadFile').click();">
                                    이미지 업로드
                                </button>
                                <p class="text-muted small mt-2">권장 사이즈: 500x500px<br>(JPG, PNG)</p>
                            </div>

                            <div class="col-md-8 ps-md-5">
                                <div class="mb-4">
                                    <label for="team_name" class="form-label fw-bold">구단명 <span class="text-danger">*</span></label>
                                    <%-- [수정] name="subject" -> name="team_name" --%>
                                    <input type="text" name="team_name" id="team_name" class="form-control form-control-lg bg-light border-0" placeholder="멋진 구단 이름을 지어주세요 (예: FC 풋로그)" required>
                                </div>

                                <div class="row mb-4">
                                    <div class="col-md-6">
                                        <label class="form-label fw-bold">활동 지역</label>
                                        <select name="region" class="form-select bg-light border-0">
                                            <option value="">선택하세요 (미정 가능)</option>
                                            <option value="서울">서울</option>
                                            <option value="경기">경기</option>
                                            <option value="인천">인천</option>
                                            <option value="부산">부산</option>
                                            <option value="대구">대구</option>
                                            <option value="광주">광주</option>
                                            <option value="대전">대전</option>
                                            <option value="울산">울산</option>
                                            <option value="강원">강원</option>
                                            <option value="충청">충청</option>
                                            <option value="전라">전라</option>
                                            <option value="경상">경상</option>
                                            <option value="제주">제주</option>
                                        </select>
                                    </div>
                                    
                                    <div class="col-md-6">
                                        <label class="form-label fw-bold">대표 연락처 <span class="text-danger">*</span></label>
                                        <input type="text" name="contact_number" class="form-control bg-light border-0" placeholder="예: 010-1234-5678" required>
                                    </div>
                                </div>
                                
                                <div class="mb-4">
                                    <label class="form-label fw-bold">홍보 영상 URL</label>
                                    <input type="text" name="intro_video_url" class="form-control bg-light border-0" placeholder="YouTube 영상 링크 등 (선택 사항)">
                                </div>
                            </div>
                        </div>

                        <hr class="my-4">

                        <div class="mb-5">
                            <label class="form-label fw-bold">구단 소개 및 가입 안내</label>
                            <%-- [수정] name="content" -> name="description" --%>
                            <textarea name="description" class="form-control border-0 bg-light rounded-4 p-4" rows="8" placeholder="우리 팀의 특징, 주로 차는 시간대, 회비 정보 등을 자유롭게 적어주세요." style="resize: none;" required></textarea>
                        </div>

                        <div class="d-flex justify-content-end gap-2">
                            <button type="button" class="btn btn-light rounded-pill px-4 fw-bold hover-scale" onclick="history.back();">취소</button>
                            <button type="submit" class="btn btn-dark rounded-pill px-5 fw-bold hover-scale" style="color: var(--primary-color, #D4F63F);">
                                <i class="bi bi-flag-fill me-2"></i>구단 창단하기
                            </button>
                        </div>

                    </form>
                </div>

            </div>
        </div> 
    </div>

    <footer>
         <jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
   </footer>
   
   <jsp:include page="/WEB-INF/views/layout/footerResources.jsp"/>
    
    <script>
        function sendOk() {
            const f = document.teamForm;
            
            // 엠블럼 체크 (필요시 주석 해제하여 필수 처리)
            if(!f.uploadFile.value) {
                alert("팀 엠블럼 이미지를 등록해주세요.");
                return false;
            }

            // [수정] subject -> team_name
            if(!f.team_name.value.trim()) {
                alert("구단명을 입력해주세요.");
                f.team_name.focus();
                return false;
            }
            
            // 활동 지역은 필수가 아니므로 체크 제거 (필요하면 부활)
            /*
            if(f.region.value === "") {
                alert("활동 지역을 선택해주세요.");
                f.region.focus();
                return false;
            }
            */
            
            // 연락처 필수 체크
            if(!f.contact_number.value.trim()) {
                alert("대표 연락처를 입력해주세요.");
                f.contact_number.focus();
                return false;
            }

            // [수정] content -> description
            if(!f.description.value.trim()) {
                alert("구단 소개 내용을 입력해주세요.");
                f.description.focus();
                return false;
            }
            return true;
        }

        // 엠블럼 미리보기 스크립트
        function previewImage(input) {
            const previewImg = document.getElementById('previewImg');
            const placeholder = document.getElementById('emblemPlaceholder');
            
            if (input.files && input.files[0]) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    previewImg.src = e.target.result;
                    previewImg.style.display = 'block';
                    placeholder.style.display = 'none';
                };
                reader.readAsDataURL(input.files[0]);
            } else {
                previewImg.src = "";
                previewImg.style.display = 'none';
                placeholder.style.display = 'block';
            }
        }
    </script>

</body>
</html>