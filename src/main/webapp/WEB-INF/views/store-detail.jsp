<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <%@ include file="/WEB-INF/views/common/_meta.jsp" %>
    <title>${fn:escapeXml(store.storeName)} - Couzl</title>
    <link rel="stylesheet" href="/static/css/store-detail.css">
</head>
<body
        data-store-id="${store.storeId}"
        data-store-name="${fn:escapeXml(store.storeName)}"
        data-store-address="${fn:escapeXml(store.address)}"
        data-store-lat="${empty store.latitude ? '' : store.latitude}"
        data-store-lng="${empty store.longitude ? '' : store.longitude}"
        data-kakao-key="${kakaoMapKey}">
<div class="wrap">

    <!-- 1. 상단 헤더 -->
    <header class="detail-header">
        <button class="btn-back" onclick="history.length > 1 ? history.back() : goTo('/main')">←</button>
        <span class="detail-title">가맹점 상세</span>
        <button class="btn-share" onclick="shareStore()" aria-label="공유">
            <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                <path d="M4 12v8a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2v-8"/>
                <polyline points="16 6 12 2 8 6"/>
                <line x1="12" y1="2" x2="12" y2="15"/>
            </svg>
        </button>
    </header>

    <!-- 2. 가맹점 이미지 -->
    <div class="store-image">
        <img src="/store/image/${store.storeId}"
             alt="${fn:escapeXml(store.storeName)}"
             onerror="this.onerror=null;this.src='/static/images/default-store.png';">
        <c:if test="${not empty store.emoji}">
            <span class="store-image-emoji">${store.emoji}</span>
        </c:if>
    </div>

    <!-- 3. 기본 정보 -->
    <div class="store-info">
        <h1 class="store-name">${fn:escapeXml(store.storeName)}</h1>
        <c:if test="${not empty store.categoryName}">
            <span class="store-category-tag">${fn:escapeXml(store.categoryName)}</span>
        </c:if>
        <div class="store-rating-row">
            <span>★ ${store.ratingAvg}</span>
        </div>

        <c:if test="${not empty store.address}">
            <div class="store-detail-row clickable" onclick="openLocationSheet()" role="button" tabindex="0">
                <span class="row-icon">📍</span>
                <span class="row-text">${fn:escapeXml(store.address)}</span>
                <span class="row-arrow">›</span>
            </div>
        </c:if>

        <c:if test="${not empty store.businessHours}">
            <div class="store-detail-row">
                <span class="row-icon">🕐</span>
                <span class="row-text">${fn:escapeXml(store.businessHours)}</span>
            </div>
        </c:if>

        <c:if test="${not empty store.phone}">
            <div class="store-detail-row">
                <span class="row-icon">📞</span>
                <a class="row-link" href="tel:${fn:replace(store.phone, ' ', '')}">
                    ${fn:escapeXml(store.phone)}
                </a>
            </div>
        </c:if>
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

            <c:choose>
                <c:when test="${empty coupons}">
                    <div class="tab-empty">등록된 쿠폰이 없습니다</div>
                </c:when>
                <c:otherwise>
                    <c:set var="todayStr" value="<%= java.time.LocalDate.now().toString() %>"/>
                    <c:forEach var="co" items="${coupons}">

                        <c:set var="expired" value="${co.expireDate < todayStr}"/>
                        <c:set var="soldOut" value="${co.totalCount > 0 and co.issuedCount >= co.totalCount}"/>

                        <div class="detail-coupon-card">
                            <div class="detail-coupon-upper">
                                <p class="detail-coupon-benefit">${fn:escapeXml(co.benefit)}</p>
                                <c:if test="${not empty co.conditionText}">
                                    <p class="detail-coupon-condition">${fn:escapeXml(co.conditionText)}</p>
                                </c:if>
                                <c:choose>
                                    <c:when test="${co.totalCount == 0}">
                                        <p class="detail-coupon-condition" style="color:#2563eb;">무제한</p>
                                    </c:when>
                                    <c:otherwise>
                                        <p class="detail-coupon-condition">잔여 ${co.totalCount - co.issuedCount}개</p>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <div class="detail-coupon-divider"></div>
                            <div class="detail-coupon-lower">
                                <span class="detail-coupon-expire">~${co.expireDate}</span>

                                <c:choose>
                                    <c:when test="${empty sessionScope.LOGIN_USER}">
                                        <button class="btn-coupon-receive"
                                                onclick="location.href='/login?redirect=' + encodeURIComponent('/store?storeId=${store.storeId}')">
                                            로그인 후 발급 가능
                                        </button>
                                    </c:when>
                                    <c:when test="${expired}">
                                        <button class="btn-coupon-receive" disabled>기간만료</button>
                                    </c:when>
                                    <c:when test="${co.alreadyIssued}">
                                        <button class="btn-coupon-receive" disabled>발급완료</button>
                                    </c:when>
                                    <c:when test="${soldOut}">
                                        <button class="btn-coupon-receive" disabled>마감</button>
                                    </c:when>
                                    <c:otherwise>
                                        <form method="post" action="/store/coupon/issue" style="margin:0;">
                                            <input type="hidden" name="couponId" value="${co.couponId}">
                                            <button type="submit" class="btn-coupon-receive">발급받기</button>
                                        </form>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>

                    </c:forEach>
                </c:otherwise>
            </c:choose>

        </div>
    </div>

    <!-- 6. 정보 탭 -->
    <div id="tab-info" class="tab-content">
        <div class="info-section">
            <h3 class="info-section-title">가게 소개</h3>
            <p class="info-desc">
                <c:choose>
                    <c:when test="${not empty store.description}">${fn:escapeXml(store.description)}</c:when>
                    <c:otherwise>등록된 소개가 없습니다.</c:otherwise>
                </c:choose>
            </p>
        </div>

        <div class="info-section">
            <h3 class="info-section-title">위치</h3>
            <c:choose>
                <c:when test="${not empty store.latitude and not empty store.longitude}">
                    <div id="storeMap" class="store-map"></div>
                    <c:if test="${not empty store.address}">
                        <p class="info-address-text">📍 ${fn:escapeXml(store.address)}</p>
                    </c:if>
                </c:when>
                <c:otherwise>
                    <div class="map-placeholder">위치 정보가 없습니다</div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <!-- 7. 리뷰 탭 -->
    <div id="tab-review" class="tab-content">
        <div class="tab-empty">아직 작성된 리뷰가 없습니다</div>
    </div>

    <!-- 8. 하단 탭바 -->
    <jsp:include page="/WEB-INF/views/common/_tab_bar.jsp"/>

</div>

<!-- 주소 → 외부 지도 바텀시트 -->
<div id="locationSheetOverlay" class="location-sheet-overlay" onclick="if(event.target===this) closeLocationSheet()">
    <div class="location-sheet" role="dialog" aria-modal="true" aria-label="길찾기">
        <div class="location-sheet-handle"></div>
        <div class="location-sheet-header">
            <span class="location-sheet-title">${fn:escapeXml(store.storeName)}</span>
            <button class="location-sheet-close" onclick="closeLocationSheet()" aria-label="닫기">✕</button>
        </div>
        <p class="location-sheet-address">${fn:escapeXml(store.address)}</p>
        <div class="location-sheet-actions">
            <button class="loc-action-btn kakao" onclick="openExternalMap('kakaomap')">
                <span class="loc-action-icon">🗺️</span>
                <span>카카오맵으로 보기</span>
            </button>
            <button class="loc-action-btn kakao-nav" onclick="openExternalMap('kakaonav')">
                <span class="loc-action-icon">🧭</span>
                <span>카카오 내비로 길안내</span>
            </button>
            <button class="loc-action-btn naver" onclick="openExternalMap('navermap')">
                <span class="loc-action-icon">🗾</span>
                <span>네이버 지도로 보기</span>
            </button>
            <button class="loc-action-close" onclick="closeLocationSheet()">닫기</button>
        </div>
    </div>
</div>

<!-- 서버 msg 토스트 -->
<c:if test="${not empty param.msg}">
    <script>
        (function () {
            var msg  = '${fn:escapeXml(param.msg)}';
            var map = {
                'issued':         { text: '쿠폰이 발급되었습니다',   type: 'success' },
                'sold-out':       { text: '마감된 쿠폰입니다',       type: 'warning' },
                'already-issued': { text: '이미 발급받은 쿠폰입니다', type: 'warning' },
                'expired':        { text: '만료된 쿠폰입니다',       type: 'danger'  },
                'error':          { text: '오류가 발생했습니다',     type: 'danger'  }
            };
            var info = map[msg];
            if (info) window.addEventListener('DOMContentLoaded', function(){ showToast(info.text, info.type); });
        })();
    </script>
</c:if>

<c:if test="${not empty store.latitude and not empty store.longitude and not empty kakaoMapKey}">
    <script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=${kakaoMapKey}&autoload=false"></script>
</c:if>
<script src="/static/js/common.js"></script>
<script src="/static/js/store-detail.js"></script>
</body>
</html>
