<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <jsp:include page="/WEB-INF/views/admin/common/_admin_meta.jsp">
        <jsp:param name="title" value="리뷰 관리"/>
    </jsp:include>
    <style>
        .rv-stars { color: #f59e0b; letter-spacing: 1px; font-size: 14px; }
        .rv-stars .empty { color: #d1d5db; }
        .rv-content-cell {
            max-width: 320px;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }
    </style>
</head>
<body>

<div class="admin-layout">

    <jsp:include page="/WEB-INF/views/admin/common/_admin_sidebar.jsp"/>

    <div class="admin-main">

        <jsp:include page="/WEB-INF/views/admin/common/_admin_header.jsp">
            <jsp:param name="title" value="리뷰 관리"/>
        </jsp:include>

        <div class="admin-content">

            <c:if test="${param.msg == 'deleted'}">
                <div class="admin-form-success" style="margin-bottom:16px;">리뷰가 삭제되었습니다</div>
            </c:if>
            <c:if test="${param.msg == 'error'}">
                <div class="admin-form-error" style="margin-bottom:16px;">처리 중 오류가 발생했습니다</div>
            </c:if>

            <div class="admin-card">

                <div class="admin-card-header">
                    <h2 class="admin-card-title">검색</h2>
                </div>

                <form method="get" action="/admin/reviews" class="admin-filter">
                    <input type="text"
                           name="keyword"
                           class="admin-input admin-filter-search"
                           placeholder="닉네임 / 리뷰내용 검색"
                           value="${fn:escapeXml(keyword)}">

                    <select name="storeId" class="admin-select">
                        <option value="">전체 가맹점</option>
                        <c:forEach var="s" items="${stores}">
                            <option value="${s.storeId}" ${storeId == s.storeId ? 'selected' : ''}>${fn:escapeXml(s.storeName)}</option>
                        </c:forEach>
                    </select>

                    <select name="rating" class="admin-select">
                        <option value="">전체 별점</option>
                        <option value="5" ${rating == 5 ? 'selected' : ''}>★★★★★ 5</option>
                        <option value="4" ${rating == 4 ? 'selected' : ''}>★★★★ 4</option>
                        <option value="3" ${rating == 3 ? 'selected' : ''}>★★★ 3</option>
                        <option value="2" ${rating == 2 ? 'selected' : ''}>★★ 2</option>
                        <option value="1" ${rating == 1 ? 'selected' : ''}>★ 1</option>
                    </select>

                    <select name="status" class="admin-select">
                        <option value=""         ${status == ''        ? 'selected' : ''}>전체 상태</option>
                        <option value="ACTIVE"   ${status == 'ACTIVE'  ? 'selected' : ''}>ACTIVE</option>
                        <option value="DELETED"  ${status == 'DELETED' ? 'selected' : ''}>DELETED</option>
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
                                <th>작성자</th>
                                <th>별점</th>
                                <th>리뷰내용</th>
                                <th>상태</th>
                                <th>작성일</th>
                                <th style="width:80px;">관리</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${empty reviews}">
                                    <tr><td colspan="8" class="admin-empty">조회된 리뷰가 없습니다</td></tr>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach var="rv" items="${reviews}" varStatus="loop">
                                        <tr>
                                            <td>${totalCount - ((currentPage - 1) * 15) - loop.index}</td>
                                            <td>${fn:escapeXml(rv.storeName)}</td>
                                            <td>${fn:escapeXml(rv.nickname)}</td>
                                            <td>
                                                <span class="rv-stars">
                                                    <c:forEach begin="1" end="5" var="i">
                                                        <c:choose>
                                                            <c:when test="${i <= rv.rating}">★</c:when>
                                                            <c:otherwise><span class="empty">★</span></c:otherwise>
                                                        </c:choose>
                                                    </c:forEach>
                                                </span>
                                                <span style="margin-left:4px; font-size:12px; color:var(--admin-text-secondary);">${rv.rating}</span>
                                            </td>
                                            <td>
                                                <div class="rv-content-cell">
                                                    <c:choose>
                                                        <c:when test="${fn:length(rv.content) > 50}">
                                                            ${fn:escapeXml(fn:substring(rv.content, 0, 50))}…
                                                        </c:when>
                                                        <c:otherwise>${fn:escapeXml(rv.content)}</c:otherwise>
                                                    </c:choose>
                                                </div>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${rv.status == 'ACTIVE'}">
                                                        <span class="badge-status badge-status-active">ACTIVE</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge-status badge-status-withdrawn">DELETED</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>${fn:substring(rv.createdAt.toString(), 0, 10)}</td>
                                            <td>
                                                <a href="/admin/reviews/${rv.reviewId}" class="btn-admin-secondary btn-admin-sm">상세</a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>
                </div>

                <c:url var="baseUrl" value="/admin/reviews">
                    <c:param name="keyword" value="${keyword}"/>
                    <c:if test="${not empty storeId}">
                        <c:param name="storeId" value="${storeId}"/>
                    </c:if>
                    <c:if test="${not empty rating}">
                        <c:param name="rating" value="${rating}"/>
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
