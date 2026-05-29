/* ===== 탭 전환 ===== */
function switchTab(tabName) {
    document.querySelectorAll('.rv-tab-btn').forEach(function (btn) {
        btn.classList.toggle('active', btn.dataset.tab === tabName);
    });
    document.querySelectorAll('.rv-tab-content').forEach(function (content) {
        content.classList.toggle('active', content.id === 'tab-' + tabName);
    });
}

/* ===== 별점 선택 ===== */
var ratingTexts = ['', '별로예요', '그저 그래요', '보통이에요', '좋아요', '매우 좋아요!'];
var currentRating = 0;

function selectStar(rating) {
    currentRating = rating;
    document.querySelectorAll('.rv-star').forEach(function (star, idx) {
        star.classList.toggle('active', idx < rating);
    });
    var textEl = document.getElementById('rv-rating-text');
    if (textEl) textEl.textContent = ratingTexts[rating] || '';
}

/* ===== 글자수 카운트 ===== */
function updateCharCount() {
    var textarea = document.getElementById('rv-review-text');
    var countEl = document.getElementById('rv-char-count');
    if (!textarea || !countEl) return;
    var len = textarea.value.length;
    countEl.textContent = len + ' / 200';
    if (len > 200) {
        textarea.value = textarea.value.substring(0, 200);
        countEl.textContent = '200 / 200';
    }
}

/* ===== 사진 추가 ===== */
function addPhoto() {
    alert('준비중입니다');
}

/* ===== 리뷰 등록 ===== */
function submitReview() {
    alert('리뷰가 등록되었습니다!');
    goTo('/review-list');
}
