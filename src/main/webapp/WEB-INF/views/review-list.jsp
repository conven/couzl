<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <%@ include file="/WEB-INF/views/common/_meta.jsp" %>
    <title>리뷰 관리 - Couzl</title>
    <link rel="stylesheet" href="/static/css/review.css">
</head>
<body>
<div class="wrap">

    <!-- 1. 상단 헤더 -->
    <div class="rv-header">
        <button class="rv-btn-back" onclick="goTo('/mypage')">&#8592;</button>
        <span class="rv-header-title">리뷰 관리</span>
        <div class="rv-header-right"></div>
    </div>

    <!-- 2. 탭 메뉴 -->
    <div class="rv-tab-menu">
        <button class="rv-tab-btn active" data-tab="writable" onclick="switchTab('writable')">작성 가능 (2)</button>
        <button class="rv-tab-btn" data-tab="written" onclick="switchTab('written')">작성한 리뷰 (1)</button>
    </div>

    <!-- 3. 작성 가능 탭 -->
    <div class="rv-tab-content active" id="tab-writable">
        <p class="rv-guide-text">사용한 쿠폰에 리뷰를 남겨보세요!</p>

        <!-- 강남커피 카드 -->
        <div class="rv-writable-card">
            <div class="rv-card-store">
                <span class="rv-card-store-emoji">☕</span>
                <span class="rv-card-store-name">강남커피</span>
            </div>
            <p class="rv-card-benefit">아메리카노 1+1</p>
            <p class="rv-card-date">사용일: 2025.10.15</p>
            <button class="rv-btn-write" onclick="goTo('/review-write')">리뷰 쓰기</button>
        </div>

        <!-- 헤어살롱모아 카드 -->
        <div class="rv-writable-card">
            <div class="rv-card-store">
                <span class="rv-card-store-emoji">💇</span>
                <span class="rv-card-store-name">헤어살롱모아</span>
            </div>
            <p class="rv-card-benefit">샴푸 무료</p>
            <p class="rv-card-date">사용일: 2025.10.08</p>
            <button class="rv-btn-write" onclick="goTo('/review-write')">리뷰 쓰기</button>
        </div>
    </div>

    <!-- 4. 작성한 리뷰 탭 -->
    <div class="rv-tab-content" id="tab-written">

        <!-- 크로스핏강남 카드 -->
        <div class="rv-written-card">
            <div class="rv-written-card-top">
                <span class="rv-written-store">크로스핏강남</span>
                <span class="rv-written-stars">★★★★★</span>
            </div>
            <p class="rv-written-date">2025.10.01</p>
            <p class="rv-written-content">정말 좋은 경험이었어요! 시설도 깨끗하고 트레이너분들도 친절해서 너무 좋았습니다.</p>
            <div class="rv-written-actions">
                <button class="rv-btn-edit" onclick="alert('준비중입니다')">수정</button>
                <button class="rv-btn-delete" onclick="alert('준비중입니다')">삭제</button>
            </div>
        </div>

    </div>

    <!-- 5. 하단 탭바 -->
    <jsp:include page="/WEB-INF/views/common/_tab_bar.jsp"/>

</div>
<script src="/static/js/common.js"></script>
<script src="/static/js/review.js"></script>
</body>
</html>
