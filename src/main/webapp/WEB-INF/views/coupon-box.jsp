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

    <!-- filter prefix 조립: 탭 링크가 keyword/category/regionId 를 보존 -->
    <c:set var="filterQsTail" value=""/>
    <c:if test="${not empty keyword}">
        <c:set var="filterQsTail" value="${filterQsTail}&keyword=${fn:escapeXml(keyword)}"/>
    </c:if>
    <c:if test="${not empty category}">
        <c:set var="filterQsTail" value="${filterQsTail}&category=${fn:escapeXml(category)}"/>
    </c:if>
    <c:if test="${not empty regionId}">
        <c:set var="filterQsTail" value="${filterQsTail}&regionId=${regionId}"/>
    </c:if>
    <c:set var="allTabHref" value="/coupon-box"/>
    <c:if test="${not empty filterQsTail}">
        <c:set var="allTabHref" value="/coupon-box?${fn:substring(filterQsTail, 1, fn:length(filterQsTail))}"/>
    </c:if>

    <!-- 2. 탭 메뉴 -->
    <div class="cb-tab-menu">
        <a href="${allTabHref}"                              class="cb-tab-item ${empty status ? 'active' : ''}">전체</a>
        <a href="/coupon-box?status=AVAILABLE${filterQsTail}" class="cb-tab-item ${status == 'AVAILABLE' ? 'active' : ''}">사용가능</a>
        <a href="/coupon-box?status=USED${filterQsTail}"      class="cb-tab-item ${status == 'USED'      ? 'active' : ''}">사용완료</a>
        <a href="/coupon-box?status=EXPIRED${filterQsTail}"   class="cb-tab-item ${status == 'EXPIRED'   ? 'active' : ''}">만료</a>
    </div>

    <!-- 2-1. 검색/필터 -->
    <form class="cb-filter" method="get" action="/coupon-box">
        <c:if test="${not empty status}">
            <input type="hidden" name="status" value="${fn:escapeXml(status)}">
        </c:if>
        <div class="cb-filter-search">
            <span class="cb-filter-icon">🔍</span>
            <input type="text" name="keyword" class="cb-filter-input"
                   placeholder="쿠폰명/가맹점/혜택 검색"
                   value="${fn:escapeXml(keyword)}" autocomplete="off">
            <c:if test="${not empty keyword or not empty category or not empty regionId}">
                <a class="cb-filter-clear" href="/coupon-box<c:if test='${not empty status}'>?status=${fn:escapeXml(status)}</c:if>">초기화</a>
            </c:if>
        </div>
        <div class="cb-filter-row">
            <select name="category" class="cb-filter-select" onchange="this.form.submit()">
                <option value=""               ${empty category               ? 'selected' : ''}>전체 카테고리</option>
                <option value="CAFE"          ${category == 'CAFE'           ? 'selected' : ''}>☕ 카페</option>
                <option value="FOOD"          ${category == 'FOOD'           ? 'selected' : ''}>🍽 음식점</option>
                <option value="BEAUTY"        ${category == 'BEAUTY'         ? 'selected' : ''}>💄 뷰티</option>
                <option value="SHOPPING"      ${category == 'SHOPPING'       ? 'selected' : ''}>🛍 쇼핑</option>
                <option value="FITNESS"       ${category == 'FITNESS'        ? 'selected' : ''}>💪 피트니스</option>
                <option value="CONVENIENCE"   ${category == 'CONVENIENCE'    ? 'selected' : ''}>🏬 편의점</option>
            </select>
            <select name="regionId" class="cb-filter-select" onchange="this.form.submit()">
                <option value=""              ${empty regionId               ? 'selected' : ''}>전체 지역</option>
                <c:forEach var="r" items="${activeRegions}">
                    <option value="${r.regionId}" ${regionId == r.regionId ? 'selected' : ''}>${fn:escapeXml(r.regionName)}</option>
                </c:forEach>
            </select>
        </div>
    </form>

    <!-- 3. 쿠폰 리스트 -->
    <div class="cb-tab-content active">

        <c:choose>
            <c:when test="${empty userCoupons}">
                <c:set var="hasFilter" value="${not empty keyword or not empty category or not empty regionId or not empty status}"/>
                <div class="cb-empty">
                    <div class="cb-empty-icon">🎟</div>
                    <c:choose>
                        <c:when test="${hasFilter}">
                            <p class="cb-empty-text">조건에 맞는 쿠폰이 없습니다</p>
                            <button type="button" class="btn-coupon-use cb-empty-cta" onclick="goTo('/coupon-box')">
                                전체 보기
                            </button>
                        </c:when>
                        <c:otherwise>
                            <p class="cb-empty-text">보유한 쿠폰이 없습니다</p>
                            <button type="button" class="btn-coupon-use cb-empty-cta" onclick="goTo('/main')">
                                쿠폰 둘러보기
                            </button>
                        </c:otherwise>
                    </c:choose>
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
