<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<style>
    /* 다크 테마 푸터 스타일 */
    .footer-dark {
        background-color: #22252a; 
        color: #999;
        font-size: 0.85rem;
        padding: 60px 0;
        line-height: 1.6;
    }

    /* 로고 스타일 */
    .footer-logo {
        font-family: sans-serif;
        font-weight: 800;
        font-style: italic;
        color: #fff;
        font-size: 1.8rem;
        margin-bottom: 20px;
        display: inline-block;
    }

    /* 상단 링크 (이용약관 등) */
    .footer-top-links a {
        color: #ccc;
        text-decoration: none;
        font-weight: 600;
        margin-right: 15px;
        font-size: 0.9rem;
        transition: color 0.2s;
    }
    .footer-top-links a:hover {
        color: #fff;
    }
    .footer-top-links span {
        margin-right: 15px;
        color: #555;
    }

    /* 일반 텍스트 및 정보 */
    .footer-info-text {
        color: #888;
        margin-bottom: 5px;
    }
    .footer-info-label {
        color: #bbb; /* 항목 이름은 조금 더 밝게 */
        margin-right: 10px;
    }

    /* SNS 아이콘 버튼 */
    .sns-btn {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        width: 36px;
        height: 36px;
        border: 1px solid #444;
        border-radius: 50%;
        color: #fff;
        margin-right: 10px;
        text-decoration: none;
        transition: 0.3s;
    }
    .sns-btn:hover {
        background-color: #fff;
        color: #000;
        border-color: #fff;
    }

    /* 우측 하단 플로팅 상담 버튼 (이미지의 노란 아이콘) */
    .floating-chat-btn {
        position: fixed;
        bottom: 30px;
        right: 30px;
        width: 60px;
        height: 60px;
        background-color: #fae100; /* 카카오톡 느낌의 노란색 or 흰색 */
        border-radius: 50%;
        box-shadow: 0 4px 12px rgba(0,0,0,0.3);
        display: flex;
        align-items: center;
        justify-content: center;
        z-index: 1000;
        cursor: pointer;
        border: none;
        transition: transform 0.2s;
    }
    .floating-chat-btn:hover {
        transform: scale(1.1);
    }
    .floating-chat-icon {
        font-size: 30px;
    }
</style>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

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
                <a href="#" class="sns-btn"><i class="fa-brands fa-instagram"></i></a>
                <a href="#" class="sns-btn"><i class="fa-brands fa-youtube"></i></a>
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
                    <p class="footer-info-text mb-1">
                        <span class="footer-info-label">대표 메일</span> help@footlog.com
                    </p>
                    <p class="footer-info-text mb-1">
                        <span class="footer-info-label">제휴 문의</span> marketing@footlog.com
                    </p>
                    <p class="footer-info-text mb-1">
                        <span class="footer-info-label">언론/연구</span> team@footlog.com
                    </p>
                </div>

                <p class="footer-info-text small">
                    주식회사 풋로그컴퍼니 | 사업자번호 123-45-67890 | 대표 홍길동 | 통신판매업 신고 2025-서울마포-0000 <br>
                </p>
                
                <p class="mt-4 small text-muted">
                    Copyright © Footlog Corp. All Rights Reserved.
                </p>
            </div>
        </div>

    </div>
</footer>

<div class="floating-chat-btn" onclick="alert('1:1 문의 채팅을 연결합니다.')">
    <span class="floating-chat-icon">🎧</span>
</div>