<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link rel="stylesheet" href="/static/css/location-modal.css">
<div id="locationModalOverlay" class="location-modal-overlay"
     data-logged-in="${not empty sessionScope.LOGIN_USER}"
     data-kakao-key="${kakaoMapKey}">
    <div class="location-modal" role="dialog" aria-modal="true" aria-label="지역 선택">
        <div class="location-modal-handle"></div>

        <div class="location-modal-header">
            <span class="location-modal-title">지역 선택</span>
            <button class="location-modal-close" onclick="LocationModal.close()" aria-label="닫기">✕</button>
        </div>

        <button type="button" class="location-gps-btn" onclick="LocationModal.useCurrentLocation()">
            <span class="location-gps-icon">📍</span>
            <span class="location-gps-text">현재위치로 찾기</span>
        </button>

        <div class="location-modal-divider"></div>

        <div class="location-search-wrap">
            <span class="location-search-icon">🔍</span>
            <input id="locationSearchInput" class="location-search-input"
                   type="text" placeholder="지역명 검색" autocomplete="off" />
        </div>

        <p class="location-section-title">지역 목록</p>
        <ul class="location-list" id="locationList">
            <c:forEach var="r" items="${activeRegions}">
                <li class="location-item"
                    data-region-id="${r.regionId}"
                    data-region="${fn:escapeXml(r.regionName)}">${fn:escapeXml(r.regionName)}</li>
            </c:forEach>
        </ul>

        <c:if test="${not empty sessionScope.LOGIN_USER}">
            <form id="locationModalForm" method="post" action="/location" style="display:none;">
                <input type="hidden" name="regionId" id="locationModalRegionId" value="">
            </form>
        </c:if>
    </div>
</div>
<script src="/static/js/location-modal.js"></script>
