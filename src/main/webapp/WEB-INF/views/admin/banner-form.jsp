<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <jsp:include page="/WEB-INF/views/admin/common/_admin_meta.jsp">
        <jsp:param name="title" value="배너 등록"/>
    </jsp:include>
    <style>
        .bn-preview {
            width: 100%;
            max-width: 500px;
            aspect-ratio: 5 / 2;
            border-radius: var(--admin-radius-sm);
            background-color: var(--admin-bg);
            border: 1px dashed var(--admin-border);
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
            color: var(--admin-text-secondary);
            font-size: 13px;
        }
        .bn-preview img {
            width: 100%; height: 100%; object-fit: cover; display: block;
        }
    </style>
</head>
<body>

<div class="admin-layout">

    <jsp:include page="/WEB-INF/views/admin/common/_admin_sidebar.jsp"/>

    <div class="admin-main">

        <jsp:include page="/WEB-INF/views/admin/common/_admin_header.jsp">
            <jsp:param name="title" value="배너 등록"/>
        </jsp:include>

        <div class="admin-content">

            <c:if test="${param.msg == 'error'}">
                <div class="admin-form-error" style="margin-bottom:16px;">처리 중 오류가 발생했습니다</div>
            </c:if>

            <form id="bannerForm" method="post" action="/admin/banners/new" enctype="multipart/form-data" onsubmit="return validateForm();">

                <!-- 이미지 -->
                <div class="admin-card">
                    <div class="admin-card-header">
                        <h2 class="admin-card-title">배너 이미지</h2>
                        <div style="display:flex; gap:8px;">
                            <a href="/admin/banners" class="btn-admin-secondary btn-admin-sm">취소</a>
                            <button type="submit" class="btn-admin-primary btn-admin-sm">등록</button>
                        </div>
                    </div>

                    <div id="bnPreview" class="bn-preview">미리보기 (5:2 비율, 800×320 자동 리사이즈)</div>
                    <div style="margin-top:12px;">
                        <input type="file" name="image" id="image" accept="image/*" required onchange="previewImage(this)">
                        <p style="margin-top:8px; font-size:12px; color:var(--admin-text-secondary);">
                            업로드 시 자동으로 800×320 크기로 리사이즈됩니다 / 최대 5MB
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
                        <input type="text" name="title" id="title" class="admin-input" required maxlength="100">
                    </div>

                    <div class="admin-form-row">
                        <div class="admin-form-group">
                            <label class="admin-label">노출 시작일</label>
                            <input type="date" name="startDate" id="startDate" class="admin-input" onchange="syncEndMin()">
                            <p style="margin-top:6px; font-size:12px; color:var(--admin-text-secondary);">미선택 시 즉시 노출</p>
                        </div>
                        <div class="admin-form-group">
                            <label class="admin-label">노출 종료일</label>
                            <input type="date" name="endDate" id="endDate" class="admin-input">
                            <p style="margin-top:6px; font-size:12px; color:var(--admin-text-secondary);">미선택 시 무기한 노출</p>
                        </div>
                    </div>

                    <div class="admin-form-row">
                        <div class="admin-form-group">
                            <label class="admin-label">노출 순서</label>
                            <input type="number" name="displayOrder" class="admin-input" value="0">
                            <p style="margin-top:6px; font-size:12px; color:var(--admin-text-secondary);">낮을수록 먼저 노출</p>
                        </div>
                        <div class="admin-form-group">
                            <label class="admin-label">활성여부</label>
                            <select name="isActive" class="admin-select">
                                <option value="1">활성</option>
                                <option value="0">비활성</option>
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
                            <option value="NONE">링크 없음</option>
                            <option value="STORE">가맹점 연결</option>
                            <option value="COUPON">쿠폰 연결</option>
                        </select>
                    </div>

                    <div class="admin-form-group" id="storeGroup" style="display:none;">
                        <label class="admin-label">가맹점 선택</label>
                        <select name="linkValueStore" id="linkValueStore" class="admin-select">
                            <option value="">선택</option>
                            <c:forEach var="s" items="${activeStores}">
                                <option value="${s.storeId}">${fn:escapeXml(s.storeName)}<c:if test="${not empty s.regionName}"> (${fn:escapeXml(s.regionName)})</c:if></option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="admin-form-group" id="couponGroup" style="display:none;">
                        <label class="admin-label">쿠폰 선택</label>
                        <select name="linkValueCoupon" id="linkValueCoupon" class="admin-select">
                            <option value="">선택</option>
                            <c:forEach var="c" items="${activeCoupons}">
                                <option value="${c.couponId}">${fn:escapeXml(c.storeName)} - ${fn:escapeXml(c.couponName)}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <input type="hidden" name="linkValue" id="linkValue" value="">
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
        if (!f.image.files[0])     { alert('배너 이미지를 선택하세요'); return false; }
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
</script>

</body>
</html>
