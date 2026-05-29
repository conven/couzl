function changePhoto() {
    alert('준비중입니다!');
}

function sendEmailChange() {
    var verifyRow = document.getElementById('verifyRow');
    verifyRow.classList.add('show');
    document.getElementById('verifyCode').focus();
}

function confirmEmailChange() {
    alert('이메일이 변경되었습니다!');
    document.getElementById('verifyRow').classList.remove('show');
    document.getElementById('verifyCode').value = '';
}

function saveProfile() {
    alert('프로필이 수정되었습니다!');
    goTo('/mypage');
}
