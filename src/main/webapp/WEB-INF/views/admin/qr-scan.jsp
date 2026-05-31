<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <jsp:include page="/WEB-INF/views/admin/common/_admin_meta.jsp">
        <jsp:param name="title" value="QR 쿠폰 스캔"/>
    </jsp:include>
    <style>
        .qr-stage {
            position: relative;
            max-width: 480px;
            margin: 0 auto;
            background-color: #0f172a;
            border-radius: var(--admin-radius);
            overflow: hidden;
            aspect-ratio: 1 / 1;
        }
        .qr-stage video {
            width: 100%; height: 100%; object-fit: cover; display: block;
        }
        .qr-stage canvas { display: none; }
        .qr-frame {
            position: absolute; inset: 14%;
            border: 3px solid rgba(255, 214, 10, 0.9);
            border-radius: 12px;
            pointer-events: none;
            box-shadow: 0 0 0 9999px rgba(0,0,0,0.35);
        }
        .qr-placeholder {
            position: absolute; inset: 0;
            display: flex; align-items: center; justify-content: center;
            color: #94a3b8; font-size: 14px;
        }
        .qr-controls {
            display: flex; gap: 10px; justify-content: center;
            margin-top: 16px; flex-wrap: wrap;
        }
        .qr-result {
            margin-top: 20px;
            display: none;
        }
        .qr-result.is-visible { display: block; }
        .qr-status-line {
            display: flex; align-items: center; gap: 10px;
            margin-bottom: 12px;
        }
        .qr-error {
            margin-top: 16px;
            padding: 12px 14px;
            background-color: var(--admin-danger-bg);
            color: var(--admin-danger);
            border: 1px solid #fecaca;
            border-radius: var(--admin-radius-sm);
            font-size: 13px;
            display: none;
        }
        .qr-error.is-visible { display: block; }
        .qr-success-banner {
            background-color: var(--admin-success-bg);
            color: var(--admin-success);
            border: 1px solid #a7f3d0;
            border-radius: var(--admin-radius);
            padding: 16px;
            text-align: center;
            font-size: 16px;
            font-weight: 700;
            margin-top: 12px;
            display: none;
        }
        .qr-success-banner.is-visible { display: block; }
    </style>
</head>
<body>

<div class="admin-layout">

    <jsp:include page="/WEB-INF/views/admin/common/_admin_sidebar.jsp"/>

    <div class="admin-main">

        <jsp:include page="/WEB-INF/views/admin/common/_admin_header.jsp">
            <jsp:param name="title" value="QR 쿠폰 스캔"/>
        </jsp:include>

        <div class="admin-content">

            <div class="admin-card">
                <div class="admin-card-header">
                    <h2 class="admin-card-title">QR 스캔</h2>
                </div>

                <div class="qr-stage" id="qrStage">
                    <div class="qr-placeholder" id="qrPlaceholder">"카메라 시작"을 눌러 스캔을 시작하세요</div>
                    <video id="qrVideo" playsinline style="display:none;"></video>
                    <canvas id="qrCanvas"></canvas>
                    <div class="qr-frame" id="qrFrame" style="display:none;"></div>
                </div>

                <div class="qr-controls">
                    <button type="button" id="btnStart" class="btn-admin-primary">카메라 시작</button>
                    <button type="button" id="btnStop"  class="btn-admin-secondary" style="display:none;">카메라 중지</button>
                </div>

                <div class="qr-error" id="qrError"></div>
            </div>

            <div class="qr-result admin-card" id="qrResult">
                <div class="admin-card-header">
                    <h2 class="admin-card-title">스캔 결과</h2>
                </div>

                <table class="admin-info-list">
                    <tbody>
                        <tr><th>가맹점</th><td id="rStore">-</td></tr>
                        <tr><th>쿠폰명</th><td id="rCoupon">-</td></tr>
                        <tr><th>혜택</th><td id="rBenefit">-</td></tr>
                        <tr><th>고객</th><td id="rUser">-</td></tr>
                        <tr><th>만료일</th><td id="rExpire">-</td></tr>
                        <tr><th>상태</th><td id="rStatus">-</td></tr>
                    </tbody>
                </table>

                <div class="qr-success-banner" id="qrSuccessBanner">✅ 사용 완료!</div>

                <div class="admin-form-actions">
                    <button type="button" id="btnAgain" class="btn-admin-secondary">다시 스캔</button>
                    <button type="button" id="btnUse"   class="btn-admin-success">사용 처리</button>
                </div>
            </div>

        </div>
    </div>
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/jsQR/1.4.0/jsQR.min.js"></script>
<script>
    var video = document.getElementById('qrVideo');
    var canvas = document.getElementById('qrCanvas');
    var ctx = canvas.getContext('2d', { willReadFrequently: true });
    var stream = null;
    var scanning = false;
    var rafId = null;
    var currentUserCouponId = null;

    var ph = document.getElementById('qrPlaceholder');
    var frame = document.getElementById('qrFrame');
    var btnStart = document.getElementById('btnStart');
    var btnStop  = document.getElementById('btnStop');
    var btnAgain = document.getElementById('btnAgain');
    var btnUse   = document.getElementById('btnUse');
    var errorBox = document.getElementById('qrError');
    var resultCard = document.getElementById('qrResult');
    var successBanner = document.getElementById('qrSuccessBanner');

    function showError(msg) {
        errorBox.textContent = msg;
        errorBox.classList.add('is-visible');
    }
    function clearError() {
        errorBox.classList.remove('is-visible');
        errorBox.textContent = '';
    }

    async function startCamera() {
        clearError();
        resultCard.classList.remove('is-visible');
        successBanner.classList.remove('is-visible');
        try {
            stream = await navigator.mediaDevices.getUserMedia({
                video: { facingMode: 'environment' }
            });
        } catch (e) {
            showError('카메라 권한이 필요합니다. 브라우저 설정에서 카메라를 허용해주세요.');
            return;
        }
        video.srcObject = stream;
        await video.play();

        video.style.display = 'block';
        ph.style.display = 'none';
        frame.style.display = 'block';
        btnStart.style.display = 'none';
        btnStop.style.display  = '';

        scanning = true;
        tick();
    }

    function stopCamera() {
        scanning = false;
        if (rafId) cancelAnimationFrame(rafId);
        if (stream) {
            stream.getTracks().forEach(function (t) { t.stop(); });
            stream = null;
        }
        video.pause();
        video.srcObject = null;
        video.style.display = 'none';
        ph.style.display = 'flex';
        frame.style.display = 'none';
        btnStart.style.display = '';
        btnStop.style.display  = 'none';
    }

    function tick() {
        if (!scanning) return;
        if (video.readyState === video.HAVE_ENOUGH_DATA) {
            canvas.width = video.videoWidth;
            canvas.height = video.videoHeight;
            ctx.drawImage(video, 0, 0, canvas.width, canvas.height);
            var img = ctx.getImageData(0, 0, canvas.width, canvas.height);
            var code = jsQR(img.data, img.width, img.height, { inversionAttempts: 'dontInvert' });
            if (code && code.data) {
                onDetected(code.data);
                return;
            }
        }
        rafId = requestAnimationFrame(tick);
    }

    async function onDetected(text) {
        scanning = false;
        if (rafId) cancelAnimationFrame(rafId);
        try {
            var form = new FormData();
            form.append('couponCode', text);
            var res = await fetch('/admin/qr-scan/validate', { method: 'POST', body: form });
            var data = await res.json();
            if (!data.success) {
                showError(data.message || '유효하지 않은 쿠폰입니다');
                stopCamera();
                return;
            }
            renderResult(data);
        } catch (e) {
            showError('검증 중 오류가 발생했습니다');
        }
        stopCamera();
    }

    function renderResult(data) {
        document.getElementById('rStore').textContent   = data.storeName || '-';
        document.getElementById('rCoupon').textContent  = data.couponName || '-';
        document.getElementById('rBenefit').textContent = data.benefit || '-';
        document.getElementById('rUser').textContent    = data.userNickname || '-';
        document.getElementById('rExpire').textContent  = data.expireDate || '-';

        var statusEl = document.getElementById('rStatus');
        if (data.status === 'AVAILABLE') {
            statusEl.innerHTML = '<span class="badge-status badge-status-active">사용가능</span>';
            btnUse.disabled = false;
        } else if (data.status === 'USED') {
            statusEl.innerHTML = '<span class="badge-status badge-status-used">사용완료</span>';
            btnUse.disabled = true;
        } else {
            statusEl.innerHTML = '<span class="badge-status badge-status-withdrawn">만료</span>';
            btnUse.disabled = true;
        }

        currentUserCouponId = data.userCouponId;
        resultCard.classList.add('is-visible');
        successBanner.classList.remove('is-visible');
    }

    async function useCoupon() {
        if (!currentUserCouponId) return;
        btnUse.disabled = true;
        try {
            var form = new FormData();
            form.append('userCouponId', currentUserCouponId);
            var res = await fetch('/admin/qr-scan/use', { method: 'POST', body: form });
            var data = await res.json();
            if (data.success) {
                successBanner.classList.add('is-visible');
                document.getElementById('rStatus').innerHTML =
                    '<span class="badge-status badge-status-used">사용완료</span>';
            } else {
                showError(data.message || '사용 처리 실패');
                btnUse.disabled = false;
            }
        } catch (e) {
            showError('사용 처리 중 오류가 발생했습니다');
            btnUse.disabled = false;
        }
    }

    btnStart.addEventListener('click', startCamera);
    btnStop.addEventListener('click', stopCamera);
    btnUse.addEventListener('click', useCoupon);
    btnAgain.addEventListener('click', function () {
        resultCard.classList.remove('is-visible');
        successBanner.classList.remove('is-visible');
        currentUserCouponId = null;
        startCamera();
    });
</script>

</body>
</html>
