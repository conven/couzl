function goTo(path) {
    window.location.href = path;
}

function goToWithSpinner(path) {
    showSpinner();
    window.location.href = path;
}

function showAlert(msg) {
    alert(msg);
}

function getToken() {
    return localStorage.getItem('token');
}

function setToken(token) {
    localStorage.setItem('token', token);
}

function removeToken() {
    localStorage.removeItem('token');
}

function showSpinner() {
    if (document.getElementById('appSpinnerOverlay')) return;
    var overlay = document.createElement('div');
    overlay.id = 'appSpinnerOverlay';
    overlay.className = 'app-spinner-overlay';
    overlay.innerHTML = '<div class="app-spinner"></div>';
    document.body.appendChild(overlay);
}

function hideSpinner() {
    var overlay = document.getElementById('appSpinnerOverlay');
    if (overlay) overlay.remove();
}

// ===== 모바일 확대(줌) 차단 =====
// iOS Safari 는 viewport meta 의 user-scalable=no / maximum-scale=1.0 을 무시하므로 JS 로 보강.
// 카카오맵 등 자체 핀치 줌이 필요한 컴포넌트는 자기 영역에서 이벤트 stopPropagation 으로 보호됨.
(function () {
    function isInsideMap(target) {
        if (!target || !target.closest) return false;
        return !!target.closest('#kakao-map, #storeMap');
    }
    ['gesturestart', 'gesturechange', 'gestureend'].forEach(function (name) {
        document.addEventListener(name, function (e) {
            if (isInsideMap(e.target)) return;
            e.preventDefault();
        }, { passive: false });
    });
    document.addEventListener('touchmove', function (e) {
        if (e.touches && e.touches.length > 1 && !isInsideMap(e.target)) {
            e.preventDefault();
        }
    }, { passive: false });
})();
