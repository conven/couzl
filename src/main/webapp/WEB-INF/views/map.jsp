<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>내 주변 - Couzl</title>
    <link rel="stylesheet" href="/static/css/common.css">
    <link rel="stylesheet" href="/static/css/map.css">
</head>
<body>

<%@ include file="/WEB-INF/views/common/_header.jsp" %>

<div class="map-container">
    <div id="kakao-map"></div>
</div>

<div id="bottom-sheet-overlay" class="bottom-sheet-overlay"></div>
<div id="bottom-sheet" class="bottom-sheet">
    <div class="bottom-sheet-handle"></div>
    <div id="bottom-sheet-content"></div>
</div>

<button id="btn-my-location" class="btn-my-location">📍</button>

<%@ include file="/WEB-INF/views/common/_tab_bar.jsp" %>

<script src="/static/js/common.js"></script>
<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=<%= request.getAttribute("kakaoMapKey") %>&libraries=services,clusterer&autoload=false"></script>
<script>var STORE_LIST = ${storeListJson};</script>
<script src="/static/js/map.js"></script>

</body>
</html>
