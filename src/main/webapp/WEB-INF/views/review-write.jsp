<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>리뷰 작성 - Couzl</title>
    <jsp:include page="/WEB-INF/views/common/header.jsp"/>
    <link rel="stylesheet" href="/static/css/common.css">
    <link rel="stylesheet" href="/static/css/review.css">
</head>
<body>
<div class="wrap">

    <!-- 1. 상단 헤더 -->
    <div class="rv-header">
        <button class="rv-btn-back" onclick="goTo('/review-list')">&#8592;</button>
        <span class="rv-header-title">리뷰 작성</span>
        <div class="rv-header-right">
            <button class="rv-btn-done" onclick="submitReview()">완료</button>
        </div>
    </div>

    <!-- 2. 가맹점 정보 -->
    <div class="rv-store-info">
        <div class="rv-store-emoji-wrap">☕</div>
        <div class="rv-store-info-texts">
            <p class="rv-store-info-name">강남커피</p>
            <p class="rv-store-info-benefit">아메리카노 1+1</p>
        </div>
    </div>

    <!-- 3. 별점 선택 -->
    <div class="rv-rating-section">
        <p class="rv-rating-label">별점을 선택해주세요</p>
        <div class="rv-stars">
            <span class="rv-star" onclick="selectStar(1)">★</span>
            <span class="rv-star" onclick="selectStar(2)">★</span>
            <span class="rv-star" onclick="selectStar(3)">★</span>
            <span class="rv-star" onclick="selectStar(4)">★</span>
            <span class="rv-star" onclick="selectStar(5)">★</span>
        </div>
        <p class="rv-rating-text" id="rv-rating-text"></p>
    </div>

    <!-- 4. 리뷰 내용 입력 -->
    <div class="rv-content-section">
        <p class="rv-content-label">리뷰 내용</p>
        <textarea
            class="rv-textarea"
            id="rv-review-text"
            placeholder="방문 경험을 공유해주세요"
            maxlength="200"
            oninput="updateCharCount()"
        ></textarea>
        <p class="rv-char-count" id="rv-char-count">0 / 200</p>
    </div>

    <!-- 5. 사진 첨부 -->
    <div class="rv-photo-section">
        <p class="rv-photo-label">사진 첨부</p>
        <button class="rv-btn-add-photo" onclick="addPhoto()">
            <span class="rv-photo-icon">📷</span>
            <span>사진 추가</span>
        </button>
    </div>

    <!-- 6. 등록 버튼 -->
    <div class="rv-submit-section">
        <button class="rv-btn-submit" onclick="submitReview()">리뷰 등록하기</button>
    </div>

</div>
<script src="/static/js/common.js"></script>
<script src="/static/js/review.js"></script>
</body>
</html>
