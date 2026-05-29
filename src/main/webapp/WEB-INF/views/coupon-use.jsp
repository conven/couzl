<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>쿠폰 사용 - Couzl</title>
    <jsp:include page="/WEB-INF/views/common/header.jsp"/>
    <link rel="stylesheet" href="/static/css/common.css">
    <link rel="stylesheet" href="/static/css/coupon-use.css">
</head>
<body>
<div class="wrap">

    <!-- 1. 상단 헤더 -->
    <div class="cu-header">
        <button class="cu-btn-back" onclick="goTo('/coupon-box')">&#8592;</button>
        <span class="cu-header-title">쿠폰 사용</span>
        <div class="cu-header-right"></div>
    </div>

    <!-- 2. 쿠폰 정보 카드 -->
    <div class="cu-section">
        <div class="cu-coupon-card">
            <p class="cu-store-name">강남 커피로스터스</p>
            <p class="cu-benefit">아메리카노 1+1</p>
            <div class="cu-meta-row">
                <span class="cu-expire">~2025.12.31</span>
                <span class="cu-condition">1만원 이상 구매시</span>
            </div>
        </div>
    </div>

    <!-- 3. QR 코드 영역 -->
    <div class="cu-section">
        <div class="cu-qr-card">
            <div id="qrcode" class="cu-qr-box"></div>
            <p class="cu-qr-guide">가맹점 직원에게 QR을 보여주세요</p>
        </div>
    </div>

    <!-- 4. 유의사항 -->
    <div class="cu-section" style="padding-top: 16px;">
        <ul class="cu-notice-list">
            <li>QR코드는 1회만 사용 가능합니다</li>
            <li>유효기간 내에만 사용 가능합니다</li>
        </ul>
    </div>

    <!-- 5. 하단 탭바 -->
    <jsp:include page="/WEB-INF/views/common/_tab_bar.jsp"/>

</div>
<script src="https://cdnjs.cloudflare.com/ajax/libs/qrcodejs/1.0.0/qrcode.min.js"></script>
<script src="/static/js/common.js"></script>
<script src="/static/js/coupon-use.js"></script>
</body>
</html>
