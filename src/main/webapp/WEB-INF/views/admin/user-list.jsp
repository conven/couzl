<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <jsp:include page="/WEB-INF/views/admin/common/_admin_meta.jsp">
        <jsp:param name="title" value="회원 관리"/>
    </jsp:include>
</head>
<body>

<div class="admin-layout">

    <jsp:include page="/WEB-INF/views/admin/common/_admin_sidebar.jsp"/>

    <div class="admin-main">

        <jsp:include page="/WEB-INF/views/admin/common/_admin_header.jsp">
            <jsp:param name="title" value="회원 관리"/>
        </jsp:include>

        <div class="admin-content">

            <c:if test="${param.msg == 'error'}">
                <div class="admin-form-error" style="margin-bottom:16px;">처리 중 오류가 발생했습니다</div>
            </c:if>

            <div class="admin-card">

                <form method="get" action="/admin/users" class="admin-filter">
                    <input type="text"
                           name="keyword"
                           class="admin-input admin-filter-search"
                           placeholder="아이디 / 닉네임 / 이메일 검색"
                           value="${fn:escapeXml(keyword)}">

                    <select name="status" class="admin-select">
                        <option value=""           ${status == ''          ? 'selected' : ''}>전체 상태</option>
                        <option value="ACTIVE"     ${status == 'ACTIVE'    ? 'selected' : ''}>ACTIVE</option>
                        <option value="SUSPENDED"  ${status == 'SUSPENDED' ? 'selected' : ''}>SUSPENDED</option>
                        <option value="WITHDRAWN"  ${status == 'WITHDRAWN' ? 'selected' : ''}>WITHDRAWN</option>
                    </select>

                    <button type="submit" class="btn-admin-primary">검색</button>
                </form>

                <p style="margin: 12px 0 16px; font-size: 13px; color: var(--admin-text-secondary);">
                    총 <strong style="color: var(--admin-text-primary);">${totalCount}</strong>명
                </p>

                <div class="admin-table-wrap">
                    <table class="admin-table">
                        <thead>
                            <tr>
                                <th style="width:60px;">No</th>
                                <th>아이디</th>
                                <th>닉네임</th>
                                <th>이메일</th>
                                <th>지역</th>
                                <th>가입유형</th>
                                <th>상태</th>
                                <th>가입일</th>
                                <th style="width:90px;">관리</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${empty users}">
                                    <tr>
                                        <td colspan="9" class="admin-empty">조회된 회원이 없습니다</td>
                                    </tr>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach var="u" items="${users}" varStatus="loop">
                                        <tr>
                                            <td>${totalCount - ((currentPage - 1) * 15) - loop.index}</td>
                                            <td><strong>${fn:escapeXml(u.loginId)}</strong></td>
                                            <td>${fn:escapeXml(u.nickname)}</td>
                                            <td>${fn:escapeXml(u.email)}</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${not empty u.regionName}">${fn:escapeXml(u.regionName)}</c:when>
                                                    <c:otherwise><span style="color: var(--admin-text-secondary);">-</span></c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>${u.socialType}</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${u.status == 'ACTIVE'}">
                                                        <span class="badge-status badge-status-active">ACTIVE</span>
                                                    </c:when>
                                                    <c:when test="${u.status == 'SUSPENDED'}">
                                                        <span class="badge-status badge-status-suspended">SUSPENDED</span>
                                                    </c:when>
                                                    <c:when test="${u.status == 'WITHDRAWN'}">
                                                        <span class="badge-status badge-status-withdrawn">WITHDRAWN</span>
                                                    </c:when>
                                                </c:choose>
                                            </td>
                                            <td>${fn:substring(u.createdAt.toString(), 0, 10)}</td>
                                            <td>
                                                <a href="/admin/users/${u.userId}" class="btn-admin-secondary btn-admin-sm">상세</a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>
                </div>

                <c:url var="baseUrl" value="/admin/users">
                    <c:param name="keyword" value="${keyword}"/>
                    <c:param name="status" value="${status}"/>
                </c:url>
                <%@ include file="/WEB-INF/views/admin/common/_admin_pagination.jsp" %>

            </div>
        </div>
    </div>
</div>

</body>
</html>
