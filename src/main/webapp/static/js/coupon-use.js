(function () {
    new QRCode(document.getElementById('qrcode'), {
        text: 'https://couzl.com/coupon/approve?id=123',
        width: 200,
        height: 200,
        colorDark: '#1A1A1A',
        colorLight: '#FFFFFF',
        correctLevel: QRCode.CorrectLevel.M
    });
})();
