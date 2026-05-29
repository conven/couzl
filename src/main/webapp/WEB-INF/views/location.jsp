<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>내 지역 관리 - Couzl</title>
    <jsp:include page="/WEB-INF/views/common/header.jsp"/>
    <link rel="stylesheet" href="/static/css/common.css">
    <link rel="stylesheet" href="/static/css/location.css">
</head>
<body>
<div class="wrap">

    <!-- 1. 상단 헤더 -->
    <div class="loc-header">
        <c:choose>
            <c:when test="${not empty currentRegion}">
                <button class="loc-btn-back" onclick="goTo('/mypage')">&#8592;</button>
            </c:when>
            <c:otherwise>
                <div class="loc-header-left"></div>
            </c:otherwise>
        </c:choose>
        <span class="loc-header-title">내 지역 관리</span>
        <div class="loc-header-right"></div>
    </div>

    <!-- 안내 문구 (최초 설정 시) -->
    <c:if test="${empty currentRegion}">
        <div class="loc-guide">
            <p>서비스 이용을 위해 지역을 선택해주세요</p>
        </div>
    </c:if>

    <!-- 2. 현재 설정 지역 (지역 있을 때만 표시) -->
    <c:if test="${not empty currentRegion}">
        <div class="loc-section">
            <p class="loc-section-title">현재 내 지역</p>
            <div class="loc-current-card">
                <span class="loc-current-icon">✓</span>
                <span class="loc-current-name">${currentRegion}</span>
            </div>
        </div>
    </c:if>

    <!-- 3. 지역 변경 -->
    <div class="loc-section">
        <p class="loc-section-title">지역 변경</p>
        <div class="loc-grid">
            <c:forEach var="region" items="${regions}">
                <button class="loc-card${region.regionId == currentRegionId ? ' selected' : ''}"
                        data-region-id="${region.regionId}"
                        data-name="${region.regionName}"
                        onclick="selectDistrict(this)">${region.regionName}</button>
            </c:forEach>
        </div>
    </div>

    <!-- 4. 저장 버튼 -->
    <div class="loc-btn-wrap">
        <button class="loc-btn-save" onclick="saveLocation()">
            <c:choose>
                <c:when test="${not empty currentRegion}">변경하기</c:when>
                <c:otherwise>지역 설정하기</c:otherwise>
            </c:choose>
        </button>
    </div>

    <!-- 히든 폼 -->
    <form id="locationForm" method="post" action="/location">
        <input type="hidden" name="regionId" id="selectedRegionId" value="">
    </form>

    <!-- 하단 탭바 -->
    <jsp:include page="/WEB-INF/views/common/_tab_bar.jsp"/>
    <script>
        (function () {
            var items = document.querySelectorAll('.tab-item');
            items.forEach(function (t) { t.classList.remove('active'); });
            if (items[2]) items[2].classList.add('active');
        })();
    </script>

</div>
<script src="/static/js/common.js"></script>
<script src="/static/js/location.js"></script>
</body>
</html>
