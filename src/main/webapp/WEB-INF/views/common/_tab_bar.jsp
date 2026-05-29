<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<nav class="tab-bar">
    <button class="tab-item active" onclick="goTo('/main')">
        <span class="tab-icon">🏠</span>
        <span class="tab-label">홈</span>
    </button>
    <button class="tab-item" onclick="goTo('/coupon-box')">
        <span class="tab-icon">🎟</span>
        <span class="tab-label">쿠폰함</span>
    </button>
    <button class="tab-item" onclick="showAlert('준비 중입니다')">
        <span class="tab-icon">👤</span>
        <span class="tab-label">마이페이지</span>
    </button>
</nav>
