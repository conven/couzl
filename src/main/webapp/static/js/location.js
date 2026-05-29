function selectDistrict(el) {
    document.querySelectorAll('.loc-card').forEach(function (c) {
        c.classList.remove('selected');
    });
    el.classList.add('selected');
    var currentName = document.querySelector('.loc-current-name');
    if (currentName) {
        currentName.textContent = el.dataset.name;
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
