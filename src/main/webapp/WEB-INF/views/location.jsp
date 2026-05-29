<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>내 지역 관리 - Couzl</title>
    <jsp:include page="/WEB-INF/views/common/header.jsp"/>
    <link rel="stylesheet" href="/static/css/common.css">
    <link rel="stylesheet" href="/static/css/location.css">
</head>
<body>
<div class="wrap">

    <!-- 1. 상단 헤더 -->
    <div class="loc-header">
        <button class="loc-btn-back" onclick="goTo('/mypage')">&#8592;</button>
        <span class="loc-header-title">내 지역 관리</span>
        <div class="loc-header-right"></div>
    </div>

    <!-- 2. 현재 설정 지역 -->
    <div class="loc-section">
        <p class="loc-section-title">현재 내 지역</p>
        <div class="loc-current-card">
            <span class="loc-current-icon">✓</span>
            <span class="loc-current-name">강남구</span>
        </div>
    </div>

    <!-- 3. 지역 변경 -->
    <div class="loc-section">
        <p class="loc-section-title">지역 변경</p>
        <div class="loc-grid">
            <button class="loc-card selected" data-name="강남구" onclick="selectDistrict(this)">강남구</button>
            <button class="loc-card" data-name="서초구" onclick="selectDistrict(this)">서초구</button>
            <button class="loc-card" data-name="마포구" onclick="selectDistrict(this)">마포구</button>
            <button class="loc-card" data-name="송파구" onclick="selectDistrict(this)">송파구</button>
            <button class="loc-card" data-name="용산구" onclick="selectDistrict(this)">용산구</button>
            <button class="loc-card" data-name="성동구" onclick="selectDistrict(this)">성동구</button>
            <button class="loc-card" data-name="광진구" onclick="selectDistrict(this)">광진구</button>
            <button class="loc-card" data-name="영등포구" onclick="selectDistrict(this)">영등포구</button>
        </div>
    </div>

    <!-- 4. 저장 버튼 -->
    <div class="loc-btn-wrap">
        <button class="loc-btn-save" onclick="saveLocation()">변경하기</button>
    </div>

    <!-- 하단 탭바 -->
    <jsp:include page="/WEB-INF/views/common/_tab_bar.jsp"/>
    <script>
        (function () {
            var items = document.querySelectorAll('.tab-item');
            items.forEach(function (t) { t.classList.remove('active'); });
            if (items[2]) items[2].classList.add('active');
        })();
    </script>

</div>
<script src="/static/js/common.js"></script>
<script src="/static/js/location.js"></script>
</body>
</html>
