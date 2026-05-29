<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>마이페이지 - Couzl</title>
    <jsp:include page="/WEB-INF/views/common/header.jsp"/>
    <link rel="stylesheet" href="/static/css/common.css">
    <link rel="stylesheet" href="/static/css/mypage.css">
</head>
<body>
<div class="wrap">

    <!-- 1. 상단 헤더 -->
    <jsp:include page="/WEB-INF/views/common/_header.jsp"/>

    <!-- 2. 프로필 영역 -->
    <div class="mp-profile-section">
        <div class="mp-profile-avatar">
            <c:choose>
                <c:when test="${not empty profileImageBase64}">
                    <img src="data:image/jpeg;base64,${profileImageBase64}" alt="프로필 이미지">
                </c:when>
                <c:otherwise>
                    <span class="profile-initial">${fn:substring(user.nickname, 0, 1)}</span>
                </c:otherwise>
            </c:choose>
        </div>
        <p class="mp-profile-name">${fn:escapeXml(user.nickname)}</p>
        <p class="mp-profile-email">${fn:escapeXml(user.email)}</p>
        <button class="mp-btn-edit-profile" onclick="goTo('/profile-edit')">프로필 수정</button>
    </div>

    <!-- 3. 내 쿠폰 현황 카드 -->
    <div class="mp-coupon-card" onclick="goTo('/coupon-box')">
        <p class="mp-coupon-card-title">내 쿠폰 현황</p>
        <div class="mp-coupon-stats">
            <div class="mp-coupon-stat">
                <span class="mp-coupon-stat-value">3</span>
                <span class="mp-coupon-stat-label">보유쿠폰</span>
            </div>
            <div class="mp-coupon-stat-divider"></div>
            <div class="mp-coupon-stat">
                <span class="mp-coupon-stat-value">1</span>
                <span class="mp-coupon-stat-label">사용완료</span>
            </div>
            <div class="mp-coupon-stat-divider"></div>
            <div class="mp-coupon-stat">
                <span class="mp-coupon-stat-value">0</span>
                <span class="mp-coupon-stat-label">만료</span>
            </div>
        </div>
    </div>

    <!-- 4. 메뉴 리스트 -->

    <!-- 쿠폰 관리 -->
    <div class="mp-menu-section">
        <p class="mp-section-header">쿠폰 관리</p>
        <button class="mp-menu-item" onclick="goTo('/coupon-box')">
            <span class="mp-menu-icon">🎟</span>
            <span class="mp-menu-label">내 쿠폰함</span>
            <span class="mp-menu-arrow">›</span>
        </button>
        <button class="mp-menu-item" onclick="goTo('/coupon-box')">
            <span class="mp-menu-icon">📋</span>
            <span class="mp-menu-label">쿠폰 사용 내역</span>
            <span class="mp-menu-arrow">›</span>
        </button>
    </div>

    <div class="mp-section-divider"></div>

    <!-- 리뷰 관리 -->
    <div class="mp-menu-section">
        <p class="mp-section-header">리뷰 관리</p>
        <button class="mp-menu-item" onclick="goTo('/review-list')">
            <span class="mp-menu-icon">✏️</span>
            <span class="mp-menu-label">작성 가능한 리뷰</span>
            <span class="mp-menu-badge">2</span>
            <span class="mp-menu-arrow">›</span>
        </button>
        <button class="mp-menu-item" onclick="goTo('/review-list')">
            <span class="mp-menu-icon">⭐</span>
            <span class="mp-menu-label">작성한 리뷰</span>
            <span class="mp-menu-arrow">›</span>
        </button>
    </div>

    <div class="mp-section-divider"></div>

    <!-- 내 정보 -->
    <div class="mp-menu-section">
        <p class="mp-section-header">내 정보</p>
        <button class="mp-menu-item" onclick="goTo('/profile-edit')">
            <span class="mp-menu-icon">👤</span>
            <span class="mp-menu-label">프로필 수정</span>
            <span class="mp-menu-arrow">›</span>
        </button>
        <button class="mp-menu-item" onclick="goTo('/password-change')">
            <span class="mp-menu-icon">🔒</span>
            <span class="mp-menu-label">비밀번호 변경</span>
            <span class="mp-menu-arrow">›</span>
        </button>
        <button class="mp-menu-item" onclick="goTo('/location')">
            <span class="mp-menu-icon">📍</span>
            <span class="mp-menu-label">내 지역 관리</span>
            <span class="mp-menu-arrow">›</span>
        </button>
    </div>

    <div class="mp-section-divider"></div>

    <!-- 계정 -->
    <div class="mp-menu-section">
        <p class="mp-section-header">계정</p>
        <button class="mp-menu-item" onclick="handleLogout()">
            <span class="mp-menu-icon">🚪</span>
            <span class="mp-menu-label">로그아웃</span>
            <span class="mp-menu-arrow">›</span>
        </button>
        <button class="mp-menu-item" onclick="goTo('/withdraw')">
            <span class="mp-menu-icon">❌</span>
            <span class="mp-menu-label">회원 탈퇴</span>
            <span class="mp-menu-arrow">›</span>
        </button>
    </div>

    <!-- 5. 앱 버전 -->
    <p class="mp-app-version">v1.0.0</p>

    <!-- 6. 하단 탭바 -->
    <jsp:include page="/WEB-INF/views/common/_tab_bar.jsp"/>

</div>
<script src="/static/js/common.js"></script>
<script src="/static/js/mypage.js"></script>
</body>
</html>
