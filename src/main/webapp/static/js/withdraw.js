function toggleAgree(checkbox) {
    var btn = document.getElementById('btnWithdraw');
    if (checkbox.checked) {
        btn.classList.add('active');
    } else {
        btn.classList.remove('active');
    }
}

function doWithdraw() {
    var agreed = document.getElementById('agreeCheck').checked;
    if (!agreed) return;

    if (confirm('정말 탈퇴하시겠습니까?')) {
        alert('탈퇴가 완료되었습니다.');
        goTo('/login');
    }
}
