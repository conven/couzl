<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <jsp:include page="/WEB-INF/views/admin/common/_admin_meta.jsp">
        <jsp:param name="title" value="대시보드"/>
    </jsp:include>
</head>
<body>

<div class="admin-layout">

    <jsp:include page="/WEB-INF/views/admin/common/_admin_sidebar.jsp"/>

    <div class="admin-main">

        <jsp:include page="/WEB-INF/views/admin/common/_admin_header.jsp">
            <jsp:param name="title" value="대시보드"/>
        </jsp:include>

        <div class="admin-content">

            <div class="admin-stat-grid">

                <c:choose>
                    <c:when test="${LOGIN_ADMIN.storeOwner}">
                        <div class="admin-stat-card accent">
                            <p class="admin-stat-label">내 가맹점 보유 쿠폰</p>
                            <p class="admin-stat-value">0</p>
                        </div>
                        <div class="admin-stat-card">
                            <p class="admin-stat-label">내 가맹점 누적 발급</p>
                            <p class="admin-stat-value">0</p>
                        </div>
                        <div class="admin-stat-card">
                            <p class="admin-stat-label">오늘 발급된 쿠폰</p>
                            <p class="admin-stat-value">0</p>
                        </div>
                        <div class="admin-stat-card">
                            <p class="admin-stat-label">오늘 사용된 쿠폰</p>
                            <p class="admin-stat-value">0</p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="admin-stat-card accent">
                            <p class="admin-stat-label">전체 회원수</p>
                            <p class="admin-stat-value">0</p>
                        </div>
                        <div class="admin-stat-card">
                            <p class="admin-stat-label">전체 가맹점수</p>
                            <p class="admin-stat-value">0</p>
                        </div>
                        <div class="admin-stat-card">
                            <p class="admin-stat-label">오늘 발급 쿠폰</p>
                            <p class="admin-stat-value">0</p>
                        </div>
                        <div class="admin-stat-card">
                            <p class="admin-stat-label">오늘 사용 쿠폰</p>
                            <p class="admin-stat-value">0</p>
                        </div>
                    </c:otherwise>
                </c:choose>

            </div>

            <div class="admin-card" style="margin-top: 24px;">
                <div class="admin-card-header">
                    <h2 class="admin-card-title">최근 활동</h2>
                </div>
                <p style="color: var(--admin-text-secondary); margin: 0;">
                    환영합니다, <strong>${LOGIN_ADMIN.name}</strong>님. 좌측 메뉴에서 관리할 항목을 선택해주세요.
                </p>
            </div>

        </div>
    </div>
</div>

</body>
</html>
