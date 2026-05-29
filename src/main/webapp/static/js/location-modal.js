const LocationModal = (() => {
    const REGIONS = ['강남구', '서초구', '마포구', '송파구', '홍대', '이태원'];
    const STORAGE_KEY = 'couzl_location';

    let currentLocation = localStorage.getItem(STORAGE_KEY) || '강남구';

    function open() {
        const overlay = document.getElementById('locationModalOverlay');
        if (!overlay) return;
        overlay.classList.add('active');
        document.body.style.overflow = 'hidden';
        _renderList('');
        document.getElementById('locationSearchInput').value = '';
        document.getElementById('locationSearchInput').focus();
    }

    function close() {
        const overlay = document.getElementById('locationModalOverlay');
        if (!overlay) return;
        overlay.classList.remove('active');
        document.body.style.overflow = '';
    }

    function select(region) {
        currentLocation = region;
        localStorage.setItem(STORAGE_KEY, region);

        const locationText = document.querySelector('.location-text');
        if (locationText) locationText.textContent = region;

        _renderList('');
        setTimeout(close, 150);
    }

    function _renderList(query) {
        const items = document.querySelectorAll('.location-item');
        items.forEach(item => {
            const name = item.dataset.region;
            const match = !query || name.includes(query);
            item.classList.toggle('hidden', !match);
            item.classList.toggle('selected', name === currentLocation);
        });
    }

    function init() {
        const locationText = document.querySelector('.location-text');
        if (locationText) locationText.textContent = currentLocation;

        const overlay = document.getElementById('locationModalOverlay');
        if (!overlay) return;

        overlay.addEventListener('click', e => {
            if (e.target === overlay) close();
        });

        document.getElementById('locationSearchInput')
            .addEventListener('input', e => _renderList(e.target.value.trim()));

        document.querySelectorAll('.location-item').forEach(item => {
            item.addEventListener('click', () => select(item.dataset.region));
        });
    }

    return { open, close, init };
})();

document.addEventListener('DOMContentLoaded', () => LocationModal.init());
