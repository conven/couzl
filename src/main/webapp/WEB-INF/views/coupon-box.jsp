<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>내 쿠폰함 - Couzl</title>
    <jsp:include page="/WEB-INF/views/common/header.jsp"/>
    <link rel="stylesheet" href="/static/css/common.css">
    <link rel="stylesheet" href="/static/css/coupon-box.css">
</head>
<body>
<div class="wrap">

    <!-- 1. 상단 헤더 -->
    <jsp:include page="/WEB-INF/views/common/_header.jsp"/>
    <div class="coupon-page-title-row">
        <span class="coupon-page-title">내 쿠폰함</span>
        <span class="coupon-count-badge">3</span>
    </div>

    <!-- 2. 탭 메뉴 -->
    <div class="cb-tab-menu">
        <button class="cb-tab-item active" data-tab="tab-available" onclick="switchCouponTab(this)">사용 가능 (3)</button>
        <button class="cb-tab-item" data-tab="tab-used" onclick="switchCouponTab(this)">사용 완료</button>
        <button class="cb-tab-item" data-tab="tab-expired" onclick="switchCouponTab(this)">기간 만료</button>
    </div>

    <!-- 3. 사용 가능 탭 -->
    <div id="tab-available" class="cb-tab-content active">
        <div class="cb-coupon-list">

            <div class="cb-coupon-card">
                <div class="cb-coupon-upper">
                    <div class="cb-coupon-info">
                        <p class="cb-coupon-store">강남커피</p>
                        <p class="cb-coupon-benefit">아메리카노 1+1</p>
                        <span class="cb-coupon-expire">~2025.12.31</span>
                    </div>
                    <div class="cb-emoji-circle">☕</div>
                </div>
                <div class="cb-coupon-divider"></div>
                <div class="cb-coupon-lower">
                    <button class="btn-coupon-use" onclick="goTo('/coupon-use')">사용하기</button>
                </div>
            </div>

            <div class="cb-coupon-card">
                <div class="cb-coupon-upper">
                    <div class="cb-coupon-info">
                        <p class="cb-coupon-store">헤어살롱모아</p>
                        <p class="cb-coupon-benefit">샴푸 무료</p>
                        <span class="cb-coupon-expire">~2025.11.30</span>
                    </div>
                    <div class="cb-emoji-circle">✂️</div>
                </div>
                <div class="cb-coupon-divider"></div>
                <div class="cb-coupon-lower">
                    <button class="btn-coupon-use" onclick="goTo('/coupon-use')">사용하기</button>
                </div>
            </div>

            <div class="cb-coupon-card">
                <div class="cb-coupon-upper">
                    <div class="cb-coupon-info">
                        <p class="cb-coupon-store">크로스핏강남</p>
                        <p class="cb-coupon-benefit">1일 무료체험</p>
                        <span class="cb-coupon-expire">~2025.10.31</span>
                    </div>
                    <div class="cb-emoji-circle">🏋️</div>
                </div>
                <div class="cb-coupon-divider"></div>
                <div class="cb-coupon-lower">
                    <button class="btn-coupon-use" onclick="goTo('/coupon-use')">사용하기</button>
                </div>
            </div>

        </div>
    </div>

    <!-- 4. 사용 완료 탭 -->
    <div id="tab-used" class="cb-tab-content">
        <div class="cb-coupon-list">

            <div class="cb-coupon-card used">
                <div class="cb-coupon-upper">
                    <div class="cb-coupon-info">
                        <span class="cb-status-badge">사용완료</span>
                        <p class="cb-coupon-store">강남커피</p>
                        <p class="cb-coupon-benefit">카페라떼 20% 할인</p>
                        <span class="cb-coupon-expire">~2025.09.30</span>
                    </div>
                    <div class="cb-emoji-circle">☕</div>
                </div>
                <div class="cb-coupon-divider"></div>
                <div class="cb-coupon-lower">
                    <button class="btn-coupon-use" disabled>사용완료</button>
                </div>
            </div>

        </div>
    </div>

    <!-- 5. 기간 만료 탭 -->
    <div id="tab-expired" class="cb-tab-content">
        <div class="cb-coupon-list">

            <div class="cb-coupon-card expired">
                <div class="cb-coupon-upper">
                    <div class="cb-coupon-info">
                        <span class="cb-status-badge">기간만료</span>
                        <p class="cb-coupon-store">헤어살롱모아</p>
                        <p class="cb-coupon-benefit">두피케어 50% 할인</p>
                        <span class="cb-coupon-expire">~2025.08.31</span>
                    </div>
                    <div class="cb-emoji-circle">✂️</div>
                </div>
                <div class="cb-coupon-divider"></div>
                <div class="cb-coupon-lower">
                    <button class="btn-coupon-use" disabled>기간만료</button>
                </div>
            </div>

        </div>
    </div>

    <!-- 하단 탭바 -->
    <jsp:include page="/WEB-INF/views/common/_tab_bar.jsp"/>
    <script>
        (function () {
            var items = document.querySelectorAll('.tab-item');
            items.forEach(function (t) { t.classList.remove('active'); });
            if (items[1]) items[1].classList.add('active');
        })();
    </script>

</div>
<script src="/static/js/common.js"></script>
<script src="/static/js/coupon-box.js"></script>
</body>
</html>
