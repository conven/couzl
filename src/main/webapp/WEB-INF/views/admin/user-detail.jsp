<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <jsp:include page="/WEB-INF/views/admin/common/_admin_meta.jsp">
        <jsp:param name="title" value="회원 상세"/>
    </jsp:include>
    <style>
        .ud-profile {
            display: flex;
            gap: 20px;
            align-items: flex-start;
        }
        .ud-profile-info {
            flex: 1;
            min-width: 0;
        }
        .ud-status-cell {
            display: flex;
            align-items: center;
            gap: 10px;
            flex-wrap: wrap;
        }
        .ud-status-cell form { margin: 0; }
        @media (max-width: 768px) {
            .ud-profile {
                flex-direction: column;
                align-items: center;
                text-align: center;
            }
        }
    </style>
</head>
<body>

<div class="admin-layout">

    <jsp:include page="/WEB-INF/views/admin/common/_admin_sidebar.jsp"/>

    <div class="admin-main">

        <jsp:include page="/WEB-INF/views/admin/common/_admin_header.jsp">
            <jsp:param name="title" value="회원 상세"/>
        </jsp:include>

        <div class="admin-content">

            <c:if test="${param.msg == 'error'}">
                <div class="admin-form-error" style="margin-bottom:16px;">처리 중 오류가 발생했습니다</div>
            </c:if>

            <!-- 상단: 기본정보 + 상태변경 -->
            <div class="admin-card">

                <div class="admin-card-header">
                    <h2 class="admin-card-title">회원 정보</h2>
                    <a href="/admin/users" class="btn-admin-secondary btn-admin-sm">목록으로</a>
                </div>

                <div class="ud-profile">
                    <div class="admin-avatar">
                        <c:choose>
                            <c:when test="${not empty user.profileImage}">
                                <img src="/profile-image/${user.userId}" alt="프로필 이미지">
                            </c:when>
                            <c:otherwise>
                                <svg viewBox="0 0 64 64" width="100%" height="100%" aria-hidden="true">
                                    <rect width="64" height="64" fill="#f1f5f9"/>
                                    <circle cx="32" cy="26" r="11" fill="#cbd5e1"/>
                                    <path d="M12 56 C 12 44, 52 44, 52 56 L 52 64 L 12 64 Z" fill="#cbd5e1"/>
                                </svg>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <div class="ud-profile-info">
                        <table class="admin-info-list">
                            <tbody>
                                <tr>
                                    <th>아이디</th>
                                    <td><strong>${fn:escapeXml(user.loginId)}</strong></td>
                                </tr>
                                <tr>
                                    <th>닉네임</th>
                                    <td>${fn:escapeXml(user.nickname)}</td>
                                </tr>
                                <tr>
                                    <th>이메일</th>
                                    <td>
                                        ${fn:escapeXml(user.email)}
                                        <c:if test="${user.emailVerified == 'Y'}">
                                            <span class="badge-status badge-status-active" style="margin-left:6px;">인증완료</span>
                                        </c:if>
                                    </td>
                                </tr>
                                <tr>
                                    <th>지역</th>
                                    <td>
                                        <c:choose>
                                            <c:when test="${not empty user.regionName}">${fn:escapeXml(user.regionName)}</c:when>
                                            <c:otherwise><span style="color: var(--admin-text-secondary);">미설정</span></c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                                <tr>
                                    <th>가입유형</th>
                                    <td><span class="badge-social">${user.socialType}</span></td>
                                </tr>
                                <tr>
                                    <th>가입일</th>
                                    <td>${fn:replace(fn:substring(user.createdAt.toString(), 0, 16), 'T', ' ')}</td>
                                </tr>
                                <tr>
                                    <th>현재 상태</th>
                                    <td>
                                        <div class="ud-status-cell">
                                            <c:choose>
                                                <c:when test="${user.status == 'ACTIVE'}">
                                                    <span class="badge-status badge-status-active">ACTIVE</span>
                                                </c:when>
                                                <c:when test="${user.status == 'SUSPENDED'}">
                                                    <span class="badge-status badge-status-suspended">SUSPENDED</span>
                                                </c:when>
                                                <c:when test="${user.status == 'WITHDRAWN'}">
                                                    <span class="badge-status badge-status-withdrawn">WITHDRAWN</span>
                                                </c:when>
                                            </c:choose>

                                            <c:if test="${(LOGIN_ADMIN.admin or LOGIN_ADMIN.superAdmin) and user.status != 'WITHDRAWN'}">
                                                <c:if test="${user.status == 'ACTIVE'}">
                                                    <form method="post"
                                                          action="/admin/users/${user.userId}/status"
                                                          onsubmit="return confirm('해당 회원을 정지하시겠습니까?');">
                                                        <input type="hidden" name="status" value="SUSPENDED">
                                                        <button type="submit" class="btn-admin-warning btn-admin-sm">정지</button>
                                                    </form>
                                                </c:if>
                                                <c:if test="${user.status == 'SUSPENDED'}">
                                                    <form method="post"
                                                          action="/admin/users/${user.userId}/status"
                                                          onsubmit="return confirm('해당 회원의 정지를 해제하시겠습니까?');">
                                                        <input type="hidden" name="status" value="ACTIVE">
                                                        <button type="submit" class="btn-admin-success btn-admin-sm">정지 해제</button>
                                                    </form>
                                                </c:if>
                                            </c:if>
                                        </div>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <!-- 하단: 보유 쿠폰 -->
            <div class="admin-card">
                <div class="admin-card-header">
                    <h2 class="admin-card-title">보유 쿠폰 (${userCoupons.size()}개)</h2>
                </div>

                <c:choose>
                    <c:when test="${empty userCoupons}">
                        <div class="admin-empty">보유한 쿠폰이 없습니다</div>
                    </c:when>
                    <c:otherwise>
                        <div class="admin-table-wrap">
                            <table class="admin-table">
                                <thead>
                                    <tr>
                                        <th style="width:60px;">No</th>
                                        <th>가맹점명</th>
                                        <th>쿠폰명</th>
                                        <th>혜택</th>
                                        <th>상태</th>
                                        <th>발급일</th>
                                        <th>사용일</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="uc" items="${userCoupons}" varStatus="loop">
                                        <tr style="cursor:pointer;"
                                            onclick="window.location.href='/admin/coupons/${uc.couponId}'">
                                            <td>${userCoupons.size() - loop.index}</td>
                                            <td>${fn:escapeXml(uc.storeName)}</td>
                                            <td>
                                                <a href="/admin/coupons/${uc.couponId}"
                                                   style="color:var(--admin-text-primary); font-weight:600;"
                                                   onclick="event.stopPropagation();">
                                                    ${fn:escapeXml(uc.couponName)}
                                                </a>
                                            </td>
                                            <td>${fn:escapeXml(uc.benefit)}</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${uc.status == 'AVAILABLE'}">
                                                        <span class="badge-status badge-status-active">사용가능</span>
                                                    </c:when>
                                                    <c:when test="${uc.status == 'USED'}">
                                                        <span class="badge-status badge-status-used">사용완료</span>
                                                    </c:when>
                                                    <c:when test="${uc.status == 'EXPIRED'}">
                                                        <span class="badge-status badge-status-withdrawn">만료</span>
                                                    </c:when>
                                                </c:choose>
                                            </td>
                                            <td>${fn:substring(uc.createdAt.toString(), 0, 10)}</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${uc.status == 'USED' and not empty uc.usedAt}">
                                                        ${fn:substring(uc.usedAt.toString(), 0, 10)}
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span style="color: var(--admin-text-secondary);">-</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>

        </div>
    </div>
</div>

</body>
</html>
