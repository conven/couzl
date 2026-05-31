<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<header class="admin-header">
    <button class="admin-hamburger" type="button" onclick="openAdminSidebar()" aria-label="메뉴 열기">☰</button>

    <h1 class="admin-page-title">${param.title}</h1>

    <div class="admin-header-right">
        <c:if test="${not empty LOGIN_ADMIN}">
            <span class="admin-user-name">${LOGIN_ADMIN.name}</span>
            <c:choose>
                <c:when test="${LOGIN_ADMIN.superAdmin}">
                    <span class="admin-badge badge-super-admin">SUPER ADMIN</span>
                </c:when>
                <c:when test="${LOGIN_ADMIN.admin}">
                    <span class="admin-badge badge-admin">ADMIN</span>
                </c:when>
                <c:when test="${LOGIN_ADMIN.storeOwner}">
                    <span class="admin-badge badge-store-owner">STORE OWNER</span>
                </c:when>
            </c:choose>
        </c:if>
        <a href="/admin/logout" class="btn-admin-secondary btn-admin-sm">로그아웃</a>
    </div>
</header>

<script>
    function openAdminSidebar() {
        document.getElementById('adminSidebar').classList.add('is-open');
        document.getElementById('adminSidebarOverlay').classList.add('is-visible');
        document.body.style.overflow = 'hidden';
    }
    function closeAdminSidebar() {
        document.getElementById('adminSidebar').classList.remove('is-open');
        document.getElementById('adminSidebarOverlay').classList.remove('is-visible');
        document.body.style.overflow = '';
    }
</script>
