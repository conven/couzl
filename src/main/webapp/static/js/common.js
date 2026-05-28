function goTo(path) {
    window.location.href = path;
}

function showAlert(msg) {
    alert(msg);
}

function getToken() {
    return localStorage.getItem('token');
}

function setToken(token) {
    localStorage.setItem('token', token);
}

function removeToken() {
    localStorage.removeItem('token');
}
