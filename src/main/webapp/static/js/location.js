function selectDistrict(el) {
    document.querySelectorAll('.loc-card').forEach(function (c) {
        c.classList.remove('selected');
    });
    el.classList.add('selected');
    document.querySelector('.loc-current-name').textContent = el.dataset.name;
}

function saveLocation() {
    alert('지역이 변경되었습니다!');
    goTo('/mypage');
}
