<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<header class="main-header">
    <c:choose>
        <c:when test="${not empty sessionScope.USER_REGION}">
            <div class="header-location" onclick="goTo('/location')">
                <span>📍 ${sessionScope.USER_REGION.regionName} ▾</span>
            </div>
        </c:when>
        <c:otherwise>
            <div class="header-location" style="visibility:hidden;"></div>
        </c:otherwise>
    </c:choose>
    <span class="header-logo">Couzl</span>
    <button class="btn-bell" onclick="showAlert('알림이 없습니다')">🔔</button>
</header>

<%@ include file="/WEB-INF/views/common/_location_modal.jsp" %>
