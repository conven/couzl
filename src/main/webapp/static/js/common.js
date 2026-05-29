function goTo(path) {
    window.location.href = path;
}

function goToWithSpinner(path) {
    showSpinner();
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

function showSpinner() {
    if (document.getElementById('appSpinnerOverlay')) return;
    var overlay = document.createElement('div');
    overlay.id = 'appSpinnerOverlay';
    overlay.className = 'app-spinner-overlay';
    overlay.innerHTML = '<div class="app-spinner"></div>';
    document.body.appendChild(overlay);
}

function hideSpinner() {
    var overlay = document.getElementById('appSpinnerOverlay');
    if (overlay) overlay.remove();
}
