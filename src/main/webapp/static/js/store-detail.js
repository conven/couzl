function switchDetailTab(el) {
    document.querySelectorAll('.tab-menu-item').forEach(function(t) {
        t.classList.remove('active');
    });
    document.querySelectorAll('.tab-content').forEach(function(c) {
        c.classList.remove('active');
    });
    el.classList.add('active');
    document.getElementById(el.dataset.tab).classList.add('active');
}

function receiveCouponDetail(btn) {
    btn.textContent = '완료 ✓';
    btn.disabled = true;
    showAlert('쿠폰이 쿠폰함에 저장되었습니다!');
}
