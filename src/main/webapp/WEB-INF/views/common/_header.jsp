<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<header class="main-header">
    <c:choose>
        <%-- 로그인 유저: DB 저장 지역 --%>
        <c:when test="${not empty sessionScope.LOGIN_USER}">
            <div class="header-location" onclick="LocationModal.open()" role="button" tabindex="0">
                <c:choose>
                    <c:when test="${not empty sessionScope.USER_REGION}">
                        <span>📍 ${sessionScope.USER_REGION.regionName} ▾</span>
                    </c:when>
                    <c:otherwise>
                        <span>📍 지역을 선택하세요 ▾</span>
                    </c:otherwise>
                </c:choose>
            </div>
        </c:when>
        <%-- 비로그인: localStorage 기반 --%>
        <c:otherwise>
            <div class="header-location" onclick="LocationModal.open()" role="button" tabindex="0">
                <span>📍 <span id="headerRegionName">지역을 선택하세요</span> ▾</span>
            </div>
        </c:otherwise>
    </c:choose>
    <span class="header-logo">Couzl</span>
    <button class="btn-bell" onclick="showAlert('알림이 없습니다')">🔔</button>
</header>

<%@ include file="/WEB-INF/views/common/_location_modal.jsp" %>

<c:if test="${empty sessionScope.LOGIN_USER}">
<script>
    (function () {
        try {
            var saved = localStorage.getItem('selectedRegion');
            if (!saved) return;
            var region = JSON.parse(saved);
            var el = document.getElementById('headerRegionName');
            if (el && region && region.regionName) {
                el.textContent = region.regionName;
            }
        } catch (e) {}
    })();
</script>
</c:if>
