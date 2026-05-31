(function () {
    var DEFAULT_LAT = 37.5665;
    var DEFAULT_LNG = 126.9780;

    var CATEGORY_STYLE = {
        CAFE:        { bg: '#6F4E37', emoji: '☕' },
        FOOD:        { bg: '#E85D04', emoji: '🍽' },
        BEAUTY:      { bg: '#E91E8C', emoji: '💄' },
        SHOPPING:    { bg: '#1565C0', emoji: '🛍' },
        FITNESS:     { bg: '#2E7D32', emoji: '💪' },
        CONVENIENCE: { bg: '#6A1B9A', emoji: '🏬' }
    };
    var CATEGORY_LABEL = {
        CAFE: '카페', FOOD: '음식점', BEAUTY: '뷰티',
        SHOPPING: '쇼핑', FITNESS: '피트니스', CONVENIENCE: '편의점'
    };

    var IS_LOGGED_IN = document.body.dataset.loggedIn === 'true';

    var map = null;
    var currentLocationOverlay = null;
    var markerList = [];        // [{ overlay, storeId, el }]
    var storeMap = {};          // storeId -> storeData
    var selectedCategory = '';
    var selectedStoreId = null;
    var loadTimer = null;

    // ===== 유틸 =====
    function toast(msg, type) {
        if (typeof window.showToast === 'function') {
            window.showToast(msg, type || 'warning');
        } else {
            alert(msg);
        }
    }

    function escapeHtml(s) {
        if (s == null) return '';
        return String(s)
            .replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;')
            .replace(/"/g, '&quot;').replace(/'/g, '&#39;');
    }

    function escapeJs(s) {
        if (s == null) return '';
        return String(s).replace(/\\/g, '\\\\').replace(/'/g, "\\'");
    }

    // ===== 마커 =====
    function clearMarkers() {
        markerList.forEach(function (m) { m.overlay.setMap(null); });
        markerList = [];
    }

    function buildMarkerEl(store) {
        var style = CATEGORY_STYLE[store.category] || { bg: '#333', emoji: '🏪' };
        var emoji = store.emoji || style.emoji;

        var el = document.createElement('div');
        el.className = 'map-marker';
        el.style.background = style.bg;
        el.textContent = emoji;
        el.dataset.storeId = store.storeId;
        el.addEventListener('click', function (e) {
            e.stopPropagation();
            showStoreSheet(store.storeId);
        });
        return el;
    }

    function addMarker(store) {
        if (store.latitude == null || store.longitude == null) return;
        var el = buildMarkerEl(store);
        var overlay = new kakao.maps.CustomOverlay({
            position: new kakao.maps.LatLng(store.latitude, store.longitude),
            content: el,
            yAnchor: 1,
            clickable: true
        });
        overlay.setMap(map);
        markerList.push({ overlay: overlay, storeId: store.storeId, el: el });
    }

    function highlightMarker(storeId) {
        markerList.forEach(function (m) {
            m.el.classList.toggle('selected', String(m.storeId) === String(storeId));
        });
    }

    function clearHighlight() {
        markerList.forEach(function (m) { m.el.classList.remove('selected'); });
    }

    // ===== 현재 위치 마커 =====
    function showCurrentLocationMarker(lat, lng) {
        var el = document.createElement('div');
        el.className = 'current-location-marker';
        el.innerHTML = '<div class="cl-dot"></div><div class="cl-pulse"></div>';

        if (currentLocationOverlay) currentLocationOverlay.setMap(null);
        currentLocationOverlay = new kakao.maps.CustomOverlay({
            position: new kakao.maps.LatLng(lat, lng),
            content: el,
            yAnchor: 0.5,
            xAnchor: 0.5,
            zIndex: 1
        });
        currentLocationOverlay.setMap(map);
    }

    // ===== 가맹점 로드 =====
    function loadStores() {
        if (!map) return;
        var bounds = map.getBounds();
        var sw = bounds.getSouthWest();
        var ne = bounds.getNorthEast();

        var params = new URLSearchParams({
            swLat: sw.getLat(),
            swLng: sw.getLng(),
            neLat: ne.getLat(),
            neLng: ne.getLng()
        });
        if (selectedCategory) params.append('category', selectedCategory);

        fetch('/map/stores?' + params.toString(), {
            credentials: 'same-origin',
            headers: { 'Accept': 'application/json' }
        })
            .then(function (res) { return res.json(); })
            .then(function (stores) {
                clearMarkers();
                storeMap = {};
                (stores || []).forEach(function (s) {
                    if (!s.coupons) s.coupons = [];
                    storeMap[s.storeId] = s;
                    addMarker(s);
                });
                if (selectedStoreId && storeMap[selectedStoreId]) {
                    highlightMarker(selectedStoreId);
                }
            })
            .catch(function () { /* 무시 */ });
    }

    function scheduleLoad() {
        if (loadTimer) clearTimeout(loadTimer);
        loadTimer = setTimeout(loadStores, 200);
    }

    // ===== 바텀시트: 가맹점 =====
    function showStoreSheet(storeId) {
        var store = storeMap[storeId];
        if (!store) return;

        selectedStoreId = storeId;
        highlightMarker(storeId);

        var couponHtml;
        if (!store.coupons.length) {
            couponHtml = '<p class="map-no-coupon">등록된 쿠폰이 없습니다</p>';
        } else {
            couponHtml = store.coupons.map(function (c) {
                var remain = (c.totalCount === 0)
                    ? '무제한'
                    : '잔여 ' + (c.totalCount - c.issuedCount) + '개';

                var btn;
                if (IS_LOGGED_IN) {
                    btn = '<button class="btn-issue" data-coupon-id="' + c.couponId
                        + '" data-store-id="' + store.storeId + '">받기</button>';
                } else {
                    btn = '<button class="btn-issue btn-issue-login" data-store-id="' + store.storeId
                        + '">로그인 후 발급</button>';
                }

                return '<div class="map-coupon-item">'
                    +    '<div class="coupon-info">'
                    +      '<span class="coupon-name">' + escapeHtml(c.couponName) + '</span>'
                    +      '<span class="coupon-benefit">' + escapeHtml(c.benefit) + '</span>'
                    +      '<span class="coupon-remain">' + remain + ' · ~' + escapeHtml(c.expireDate) + '</span>'
                    +    '</div>'
                    +    btn
                    + '</div>';
            }).join('');
        }

        var sheet = document.getElementById('storeSheet');
        var rating = (store.ratingAvg != null) ? Number(store.ratingAvg).toFixed(1) : '0.0';
        var emoji = store.emoji || (CATEGORY_STYLE[store.category] || {}).emoji || '🏪';
        var label = CATEGORY_LABEL[store.category] || store.category || '';

        sheet.innerHTML =
              '<div class="sheet-handle"></div>'
            + '<div class="sheet-content">'
            +   '<div class="store-header">'
            +     '<img src="/store/image/' + store.storeId + (store.imgVer ? '?v=' + store.imgVer : '') + '" class="store-thumb"'
            +          ' onerror="this.onerror=null;this.src=\'/static/images/default-store.png\'">'
            +     '<div class="store-info">'
            +       '<div class="store-title">'
            +         '<span class="store-emoji">' + emoji + '</span>'
            +         '<span class="store-name">' + escapeHtml(store.storeName) + '</span>'
            +         '<span class="category-badge">' + escapeHtml(label) + '</span>'
            +       '</div>'
            +       '<div class="store-rating">★ ' + rating + '</div>'
            +       '<div class="store-address" data-store-addr role="button" tabindex="0">'
            +         '📍 ' + escapeHtml(store.address || '주소 정보 없음')
            +       '</div>'
            +     '</div>'
            +   '</div>'
            +   '<div class="coupon-list">' + couponHtml + '</div>'
            +   '<button class="btn-store-detail" data-store-detail>가맹점 상세 보기 &rsaquo;</button>'
            + '</div>';

        // 주소 클릭 → 길찾기 시트
        var addrEl = sheet.querySelector('[data-store-addr]');
        if (addrEl) {
            addrEl.addEventListener('click', function () {
                showNavSheet(store.latitude, store.longitude, store.storeName, store.address);
            });
        }
        // 상세 이동
        var detailBtn = sheet.querySelector('[data-store-detail]');
        if (detailBtn) {
            detailBtn.addEventListener('click', function () {
                window.location.href = '/store?storeId=' + store.storeId;
            });
        }
        // 쿠폰 발급 / 로그인 이동
        sheet.querySelectorAll('.btn-issue').forEach(function (btn) {
            btn.addEventListener('click', function () {
                if (btn.classList.contains('btn-issue-login')) {
                    var sid = btn.dataset.storeId;
                    window.location.href = '/login?redirect='
                        + encodeURIComponent('/store?storeId=' + sid);
                    return;
                }
                issueCoupon(btn.dataset.couponId, btn.dataset.storeId, btn);
            });
        });

        openSheet('storeSheet');
    }

    // ===== 바텀시트: 길찾기 =====
    function showNavSheet(lat, lng, storeName, address) {
        if (lat == null || lng == null) {
            toast('위치 정보가 등록되지 않은 가맹점입니다');
            return;
        }

        var sheet = document.getElementById('navSheet');
        sheet.innerHTML =
              '<div class="sheet-handle"></div>'
            + '<div class="nav-sheet-content">'
            +   '<p class="nav-store-name">' + escapeHtml(storeName || '') + '</p>'
            +   '<p class="nav-address">' + escapeHtml(address || '') + '</p>'
            +   '<button type="button" class="nav-btn kakao" data-nav="kakaomap">🗺 카카오맵으로 보기</button>'
            +   '<button type="button" class="nav-btn kakao-nav" data-nav="kakaonav">🚗 카카오 내비로 길안내</button>'
            +   '<button type="button" class="nav-btn naver" data-nav="navermap">🗺 네이버 지도로 보기</button>'
            +   '<button type="button" class="nav-btn cancel" data-nav-close>닫기</button>'
            + '</div>';

        sheet.querySelectorAll('[data-nav]').forEach(function (btn) {
            btn.addEventListener('click', function () {
                openExternalMap(btn.dataset.nav, lat, lng, storeName || '가맹점');
            });
        });
        var closeBtn = sheet.querySelector('[data-nav-close]');
        if (closeBtn) closeBtn.addEventListener('click', function () { closeSheet('navSheet'); });

        openSheet('navSheet');
    }

    function openExternalMap(type, lat, lng, name) {
        var enc = encodeURIComponent(name);
        var appUrl, webUrl;
        if (type === 'kakaomap') {
            appUrl = 'kakaomap://look?p=' + lat + ',' + lng;
            webUrl = 'https://map.kakao.com/link/map/' + enc + ',' + lat + ',' + lng;
        } else if (type === 'kakaonav') {
            appUrl = 'kakaomap://route?ep=' + lat + ',' + lng + '&by=CAR';
            webUrl = 'https://map.kakao.com/link/to/' + enc + ',' + lat + ',' + lng;
        } else if (type === 'navermap') {
            appUrl = 'nmap://place?lat=' + lat + '&lng=' + lng + '&name=' + enc + '&appname=com.couzl';
            webUrl = 'https://map.naver.com/v5/search/' + enc;
        } else {
            return;
        }
        closeSheet('navSheet');
        tryAppScheme(appUrl, webUrl);
    }

    function tryAppScheme(appUrl, webUrl) {
        var start = Date.now();
        var timer = setTimeout(function () {
            if (document.hidden) return;
            if (Date.now() - start < 2200) {
                window.location.href = webUrl;
            }
        }, 2000);
        function onVis() {
            if (document.hidden) {
                clearTimeout(timer);
                document.removeEventListener('visibilitychange', onVis);
            }
        }
        document.addEventListener('visibilitychange', onVis);
        window.location.href = appUrl;
    }

    // ===== 쿠폰 발급 (AJAX) =====
    function issueCoupon(couponId, storeId, btn) {
        if (btn.disabled) return;
        btn.disabled = true;
        var prevText = btn.textContent;
        btn.textContent = '발급 중...';

        fetch('/store/coupon/issue', {
            method: 'POST',
            credentials: 'same-origin',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
            body: 'couponId=' + encodeURIComponent(couponId)
        })
            .then(function (res) {
                if (res.redirected) {
                    // 로그인 페이지 등으로 리다이렉트 — URL 의 msg 파라미터로 결과 판별
                    var url = res.url || '';
                    var msg = url.match(/[?&]msg=([^&]+)/);
                    if (msg && msg[1] === 'issued') {
                        btn.textContent = '발급완료';
                        btn.classList.add('issued');
                        toast('쿠폰이 발급되었습니다', 'success');
                        return;
                    }
                    if (msg && msg[1] === 'already-issued') {
                        btn.textContent = '발급완료';
                        btn.classList.add('issued');
                        toast('이미 발급받은 쿠폰입니다');
                        return;
                    }
                    if (msg && msg[1] === 'sold-out') {
                        btn.textContent = '마감';
                        toast('마감된 쿠폰입니다');
                        return;
                    }
                    if (msg && msg[1] === 'expired') {
                        btn.textContent = '만료';
                        toast('만료된 쿠폰입니다', 'danger');
                        return;
                    }
                    if (url.indexOf('/login') !== -1) {
                        window.location.href = '/login?redirect='
                            + encodeURIComponent('/store?storeId=' + storeId);
                        return;
                    }
                    btn.disabled = false;
                    btn.textContent = prevText;
                    toast('오류가 발생했습니다', 'danger');
                }
            })
            .catch(function () {
                btn.disabled = false;
                btn.textContent = prevText;
                toast('오류가 발생했습니다', 'danger');
            });
    }

    // ===== 시트 open/close =====
    function openSheet(id) {
        document.getElementById(id).classList.add('open');
        document.getElementById(id + 'Overlay').classList.add('open');
    }

    function closeSheet(id) {
        document.getElementById(id).classList.remove('open');
        document.getElementById(id + 'Overlay').classList.remove('open');
        if (id === 'storeSheet') {
            selectedStoreId = null;
            clearHighlight();
        }
    }

    function bindSheetClose(id) {
        document.getElementById(id + 'Overlay').addEventListener('click', function () {
            closeSheet(id);
        });

        // 스와이프 다운으로 닫기 (핸들 영역만)
        var sheet = document.getElementById(id);
        var startY = null;
        sheet.addEventListener('touchstart', function (e) {
            var handle = e.target.closest('.sheet-handle');
            if (!handle) { startY = null; return; }
            startY = e.touches[0].clientY;
        }, { passive: true });
        sheet.addEventListener('touchmove', function (e) {
            if (startY == null) return;
            var dy = e.touches[0].clientY - startY;
            if (dy > 60) {
                closeSheet(id);
                startY = null;
            }
        }, { passive: true });
        sheet.addEventListener('touchend', function () { startY = null; }, { passive: true });
    }

    // ===== 카테고리 필터 =====
    function bindCategoryBar() {
        var bar = document.getElementById('mapCatBar');
        if (!bar) return;
        bar.addEventListener('click', function (e) {
            var item = e.target.closest('.map-cat-item');
            if (!item) return;
            bar.querySelectorAll('.map-cat-item').forEach(function (el) {
                el.classList.remove('active');
            });
            item.classList.add('active');
            selectedCategory = item.dataset.category || '';
            loadStores();
        });
    }

    // ===== 내 위치 버튼 =====
    function bindMyLocationBtn() {
        var btn = document.getElementById('btn-my-location');
        if (!btn) return;
        btn.addEventListener('click', function () {
            if (!navigator.geolocation) {
                toast('위치 서비스를 지원하지 않는 브라우저입니다');
                return;
            }
            navigator.geolocation.getCurrentPosition(function (pos) {
                var loc = new kakao.maps.LatLng(pos.coords.latitude, pos.coords.longitude);
                map.setCenter(loc);
                showCurrentLocationMarker(pos.coords.latitude, pos.coords.longitude);
            }, function () {
                toast('현재 위치를 가져올 수 없습니다');
            }, { enableHighAccuracy: true, timeout: 8000 });
        });
    }

    // ===== 초기화 =====
    function initMap() {
        var container = document.getElementById('kakao-map');
        if (!container) return;

        map = new kakao.maps.Map(container, {
            center: new kakao.maps.LatLng(DEFAULT_LAT, DEFAULT_LNG),
            level: 5
        });

        kakao.maps.event.addListener(map, 'idle', scheduleLoad);
        kakao.maps.event.addListener(map, 'click', function () {
            closeSheet('storeSheet');
        });

        bindSheetClose('storeSheet');
        bindSheetClose('navSheet');
        bindCategoryBar();
        bindMyLocationBtn();

        if (navigator.geolocation) {
            navigator.geolocation.getCurrentPosition(function (pos) {
                var lat = pos.coords.latitude;
                var lng = pos.coords.longitude;
                map.setCenter(new kakao.maps.LatLng(lat, lng));
                showCurrentLocationMarker(lat, lng);
                loadStores();
            }, function () {
                toast('위치 권한을 허용하면 내 주변 가맹점을 볼 수 있어요');
                loadStores();
            }, { enableHighAccuracy: true, timeout: 10000 });
        } else {
            toast('위치 서비스를 지원하지 않는 브라우저입니다');
            loadStores();
        }
    }

    kakao.maps.load(initMap);
})();
