<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <jsp:include page="/WEB-INF/views/admin/common/_admin_meta.jsp">
        <jsp:param name="title" value="가맹점 관리"/>
    </jsp:include>
</head>
<body>

<div class="admin-layout">

    <jsp:include page="/WEB-INF/views/admin/common/_admin_sidebar.jsp"/>

    <div class="admin-main">

        <jsp:include page="/WEB-INF/views/admin/common/_admin_header.jsp">
            <jsp:param name="title" value="가맹점 관리"/>
        </jsp:include>

        <div class="admin-content">

            <c:if test="${param.msg == 'created'}">
                <div class="admin-form-success" style="margin-bottom:16px;">가맹점이 등록되었습니다</div>
            </c:if>
            <c:if test="${param.msg == 'error'}">
                <div class="admin-form-error" style="margin-bottom:16px;">처리 중 오류가 발생했습니다</div>
            </c:if>

            <div class="admin-card">

                <div class="admin-card-header">
                    <h2 class="admin-card-title">검색</h2>
                    <c:if test="${LOGIN_ADMIN.admin or LOGIN_ADMIN.superAdmin}">
                        <a href="/admin/stores/new" class="btn-admin-primary btn-admin-sm">+ 가맹점 등록</a>
                    </c:if>
                </div>

                <form method="get" action="/admin/stores" class="admin-filter">
                    <input type="text"
                           name="keyword"
                           class="admin-input admin-filter-search"
                           placeholder="가맹점명 검색"
                           value="${fn:escapeXml(keyword)}">

                    <select name="categoryId" class="admin-select">
                        <option value="">전체 카테고리</option>
                        <c:forEach var="cat" items="${categories}">
                            <option value="${cat.categoryId}" ${categoryId == cat.categoryId ? 'selected' : ''}>${fn:escapeXml(cat.name)}</option>
                        </c:forEach>
                    </select>

                    <select name="status" class="admin-select">
                        <option value=""          ${status == ''         ? 'selected' : ''}>전체 상태</option>
                        <option value="ACTIVE"    ${status == 'ACTIVE'   ? 'selected' : ''}>ACTIVE</option>
                        <option value="INACTIVE"  ${status == 'INACTIVE' ? 'selected' : ''}>INACTIVE</option>
                    </select>

                    <select name="regionId" class="admin-select">
                        <option value="">전체 지역</option>
                        <c:forEach var="r" items="${regions}">
                            <option value="${r.regionId}" ${regionId == r.regionId ? 'selected' : ''}>${fn:escapeXml(r.regionName)}</option>
                        </c:forEach>
                    </select>

                    <button type="submit" class="btn-admin-primary">검색</button>
                </form>

                <p style="margin: 12px 0 16px; font-size: 13px; color: var(--admin-text-secondary);">
                    총 <strong style="color: var(--admin-text-primary);">${totalCount}</strong>개
                </p>

                <div class="admin-table-wrap">
                    <table class="admin-table">
                        <thead>
                            <tr>
                                <th style="width:60px;">No</th>
                                <th>가맹점명</th>
                                <th>카테고리</th>
                                <th>지역</th>
                                <th>연락처</th>
                                <th>가맹점주ID</th>
                                <th>상태</th>
                                <th>등록일</th>
                                <th style="width:90px;">관리</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${empty stores}">
                                    <tr>
                                        <td colspan="9" class="admin-empty">조회된 가맹점이 없습니다</td>
                                    </tr>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach var="s" items="${stores}" varStatus="loop">
                                        <tr>
                                            <td>${totalCount - ((currentPage - 1) * 15) - loop.index}</td>
                                            <td>
                                                <c:if test="${not empty s.emoji}"><span style="margin-right:4px;">${s.emoji}</span></c:if>
                                                <strong>${fn:escapeXml(s.storeName)}</strong>
                                            </td>
                                            <td>
                                                <c:if test="${not empty s.categoryIcon}"><span style="margin-right:4px;">${s.categoryIcon}</span></c:if>
                                                ${fn:escapeXml(s.categoryName)}
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${not empty s.regionName}">${fn:escapeXml(s.regionName)}</c:when>
                                                    <c:otherwise><span style="color: var(--admin-text-secondary);">-</span></c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${not empty s.phone}">${fn:escapeXml(s.phone)}</c:when>
                                                    <c:otherwise><span style="color: var(--admin-text-secondary);">-</span></c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${not empty s.adminLoginId}">${fn:escapeXml(s.adminLoginId)}</c:when>
                                                    <c:otherwise><span style="color: var(--admin-text-secondary);">미할당</span></c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${s.status == 'ACTIVE'}">
                                                        <span class="badge-status badge-status-active">ACTIVE</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge-status badge-status-withdrawn">INACTIVE</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>${fn:substring(s.createdAt.toString(), 0, 10)}</td>
                                            <td>
                                                <a href="/admin/stores/${s.storeId}" class="btn-admin-secondary btn-admin-sm">상세</a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>
                </div>

                <c:url var="baseUrl" value="/admin/stores">
                    <c:param name="keyword" value="${keyword}"/>
                    <c:if test="${not empty categoryId}">
                        <c:param name="categoryId" value="${categoryId}"/>
                    </c:if>
                    <c:param name="status" value="${status}"/>
                    <c:if test="${not empty regionId}">
                        <c:param name="regionId" value="${regionId}"/>
                    </c:if>
                </c:url>
                <%@ include file="/WEB-INF/views/admin/common/_admin_pagination.jsp" %>

            </div>
        </div>
    </div>
</div>

</body>
</html>
