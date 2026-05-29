function switchCouponTab(el) {
    document.querySelectorAll('.cb-tab-item').forEach(function(tab) {
        tab.classList.remove('active');
    });
    document.querySelectorAll('.cb-tab-content').forEach(function(content) {
        content.classList.remove('active');
    });
    el.classList.add('active');
    document.getElementById(el.getAttribute('data-tab')).classList.add('active');
}
