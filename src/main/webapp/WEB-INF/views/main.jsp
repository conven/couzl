<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <%@ include file="/WEB-INF/views/common/_meta.jsp" %>
    <title>Couzl - 홈</title>
    <link rel="stylesheet" href="/static/css/main.css">
</head>
<body data-logged-in="${not empty sessionScope.LOGIN_USER}"
      data-region-id="${empty regionId ? '' : regionId}"
      data-region-in-url="${not empty param.regionId}">
<div class="wrap">

    <!-- 1. 헤더 -->
    <jsp:include page="/WEB-INF/views/common/_header.jsp"/>

    <!-- regionId 쿼리스트링 prefix 조립 (비로그인 + regionId 있을 때만) -->
    <c:set var="regionQs" value=""/>
    <c:if test="${empty sessionScope.LOGIN_USER and not empty regionId}">
        <c:set var="regionQs" value="&regionId=${regionId}"/>
    </c:if>
    <c:set var="regionQsFirst" value=""/>
    <c:if test="${empty sessionScope.LOGIN_USER and not empty regionId}">
        <c:set var="regionQsFirst" value="?regionId=${regionId}"/>
    </c:if>

    <!-- 2. 검색바 -->
    <div class="search-wrap">
        <form class="search-bar" method="get" action="/main">
            <c:if test="${empty sessionScope.LOGIN_USER and not empty regionId}">
                <input type="hidden" name="regionId" value="${regionId}"/>
            </c:if>
            <c:if test="${not empty category}">
                <input type="hidden" name="category" value="${fn:escapeXml(category)}"/>
            </c:if>
            <span>🔍</span>
            <input type="text" name="keyword" placeholder="가맹점명을 검색해 보세요"
                   value="${fn:escapeXml(keyword)}" autocomplete="off">
            <c:if test="${not empty keyword}">
                <a class="search-clear" href="/main${regionQsFirst}<c:if test='${not empty category}'>${empty regionQsFirst ? "?" : "&"}category=${fn:escapeXml(category)}</c:if>">×</a>
            </c:if>
        </form>
    </div>

    <!-- 3. 배너 슬라이더 -->
    <div class="banner-section">
        <c:choose>
            <c:when test="${not empty banners}">
                <div class="banner-track" id="bannerTrack">
                    <c:forEach var="bn" items="${banners}">
                        <c:choose>
                            <c:when test="${bn.linkType == 'STORE' and not empty bn.linkValue}">
                                <c:set var="bnHref" value="/store?storeId=${bn.linkValue}"/>
                            </c:when>
                            <c:when test="${bn.linkType == 'COUPON' and not empty bn.couponStoreId}">
                                <c:set var="bnHref" value="/store?storeId=${bn.couponStoreId}#coupon"/>
                            </c:when>
                            <c:otherwise>
                                <c:set var="bnHref" value=""/>
                            </c:otherwise>
                        </c:choose>

                        <c:choose>
                            <c:when test="${not empty bnHref}">
                                <a class="banner-card banner-image" href="${bnHref}"
                                   style="background-image:url('/banner/image/${bn.bannerId}?v=${bn.imgVer}');"
                                   aria-label="${fn:escapeXml(bn.title)}"></a>
                            </c:when>
                            <c:otherwise>
                                <div class="banner-card banner-image"
                                     style="background-image:url('/banner/image/${bn.bannerId}?v=${bn.imgVer}');"
                                     aria-label="${fn:escapeXml(bn.title)}"></div>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                </div>
                <c:if test="${banners.size() > 1}">
                    <div class="banner-dots" id="bannerDots">
                        <c:forEach var="bn" items="${banners}" varStatus="loop">
                            <span class="dot ${loop.first ? 'active' : ''}" data-index="${loop.index}"></span>
                        </c:forEach>
                    </div>
                </c:if>
            </c:when>
            <c:otherwise>
                <div class="banner-empty">등록된 배너가 없습니다</div>
            </c:otherwise>
        </c:choose>
    </div>

    <!-- 4. 카테고리 바 -->
    <c:set var="catQs" value="${regionQs}"/>
    <c:if test="${not empty keyword}">
        <c:set var="catQs" value="${catQs}&keyword=${fn:escapeXml(keyword)}"/>
    </c:if>
    <c:set var="catBase" value="/main${regionQsFirst}"/>
    <c:set var="catBaseSep" value="${empty regionQsFirst ? '?' : '&'}"/>
    <div class="category-section">
        <div class="category-bar" id="categoryBar">
            <a class="category-item ${empty category ? 'active' : ''}" data-category=""
               href="/main${regionQsFirst}<c:if test='${not empty keyword}'>${catBaseSep}keyword=${fn:escapeXml(keyword)}</c:if>">
                <span class="cat-icon">🏪</span>
                <span class="cat-label">전체</span>
            </a>
            <a class="category-item ${category == 'CAFE' ? 'active' : ''}" data-category="CAFE"
               href="${catBase}${catBaseSep}category=CAFE<c:if test='${not empty keyword}'>&keyword=${fn:escapeXml(keyword)}</c:if>">
                <span class="cat-icon">☕</span>
                <span class="cat-label">카페</span>
            </a>
            <a class="category-item ${category == 'FOOD' ? 'active' : ''}" data-category="FOOD"
               href="${catBase}${catBaseSep}category=FOOD<c:if test='${not empty keyword}'>&keyword=${fn:escapeXml(keyword)}</c:if>">
                <span class="cat-icon">🍽</span>
                <span class="cat-label">음식점</span>
            </a>
            <a class="category-item ${category == 'BEAUTY' ? 'active' : ''}" data-category="BEAUTY"
               href="${catBase}${catBaseSep}category=BEAUTY<c:if test='${not empty keyword}'>&keyword=${fn:escapeXml(keyword)}</c:if>">
                <span class="cat-icon">💄</span>
                <span class="cat-label">뷰티</span>
            </a>
            <a class="category-item ${category == 'SHOPPING' ? 'active' : ''}" data-category="SHOPPING"
               href="${catBase}${catBaseSep}category=SHOPPING<c:if test='${not empty keyword}'>&keyword=${fn:escapeXml(keyword)}</c:if>">
                <span class="cat-icon">🛍</span>
                <span class="cat-label">쇼핑</span>
            </a>
            <a class="category-item ${category == 'FITNESS' ? 'active' : ''}" data-category="FITNESS"
               href="${catBase}${catBaseSep}category=FITNESS<c:if test='${not empty keyword}'>&keyword=${fn:escapeXml(keyword)}</c:if>">
                <span class="cat-icon">💪</span>
                <span class="cat-label">피트니스</span>
            </a>
            <a class="category-item ${category == 'CONVENIENCE' ? 'active' : ''}" data-category="CONVENIENCE"
               href="${catBase}${catBaseSep}category=CONVENIENCE<c:if test='${not empty keyword}'>&keyword=${fn:escapeXml(keyword)}</c:if>">
                <span class="cat-icon">🏬</span>
                <span class="cat-label">편의점</span>
            </a>
        </div>
    </div>

    <!-- 5,6,7. 인기 / HOT / 가맹점 목록 (AJAX 갱신 영역) -->
    <div id="mainSections">
        <%@ include file="/WEB-INF/views/main/_sections.jsp" %>
    </div>

    <!-- 로딩 인디케이터 -->
    <div id="mainLoader" class="main-loader" hidden>
        <div class="loader-spinner"></div>
    </div>

    <!-- 8. 하단 탭바 -->
    <jsp:include page="/WEB-INF/views/common/_tab_bar.jsp"/>

</div>
<script src="/static/js/common.js"></script>
<script src="/static/js/main.js"></script>
</body>
</html>
