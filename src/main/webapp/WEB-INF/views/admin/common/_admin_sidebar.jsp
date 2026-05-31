<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
    String currentUri = request.getRequestURI();
    request.setAttribute("currentUri", currentUri);
%>
<div id="adminSidebarOverlay" class="admin-sidebar-overlay" onclick="closeAdminSidebar()"></div>

<aside id="adminSidebar" class="admin-sidebar">
    <div class="admin-sidebar-brand">
        <span class="admin-brand-logo">C</span>
        <span class="admin-brand-text">Couzl <strong>BO</strong></span>
    </div>

    <nav class="admin-nav">

        <a href="/admin/dashboard"
           class="admin-nav-item ${fn:contains(currentUri, '/admin/dashboard') ? 'active' : ''}">
            <span class="admin-nav-icon">▦</span>
            <span class="admin-nav-label">대시보드</span>
        </a>

        <c:if test="${LOGIN_ADMIN.admin or LOGIN_ADMIN.superAdmin}">
            <p class="admin-nav-group">운영 관리</p>

            <a href="/admin/users"
               class="admin-nav-item ${fn:contains(currentUri, '/admin/users') ? 'active' : ''}">
                <span class="admin-nav-icon">◉</span>
                <span class="admin-nav-label">회원관리</span>
            </a>

            <a href="/admin/categories"
               class="admin-nav-item ${fn:contains(currentUri, '/admin/categories') ? 'active' : ''}">
                <span class="admin-nav-icon">▤</span>
                <span class="admin-nav-label">카테고리관리</span>
            </a>

            <a href="/admin/stores"
               class="admin-nav-item ${fn:contains(currentUri, '/admin/stores') ? 'active' : ''}">
                <span class="admin-nav-icon">▣</span>
                <span class="admin-nav-label">가맹점관리</span>
            </a>

            <a href="/admin/coupons"
               class="admin-nav-item ${fn:contains(currentUri, '/admin/coupons') ? 'active' : ''}">
                <span class="admin-nav-icon">◈</span>
                <span class="admin-nav-label">쿠폰관리</span>
            </a>

            <a href="/admin/reviews"
               class="admin-nav-item ${fn:contains(currentUri, '/admin/reviews') ? 'active' : ''}">
                <span class="admin-nav-icon">★</span>
                <span class="admin-nav-label">리뷰관리</span>
            </a>

            <a href="/admin/regions"
               class="admin-nav-item ${fn:contains(currentUri, '/admin/regions') ? 'active' : ''}">
                <span class="admin-nav-icon">◎</span>
                <span class="admin-nav-label">지역관리</span>
            </a>

            <a href="/admin/banners"
               class="admin-nav-item ${fn:contains(currentUri, '/admin/banners') ? 'active' : ''}">
                <span class="admin-nav-icon">▭</span>
                <span class="admin-nav-label">배너관리</span>
            </a>
        </c:if>

        <c:if test="${LOGIN_ADMIN.superAdmin}">
            <p class="admin-nav-group">시스템</p>

            <a href="/admin/accounts"
               class="admin-nav-item ${fn:contains(currentUri, '/admin/accounts') ? 'active' : ''}">
                <span class="admin-nav-icon">◆</span>
                <span class="admin-nav-label">어드민계정관리</span>
            </a>
        </c:if>

        <c:if test="${LOGIN_ADMIN.storeOwner}">
            <p class="admin-nav-group">내 가맹점</p>

            <a href="/admin/store"
               class="admin-nav-item ${fn:contains(currentUri, '/admin/store') and not fn:contains(currentUri, '/admin/stores') ? 'active' : ''}">
                <span class="admin-nav-icon">▣</span>
                <span class="admin-nav-label">내 가맹점 정보</span>
            </a>

            <a href="/admin/store/coupons"
               class="admin-nav-item ${fn:contains(currentUri, '/admin/store/coupons') ? 'active' : ''}">
                <span class="admin-nav-icon">◈</span>
                <span class="admin-nav-label">내 쿠폰 관리</span>
            </a>

            <a href="/admin/qr-scan"
               class="admin-nav-item ${fn:contains(currentUri, '/admin/qr-scan') ? 'active' : ''}">
                <span class="admin-nav-icon">▦</span>
                <span class="admin-nav-label">QR 쿠폰 스캔</span>
            </a>
        </c:if>
    </nav>
</aside>
