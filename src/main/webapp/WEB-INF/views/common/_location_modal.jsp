<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link rel="stylesheet" href="/static/css/location-modal.css">
<div id="locationModalOverlay" class="location-modal-overlay">
    <div class="location-modal" role="dialog" aria-modal="true" aria-label="내 지역 설정">
        <div class="location-modal-handle"></div>

        <div class="location-modal-header">
            <span class="location-modal-title">내 지역 설정</span>
            <button class="location-modal-close" onclick="LocationModal.close()" aria-label="닫기">✕</button>
        </div>

        <div class="location-search-wrap">
            <span class="location-search-icon">🔍</span>
            <input id="locationSearchInput" class="location-search-input"
                   type="text" placeholder="지역명 검색" autocomplete="off" />
        </div>

        <p class="location-section-title">인기 지역</p>
        <ul class="location-list">
            <li class="location-item" data-region="강남구">강남구</li>
            <li class="location-item" data-region="서초구">서초구</li>
            <li class="location-item" data-region="마포구">마포구</li>
            <li class="location-item" data-region="송파구">송파구</li>
            <li class="location-item" data-region="홍대">홍대</li>
            <li class="location-item" data-region="이태원">이태원</li>
        </ul>
    </div>
</div>
<script src="/static/js/location-modal.js"></script>
