// ===== 탭 전환 =====
function switchDetailTab(el) {
    document.querySelectorAll('.tab-menu-item').forEach(function (t) {
        t.classList.remove('active');
    });
    document.querySelectorAll('.tab-content').forEach(function (c) {
        c.classList.remove('active');
    });
    el.classList.add('active');
    document.getElementById(el.dataset.tab).classList.add('active');

    if (el.dataset.tab === 'tab-info') {
        initStoreMap();
    }
}

// ===== 토스트 =====
function showToast(message, type) {
    var prev = document.getElementById('toast');
    if (prev) prev.remove();

    var toast = document.createElement('div');
    toast.id = 'toast';
    toast.className = 'cz-toast';

    var body = document.createElement('div');
    body.className = 'cz-toast-body ' + (type || 'success');
    body.textContent = message;

    toast.appendChild(body);
    document.body.appendChild(toast);

    setTimeout(function () {
        toast.classList.add('cz-toast-hide');
        setTimeout(function () {
            if (toast.parentNode) toast.parentNode.removeChild(toast);
        }, 350);
    }, 2000);
}

// ===== 가맹점 데이터 =====
function getStoreCtx() {
    var b = document.body;
    return {
        storeId:   b.dataset.storeId,
        name:      b.dataset.storeName  || '',
        address:   b.dataset.storeAddress || '',
        lat:       parseFloat(b.dataset.storeLat),
        lng:       parseFloat(b.dataset.storeLng),
        kakaoKey:  b.dataset.kakaoKey || ''
    };
}

function hasCoords(ctx) {
    return !isNaN(ctx.lat) && !isNaN(ctx.lng);
}

// ===== 길찾기 바텀시트 =====
function openLocationSheet() {
    var ctx = getStoreCtx();
    if (!hasCoords(ctx)) {
        showToast('위치 정보가 등록되지 않은 가맹점입니다', 'warning');
        return;
    }
    var overlay = document.getElementById('locationSheetOverlay');
    if (overlay) overlay.classList.add('active');
}

function closeLocationSheet() {
    var overlay = document.getElementById('locationSheetOverlay');
    if (overlay) overlay.classList.remove('active');
}

// ===== 앱 스킴 → 2초 내 미응답 시 웹 URL 폴백 =====
function tryAppOrWeb(appUrl, webUrl) {
    var start = Date.now();
    var timer = setTimeout(function () {
        // 앱 전환되면 page hidden → 타이머가 실행되어도 곧바로 폴백되지 않도록 visibility 체크
        if (document.hidden) return;
        if (Date.now() - start < 2200) {
            window.location.href = webUrl;
        }
    }, 2000);

    function onVisibility() {
        if (document.hidden) {
            clearTimeout(timer);
            document.removeEventListener('visibilitychange', onVisibility);
        }
    }
    document.addEventListener('visibilitychange', onVisibility);

    window.location.href = appUrl;
}

function openExternalMap(type) {
    var ctx = getStoreCtx();
    if (!hasCoords(ctx)) {
        showToast('위치 정보가 등록되지 않은 가맹점입니다', 'warning');
        return;
    }

    var name = encodeURIComponent(ctx.name || '가맹점');
    var lat  = ctx.lat;
    var lng  = ctx.lng;
    var appUrl, webUrl;

    if (type === 'kakaomap') {
        appUrl = 'kakaomap://look?p=' + lat + ',' + lng;
        webUrl = 'https://map.kakao.com/link/map/' + name + ',' + lat + ',' + lng;
    } else if (type === 'kakaonav') {
        appUrl = 'kakaomap://route?ep=' + lat + ',' + lng + '&by=CAR';
        webUrl = 'https://map.kakao.com/link/to/' + name + ',' + lat + ',' + lng;
    } else if (type === 'navermap') {
        appUrl = 'nmap://place?lat=' + lat + '&lng=' + lng + '&name=' + name + '&appname=com.couzl';
        webUrl = 'https://map.naver.com/v5/search/' + name;
    } else {
        return;
    }

    closeLocationSheet();
    tryAppOrWeb(appUrl, webUrl);
}

// ===== 공유 =====
function shareStore() {
    var ctx = getStoreCtx();
    var data = {
        title: ctx.name + ' - Couzl',
        text:  ctx.name + ' 가맹점 쿠폰을 확인해 보세요!',
        url:   window.location.href
    };

    if (navigator.share) {
        navigator.share(data).catch(function () { /* 사용자 취소 등 */ });
        return;
    }

    var url = window.location.href;
    if (navigator.clipboard && navigator.clipboard.writeText) {
        navigator.clipboard.writeText(url).then(function () {
            showToast('링크가 복사되었습니다', 'success');
        }).catch(function () {
            fallbackCopy(url);
        });
    } else {
        fallbackCopy(url);
    }
}

function fallbackCopy(text) {
    try {
        var ta = document.createElement('textarea');
        ta.value = text;
        ta.style.position = 'fixed';
        ta.style.left = '-9999px';
        document.body.appendChild(ta);
        ta.select();
        document.execCommand('copy');
        document.body.removeChild(ta);
        showToast('링크가 복사되었습니다', 'success');
    } catch (e) {
        showToast('공유를 지원하지 않는 환경입니다', 'warning');
    }
}

// ===== 카카오맵 (정보 탭) =====
var _mapInited = false;
function initStoreMap() {
    if (_mapInited) return;
    var container = document.getElementById('storeMap');
    if (!container) return;

    var ctx = getStoreCtx();
    if (!hasCoords(ctx)) return;

    if (typeof kakao === 'undefined' || !kakao.maps) return;

    kakao.maps.load(function () {
        var center = new kakao.maps.LatLng(ctx.lat, ctx.lng);
        var map = new kakao.maps.Map(container, {
            center: center,
            level: 4,
            draggable: true,
            zoomable: true
        });
        var marker = new kakao.maps.Marker({ position: center });
        marker.setMap(map);
        _mapInited = true;
    });
}

// ESC 키로 바텀시트 닫기
document.addEventListener('keydown', function (e) {
    if (e.key === 'Escape') closeLocationSheet();
});
