<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<header class="main-header">
    <c:choose>
        <c:when test="${not empty sessionScope.USER_REGION}">
            <div class="header-location" onclick="LocationModal.open()">
                <span>📍</span>
                <span class="location-text">${sessionScope.USER_REGION}</span>
                <span class="location-arrow">▾</span>
            </div>
        </c:when>
        <c:otherwise>
            <div class="header-location" onclick="goTo('/location')">
                <span>📍</span>
                <span class="location-text">지역선택</span>
                <span class="location-arrow">▾</span>
            </div>
        </c:otherwise>
    </c:choose>
    <span class="header-logo">Couzl</span>
    <button class="btn-bell" onclick="showAlert('알림이 없습니다')">🔔</button>
</header>

<%@ include file="/WEB-INF/views/common/_location_modal.jsp" %>
