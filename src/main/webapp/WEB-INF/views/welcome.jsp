<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <%@ include file="/WEB-INF/views/common/_meta.jsp" %>
    <title>Couzl - 환영합니다</title>
    <link rel="stylesheet" href="/static/css/welcome.css">
</head>
<body>
<div class="welcome-wrap">

    <div class="welcome-logo">
        <jsp:include page="/WEB-INF/views/common/_logo.jsp">
            <jsp:param name="bgColor"    value="white"/>
            <jsp:param name="inkColor"   value="#FFD60A"/>
            <jsp:param name="notchColor" value="#FFD60A"/>
        </jsp:include>
        <span class="welcome-logo-title">Couzl</span>
    </div>

    <p class="welcome-headline">환영합니다! 👋</p>
    <p class="welcome-sub">즐거움을 나누는 로컬 쿠폰 플랫폼</p>

    <div class="welcome-cards">
        <div class="welcome-card">
            <span class="welcome-card-icon">🗺️</span>
            <div class="welcome-card-body">
                <p class="welcome-card-title">내 주변 가맹점</p>
                <p class="welcome-card-desc">가까운 가맹점의 다양한 혜택을 만나보세요</p>
            </div>
        </div>
        <div class="welcome-card">
            <span class="welcome-card-icon">🎟️</span>
            <div class="welcome-card-body">
                <p class="welcome-card-title">특별한 쿠폰</p>
                <p class="welcome-card-desc">할인, 무료, 1+1 등 다양한 쿠폰을 받아보세요</p>
            </div>
        </div>
        <div class="welcome-card">
            <span class="welcome-card-icon">⭐</span>
            <div class="welcome-card-body">
                <p class="welcome-card-title">리뷰 &amp; 혜택</p>
                <p class="welcome-card-desc">리뷰를 남기고 추가 혜택을 받아보세요</p>
            </div>
        </div>
    </div>

    <div class="welcome-btn-wrap">
        <button class="welcome-btn-start" onclick="goTo('/location')">
            내 지역 설정하고 시작하기
        </button>
    </div>

</div>
<script src="/static/js/common.js"></script>
</body>
</html>
