
function applyLang(lang) {
    if (typeof i18n === 'undefined') return;
    document.querySelectorAll('[data-i18n]').forEach(el => {
        const key = el.dataset.i18n;
        if (i18n[lang]?.[key] !== undefined) el.innerHTML = i18n[lang][key];
    });
    document.querySelectorAll('[data-i18n-href]').forEach(el => {
        const key = el.dataset.i18nHref;
        if (i18n[lang]?.[key] !== undefined) el.href = i18n[lang][key];
    });
    document.documentElement.lang = lang;
    localStorage.setItem('lang', lang);
    const btn = document.getElementById('lang-toggle');
    if (btn) btn.textContent = lang === 'en' ? 'CS' : 'EN';
}

function initLang() {
    const stored = localStorage.getItem('lang');
    const browserLang = navigator.language.startsWith('cs') ? 'cs' : 'en';
    applyLang(stored || browserLang);
    const btn = document.getElementById('lang-toggle');
    if (btn) btn.addEventListener('click', () => {
        applyLang(document.documentElement.lang === 'en' ? 'cs' : 'en');
    });
}

// Helper to toggle theme
function initTheme() {
    const html = document.documentElement;
    const toggle = document.getElementById('theme-toggle');
    const iconSun = document.getElementById('icon-sun');
    const iconMoon = document.getElementById('icon-moon');

    function applyTheme(dark) {
        html.classList.toggle('dark', dark);
        iconSun.classList.toggle('hidden', !dark);
        iconMoon.classList.toggle('hidden', dark);
        localStorage.setItem('theme', dark ? 'dark' : 'light');
    }

    const stored = localStorage.getItem('theme');
    applyTheme(stored === 'dark' || (!stored && window.matchMedia('(prefers-color-scheme: dark)').matches));

    if (toggle) {
        toggle.addEventListener('click', () => applyTheme(!html.classList.contains('dark')));
    }
}
