<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<nav class="tab-bar">
    <button class="tab-item" id="tab-home" onclick="goToWithSpinner('/main')">
        <span class="tab-icon">🏠</span>
        <span class="tab-label">홈</span>
    </button>
    <button class="tab-item" id="tab-map" onclick="goToWithSpinner('/map')">
        <span class="tab-icon">📍</span>
        <span class="tab-label">내 주변</span>
    </button>
    <button class="tab-item" id="tab-coupon" onclick="goToWithSpinner('/coupon-box')">
        <span class="tab-icon">🎟</span>
        <span class="tab-label">쿠폰함</span>
    </button>
    <button class="tab-item" id="tab-mypage" onclick="goToWithSpinner('/mypage')">
        <span class="tab-icon">👤</span>
        <span class="tab-label">마이페이지</span>
    </button>
</nav>
<script>
(function () {
    var path = window.location.pathname;
    var tabMap = {
        '/main': 'tab-home',
        '/map': 'tab-map',
        '/coupon-box': 'tab-coupon',
        '/mypage': 'tab-mypage'
    };
    var id = tabMap[path];
    if (id) document.getElementById(id).classList.add('active');
})();
</script>
