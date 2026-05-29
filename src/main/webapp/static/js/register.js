function checkDuplicate() {
    var val = document.getElementById('userId').value.trim();
    if (!val) {
        showAlert('아이디를 입력해주세요');
        return;
    }
    showAlert('사용 가능한 아이디입니다!');
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
    var email = document.getElementById('email').value.trim();
    if (!email) {
        showAlert('이메일을 입력해주세요');
        return;
    }
    document.getElementById('verifyWrap').classList.add('visible');
}

function confirmVerifyCode() {
    showAlert('인증되었습니다!');
}

function toggleAllTerms(el) {
    var boxes = document.querySelectorAll('.term-item');
    boxes.forEach(function(box) { box.checked = el.checked; });
}

function syncAllTerms() {
    var boxes = document.querySelectorAll('.term-item');
    var allChecked = Array.from(boxes).every(function(b) { return b.checked; });
    document.getElementById('termAll').checked = allChecked;
}

function doRegister() {
    var userId = document.getElementById('userId').value.trim();
    var pw = document.getElementById('password').value;
    var pw2 = document.getElementById('passwordConfirm').value;
    var nickname = document.getElementById('nickname').value.trim();
    var email = document.getElementById('email').value.trim();
    var termRequired1 = document.getElementById('term1').checked;
    var termRequired2 = document.getElementById('term2').checked;

    if (!userId || !pw || !pw2 || !nickname || !email) {
        showAlert('필수 항목을 입력해주세요');
        return;
    }
    if (pw !== pw2) {
        showAlert('비밀번호가 일치하지 않습니다');
        return;
    }
    if (!termRequired1 || !termRequired2) {
        showAlert('필수 항목을 입력해주세요');
        return;
    }

    showAlert('회원가입이 완료되었습니다!');
    setTimeout(function() { goTo('/login'); }, 500);
}
