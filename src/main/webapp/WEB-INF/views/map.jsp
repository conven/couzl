<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <%@ include file="/WEB-INF/views/common/_meta.jsp" %>
    <title>내 주변 - Couzl</title>
    <link rel="stylesheet" href="/static/css/map.css">
</head>
<body data-logged-in="${not empty sessionScope.LOGIN_USER}">

<%@ include file="/WEB-INF/views/common/_header.jsp" %>

<!-- 카테고리 필터 -->
<div class="map-cat-bar" id="mapCatBar">
    <button type="button" class="map-cat-item active" data-category="">전체</button>
    <button type="button" class="map-cat-item" data-category="CAFE">☕</button>
    <button type="button" class="map-cat-item" data-category="FOOD">🍽</button>
    <button type="button" class="map-cat-item" data-category="BEAUTY">💄</button>
    <button type="button" class="map-cat-item" data-category="SHOPPING">🛍</button>
    <button type="button" class="map-cat-item" data-category="FITNESS">💪</button>
    <button type="button" class="map-cat-item" data-category="CONVENIENCE">🏬</button>
</div>

<div class="map-container">
    <div id="kakao-map"></div>
    <button id="btn-my-location" class="btn-my-location" type="button" aria-label="내 위치">📍</button>
</div>

<!-- 가맹점 상세 바텀시트 -->
<div id="storeSheetOverlay" class="map-sheet-overlay"></div>
<div id="storeSheet" class="map-sheet store-sheet"></div>

<!-- 길찾기 바텀시트 -->
<div id="navSheetOverlay" class="map-sheet-overlay"></div>
<div id="navSheet" class="map-sheet nav-sheet"></div>

<%@ include file="/WEB-INF/views/common/_tab_bar.jsp" %>

<script src="/static/js/common.js"></script>
<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=${kakaoMapKey}&libraries=services,clusterer&autoload=false"></script>
<script src="/static/js/map.js"></script>

</body>
</html>
