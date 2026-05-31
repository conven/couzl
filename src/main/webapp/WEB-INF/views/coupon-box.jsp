<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <%@ include file="/WEB-INF/views/common/_meta.jsp" %>
    <title>내 쿠폰함 - Couzl</title>
    <link rel="stylesheet" href="/static/css/coupon-box.css">
</head>
<body>
<div class="wrap">

    <!-- 1. 상단 헤더 -->
    <jsp:include page="/WEB-INF/views/common/_header.jsp"/>
    <div class="coupon-page-title-row">
        <span class="coupon-page-title">내 쿠폰함</span>
        <span class="coupon-count-badge">${userCoupons.size()}</span>
    </div>

    <!-- 2. 탭 메뉴 -->
    <div class="cb-tab-menu">
        <a href="/coupon-box"               class="cb-tab-item ${empty status ? 'active' : ''}">전체</a>
        <a href="/coupon-box?status=AVAILABLE" class="cb-tab-item ${status == 'AVAILABLE' ? 'active' : ''}">사용가능</a>
        <a href="/coupon-box?status=USED"      class="cb-tab-item ${status == 'USED'      ? 'active' : ''}">사용완료</a>
        <a href="/coupon-box?status=EXPIRED"   class="cb-tab-item ${status == 'EXPIRED'   ? 'active' : ''}">만료</a>
    </div>

    <!-- 3. 쿠폰 리스트 -->
    <div class="cb-tab-content active">

        <c:choose>
            <c:when test="${empty userCoupons}">
                <div class="cb-empty">
                    <div class="cb-empty-icon">🎟</div>
                    <p class="cb-empty-text">보유한 쿠폰이 없습니다</p>
                    <button type="button" class="btn-coupon-use cb-empty-cta" onclick="goTo('/main')">
                        쿠폰 둘러보기
                    </button>
                </div>
            </c:when>
            <c:otherwise>
                <c:set var="todayStr" value="<%= java.time.LocalDate.now().toString() %>"/>
                <c:set var="threeDaysLater" value="<%= java.time.LocalDate.now().plusDays(3).toString() %>"/>

                <div class="cb-coupon-list">
                    <c:forEach var="uc" items="${userCoupons}">

                        <c:set var="isExpiringSoon"
                               value="${uc.status == 'AVAILABLE' and uc.expireDate <= threeDaysLater and uc.expireDate >= todayStr}"/>

                        <div class="cb-coupon-card ${uc.status == 'EXPIRED' ? 'expired' : ''} ${uc.status == 'USED' ? 'used' : ''}">
                            <div class="cb-coupon-upper">
                                <div class="cb-coupon-info">
                                    <c:choose>
                                        <c:when test="${uc.status == 'USED'}"><span class="cb-status-badge">사용완료</span></c:when>
                                        <c:when test="${uc.status == 'EXPIRED'}"><span class="cb-status-badge">기간만료</span></c:when>
                                    </c:choose>
                                    <p class="cb-coupon-store">${fn:escapeXml(uc.storeName)}</p>
                                    <p class="cb-coupon-name">${fn:escapeXml(uc.couponName)}</p>
                                    <p class="cb-coupon-benefit">${fn:escapeXml(uc.benefit)}</p>
                                    <span class="cb-coupon-expire ${isExpiringSoon ? 'cb-coupon-expire-soon' : ''}">
                                        ~${uc.expireDate}
                                    </span>
                                </div>
                                <div class="cb-emoji-circle">🎟</div>
                            </div>
                            <div class="cb-coupon-divider"></div>
                            <div class="cb-coupon-lower">
                                <c:choose>
                                    <c:when test="${uc.status == 'AVAILABLE'}">
                                        <button class="btn-coupon-use" onclick="goTo('/coupon-box/${uc.userCouponId}')">QR 보기</button>
                                    </c:when>
                                    <c:when test="${uc.status == 'USED' and uc.canWriteReview}">
                                        <button class="btn-coupon-use"
                                                style="background:#FFD60A; color:#1a1a1a;"
                                                onclick="goTo('/review-write?userCouponId=${uc.userCouponId}')">
                                            리뷰 작성
                                        </button>
                                    </c:when>
                                    <c:when test="${uc.status == 'USED'}">
                                        <button class="btn-coupon-use" disabled>사용완료</button>
                                    </c:when>
                                    <c:otherwise>
                                        <button class="btn-coupon-use" disabled>기간만료</button>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>

                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>

    </div>

    <!-- 하단 탭바 -->
    <jsp:include page="/WEB-INF/views/common/_tab_bar.jsp"/>

</div>
<script src="/static/js/common.js"></script>
</body>
</html>
