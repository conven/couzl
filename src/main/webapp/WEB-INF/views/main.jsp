<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Couzl - 홈</title>
    <link rel="stylesheet" href="/static/css/common.css">
    <link rel="stylesheet" href="/static/css/main.css">
</head>
<body>
<div class="wrap">

    <!-- 1. 헤더 -->
    <header class="main-header">
        <div class="header-location">
            <span>📍</span>
            <span class="location-text">강남구</span>
            <span class="location-arrow">▾</span>
        </div>
        <span class="header-logo">Couzl</span>
        <button class="btn-bell" onclick="showAlert('알림이 없습니다')">🔔</button>
    </header>

    <!-- 2. 검색바 -->
    <div class="search-wrap">
        <div class="search-bar">
            <span>🔍</span>
            <input type="text" placeholder="가맹점, 쿠폰 검색" readonly>
        </div>
    </div>

    <!-- 3. 배너 슬라이더 -->
    <div class="banner-section">
        <div class="banner-track">
            <div class="banner-card banner-yellow">
                <p class="banner-sub">신규 가맹점 혜택</p>
                <h2 class="banner-title">신규 가맹점 쿠폰<br>20% 할인</h2>
                <span class="banner-cta">지금 받기 →</span>
            </div>
            <div class="banner-card banner-dark">
                <p class="banner-sub">이번 주 랭킹</p>
                <h2 class="banner-title">이번 주 인기 쿠폰<br>TOP 5</h2>
                <span class="banner-cta">확인하기 →</span>
            </div>
            <div class="banner-card banner-red">
                <p class="banner-sub">특별 이벤트</p>
                <h2 class="banner-title">주말 특별<br>이벤트</h2>
                <span class="banner-cta">참여하기 →</span>
            </div>
        </div>
        <div class="banner-dots">
            <span class="dot active"></span>
            <span class="dot"></span>
            <span class="dot"></span>
        </div>
    </div>

    <!-- 4. 카테고리 바 -->
    <div class="category-section">
        <div class="category-bar">
            <div class="category-item active" onclick="selectCategory(this)">
                <span class="cat-icon">☕</span>
                <span class="cat-label">카페</span>
            </div>
            <div class="category-item" onclick="selectCategory(this)">
                <span class="cat-icon">🍽</span>
                <span class="cat-label">음식점</span>
            </div>
            <div class="category-item" onclick="selectCategory(this)">
                <span class="cat-icon">💇</span>
                <span class="cat-label">미용</span>
            </div>
            <div class="category-item" onclick="selectCategory(this)">
                <span class="cat-icon">🛍</span>
                <span class="cat-label">쇼핑</span>
            </div>
            <div class="category-item" onclick="selectCategory(this)">
                <span class="cat-icon">💪</span>
                <span class="cat-label">운동</span>
            </div>
            <div class="category-item" onclick="selectCategory(this)">
                <span class="cat-icon">🏪</span>
                <span class="cat-label">편의점</span>
            </div>
            <div class="category-item" onclick="selectCategory(this)">
                <span class="cat-icon">🔎</span>
                <span class="cat-label">전체보기</span>
            </div>
        </div>
    </div>

    <!-- 5. 내 주변 인기 가맹점 -->
    <section class="main-section">
        <div class="section-header">
            <h2 class="section-title">내 주변 인기 가맹점</h2>
            <span class="section-more">전체보기 &gt;</span>
        </div>
        <div class="shop-grid">
            <div class="shop-card">
                <div class="shop-image" style="background-color:#FFEAA7;">☕</div>
                <div class="shop-info">
                    <span class="shop-tag">카페</span>
                    <h3 class="shop-name">강남 커피로스터스</h3>
                    <div class="shop-meta">
                        <span class="shop-rating">★ 4.8</span>
                    </div>
                    <span class="shop-coupon">🎟 쿠폰 2개</span>
                </div>
            </div>
            <div class="shop-card">
                <div class="shop-image" style="background-color:#DFE6E9;">🍣</div>
                <div class="shop-info">
                    <span class="shop-tag">음식점</span>
                    <h3 class="shop-name">스시 오마카세 나카</h3>
                    <div class="shop-meta">
                        <span class="shop-rating">★ 4.6</span>
                    </div>
                    <span class="shop-coupon">🎟 쿠폰 1개</span>
                </div>
            </div>
            <div class="shop-card">
                <div class="shop-image" style="background-color:#FFEEF0;">✂️</div>
                <div class="shop-info">
                    <span class="shop-tag">미용</span>
                    <h3 class="shop-name">헤어살롱 모아</h3>
                    <div class="shop-meta">
                        <span class="shop-rating">★ 4.9</span>
                    </div>
                    <span class="shop-coupon">🎟 쿠폰 3개</span>
                </div>
            </div>
            <div class="shop-card">
                <div class="shop-image" style="background-color:#E8F5E9;">🏋</div>
                <div class="shop-info">
                    <span class="shop-tag">운동</span>
                    <h3 class="shop-name">크로스핏 강남</h3>
                    <div class="shop-meta">
                        <span class="shop-rating">★ 4.3</span>
                    </div>
                    <span class="shop-coupon">🎟 쿠폰 2개</span>
                </div>
            </div>
        </div>
    </section>

    <!-- 6. HOT 쿠폰 -->
    <section class="main-section">
        <div class="section-header">
            <h2 class="section-title">이번 주 HOT 쿠폰 🔥</h2>
            <span class="section-more">전체보기 &gt;</span>
        </div>
        <div class="coupon-scroll">

            <div class="coupon-card">
                <div class="coupon-upper">
                    <span class="coupon-shop-name">강남커피</span>
                    <p class="coupon-benefit">아메리카노<br>1+1</p>
                </div>
                <div class="coupon-divider"></div>
                <div class="coupon-lower">
                    <span class="coupon-expire">~2025.06.30</span>
                    <button class="btn-receive" onclick="receiveCoupon(this)">받기</button>
                </div>
            </div>

            <div class="coupon-card">
                <div class="coupon-upper">
                    <span class="coupon-shop-name">나카스시</span>
                    <p class="coupon-benefit">런치<br>10% 할인</p>
                </div>
                <div class="coupon-divider"></div>
                <div class="coupon-lower">
                    <span class="coupon-expire">~2025.06.28</span>
                    <button class="btn-receive" onclick="receiveCoupon(this)">받기</button>
                </div>
            </div>

            <div class="coupon-card">
                <div class="coupon-upper">
                    <span class="coupon-shop-name">헤어살롱모아</span>
                    <p class="coupon-benefit">샴푸<br>무료</p>
                </div>
                <div class="coupon-divider"></div>
                <div class="coupon-lower">
                    <span class="coupon-expire">~2025.07.05</span>
                    <button class="btn-receive" onclick="receiveCoupon(this)">받기</button>
                </div>
            </div>

            <div class="coupon-card">
                <div class="coupon-upper">
                    <span class="coupon-shop-name">크로스핏강남</span>
                    <p class="coupon-benefit">1일<br>무료체험</p>
                </div>
                <div class="coupon-divider"></div>
                <div class="coupon-lower">
                    <span class="coupon-expire">~2025.06.25</span>
                    <button class="btn-receive" onclick="receiveCoupon(this)">받기</button>
                </div>
            </div>

            <div class="coupon-card">
                <div class="coupon-upper">
                    <span class="coupon-shop-name">편의점GS</span>
                    <p class="coupon-benefit">1,000원<br>할인</p>
                </div>
                <div class="coupon-divider"></div>
                <div class="coupon-lower">
                    <span class="coupon-expire">~2025.07.10</span>
                    <button class="btn-receive" onclick="receiveCoupon(this)">받기</button>
                </div>
            </div>

        </div>
    </section>

    <!-- 7. 새로 들어온 가맹점 -->
    <section class="main-section">
        <div class="section-header">
            <h2 class="section-title">새로 들어온 가맹점 ✨</h2>
            <span class="section-more">전체보기 &gt;</span>
        </div>
        <div class="story-scroll">
            <div class="story-item">
                <div class="story-circle" style="background:linear-gradient(135deg,#FFD60A,#FF6B6B);">🍰</div>
                <span class="story-name">달콤케이크</span>
            </div>
            <div class="story-item">
                <div class="story-circle" style="background:linear-gradient(135deg,#74B9FF,#0984E3);">🍜</div>
                <span class="story-name">라멘하우스</span>
            </div>
            <div class="story-item">
                <div class="story-circle" style="background:linear-gradient(135deg,#55EFC4,#00B894);">💆</div>
                <span class="story-name">스파앤웰니스</span>
            </div>
            <div class="story-item">
                <div class="story-circle" style="background:linear-gradient(135deg,#FDCB6E,#E17055);">📚</div>
                <span class="story-name">북카페 페이지</span>
            </div>
            <div class="story-item">
                <div class="story-circle" style="background:linear-gradient(135deg,#A29BFE,#6C5CE7);">🎮</div>
                <span class="story-name">플레이존</span>
            </div>
        </div>
    </section>

    <!-- 8. 하단 탭바 -->
    <nav class="tab-bar">
        <button class="tab-item active">
            <span class="tab-icon">🏠</span>
            <span class="tab-label">홈</span>
        </button>
        <button class="tab-item" onclick="switchTab(this)">
            <span class="tab-icon">🎟</span>
            <span class="tab-label">쿠폰함</span>
        </button>
        <button class="tab-item" onclick="switchTab(this)">
            <span class="tab-icon">👤</span>
            <span class="tab-label">마이페이지</span>
        </button>
    </nav>

</div>
<script src="/static/js/common.js"></script>
<script src="/static/js/main.js"></script>
</body>
</html>
