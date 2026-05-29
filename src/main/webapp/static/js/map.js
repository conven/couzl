kakao.maps.load(function () {
    var DEFAULT_LAT = 37.4979;
    var DEFAULT_LNG = 127.0276;
    var map;

    function getCategoryLabel(category) {
        var labels = {
            CAFE: '카페',
            FOOD: '음식',
            BEAUTY: '뷰티',
            SHOPPING: '쇼핑',
            FITNESS: '피트니스',
            CONVENIENCE: '편의점'
        };
        return labels[category] || category;
    }

    function buildBottomSheetHTML(store) {
        var html = '<div class="bs-header">'
            + '<div class="bs-title">'
            + '<span class="bs-emoji">' + store.emoji + '</span>'
            + '<span class="bs-store-name">' + store.storeName + '</span>'
            + '</div>'
            + '<span class="bs-category">' + getCategoryLabel(store.category) + '</span>'
            + '</div>'
            + '<div class="bs-rating">★ ' + store.ratingAvg.toFixed(1) + '</div>';

        if (store.coupons && store.coupons.length > 0) {
            html += '<div class="bs-coupons">';
            store.coupons.forEach(function (coupon) {
                html += '<div class="bs-coupon-item">'
                    + '<span class="bs-coupon-name">' + coupon.benefit + '</span>'
                    + '<button class="bs-coupon-btn" onclick="claimCoupon()">받기</button>'
                    + '</div>';
            });
            html += '</div>';
        }

        html += '<a href="/store?id=' + store.storeId + '" class="bs-detail-btn">가맹점 상세 보기 ></a>';
        return html;
    }

    function openBottomSheet(store) {
        document.getElementById('bottom-sheet-content').innerHTML = buildBottomSheetHTML(store);
        document.getElementById('bottom-sheet').classList.add('open');
        document.getElementById('bottom-sheet-overlay').classList.add('open');
    }

    function closeBottomSheet() {
        document.getElementById('bottom-sheet').classList.remove('open');
        document.getElementById('bottom-sheet-overlay').classList.remove('open');
    }

    window.claimCoupon = function () {
        alert('쿠폰이 저장되었습니다!');
    };

    function initMap(center) {
        map = new kakao.maps.Map(document.getElementById('kakao-map'), {
            center: center,
            level: 4
        });

        STORE_LIST.forEach(function (store) {
            if (!store.latitude || !store.longitude) return;

            var marker = new kakao.maps.Marker({
                map: map,
                position: new kakao.maps.LatLng(store.latitude, store.longitude)
            });

            kakao.maps.event.addListener(marker, 'click', function () {
                openBottomSheet(store);
            });
        });
    }

    document.getElementById('bottom-sheet-overlay').addEventListener('click', closeBottomSheet);

    document.getElementById('btn-my-location').addEventListener('click', function () {
        if (!navigator.geolocation) return;
        navigator.geolocation.getCurrentPosition(function (pos) {
            map.panTo(new kakao.maps.LatLng(pos.coords.latitude, pos.coords.longitude));
        });
    });

    if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(
            function (pos) {
                initMap(new kakao.maps.LatLng(pos.coords.latitude, pos.coords.longitude));
            },
            function () {
                initMap(new kakao.maps.LatLng(DEFAULT_LAT, DEFAULT_LNG));
            }
        );
    } else {
        initMap(new kakao.maps.LatLng(DEFAULT_LAT, DEFAULT_LNG));
    }
});
