<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <jsp:include page="/WEB-INF/views/admin/common/_admin_meta.jsp">
        <jsp:param name="title" value="쿠폰 등록"/>
    </jsp:include>
</head>
<body>

<div class="admin-layout">

    <jsp:include page="/WEB-INF/views/admin/common/_admin_sidebar.jsp"/>

    <div class="admin-main">

        <jsp:include page="/WEB-INF/views/admin/common/_admin_header.jsp">
            <jsp:param name="title" value="쿠폰 등록"/>
        </jsp:include>

        <div class="admin-content">

            <c:if test="${param.msg == 'error'}">
                <div class="admin-form-error" style="margin-bottom:16px;">처리 중 오류가 발생했습니다</div>
            </c:if>

            <form id="couponForm" method="post" action="/admin/coupons/new" onsubmit="return validateForm();">

                <!-- 기본정보 -->
                <div class="admin-card">
                    <div class="admin-card-header">
                        <h2 class="admin-card-title">기본 정보</h2>
                        <div style="display:flex; gap:8px;">
                            <a href="/admin/coupons" class="btn-admin-secondary btn-admin-sm">취소</a>
                            <button type="submit" class="btn-admin-primary btn-admin-sm">등록</button>
                        </div>
                    </div>

                    <div class="admin-form-group">
                        <label class="admin-label">가맹점 <span style="color:var(--admin-danger);">*</span></label>
                        <c:choose>
                            <c:when test="${LOGIN_ADMIN.storeOwner}">
                                <input type="text" class="admin-input" readonly
                                       value="${fn:escapeXml(LOGIN_ADMIN.storeName)}"
                                       style="background-color:var(--admin-bg);">
                            </c:when>
                            <c:otherwise>
                                <select name="storeId" class="admin-select" required>
                                    <option value="">선택</option>
                                    <c:forEach var="s" items="${activeStores}">
                                        <option value="${s.storeId}">${fn:escapeXml(s.storeName)}<c:if test="${not empty s.regionName}"> (${fn:escapeXml(s.regionName)})</c:if></option>
                                    </c:forEach>
                                </select>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <div class="admin-form-row">
                        <div class="admin-form-group">
                            <label class="admin-label">쿠폰명 <span style="color:var(--admin-danger);">*</span></label>
                            <input type="text" name="couponName" class="admin-input" required maxlength="100">
                        </div>
                        <div class="admin-form-group">
                            <label class="admin-label">만료일 <span style="color:var(--admin-danger);">*</span></label>
                            <input type="date" name="expireDate" id="expireDate" class="admin-input" required>
                        </div>
                    </div>

                    <div class="admin-form-group">
                        <label class="admin-label">혜택 내용 <span style="color:var(--admin-danger);">*</span></label>
                        <input type="text" name="benefit" class="admin-input" required maxlength="200"
                               placeholder="예) 아메리카노 1잔 무료">
                    </div>

                    <div class="admin-form-group">
                        <label class="admin-label">사용 조건</label>
                        <input type="text" name="conditionText" class="admin-input" maxlength="200"
                               placeholder="예) 1만원 이상 구매 시">
                    </div>
                </div>

                <!-- 수량 -->
                <div class="admin-card">
                    <div class="admin-card-header">
                        <h2 class="admin-card-title">수량 설정</h2>
                    </div>

                    <div class="admin-form-group">
                        <label style="display:inline-flex; align-items:center; gap:8px; cursor:pointer;">
                            <input type="checkbox" name="isUnlimited" id="isUnlimited" onchange="toggleUnlimited()">
                            <span><strong>무제한</strong> 발급</span>
                        </label>
                    </div>

                    <div class="admin-form-group">
                        <label class="admin-label">발급 수량</label>
                        <input type="number" name="totalCount" id="totalCount" class="admin-input" min="1" value="100">
                        <p style="margin-top:6px; font-size:12px; color:var(--admin-text-secondary);">
                            0 입력 불가 — 무제한은 위 체크박스를 사용하세요
                        </p>
                    </div>

                    <div class="admin-form-group">
                        <label class="admin-label">인당 최대 발급 수</label>
                        <input type="number" name="maxPerUser" class="admin-input" min="1" value="1">
                        <p style="margin-top:6px; font-size:12px; color:var(--admin-text-secondary);">
                            1인당 발급받을 수 있는 최대 수량입니다
                        </p>
                    </div>
                </div>

            </form>
        </div>
    </div>
</div>

<script>
    // 만료일 min을 오늘로 설정
    (function () {
        var d = new Date();
        var iso = d.getFullYear() + '-'
            + String(d.getMonth() + 1).padStart(2, '0') + '-'
            + String(d.getDate()).padStart(2, '0');
        document.getElementById('expireDate').min = iso;
    })();

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
        <c:if test="${!LOGIN_ADMIN.storeOwner}">
        if (!f.storeId.value) { alert('가맹점을 선택하세요'); return false; }
        </c:if>
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
