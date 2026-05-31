<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <jsp:include page="/WEB-INF/views/admin/common/_admin_meta.jsp">
        <jsp:param name="title" value="어드민 계정 관리"/>
    </jsp:include>
</head>
<body>

<div class="admin-layout">

    <jsp:include page="/WEB-INF/views/admin/common/_admin_sidebar.jsp"/>

    <div class="admin-main">

        <jsp:include page="/WEB-INF/views/admin/common/_admin_header.jsp">
            <jsp:param name="title" value="어드민 계정 관리"/>
        </jsp:include>

        <div class="admin-content">

            <c:if test="${param.msg == 'created'}">
                <div class="admin-form-success" style="margin-bottom:16px;">계정이 등록되었습니다</div>
            </c:if>
            <c:if test="${param.msg == 'error'}">
                <div class="admin-form-error" style="margin-bottom:16px;">처리 중 오류가 발생했습니다</div>
            </c:if>

            <div class="admin-card">

                <div class="admin-card-header">
                    <h2 class="admin-card-title">검색</h2>
                    <a href="/admin/accounts/new" class="btn-admin-primary btn-admin-sm">+ 계정 등록</a>
                </div>

                <form method="get" action="/admin/accounts" class="admin-filter">
                    <input type="text"
                           name="keyword"
                           class="admin-input admin-filter-search"
                           placeholder="아이디 / 이름 검색"
                           value="${fn:escapeXml(keyword)}">

                    <select name="role" class="admin-select">
                        <option value=""              ${role == ''            ? 'selected' : ''}>전체 역할</option>
                        <option value="SUPER_ADMIN"   ${role == 'SUPER_ADMIN' ? 'selected' : ''}>슈퍼관리자</option>
                        <option value="ADMIN"         ${role == 'ADMIN'       ? 'selected' : ''}>일반관리자</option>
                        <option value="STORE_OWNER"   ${role == 'STORE_OWNER' ? 'selected' : ''}>가맹점주</option>
                    </select>

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
                                <th>아이디</th>
                                <th>이름</th>
                                <th>역할</th>
                                <th>가맹점</th>
                                <th>상태</th>
                                <th>마지막 로그인</th>
                                <th>등록일</th>
                                <th style="width:80px;">관리</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${empty admins}">
                                    <tr><td colspan="9" class="admin-empty">조회된 계정이 없습니다</td></tr>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach var="a" items="${admins}" varStatus="loop">
                                        <tr>
                                            <td>${totalCount - ((currentPage - 1) * 15) - loop.index}</td>
                                            <td><strong>${fn:escapeXml(a.loginId)}</strong></td>
                                            <td>${fn:escapeXml(a.name)}</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${a.role == 'SUPER_ADMIN'}">
                                                        <span class="admin-badge badge-super-admin">슈퍼관리자</span>
                                                    </c:when>
                                                    <c:when test="${a.role == 'ADMIN'}">
                                                        <span class="admin-badge badge-admin">일반관리자</span>
                                                    </c:when>
                                                    <c:when test="${a.role == 'STORE_OWNER'}">
                                                        <span class="admin-badge badge-store-owner">가맹점주</span>
                                                    </c:when>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${a.role == 'STORE_OWNER' and not empty a.storeName}">${fn:escapeXml(a.storeName)}</c:when>
                                                    <c:otherwise><span style="color:var(--admin-text-secondary);">-</span></c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${a.status == 'ACTIVE'}">
                                                        <span class="badge-status badge-status-active">ACTIVE</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge-status badge-status-withdrawn">INACTIVE</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${empty a.lastLoginAt}">
                                                        <span style="color:var(--admin-text-secondary);">미로그인</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        ${fn:replace(fn:substring(a.lastLoginAt.toString(), 0, 16), 'T', ' ')}
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>${fn:substring(a.createdAt.toString(), 0, 10)}</td>
                                            <td>
                                                <a href="/admin/accounts/${a.adminId}" class="btn-admin-secondary btn-admin-sm">상세</a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>
                </div>

                <c:url var="baseUrl" value="/admin/accounts">
                    <c:param name="keyword" value="${keyword}"/>
                    <c:param name="role" value="${role}"/>
                    <c:param name="status" value="${status}"/>
                </c:url>
                <%@ include file="/WEB-INF/views/admin/common/_admin_pagination.jsp" %>

            </div>
        </div>
    </div>
</div>

</body>
</html>
