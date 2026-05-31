// ===== 비로그인: localStorage 의 지역으로 첫 진입 시 redirect =====
(function () {
    var body = document.body;
    if (!body) return;
    var loggedIn = body.dataset.loggedIn === 'true';
    var hasRegionInUrl = body.dataset.regionInUrl === 'true';
    if (loggedIn || hasRegionInUrl) return;

    try {
        var raw = localStorage.getItem('selectedRegion');
        if (!raw) return;
        var saved = JSON.parse(raw);
        if (!saved || saved.regionId == null) return;
        var url = new URL(window.location.href);
        url.searchParams.set('regionId', saved.regionId);
        // 페이지 진입 시 reload
        window.location.replace(url.pathname + '?' + url.searchParams.toString() + url.hash);
    } catch (e) {}
})();

// ===== 배너 자동 슬라이드 + dot indicator =====
function initBanner() {
    var track = document.getElementById('bannerTrack');
    var dotsWrap = document.getElementById('bannerDots');
    if (!track) return;

    var dots = dotsWrap ? dotsWrap.querySelectorAll('.dot') : [];
    var cards = track.querySelectorAll('.banner-card');
    var count = cards.length;

    function updateDots(index) {
        if (!dots.length) return;
        dots.forEach(function (dot, i) {
            dot.classList.toggle('active', i === index);
        });
    }

    track.addEventListener('scroll', function () {
        var index = Math.round(track.scrollLeft / track.offsetWidth);
        if (index < 0) index = 0;
        if (index >= count) index = count - 1;
        updateDots(index);
    });

    dots.forEach(function (dot, i) {
        dot.addEventListener('click', function () {
            track.scrollTo({ left: i * track.offsetWidth, behavior: 'smooth' });
        });
    });

    if (count > 1) {
        var slideTo = function () {
            var current = Math.round(track.scrollLeft / track.offsetWidth);
            var next = (current + 1) % count;
            track.scrollTo({ left: next * track.offsetWidth, behavior: 'smooth' });
        };
        var autoTimer = setInterval(slideTo, 3000);

        var pauseTimer = null;
        function pauseAuto() {
            clearInterval(autoTimer);
            if (pauseTimer) clearTimeout(pauseTimer);
            pauseTimer = setTimeout(function () {
                autoTimer = setInterval(slideTo, 3000);
            }, 5000);
        }
        track.addEventListener('touchstart', pauseAuto);
        track.addEventListener('mousedown', pauseAuto);
    }
}

// ===== AJAX 카테고리 / 페이지네이션 =====
(function () {
    var sectionsEl = document.getElementById('mainSections');
    var loaderEl   = document.getElementById('mainLoader');
    var categoryBar = document.getElementById('categoryBar');

    if (!sectionsEl) return;

    function showLoader(on) {
        if (!loaderEl) return;
        loaderEl.hidden = !on;
    }

    function paramsFromUrl(url) {
        var i = url.indexOf('?');
        return i >= 0 ? url.substring(i) : '';
    }

    function getParam(qs, name) {
        if (!qs) return null;
        var s = qs.charAt(0) === '?' ? qs.substring(1) : qs;
        var parts = s.split('&');
        for (var i = 0; i < parts.length; i++) {
            var kv = parts[i].split('=');
            if (decodeURIComponent(kv[0]) === name) {
                return decodeURIComponent(kv[1] || '');
            }
        }
        return null;
    }

    function updateCategoryActive(category) {
        if (!categoryBar) return;
        var items = categoryBar.querySelectorAll('.category-item');
        items.forEach(function (item) {
            var cat = item.getAttribute('data-category') || '';
            item.classList.toggle('active', cat === (category || ''));
        });
    }

    function loadContent(url, pushState) {
        var qs = paramsFromUrl(url);
        showLoader(true);

        fetch('/main/content' + qs, {
            headers: { 'X-Requested-With': 'XMLHttpRequest' },
            credentials: 'same-origin'
        })
            .then(function (res) {
                if (!res.ok) throw new Error('네트워크 오류');
                return res.text();
            })
            .then(function (html) {
                sectionsEl.innerHTML = html;
                updateCategoryActive(getParam(qs, 'category'));
                if (pushState) {
                    history.pushState({ couzlMain: true }, '', url);
                }
                window.scrollTo({ top: 0, behavior: 'smooth' });
            })
            .catch(function () {
                // 실패 시 폴백 — 전체 페이지 이동
                window.location.href = url;
            })
            .finally(function () {
                showLoader(false);
            });
    }

    // 카테고리 클릭 (이벤트 위임)
    if (categoryBar) {
        categoryBar.addEventListener('click', function (e) {
            var item = e.target.closest('.category-item');
            if (!item) return;
            e.preventDefault();
            var href = item.getAttribute('href');
            if (!href) return;
            loadContent(href, true);
        });
    }

    // 페이지네이션 클릭 (fragment 내부 → 위임으로 처리)
    sectionsEl.addEventListener('click', function (e) {
        var link = e.target.closest('a.page-link');
        if (!link) return;
        e.preventDefault();
        var href = link.getAttribute('href');
        if (!href) return;
        loadContent(href, true);
    });

    // 브라우저 뒤로/앞으로
    window.addEventListener('popstate', function () {
        loadContent(location.pathname + location.search, false);
    });
})();

document.addEventListener('DOMContentLoaded', initBanner);
