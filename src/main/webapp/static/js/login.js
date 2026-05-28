function doLogin() {
    var username = document.getElementById('username');
    var password = document.getElementById('password');

    username.classList.remove('error');
    password.classList.remove('error');

    if (username.value === 'couzl' && password.value === 'couzl') {
        goTo('/main');
    } else {
        username.classList.add('error');
        password.classList.add('error');
        showAlert('아이디 또는 비밀번호를 확인해주세요');
    }
}
