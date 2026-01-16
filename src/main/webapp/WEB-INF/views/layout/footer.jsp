<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<style>
    /* --- 기존 푸터 스타일 --- */
    .footer-dark { background-color: #22252a; color: #999; font-size: 0.85rem; padding: 60px 0; line-height: 1.6; }
    .footer-logo { font-family: sans-serif; font-weight: 800; font-style: italic; color: #fff; font-size: 1.8rem; margin-bottom: 20px; display: inline-block; }
    .footer-top-links a { color: #ccc; text-decoration: none; font-weight: 600; margin-right: 15px; font-size: 0.9rem; transition: color 0.2s; }
    .footer-top-links a:hover { color: #fff; }
    .footer-top-links span { margin-right: 15px; color: #555; }
    .footer-info-text { color: #888; margin-bottom: 5px; }
    .footer-info-label { color: #bbb; margin-right: 10px; }
    .sns-btn { display: inline-flex; align-items: center; justify-content: center; width: 36px; height: 36px; border: 1px solid #444; border-radius: 50%; color: #fff; margin-right: 10px; text-decoration: none; transition: 0.3s; font-size: 1.2rem; }
    .sns-btn:hover { background-color: #fff; color: #000; border-color: #fff; }

    /* --- 상담 플로팅 버튼 --- */
    .floating-chat-btn { position: fixed; bottom: 30px; right: 30px; width: 60px; height: 60px; background-color: #fae100; border-radius: 50%; box-shadow: 0 4px 12px rgba(0,0,0,0.3); display: flex; align-items: center; justify-content: center; z-index: 1000; cursor: pointer; border: none; transition: transform 0.2s; color: #3b1e1e; text-decoration: none; }
    .floating-chat-btn:hover { transform: scale(1.1); color: #3b1e1e; }
    .floating-chat-icon { font-size: 28px; }

    /* --- 모달 디자인 (화이트 모던) --- */
    .cs-modal-content {
        border-radius: 24px;
        border: none;
        overflow: hidden;
    }
    
    .cs-header {
        background-color: #fff;
        padding: 25px 25px 10px 25px;
        text-align: center;
    }

    /* ★ 모달 내부용 풋로그 로고 스타일 ★ */
    .modal-logo-text {
        font-family: sans-serif;
        font-weight: 900;
        font-style: italic;
        color: #111; /* 검은색 */
        font-size: 2.2rem;
        letter-spacing: -1px;
        display: inline-block;
        margin-bottom: 5px;
    }

    /* 전화번호 박스 */
    .cs-phone-card {
        background-color: #f8f9fa;
        border: 1px solid #eee;
        border-radius: 16px;
        padding: 20px;
        text-align: center;
        margin: 10px 20px 20px 20px;
    }
    .cs-phone-number {
        font-size: 2rem;
        font-weight: 900;
        color: #333;
        letter-spacing: -1px;
        line-height: 1.2;
    }
    
    /* SNS 그리드 */
    .cs-sns-grid { display: flex; gap: 10px; padding: 0 20px 30px 20px; }
    
    .cs-sns-item {
        flex: 1; display: flex; flex-direction: column; align-items: center; justify-content: center;
        padding: 15px; border-radius: 16px; text-decoration: none; transition: all 0.2s ease; border: 1px solid #eee;
    }
    
    /* 인스타 */
    .cs-sns-item.insta { background-color: #fff; color: #333; }
    .cs-sns-item.insta i { 
        font-size: 24px; 
        background: linear-gradient(45deg, #f09433 0%, #e6683c 25%, #dc2743 50%, #cc2366 75%, #bc1888 100%); 
        -webkit-background-clip: text; -webkit-text-fill-color: transparent; margin-bottom: 5px;
    }
    
    /* 유튜브 */
    .cs-sns-item.youtube { background-color: #fff; color: #333; }
    .cs-sns-item.youtube i { font-size: 24px; color: #ff0000; margin-bottom: 5px; }
    
    .cs-sns-item:hover { transform: translateY(-3px); box-shadow: 0 5px 15px rgba(0,0,0,0.08); background-color: #fcfcfc; }
    .cs-sns-label { font-size: 0.8rem; font-weight: 700; }

</style>

<footer class="footer-dark mt-5">
    <div class="container">
        <div class="d-flex flex-column flex-md-row justify-content-between align-items-start align-items-md-center mb-4 border-bottom border-secondary pb-4" style="border-color: #333 !important;">
            <div class="footer-top-links mb-3 mb-md-0">
                <a href="#">이용약관</a> <span>|</span>
                <a href="#" class="text-white">개인정보 처리 방침</a> <span>|</span>
                <a href="#">사업자 정보 확인</a> <span>|</span>
                <a href="#">채용</a>
            </div>
            <div>
                <a href="https://www.instagram.com/" target="_blank" class="sns-btn"><i class="bi bi-instagram"></i></a>
                <a href="https://www.youtube.com/@CoupangPlaySports" target="_blank" class="sns-btn"><i class="bi bi-youtube"></i></a>
            </div>
        </div>

        <div class="mb-2">
            <span class="footer-logo">Footlog</span>
        </div>

        <div class="row">
            <div class="col-md-8">
                <p class="footer-info-text">
                    풋로그 | 서울특별시 마포구 서교동 447-5 쌍용강북교육센터 | 02-1234-5678
                </p>
                <div class="mt-3 mb-3">
                    <p class="footer-info-text mb-1"><span class="footer-info-label">대표 메일</span> help@footlog.com</p>
                    <p class="footer-info-text mb-1"><span class="footer-info-label">제휴 문의</span> marketing@footlog.com</p>
                </div>
                <p class="mt-4 small text-muted">Copyright © Footlog Corp. All Rights Reserved.</p>
            </div>
        </div>
    </div>
</footer>

<div class="floating-chat-btn" data-bs-toggle="modal" data-bs-target="#customerCenterModal">
    <i class="bi bi-headset floating-chat-icon"></i>
</div>

<div class="modal fade" id="customerCenterModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-sm"> 
        <div class="modal-content cs-modal-content shadow-lg">
            
            <div class="cs-header">
                <div class="d-flex justify-content-end">
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                
                <div class="mb-1">
                    <span class="modal-logo-text">Footlog</span>
                </div>
                
                <h6 class="fw-bold text-dark mb-3 mt-4">고객센터</h6>
				<p class="text-secondary small">평일 09:00 - 18:00 (주말/공휴일 휴무)</p>
            </div>

            <div class="cs-phone-card">
                <div class="small text-muted mb-1 fw-bold"><i class="bi bi-telephone-fill me-1"></i>전화 상담</div>
                <div class="cs-phone-number">1544-2193</div>
            </div>

            <div class="px-4 pb-2">
                <p class="small fw-bold text-secondary mb-2 ms-1">공식 채널 바로가기</p>
            </div>
            
            <div class="cs-sns-grid">
                <a href="https://www.instagram.com/" target="_blank" class="cs-sns-item insta">
                    <i class="bi bi-instagram"></i>
                    <span class="cs-sns-label">Instagram</span>
                </a>
                <a href="https://www.youtube.com/@CoupangPlaySports" target="_blank" class="cs-sns-item youtube">
                    <i class="bi bi-youtube"></i>
                    <span class="cs-sns-label">YouTube</span>
                </a>
            </div>
            
        </div>
    </div>
</div>

<script>
    $(function(){
        const urlParams = new URLSearchParams(window.location.search);
        const msg = urlParams.get('msg');

        if(msg === 'noteam') {
            alert('가입한 구단이 없습니다.\n구단 목록 페이지로 이동합니다.');
            history.replaceState({}, null, location.pathname);
        } else if(msg === 'unauthorized') {
            alert('접근 권한이 없습니다.');
            history.replaceState({}, null, location.pathname);
        }
    });
</script>