var emailVerified = false;
var idChecked = false;
var verifyTimerId = null;
var verifyExpiresAt = 0;

function startVerifyTimer(seconds) {
    stopVerifyTimer();
    verifyExpiresAt = Date.now() + seconds * 1000;
    var el = document.getElementById('verifyTimer');
    el.style.display = 'block';
    el.style.color = '#B8A000';
    renderVerifyTimer();
    verifyTimerId = setInterval(renderVerifyTimer, 1000);
}

function stopVerifyTimer() {
    if (verifyTimerId) {
        clearInterval(verifyTimerId);
        verifyTimerId = null;
    }
}

function renderVerifyTimer() {
    var el = document.getElementById('verifyTimer');
    var remain = Math.max(0, Math.floor((verifyExpiresAt - Date.now()) / 1000));
    if (remain === 0) {
        stopVerifyTimer();
        el.style.color = '#e74c3c';
        el.textContent = '인증코드가 만료되었습니다. 다시 발송해주세요';
        return;
    }
    var m = Math.floor(remain / 60);
    var s = remain % 60;
    el.textContent = '남은 시간 ' + m + ':' + (s < 10 ? '0' + s : s);
}

function checkDuplicate() {
    var val = document.getElementById('userId').value.trim();
    if (!val) {
        showAlert('아이디를 입력해주세요');
        return;
    }

    showSpinner();
    fetch('/register/check-id', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
        body: 'loginId=' + encodeURIComponent(val)
    })
        .then(function (res) { return res.json(); })
        .then(function (data) {
            idChecked = data.success;
            var input = document.getElementById('userId');
            input.style.borderColor = data.success ? '#1ec773' : '#e74c3c';
            showAlert(data.message);
        })
        .catch(function () {
            idChecked = false;
            showAlert('요청 처리에 실패했습니다');
        })
        .finally(function () { hideSpinner(); });
}

function onUserIdChange() {
    idChecked = false;
    document.getElementById('userId').style.borderColor = '';
}

function togglePw(inputId, btn) {
    var input = document.getElementById(inputId);
    if (input.type === 'password') {
        input.type = 'text';
        btn.textContent = '🙈';
    } else {
        input.type = 'password';
        btn.textContent = '👁';
    }
}

function checkPwMatch() {
    var pw = document.getElementById('password').value;
    var pw2 = document.getElementById('passwordConfirm').value;
    var msg = document.getElementById('pwMatchError');
    if (pw2 && pw !== pw2) {
        msg.classList.add('visible');
    } else {
        msg.classList.remove('visible');
    }
}

function sendVerifyCode() {
    var loginId = document.getElementById('userId').value.trim();
    var pw = document.getElementById('password').value;
    var pw2 = document.getElementById('passwordConfirm').value;
    var nickname = document.getElementById('nickname').value.trim();
    var email = document.getElementById('email').value.trim();

    if (!loginId || !pw || !pw2 || !nickname || !email) {
        showAlert('아이디/비밀번호/닉네임/이메일을 모두 입력해주세요');
        return;
    }
    if (!idChecked) {
        showAlert('아이디 중복확인을 해주세요');
        return;
    }
    if (pw !== pw2) {
        showAlert('비밀번호가 일치하지 않습니다');
        return;
    }

    var body = 'loginId=' + encodeURIComponent(loginId)
             + '&nickname=' + encodeURIComponent(nickname)
             + '&email=' + encodeURIComponent(email)
             + '&password=' + encodeURIComponent(pw);

    showSpinner();
    fetch('/register/send-code', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
        body: body
    })
        .then(function (res) { return res.json(); })
        .then(function (data) {
            if (data.success) {
                document.getElementById('verifyWrap').classList.add('visible');
                var input = document.getElementById('verifyCode');
                input.disabled = false;
                input.value = '';
                input.style.borderColor = '';
                emailVerified = false;
                startVerifyTimer(300);
            }
            showAlert(data.message);
        })
        .catch(function () { showAlert('요청 처리에 실패했습니다'); })
        .finally(function () { hideSpinner(); });
}

function confirmVerifyCode() {
    var email = document.getElementById('email').value.trim();
    var code = document.getElementById('verifyCode').value.trim();
    if (!email || !code) {
        showAlert('인증코드를 입력해주세요');
        return;
    }

    var body = 'email=' + encodeURIComponent(email)
             + '&code=' + encodeURIComponent(code);

    showSpinner();
    fetch('/register/verify-code', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
        body: body
    })
        .then(function (res) { return res.json(); })
        .then(function (data) {
            if (data.success) {
                emailVerified = true;
                stopVerifyTimer();
                var timerEl = document.getElementById('verifyTimer');
                timerEl.style.color = '#1ec773';
                timerEl.textContent = '✓ 인증 완료';
                var input = document.getElementById('verifyCode');
                input.disabled = true;
                input.style.borderColor = '#1ec773';
                input.value = '✓ ' + input.value;
            } else {
                emailVerified = false;
            }
            showAlert(data.message);
        })
        .catch(function () { showAlert('요청 처리에 실패했습니다'); })
        .finally(function () { hideSpinner(); });
}

function toggleAllTerms(el) {
    var boxes = document.querySelectorAll('.term-item');
    boxes.forEach(function (box) { box.checked = el.checked; });
}

function syncAllTerms() {
    var boxes = document.querySelectorAll('.term-item');
    var allChecked = Array.from(boxes).every(function (b) { return b.checked; });
    document.getElementById('termAll').checked = allChecked;
}

function doRegister() {
    var email = document.getElementById('email').value.trim();
    var termRequired1 = document.getElementById('term1').checked;
    var termRequired2 = document.getElementById('term2').checked;

    if (!emailVerified) {
        showAlert('이메일 인증을 완료해주세요');
        return;
    }
    if (!termRequired1 || !termRequired2) {
        showAlert('필수 약관에 동의해주세요');
        return;
    }

    var form = document.createElement('form');
    form.method = 'POST';
    form.action = '/register';

    var input = document.createElement('input');
    input.type = 'hidden';
    input.name = 'email';
    input.value = email;
    form.appendChild(input);

    document.body.appendChild(form);
    showSpinner();
    form.submit();
}
