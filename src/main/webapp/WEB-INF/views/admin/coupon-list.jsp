<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <jsp:include page="/WEB-INF/views/admin/common/_admin_meta.jsp">
        <jsp:param name="title" value="쿠폰 관리"/>
    </jsp:include>
</head>
<body>

<div class="admin-layout">

    <jsp:include page="/WEB-INF/views/admin/common/_admin_sidebar.jsp"/>

    <div class="admin-main">

        <jsp:include page="/WEB-INF/views/admin/common/_admin_header.jsp">
            <jsp:param name="title" value="쿠폰 관리"/>
        </jsp:include>

        <div class="admin-content">

            <c:if test="${param.msg == 'created'}">
                <div class="admin-form-success" style="margin-bottom:16px;">쿠폰이 등록되었습니다</div>
            </c:if>
            <c:if test="${param.msg == 'error'}">
                <div class="admin-form-error" style="margin-bottom:16px;">처리 중 오류가 발생했습니다</div>
            </c:if>

            <div class="admin-card">

                <div class="admin-card-header">
                    <h2 class="admin-card-title">검색</h2>
                    <a href="/admin/coupons/new" class="btn-admin-primary btn-admin-sm">+ 쿠폰 등록</a>
                </div>

                <form method="get" action="/admin/coupons" class="admin-filter">
                    <input type="text"
                           name="keyword"
                           class="admin-input admin-filter-search"
                           placeholder="쿠폰명 검색"
                           value="${fn:escapeXml(keyword)}">

                    <c:choose>
                        <c:when test="${LOGIN_ADMIN.storeOwner}">
                            <span style="padding:9px 12px; background:var(--admin-bg); border:1px solid var(--admin-border); border-radius:var(--admin-radius-sm); font-size:13px;">
                                내 가맹점 쿠폰
                            </span>
                        </c:when>
                        <c:otherwise>
                            <select name="storeId" class="admin-select">
                                <option value="">전체 가맹점</option>
                                <c:forEach var="s" items="${stores}">
                                    <option value="${s.storeId}" ${storeId == s.storeId ? 'selected' : ''}>${fn:escapeXml(s.storeName)}</option>
                                </c:forEach>
                            </select>
                        </c:otherwise>
                    </c:choose>

                    <select name="status" class="admin-select">
                        <option value=""          ${status == ''         ? 'selected' : ''}>전체 상태</option>
                        <option value="ACTIVE"    ${status == 'ACTIVE'   ? 'selected' : ''}>ACTIVE</option>
                        <option value="INACTIVE"  ${status == 'INACTIVE' ? 'selected' : ''}>INACTIVE</option>
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
                                <th>가맹점</th>
                                <th>쿠폰명</th>
                                <th>혜택</th>
                                <th>수량 (발급/전체)</th>
                                <th>만료일</th>
                                <th>상태</th>
                                <th>등록일</th>
                                <th style="width:80px;">관리</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${empty coupons}">
                                    <tr><td colspan="9" class="admin-empty">조회된 쿠폰이 없습니다</td></tr>
                                </c:when>
                                <c:otherwise>
                                    <c:set var="today" value="<%= java.time.LocalDate.now().toString() %>"/>
                                    <c:forEach var="co" items="${coupons}" varStatus="loop">
                                        <tr>
                                            <td>${totalCount - ((currentPage - 1) * 15) - loop.index}</td>
                                            <td>${fn:escapeXml(co.storeName)}</td>
                                            <td><strong>${fn:escapeXml(co.couponName)}</strong></td>
                                            <td>${fn:escapeXml(co.benefit)}</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${co.totalCount == 0}">
                                                        <span style="color:#2563eb; font-weight:600;">∞ 무제한</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        ${co.issuedCount} / ${co.totalCount}
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${co.expireDate < today}">
                                                        <span style="color:var(--admin-danger); font-weight:600;">${co.expireDate}</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        ${co.expireDate}
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${co.status == 'ACTIVE'}">
                                                        <span class="badge-status badge-status-active">ACTIVE</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge-status badge-status-withdrawn">INACTIVE</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>${fn:substring(co.createdAt.toString(), 0, 10)}</td>
                                            <td>
                                                <a href="/admin/coupons/${co.couponId}" class="btn-admin-secondary btn-admin-sm">상세</a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>
                </div>

                <c:url var="baseUrl" value="/admin/coupons">
                    <c:param name="keyword" value="${keyword}"/>
                    <c:if test="${not empty storeId}">
                        <c:param name="storeId" value="${storeId}"/>
                    </c:if>
                    <c:param name="status" value="${status}"/>
                </c:url>
                <%@ include file="/WEB-INF/views/admin/common/_admin_pagination.jsp" %>

            </div>
        </div>
    </div>
</div>

</body>
</html>
