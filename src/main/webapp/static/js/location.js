var REGION_EMOJI = {
    '강남구': '🏙️', '서초구': '🌳', '마포구': '🎨',
    '송파구': '🏟️', '종로구': '🏯', '영등포구': '🌆',
    '용산구': '🏛️', '성동구': '🌉', '광진구': '🎭',
    '동대문구': '🏪', '중랑구': '🌿', '성북구': '📚',
    '강북구': '🏔️', '도봉구': '🌲', '노원구': '🏫',
    '은평구': '🛕', '서대문구': '🎓', '양천구': '🏠',
    '강서구': '✈️', '구로구': '🏭', '금천구': '💎',
    '관악구': '🎒', '동작구': '🌊', '강동구': '🌸',
    '중구': '🏰'
};

document.addEventListener('DOMContentLoaded', function () {
    document.querySelectorAll('.loc-card').forEach(function (card) {
        var emojiEl = card.querySelector('.loc-card-emoji');
        if (emojiEl) {
            emojiEl.textContent = REGION_EMOJI[card.dataset.name] || '📍';
        }
    });
});

function selectDistrict(el) {
    document.querySelectorAll('.loc-card').forEach(function (c) {
        c.classList.remove('selected');
    });
    el.classList.add('selected');

    var currentName = document.querySelector('.loc-current-name');
    if (currentName) {
        currentName.textContent = el.dataset.name;
    }

    var saveBtn = document.getElementById('locBtnSave');
    if (saveBtn && saveBtn.disabled) {
        saveBtn.disabled = false;
    }
}

function saveLocation() {
    var selected = document.querySelector('.loc-card.selected');
    if (!selected) {
        alert('지역을 선택해주세요.');
        return;
    }
    document.getElementById('selectedRegionId').value = selected.dataset.regionId;
    document.getElementById('locationForm').submit();
}
