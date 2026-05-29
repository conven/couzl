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

<c:choose>

<%-- ───── 최초 설정 모드 (탭바 없음) ───── --%>
<c:when test="${empty currentRegion}">
<div class="loc-setup-wrap">

    <div class="loc-setup-logo">
        <jsp:include page="/WEB-INF/views/common/_logo.jsp">
            <jsp:param name="bgColor"    value="white"/>
            <jsp:param name="inkColor"   value="#FFD60A"/>
            <jsp:param name="notchColor" value="#FFD60A"/>
        </jsp:include>
    </div>

    <p class="loc-setup-headline">내 지역을 설정해주세요</p>
    <p class="loc-setup-sub">선택한 지역의 가맹점과 쿠폰을 만나보세요!</p>

    <div class="loc-setup-list">
        <c:forEach var="region" items="${regions}">
            <button class="loc-card"
                    data-region-id="${region.regionId}"
                    data-name="${region.regionName}"
                    onclick="selectDistrict(this)">
                <span class="loc-card-left">
                    <span class="loc-card-emoji"></span>
                    <span class="loc-card-name">${region.regionName}</span>
                </span>
                <span class="loc-card-check">✓</span>
            </button>
        </c:forEach>
    </div>

    <div class="loc-setup-bottom">
        <p class="loc-setup-hint">지역은 마이페이지 &gt; 내 지역 관리에서 변경할 수 있어요</p>
        <button id="locBtnSave" class="loc-btn-save" disabled onclick="saveLocation()">
            이 지역으로 시작하기!
        </button>
    </div>

    <form id="locationForm" method="post" action="/location">
        <input type="hidden" name="regionId" id="selectedRegionId" value="">
    </form>
</div>
</c:when>

<%-- ───── 지역 변경 모드 (탭바 있음) ───── --%>
<c:otherwise>
<div class="wrap">

    <div class="loc-header">
        <button class="loc-btn-back" onclick="goTo('/mypage')">&#8592;</button>
        <span class="loc-header-title">내 지역 관리</span>
        <div class="loc-header-right"></div>
    </div>

    <div class="loc-section">
        <p class="loc-section-title">현재 내 지역</p>
        <div class="loc-current-card">
            <span class="loc-current-icon">✓</span>
            <span class="loc-current-name">${currentRegion.regionName}</span>
        </div>
    </div>

    <div class="loc-section">
        <p class="loc-section-title">지역 변경</p>
        <div class="loc-grid">
            <c:forEach var="region" items="${regions}">
                <button class="loc-card${region.regionId == currentRegionId ? ' selected' : ''}"
                        data-region-id="${region.regionId}"
                        data-name="${region.regionName}"
                        onclick="selectDistrict(this)">
                    <span class="loc-card-emoji"></span>
                    <span class="loc-card-name">${region.regionName}</span>
                </button>
            </c:forEach>
        </div>
    </div>

    <div class="loc-btn-wrap">
        <button id="locBtnSave" class="loc-btn-save" onclick="saveLocation()">변경하기</button>
    </div>

    <form id="locationForm" method="post" action="/location">
        <input type="hidden" name="regionId" id="selectedRegionId" value="">
    </form>

    <jsp:include page="/WEB-INF/views/common/_tab_bar.jsp"/>
    <script>
        (function () {
            var items = document.querySelectorAll('.tab-item');
            items.forEach(function (t) { t.classList.remove('active'); });
            if (items[2]) items[2].classList.add('active');
        })();
    </script>
</div>
</c:otherwise>

</c:choose>

<script src="/static/js/common.js"></script>
<script src="/static/js/location.js"></script>
</body>
</html>
