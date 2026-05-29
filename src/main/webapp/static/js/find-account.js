function sendVerifyCode() {
    const email = document.getElementById('email').value.trim();
    if (!email) {
        alert('이메일을 입력해주세요.');
        return;
    }
    alert('인증번호가 발송되었습니다.');
}

function confirmVerifyCode() {
    const code = document.getElementById('verifyCode').value.trim();
    if (!code) {
        alert('인증번호를 입력해주세요.');
        return;
    }
    const resultArea = document.getElementById('resultArea');
    resultArea.classList.add('show');
}

function sendVerifyCodePw() {
    const email = document.getElementById('email').value.trim();
    if (!email) {
        alert('이메일을 입력해주세요.');
        return;
    }
    alert('인증번호가 발송되었습니다.');
}

function confirmVerifyCodePw() {
    const code = document.getElementById('verifyCode').value.trim();
    if (!code) {
        alert('인증번호를 입력해주세요.');
        return;
    }
    const newPwArea = document.getElementById('newPwArea');
    newPwArea.classList.add('show');
}

function changePassword() {
    const newPw = document.getElementById('newPassword').value.trim();
    const confirmPw = document.getElementById('confirmPassword').value.trim();
    if (!newPw || !confirmPw) {
        alert('새 비밀번호를 입력해주세요.');
        return;
    }
    if (newPw !== confirmPw) {
        alert('비밀번호가 일치하지 않습니다.');
        return;
    }
    alert('비밀번호가 변경되었습니다!');
    goTo('/login');
}
