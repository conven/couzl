const LocationModal = (() => {
    const STORAGE_KEY = 'selectedRegion';

    let overlay = null;
    let listEl = null;
    let searchInput = null;
    let isLoggedIn = false;
    let kakaoKey = '';
    let kakaoLoading = null;

    function _toast(msg, type) {
        if (typeof window.showToast === 'function') {
            window.showToast(msg, type || 'warning');
        } else {
            alert(msg);
        }
    }

    function _getSavedRegion() {
        try {
            const raw = localStorage.getItem(STORAGE_KEY);
            if (!raw) return null;
            const obj = JSON.parse(raw);
            if (obj && obj.regionId != null && obj.regionName) return obj;
        } catch (e) {}
        return null;
    }

    function _renderList(query) {
        if (!listEl) return;
        const saved = _getSavedRegion();
        const items = listEl.querySelectorAll('.location-item');
        const q = (query || '').trim();
        items.forEach(item => {
            const name = item.dataset.region || '';
            const id = item.dataset.regionId;
            const match = !q || name.includes(q);
            item.classList.toggle('hidden', !match);
            item.classList.toggle('selected', saved && String(saved.regionId) === String(id));
        });
    }

    function open() {
        if (!overlay) return;
        overlay.classList.add('active');
        document.body.style.overflow = 'hidden';
        if (searchInput) {
            searchInput.value = '';
        }
        _renderList('');
    }

    function close() {
        if (!overlay) return;
        overlay.classList.remove('active');
        document.body.style.overflow = '';
    }

    function _selectGuest(regionId, regionName) {
        try {
            localStorage.setItem(STORAGE_KEY, JSON.stringify({
                regionId: Number(regionId),
                regionName: regionName
            }));
        } catch (e) {}

        const headerName = document.getElementById('headerRegionName');
        if (headerName) headerName.textContent = regionName;

        close();

        // 현재 페이지에 머문 채 reload
        // 단, /main 이면 regionId 파라미터를 새 값으로 갱신 (페이지네이션은 리셋)
        const url = new URL(window.location.href);
        if (url.pathname === '/main') {
            url.searchParams.set('regionId', String(regionId));
            url.searchParams.delete('page');
            const qs = url.searchParams.toString();
            window.location.href = url.pathname + (qs ? '?' + qs : '') + url.hash;
        } else {
            window.location.reload();
        }
    }

    function _selectLoggedIn(regionId) {
        close();
        // POST /location 로 세션·DB 갱신만 시키고 응답(리다이렉트)은 무시 → 현재 페이지 reload
        fetch('/location', {
            method: 'POST',
            credentials: 'same-origin',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
                'X-Requested-With': 'XMLHttpRequest'
            },
            body: 'regionId=' + encodeURIComponent(regionId)
        })
            .then(function () { window.location.reload(); })
            .catch(function () { window.location.reload(); });
    }

    function select(regionId, regionName) {
        if (regionId == null || !regionName) return;
        if (isLoggedIn) {
            _selectLoggedIn(regionId);
        } else {
            _selectGuest(regionId, regionName);
        }
    }

    function _loadKakaoSdk() {
        if (kakaoLoading) return kakaoLoading;
        if (window.kakao && window.kakao.maps && window.kakao.maps.services) {
            kakaoLoading = Promise.resolve();
            return kakaoLoading;
        }
        if (!kakaoKey) {
            return Promise.reject(new Error('no-key'));
        }
        kakaoLoading = new Promise((resolve, reject) => {
            // 기존 SDK script 가 이미 있으면 재사용
            const existing = document.querySelector('script[data-couzl-kakao-sdk]');
            if (existing) {
                existing.addEventListener('load', () => {
                    window.kakao.maps.load(resolve);
                });
                existing.addEventListener('error', reject);
                return;
            }
            const s = document.createElement('script');
            s.src = 'https://dapi.kakao.com/v2/maps/sdk.js?appkey=' + encodeURIComponent(kakaoKey)
                + '&libraries=services&autoload=false';
            s.async = true;
            s.setAttribute('data-couzl-kakao-sdk', '1');
            s.onload = function () {
                if (window.kakao && window.kakao.maps) {
                    window.kakao.maps.load(resolve);
                } else {
                    reject(new Error('kakao-not-loaded'));
                }
            };
            s.onerror = reject;
            document.head.appendChild(s);
        });
        return kakaoLoading;
    }

    function _matchRegionByName(name) {
        if (!name || !listEl) return null;
        const items = listEl.querySelectorAll('.location-item');
        for (let i = 0; i < items.length; i++) {
            const regionName = items[i].dataset.region || '';
            if (regionName && (name.indexOf(regionName) !== -1 || regionName.indexOf(name) !== -1)) {
                return {
                    regionId: items[i].dataset.regionId,
                    regionName: regionName
                };
            }
        }
        return null;
    }

    function useCurrentLocation() {
        if (!navigator.geolocation) {
            _toast('위치를 가져올 수 없습니다');
            return;
        }
        navigator.geolocation.getCurrentPosition(function (pos) {
            _loadKakaoSdk().then(function () {
                try {
                    const geocoder = new window.kakao.maps.services.Geocoder();
                    geocoder.coord2RegionCode(
                        pos.coords.longitude, pos.coords.latitude,
                        function (result, status) {
                            if (status !== window.kakao.maps.services.Status.OK || !result || !result.length) {
                                _toast('위치를 가져올 수 없습니다');
                                return;
                            }
                            // 행정동(H) 우선, 없으면 법정동(B)
                            const h = result.find(r => r.region_type === 'H') || result[0];
                            const candidate = h.region_3depth_name || h.region_2depth_name || h.region_1depth_name;
                            const matched = _matchRegionByName(candidate)
                                || _matchRegionByName(h.region_2depth_name)
                                || _matchRegionByName(h.region_1depth_name);
                            if (!matched) {
                                _toast('해당 위치의 서비스 지역이 없습니다');
                                return;
                            }
                            select(matched.regionId, matched.regionName);
                        }
                    );
                } catch (e) {
                    _toast('위치를 가져올 수 없습니다');
                }
            }).catch(function () {
                _toast('위치를 가져올 수 없습니다');
            });
        }, function () {
            _toast('위치를 가져올 수 없습니다');
        }, { timeout: 8000, enableHighAccuracy: false });
    }

    function init() {
        overlay = document.getElementById('locationModalOverlay');
        if (!overlay) return;

        isLoggedIn = overlay.dataset.loggedIn === 'true';
        kakaoKey = overlay.dataset.kakaoKey || '';

        listEl = document.getElementById('locationList');
        searchInput = document.getElementById('locationSearchInput');

        overlay.addEventListener('click', e => {
            if (e.target === overlay) close();
        });

        if (searchInput) {
            searchInput.addEventListener('input', e => _renderList(e.target.value));
        }

        if (listEl) {
            listEl.addEventListener('click', e => {
                const item = e.target.closest('.location-item');
                if (!item) return;
                select(item.dataset.regionId, item.dataset.region);
            });
        }

        document.addEventListener('keydown', e => {
            if (e.key === 'Escape' && overlay.classList.contains('active')) close();
        });
    }

    return { open, close, init, useCurrentLocation };
})();

document.addEventListener('DOMContentLoaded', () => LocationModal.init());
