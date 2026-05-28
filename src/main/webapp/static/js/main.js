// 카테고리 선택
function selectCategory(el) {
    document.querySelectorAll('.category-item').forEach(function (item) {
        item.classList.remove('active');
    });
    el.classList.add('active');
}

// 탭바 전환 (준비 중)
function switchTab(el) {
    showAlert('준비 중입니다');
}

// 쿠폰 받기
function receiveCoupon(btn) {
    btn.textContent = '완료 ✓';
    btn.disabled = true;
}

// 배너 스크롤 → 인디케이터 업데이트
document.addEventListener('DOMContentLoaded', function () {
    var track = document.querySelector('.banner-track');
    var dots  = document.querySelectorAll('.dot');

    if (!track || !dots.length) return;

    track.addEventListener('scroll', function () {
        var index = Math.round(this.scrollLeft / this.offsetWidth);
        dots.forEach(function (dot, i) {
            dot.classList.toggle('active', i === index);
        });
    });
});
