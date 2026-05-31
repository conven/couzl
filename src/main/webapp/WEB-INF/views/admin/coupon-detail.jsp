<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <jsp:include page="/WEB-INF/views/admin/common/_admin_meta.jsp">
        <jsp:param name="title" value="쿠폰 상세"/>
    </jsp:include>
</head>
<body>

<div class="admin-layout">

    <jsp:include page="/WEB-INF/views/admin/common/_admin_sidebar.jsp"/>

    <div class="admin-main">

        <jsp:include page="/WEB-INF/views/admin/common/_admin_header.jsp">
            <jsp:param name="title" value="쿠폰 상세"/>
        </jsp:include>

        <div class="admin-content">

            <c:if test="${param.msg == 'updated'}">
                <div class="admin-form-success" style="margin-bottom:16px;">수정되었습니다</div>
            </c:if>
            <c:if test="${param.msg == 'error'}">
                <div class="admin-form-error" style="margin-bottom:16px;">처리 중 오류가 발생했습니다</div>
            </c:if>

            <form id="couponForm" method="post" action="/admin/coupons/${coupon.couponId}" onsubmit="return validateForm();">

                <!-- 기본정보 (수정 가능) -->
                <div class="admin-card">
                    <div class="admin-card-header">
                        <h2 class="admin-card-title">기본 정보</h2>
                        <div style="display:flex; gap:8px;">
                            <a href="/admin/coupons" class="btn-admin-secondary btn-admin-sm">목록으로</a>
                            <button type="submit" class="btn-admin-primary btn-admin-sm">수정 저장</button>
                        </div>
                    </div>

                    <div class="admin-form-group">
                        <label class="admin-label">가맹점</label>
                        <input type="text" class="admin-input" readonly
                               value="${fn:escapeXml(coupon.storeName)}<c:if test='${not empty coupon.regionName}'> (${fn:escapeXml(coupon.regionName)})</c:if>"
                               style="background-color:var(--admin-bg);">
                    </div>

                    <div class="admin-form-row">
                        <div class="admin-form-group">
                            <label class="admin-label">쿠폰명 <span style="color:var(--admin-danger);">*</span></label>
                            <input type="text" name="couponName" class="admin-input" required maxlength="100"
                                   value="${fn:escapeXml(coupon.couponName)}">
                        </div>
                        <div class="admin-form-group">
                            <label class="admin-label">만료일 <span style="color:var(--admin-danger);">*</span></label>
                            <input type="date" name="expireDate" id="expireDate" class="admin-input" required
                                   value="${coupon.expireDate}">
                        </div>
                    </div>

                    <div class="admin-form-group">
                        <label class="admin-label">혜택 내용 <span style="color:var(--admin-danger);">*</span></label>
                        <input type="text" name="benefit" class="admin-input" required maxlength="200"
                               value="${fn:escapeXml(coupon.benefit)}">
                    </div>

                    <div class="admin-form-group">
                        <label class="admin-label">사용 조건</label>
                        <input type="text" name="conditionText" class="admin-input" maxlength="200"
                               value="${fn:escapeXml(coupon.conditionText)}">
                    </div>
                </div>

                <!-- 수량 -->
                <div class="admin-card">
                    <div class="admin-card-header">
                        <h2 class="admin-card-title">수량 설정</h2>
                    </div>

                    <div class="admin-form-group">
                        <label style="display:inline-flex; align-items:center; gap:8px; cursor:pointer;">
                            <input type="checkbox" name="isUnlimited" id="isUnlimited"
                                   ${coupon.totalCount == 0 ? 'checked' : ''}
                                   onchange="toggleUnlimited()">
                            <span><strong>무제한</strong> 발급</span>
                        </label>
                    </div>

                    <div class="admin-form-group">
                        <label class="admin-label">발급 수량</label>
                        <input type="number" name="totalCount" id="totalCount" class="admin-input"
                               min="1"
                               value="${coupon.totalCount == 0 ? 100 : coupon.totalCount}">
                        <p style="margin-top:6px; font-size:12px; color:var(--admin-text-secondary);">
                            이미 발급된 수량(${coupon.issuedCount}개)보다 적게 설정할 수 없습니다.
                        </p>
                    </div>

                    <div class="admin-form-group">
                        <label class="admin-label">인당 최대 발급 수</label>
                        <input type="number" name="maxPerUser" class="admin-input" min="1"
                               value="${empty coupon.maxPerUser ? 1 : coupon.maxPerUser}">
                        <p style="margin-top:6px; font-size:12px; color:var(--admin-text-secondary);">
                            1인당 발급받을 수 있는 최대 수량입니다
                        </p>
                    </div>
                </div>

            </form>

            <!-- 발급 현황 (읽기전용) -->
            <div class="admin-card">
                <div class="admin-card-header">
                    <h2 class="admin-card-title">발급 현황</h2>
                </div>
                <table class="admin-info-list">
                    <tbody>
                        <tr>
                            <th>총 수량</th>
                            <td>
                                <c:choose>
                                    <c:when test="${coupon.totalCount == 0}">
                                        <span style="color:#2563eb; font-weight:600;">∞ 무제한</span>
                                    </c:when>
                                    <c:otherwise>${coupon.totalCount}개</c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                        <tr>
                            <th>발급된 수량</th>
                            <td>${coupon.issuedCount}개</td>
                        </tr>
                        <tr>
                            <th>잔여 수량</th>
                            <td>
                                <c:choose>
                                    <c:when test="${coupon.totalCount == 0}">
                                        <span style="color:#2563eb; font-weight:600;">∞ 무제한</span>
                                    </c:when>
                                    <c:otherwise>${coupon.remainCount}개</c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                        <tr>
                            <th>등록일</th>
                            <td>${fn:replace(fn:substring(coupon.createdAt.toString(), 0, 16), 'T', ' ')}</td>
                        </tr>
                        <tr>
                            <th>최종 수정</th>
                            <td>${fn:replace(fn:substring(coupon.updatedAt.toString(), 0, 16), 'T', ' ')}</td>
                        </tr>
                    </tbody>
                </table>
            </div>

            <!-- 발급 받은 사용자 -->
            <div class="admin-card">
                <div class="admin-card-header">
                    <h2 class="admin-card-title">발급 받은 사용자 (${issuedUsers.size()}명)</h2>
                </div>

                <c:choose>
                    <c:when test="${empty issuedUsers}">
                        <div class="admin-empty">아직 발급 받은 사용자가 없습니다</div>
                    </c:when>
                    <c:otherwise>
                        <div class="admin-table-wrap">
                            <table class="admin-table">
                                <thead>
                                    <tr>
                                        <th style="width:60px;">No</th>
                                        <th>아이디</th>
                                        <th>닉네임</th>
                                        <th>이메일</th>
                                        <th>상태</th>
                                        <th>발급일</th>
                                        <th>사용일</th>
                                        <th style="width:80px;">회원</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="iu" items="${issuedUsers}" varStatus="loop">
                                        <tr>
                                            <td>${issuedUsers.size() - loop.index}</td>
                                            <td><strong>${fn:escapeXml(iu.userLoginId)}</strong></td>
                                            <td>${fn:escapeXml(iu.userNickname)}</td>
                                            <td>${fn:escapeXml(iu.userEmail)}</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${iu.status == 'AVAILABLE'}">
                                                        <span class="badge-status badge-status-active">사용가능</span>
                                                    </c:when>
                                                    <c:when test="${iu.status == 'USED'}">
                                                        <span class="badge-status badge-status-used">사용완료</span>
                                                    </c:when>
                                                    <c:when test="${iu.status == 'EXPIRED'}">
                                                        <span class="badge-status badge-status-withdrawn">만료</span>
                                                    </c:when>
                                                </c:choose>
                                            </td>
                                            <td>${fn:substring(iu.createdAt.toString(), 0, 10)}</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${iu.status == 'USED' and not empty iu.usedAt}">
                                                        ${fn:substring(iu.usedAt.toString(), 0, 10)}
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span style="color:var(--admin-text-secondary);">-</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <c:if test="${LOGIN_ADMIN.admin or LOGIN_ADMIN.superAdmin}">
                                                    <a href="/admin/users/${iu.userId}" class="btn-admin-secondary btn-admin-sm">상세</a>
                                                </c:if>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- 상태 관리 -->
            <div class="admin-card">
                <div class="admin-card-header">
                    <h2 class="admin-card-title">상태 관리</h2>
                </div>

                <div style="display:flex; gap:16px; align-items:center; flex-wrap:wrap;">
                    <c:choose>
                        <c:when test="${coupon.status == 'ACTIVE'}">
                            <span class="badge-status badge-status-lg badge-status-active">ACTIVE</span>
                            <form method="post" action="/admin/coupons/${coupon.couponId}/status"
                                  onsubmit="return confirm('쿠폰을 비활성화하면 더 이상 발급되지 않습니다. 계속하시겠습니까?');">
                                <input type="hidden" name="status" value="INACTIVE">
                                <button type="submit" class="btn-admin-secondary">비활성화</button>
                            </form>
                        </c:when>
                        <c:otherwise>
                            <span class="badge-status badge-status-lg badge-status-withdrawn">INACTIVE</span>
                            <form method="post" action="/admin/coupons/${coupon.couponId}/status"
                                  onsubmit="return confirm('쿠폰을 활성화하시겠습니까?');">
                                <input type="hidden" name="status" value="ACTIVE">
                                <button type="submit" class="btn-admin-success">활성화</button>
                            </form>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

        </div>
    </div>
</div>

<script>
    (function () { toggleUnlimited(); })();

    function toggleUnlimited() {
        var chk = document.getElementById('isUnlimited');
        var input = document.getElementById('totalCount');
        if (chk.checked) {
            input.disabled = true;
            input.style.backgroundColor = 'var(--admin-bg)';
            input.style.color = 'var(--admin-text-secondary)';
        } else {
            input.disabled = false;
            input.style.backgroundColor = '';
            input.style.color = '';
        }
    }

    function validateForm() {
        var f = document.getElementById('couponForm');
        if (!f.couponName.value.trim()) { alert('쿠폰명을 입력하세요'); return false; }
        if (!f.benefit.value.trim())    { alert('혜택 내용을 입력하세요'); return false; }
        if (!f.expireDate.value)        { alert('만료일을 선택하세요'); return false; }

        if (!document.getElementById('isUnlimited').checked) {
            var n = parseInt(f.totalCount.value, 10);
            if (!n || n < 1) {
                alert('발급 수량은 1 이상이어야 합니다');
                return false;
            }
        }
        return true;
    }
</script>

</body>
</html>
