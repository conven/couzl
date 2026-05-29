<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>강남 커피로스터스 - Couzl</title>
    <jsp:include page="/WEB-INF/views/common/header.jsp"/>
    <link rel="stylesheet" href="/static/css/common.css">
    <link rel="stylesheet" href="/static/css/store-detail.css">
</head>
<body>
<div class="wrap">

    <!-- 1. 상단 헤더 -->
    <header class="detail-header">
        <button class="btn-back" onclick="goTo('/main')">←</button>
        <span class="detail-title">가맹점 상세</span>
        <button class="btn-share" onclick="showAlert('공유 기능은 준비 중입니다')">
            <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                <path d="M4 12v8a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2v-8"/>
                <polyline points="16 6 12 2 8 6"/>
                <line x1="12" y1="2" x2="12" y2="15"/>
            </svg>
        </button>
    </header>

    <!-- 2. 가맹점 이미지 -->
    <div class="store-image">☕</div>

    <!-- 3. 기본 정보 -->
    <div class="store-info">
        <h1 class="store-name">강남 커피로스터스</h1>
        <span class="store-category-tag">카페</span>
        <div class="store-rating-row">
            <span>★ 4.8</span>
            <span class="review-count">(24개 리뷰)</span>
        </div>
        <div class="store-detail-row">
            <span class="row-icon">📍</span>
            <span>서울 강남구 테헤란로 123</span>
        </div>
        <div class="store-detail-row">
            <span class="row-icon">🕐</span>
            <span>09:00 - 22:00 &nbsp;<em class="store-open">(영업 중)</em></span>
        </div>
        <div class="store-detail-row">
            <span class="row-icon">📞</span>
            <span>02-1234-5678</span>
        </div>
    </div>

    <!-- 4. 탭 메뉴 -->
    <div class="tab-menu">
        <div class="tab-menu-item active" data-tab="tab-coupon" onclick="switchDetailTab(this)">쿠폰</div>
        <div class="tab-menu-item" data-tab="tab-info" onclick="switchDetailTab(this)">정보</div>
        <div class="tab-menu-item" data-tab="tab-review" onclick="switchDetailTab(this)">리뷰</div>
    </div>

    <!-- 5. 쿠폰 탭 -->
    <div id="tab-coupon" class="tab-content active">
        <div class="detail-coupon-list">

            <div class="detail-coupon-card">
                <div class="detail-coupon-upper">
                    <p class="detail-coupon-benefit">아메리카노 1+1</p>
                    <p class="detail-coupon-condition">1만원 이상 구매시</p>
                </div>
                <div class="detail-coupon-divider"></div>
                <div class="detail-coupon-lower">
                    <span class="detail-coupon-expire">~2025.12.31</span>
                    <button class="btn-coupon-receive" onclick="receiveCouponDetail(this)">쿠폰 받기</button>
                </div>
            </div>

            <div class="detail-coupon-card">
                <div class="detail-coupon-upper">
                    <p class="detail-coupon-benefit">카페라떼 20% 할인</p>
                    <p class="detail-coupon-condition">앱 주문시</p>
                </div>
                <div class="detail-coupon-divider"></div>
                <div class="detail-coupon-lower">
                    <span class="detail-coupon-expire">~2025.11.30</span>
                    <button class="btn-coupon-receive" onclick="receiveCouponDetail(this)">쿠폰 받기</button>
                </div>
            </div>

            <div class="detail-coupon-card">
                <div class="detail-coupon-upper">
                    <p class="detail-coupon-benefit">디저트 무료</p>
                    <p class="detail-coupon-condition">음료 2잔 이상 주문시</p>
                </div>
                <div class="detail-coupon-divider"></div>
                <div class="detail-coupon-lower">
                    <span class="detail-coupon-expire">~2025.10.31</span>
                    <button class="btn-coupon-receive" onclick="receiveCouponDetail(this)">쿠폰 받기</button>
                </div>
            </div>

        </div>
    </div>

    <!-- 6. 정보 탭 -->
    <div id="tab-info" class="tab-content">
        <div class="info-section">
            <h3 class="info-section-title">가게 소개</h3>
            <p class="info-desc">강남 한복판에서 직접 로스팅한 스페셜티 커피를 즐길 수 있는 카페입니다. 에티오피아, 콜롬비아 등 세계 각지의 프리미엄 원두를 엄선하여 최고의 한 잔을 제공합니다. 편안한 분위기에서 업무나 미팅을 즐길 수 있으며, 다양한 시즌 음료도 만나보세요.</p>
        </div>
        <div class="map-placeholder">🗺️ 지도 준비중</div>
        <div class="info-section">
            <h3 class="info-section-title">편의시설</h3>
            <div class="amenity-list">
                <span class="amenity-chip">🚗 주차가능</span>
                <span class="amenity-chip">📶 와이파이</span>
                <span class="amenity-chip">🥡 포장가능</span>
            </div>
        </div>
    </div>

    <!-- 7. 리뷰 탭 -->
    <div id="tab-review" class="tab-content">
        <div class="review-summary">
            <span class="review-score">4.8</span>
            <div>
                <div class="review-stars">★★★★★</div>
                <div class="review-total">24개 리뷰</div>
            </div>
        </div>
        <div class="review-list">
            <div class="review-card">
                <div class="review-header">
                    <span class="review-author">커피러버🍵</span>
                    <span class="review-rating">★★★★★</span>
                </div>
                <div class="review-date">2025.05.12</div>
                <p class="review-text">원두 향이 정말 좋고, 바리스타분이 친절하게 설명해주셔서 좋았어요. 라떼도 진하고 부드러워서 자주 올 것 같습니다!</p>
            </div>
            <div class="review-card">
                <div class="review-header">
                    <span class="review-author">daily_brew</span>
                    <span class="review-rating">★★★★☆</span>
                </div>
                <div class="review-date">2025.04.28</div>
                <p class="review-text">공간이 넓고 조용해서 작업하기 좋아요. 와이파이도 빠르고 콘센트도 많습니다. 쿠폰 덕분에 아메리카노 1+1으로 즐겼어요 😊</p>
            </div>
            <div class="review-card">
                <div class="review-header">
                    <span class="review-author">강남직장인</span>
                    <span class="review-rating">★★★★★</span>
                </div>
                <div class="review-date">2025.04.15</div>
                <p class="review-text">점심시간에 자주 오는데 회전이 빠르고 주문도 편리해요. 시즌 음료 다 맛있고 디저트 퀄리티도 높습니다.</p>
            </div>
        </div>
    </div>

    <!-- 8. 하단 탭바 -->
    <jsp:include page="/WEB-INF/views/common/_tab_bar.jsp"/>

</div>
<script src="/static/js/common.js"></script>
<script src="/static/js/store-detail.js"></script>
</body>
</html>
