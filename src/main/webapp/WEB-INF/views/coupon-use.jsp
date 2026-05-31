<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <%@ include file="/WEB-INF/views/common/_meta.jsp" %>
    <title>쿠폰 사용 - Couzl</title>
    <link rel="stylesheet" href="/static/css/coupon-use.css">
</head>
<body>
<div class="wrap">

    <!-- 1. 상단 헤더 -->
    <div class="cu-header">
        <button class="cu-btn-back" onclick="goTo('/coupon-box')">&#8592;</button>
        <span class="cu-header-title">쿠폰 사용</span>
        <div class="cu-header-right"></div>
    </div>

    <!-- 2. 쿠폰 정보 카드 -->
    <div class="cu-section">
        <div class="cu-coupon-card">
            <p class="cu-store-name">${fn:escapeXml(userCoupon.storeName)}</p>
            <p class="cu-coupon-name">${fn:escapeXml(userCoupon.couponName)}</p>
            <p class="cu-benefit">${fn:escapeXml(userCoupon.benefit)}</p>
            <div class="cu-meta-row">
                <span class="cu-expire">~${userCoupon.expireDate}</span>
                <c:if test="${not empty userCoupon.conditionText}">
                    <span class="cu-condition">${fn:escapeXml(userCoupon.conditionText)}</span>
                </c:if>
            </div>
        </div>
    </div>

    <!-- 3. QR 코드 영역 -->
    <div class="cu-section">
        <div class="cu-qr-card">
            <c:choose>
                <c:when test="${userCoupon.status == 'AVAILABLE'}">
                    <div id="qrcode" class="cu-qr-box"></div>
                    <p class="cu-qr-guide">가맹점 직원에게 QR을 보여주세요</p>
                </c:when>
                <c:when test="${userCoupon.status == 'USED'}">
                    <div id="qrcode" class="cu-qr-box" style="opacity:0.25;"></div>
                    <p class="cu-qr-guide" style="color:#2563eb; font-weight:700;">이미 사용된 쿠폰입니다</p>
                </c:when>
                <c:otherwise>
                    <div id="qrcode" class="cu-qr-box" style="opacity:0.25;"></div>
                    <p class="cu-qr-guide" style="color:#FF3B30; font-weight:700;">만료된 쿠폰입니다</p>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <!-- 4. 유의사항 -->
    <div class="cu-section" style="padding-top: 16px;">
        <ul class="cu-notice-list">
            <li>QR코드는 1회만 사용 가능합니다</li>
            <li>유효기간 내에만 사용 가능합니다</li>
        </ul>
    </div>

    <!-- 5. 하단 탭바 -->
    <jsp:include page="/WEB-INF/views/common/_tab_bar.jsp"/>

</div>
<script src="https://cdnjs.cloudflare.com/ajax/libs/qrcodejs/1.0.0/qrcode.min.js"></script>
<script src="/static/js/common.js"></script>
<script>
    (function () {
        var box = document.getElementById('qrcode');
        if (!box) return;
        new QRCode(box, {
            text: '${userCoupon.couponCode}',
            width: 200,
            height: 200,
            correctLevel: QRCode.CorrectLevel.M
        });
    })();
</script>
</body>
</html>
