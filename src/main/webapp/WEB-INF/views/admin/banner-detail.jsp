<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <jsp:include page="/WEB-INF/views/admin/common/_admin_meta.jsp">
        <jsp:param name="title" value="배너 상세"/>
    </jsp:include>
    <style>
        .bn-preview {
            width: 100%;
            max-width: 500px;
            aspect-ratio: 5 / 2;
            border-radius: var(--admin-radius-sm);
            background-color: var(--admin-bg);
            border: 1px solid var(--admin-border);
            overflow: hidden;
        }
        .bn-preview img { width:100%; height:100%; object-fit:cover; display:block; }
    </style>
</head>
<body>

<div class="admin-layout">

    <jsp:include page="/WEB-INF/views/admin/common/_admin_sidebar.jsp"/>

    <div class="admin-main">

        <jsp:include page="/WEB-INF/views/admin/common/_admin_header.jsp">
            <jsp:param name="title" value="배너 상세"/>
        </jsp:include>

        <div class="admin-content">

            <c:if test="${param.msg == 'updated'}">
                <div class="admin-form-success" style="margin-bottom:16px;">수정되었습니다</div>
            </c:if>
            <c:if test="${param.msg == 'error'}">
                <div class="admin-form-error" style="margin-bottom:16px;">처리 중 오류가 발생했습니다</div>
            </c:if>

            <form id="bannerForm" method="post" action="/admin/banners/${banner.bannerId}" enctype="multipart/form-data" onsubmit="return validateForm();">

                <!-- 이미지 -->
                <div class="admin-card">
                    <div class="admin-card-header">
                        <h2 class="admin-card-title">배너 이미지</h2>
                        <div style="display:flex; gap:8px;">
                            <a href="/admin/banners" class="btn-admin-secondary btn-admin-sm">목록으로</a>
                            <button type="submit" class="btn-admin-primary btn-admin-sm">수정 저장</button>
                        </div>
                    </div>

                    <div id="bnPreview" class="bn-preview">
                        <img src="/admin/banners/${banner.bannerId}/image" alt="배너">
                    </div>
                    <div style="margin-top:12px;">
                        <input type="file" name="image" id="image" accept="image/*" onchange="previewImage(this)">
                        <p style="margin-top:8px; font-size:12px; color:var(--admin-text-secondary);">
                            변경 시 자동으로 800×320 크기로 리사이즈됩니다 / 최대 5MB
                        </p>
                    </div>
                </div>

                <!-- 배너 정보 -->
                <div class="admin-card">
                    <div class="admin-card-header">
                        <h2 class="admin-card-title">배너 정보</h2>
                    </div>

                    <div class="admin-form-group">
                        <label class="admin-label">관리용 제목 <span style="color:var(--admin-danger);">*</span></label>
                        <input type="text" name="title" id="title" class="admin-input" required maxlength="100"
                               value="${fn:escapeXml(banner.title)}">
                    </div>

                    <div class="admin-form-row">
                        <div class="admin-form-group">
                            <label class="admin-label">노출 시작일</label>
                            <input type="date" name="startDate" id="startDate" class="admin-input"
                                   value="${banner.startDate}" onchange="syncEndMin()">
                        </div>
                        <div class="admin-form-group">
                            <label class="admin-label">노출 종료일</label>
                            <input type="date" name="endDate" id="endDate" class="admin-input"
                                   value="${banner.endDate}">
                        </div>
                    </div>

                    <div class="admin-form-row">
                        <div class="admin-form-group">
                            <label class="admin-label">노출 순서</label>
                            <input type="number" name="displayOrder" class="admin-input" value="${banner.displayOrder}">
                        </div>
                        <div class="admin-form-group">
                            <label class="admin-label">활성여부</label>
                            <select name="isActive" class="admin-select">
                                <option value="1" ${banner.isActive == 1 ? 'selected' : ''}>활성</option>
                                <option value="0" ${banner.isActive == 0 ? 'selected' : ''}>비활성</option>
                            </select>
                        </div>
                    </div>
                </div>

                <!-- 링크 설정 -->
                <div class="admin-card">
                    <div class="admin-card-header">
                        <h2 class="admin-card-title">링크 설정</h2>
                    </div>

                    <div class="admin-form-group">
                        <label class="admin-label">링크 유형</label>
                        <select name="linkType" id="linkType" class="admin-select" onchange="toggleLink()">
                            <option value="NONE"   ${banner.linkType == 'NONE'   ? 'selected' : ''}>링크 없음</option>
                            <option value="STORE"  ${banner.linkType == 'STORE'  ? 'selected' : ''}>가맹점 연결</option>
                            <option value="COUPON" ${banner.linkType == 'COUPON' ? 'selected' : ''}>쿠폰 연결</option>
                        </select>
                    </div>

                    <div class="admin-form-group" id="storeGroup" style="${banner.linkType == 'STORE' ? '' : 'display:none;'}">
                        <label class="admin-label">가맹점 선택</label>
                        <select name="linkValueStore" id="linkValueStore" class="admin-select">
                            <option value="">선택</option>
                            <c:forEach var="s" items="${activeStores}">
                                <option value="${s.storeId}" ${banner.linkType == 'STORE' and banner.linkValue == s.storeId.toString() ? 'selected' : ''}>${fn:escapeXml(s.storeName)}<c:if test="${not empty s.regionName}"> (${fn:escapeXml(s.regionName)})</c:if></option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="admin-form-group" id="couponGroup" style="${banner.linkType == 'COUPON' ? '' : 'display:none;'}">
                        <label class="admin-label">쿠폰 선택</label>
                        <select name="linkValueCoupon" id="linkValueCoupon" class="admin-select">
                            <option value="">선택</option>
                            <c:forEach var="c" items="${activeCoupons}">
                                <option value="${c.couponId}" ${banner.linkType == 'COUPON' and banner.linkValue == c.couponId.toString() ? 'selected' : ''}>${fn:escapeXml(c.storeName)} - ${fn:escapeXml(c.couponName)}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <input type="hidden" name="linkValue" id="linkValue" value="${banner.linkValue}">
                </div>

            </form>
        </div>
    </div>
</div>

<script>
    function previewImage(input) {
        var file = input.files[0];
        if (!file) return;
        if (file.size > 5 * 1024 * 1024) {
            alert('이미지 크기는 5MB 이하만 가능합니다');
            input.value = '';
            return;
        }
        var reader = new FileReader();
        reader.onload = function (e) {
            document.getElementById('bnPreview').innerHTML =
                '<img src="' + e.target.result + '" alt="미리보기">';
        };
        reader.readAsDataURL(file);
    }

    function toggleLink() {
        var t = document.getElementById('linkType').value;
        document.getElementById('storeGroup').style.display  = (t === 'STORE')  ? '' : 'none';
        document.getElementById('couponGroup').style.display = (t === 'COUPON') ? '' : 'none';
    }

    function syncEndMin() {
        var start = document.getElementById('startDate').value;
        document.getElementById('endDate').min = start || '';
    }

    function validateForm() {
        var f = document.getElementById('bannerForm');
        if (!f.title.value.trim()) { alert('제목을 입력하세요'); return false; }

        var t = document.getElementById('linkType').value;
        var lv = '';
        if (t === 'STORE')  lv = document.getElementById('linkValueStore').value;
        if (t === 'COUPON') lv = document.getElementById('linkValueCoupon').value;
        if ((t === 'STORE' || t === 'COUPON') && !lv) {
            alert('링크 대상을 선택하세요');
            return false;
        }
        document.getElementById('linkValue').value = lv;

        var s = document.getElementById('startDate').value;
        var e = document.getElementById('endDate').value;
        if (s && e && s >= e) {
            alert('종료일은 시작일 이후로 설정하세요');
            return false;
        }
        return true;
    }
    // 초기화
    syncEndMin();
</script>

</body>
</html>
