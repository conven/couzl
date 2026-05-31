<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <jsp:include page="/WEB-INF/views/admin/common/_admin_meta.jsp">
        <jsp:param name="title" value="배너 관리"/>
    </jsp:include>
    <style>
        .bn-thumb {
            width: 140px;
            height: 56px;
            object-fit: cover;
            border-radius: var(--admin-radius-sm);
            background-color: var(--admin-bg);
            border: 1px solid var(--admin-border);
            display: block;
        }
        .bn-order-form {
            display: flex;
            gap: 4px;
            align-items: center;
        }
        .bn-order-form input {
            width: 60px;
            padding: 4px 6px;
            font-size: 13px;
        }
        .bn-actions { display: flex; gap: 4px; flex-wrap: wrap; }
        .bn-actions form { margin: 0; }
    </style>
</head>
<body>

<div class="admin-layout">

    <jsp:include page="/WEB-INF/views/admin/common/_admin_sidebar.jsp"/>

    <div class="admin-main">

        <jsp:include page="/WEB-INF/views/admin/common/_admin_header.jsp">
            <jsp:param name="title" value="배너 관리"/>
        </jsp:include>

        <div class="admin-content">

            <c:if test="${param.msg == 'created'}">
                <div class="admin-form-success" style="margin-bottom:16px;">배너가 등록되었습니다</div>
            </c:if>
            <c:if test="${param.msg == 'deleted'}">
                <div class="admin-form-success" style="margin-bottom:16px;">배너가 삭제되었습니다</div>
            </c:if>
            <c:if test="${param.msg == 'error'}">
                <div class="admin-form-error" style="margin-bottom:16px;">처리 중 오류가 발생했습니다</div>
            </c:if>

            <div class="admin-card">

                <div class="admin-card-header">
                    <h2 class="admin-card-title">검색</h2>
                    <a href="/admin/banners/new" class="btn-admin-primary btn-admin-sm">+ 배너 등록</a>
                </div>

                <form method="get" action="/admin/banners" class="admin-filter">
                    <select name="isActive" class="admin-select">
                        <option value=""  ${empty isActive ? 'selected' : ''}>전체</option>
                        <option value="1" ${isActive == 1 ? 'selected' : ''}>활성</option>
                        <option value="0" ${isActive == 0 ? 'selected' : ''}>비활성</option>
                    </select>
                    <button type="submit" class="btn-admin-primary">검색</button>
                </form>

                <p style="margin: 12px 0 16px; font-size: 13px; color: var(--admin-text-secondary);">
                    총 <strong style="color: var(--admin-text-primary);">${banners.size()}</strong>개
                </p>

                <div class="admin-table-wrap">
                    <table class="admin-table">
                        <thead>
                            <tr>
                                <th style="width:100px;">순서</th>
                                <th style="width:160px;">미리보기</th>
                                <th>제목</th>
                                <th style="width:100px;">링크유형</th>
                                <th>링크대상</th>
                                <th>노출기간</th>
                                <th style="width:90px;">활성여부</th>
                                <th style="width:110px;">등록일</th>
                                <th style="width:240px;">관리</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${empty banners}">
                                    <tr><td colspan="9" class="admin-empty">등록된 배너가 없습니다</td></tr>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach var="b" items="${banners}">
                                        <tr>
                                            <td>
                                                <form method="post" action="/admin/banners/${b.bannerId}/order" class="bn-order-form">
                                                    <input type="number" name="displayOrder" value="${b.displayOrder}" class="admin-input">
                                                    <button type="submit" class="btn-admin-secondary btn-admin-sm">적용</button>
                                                </form>
                                            </td>
                                            <td><img src="/admin/banners/${b.bannerId}/image" class="bn-thumb" alt="배너"></td>
                                            <td><strong>${fn:escapeXml(b.title)}</strong></td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${b.linkType == 'STORE'}">
                                                        <span class="admin-badge badge-admin">가맹점</span>
                                                    </c:when>
                                                    <c:when test="${b.linkType == 'COUPON'}">
                                                        <span class="admin-badge badge-store-owner">쿠폰</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span style="color:var(--admin-text-secondary);">없음</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${not empty b.linkTargetName}">${fn:escapeXml(b.linkTargetName)}</c:when>
                                                    <c:otherwise><span style="color:var(--admin-text-secondary);">-</span></c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td style="font-size:13px;">
                                                <c:choose>
                                                    <c:when test="${empty b.startDate}">즉시</c:when>
                                                    <c:otherwise>${b.startDate}</c:otherwise>
                                                </c:choose>
                                                ~
                                                <c:choose>
                                                    <c:when test="${empty b.endDate}">무기한</c:when>
                                                    <c:otherwise>${b.endDate}</c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${b.isActive == 1}">
                                                        <span class="badge-status badge-status-active">활성</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge-status badge-status-withdrawn">비활성</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>${fn:substring(b.createdAt.toString(), 0, 10)}</td>
                                            <td>
                                                <div class="bn-actions">
                                                    <a href="/admin/banners/${b.bannerId}" class="btn-admin-secondary btn-admin-sm">수정</a>
                                                    <c:choose>
                                                        <c:when test="${b.isActive == 1}">
                                                            <form method="post" action="/admin/banners/${b.bannerId}/active"
                                                                  onsubmit="return confirm('비활성화하시겠습니까?');">
                                                                <input type="hidden" name="isActive" value="0">
                                                                <button type="submit" class="btn-admin-secondary btn-admin-sm">비활성화</button>
                                                            </form>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <form method="post" action="/admin/banners/${b.bannerId}/active"
                                                                  onsubmit="return confirm('활성화하시겠습니까?');">
                                                                <input type="hidden" name="isActive" value="1">
                                                                <button type="submit" class="btn-admin-success btn-admin-sm">활성화</button>
                                                            </form>
                                                        </c:otherwise>
                                                    </c:choose>
                                                    <form method="post" action="/admin/banners/${b.bannerId}/delete"
                                                          onsubmit="return confirm('배너를 삭제하시겠습니까?');">
                                                        <button type="submit" class="btn-admin-danger btn-admin-sm">삭제</button>
                                                    </form>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>
                </div>

                <p style="margin-top:12px; font-size:12px; color:var(--admin-text-secondary);">
                    ※ 순서는 숫자가 낮을수록 먼저 노출됩니다. 변경 후 "적용"을 눌러주세요.
                </p>
            </div>

        </div>
    </div>
</div>

</body>
</html>
