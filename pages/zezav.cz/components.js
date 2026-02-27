
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

function renderHeader(title) {
    const headerHTML = `
    <header class="sticky top-0 z-50 backdrop-blur bg-white/80 dark:bg-gray-900/80 border-b border-gray-200 dark:border-gray-800">
        <div class="max-w-4xl mx-auto px-4 py-4 flex items-center justify-between">
            <h1 class="text-xl font-bold tracking-tight">${title}</h1>
        <div class="flex items-center gap-2">
            <button id="lang-toggle"
                class="px-2 py-1 text-sm font-medium rounded-lg hover:bg-gray-200 dark:hover:bg-gray-700 transition-colors"
                aria-label="Toggle language">CS</button>
            <button id="theme-toggle"
                class="p-2 rounded-lg hover:bg-gray-200 dark:hover:bg-gray-700 transition-colors"
                aria-label="Toggle dark mode">
                <svg id="icon-sun" class="w-5 h-5 hidden" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M 12 3 v 1 m 0 16 v 1 m 7 -16 l 1 -1 M 5 19 l -1 1 M 21 12 h -1 M 4 12 H 3 m 17 8 l -1 -1 M 5 5 l -1 -1 M 16 12 a 4 4 0 1 1 -8 0 a 4 4 0 0 1 8 0 z"/>
                </svg>
                <svg id="icon-moon" class="w-5 h-5 hidden" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M21 12.79A9 9 0 1111.21 3a7 7 0 009.79 9.79z"/>
                </svg>
            </button>
        </div>
    </div>
    </header>`;
    
    document.body.insertAdjacentHTML('afterbegin', headerHTML);
    setTimeout(() => { initTheme(); initLang(); }, 0);
}

function renderFooter() {
    const year = new Date().getFullYear();
    
    const footerHTML = `
    <footer class="max-w-4xl mx-auto px-4 py-8 border-t border-gray-200 dark:border-gray-800 mt-8">
        <div class="flex flex-wrap gap-4 text-sm text-gray-500 dark:text-gray-400">
            <a href="https://github.com/zezav-cz" class="hover:underline" target="_blank" rel="noopener">GitHub</a>
            <span>&bull;</span>
            <a href="https://zezav.cz" class="hover:underline">Jan Troják</a>
            <span>&bull;</span>
            <a href="https://pub.zezav.cz" class="hover:underline">Publications</a>
            <span>&bull;</span>
            <a href="https://blog.zezav.cz" class="hover:underline">Blog</a>
            <span>&bull;</span>
            <a href="" data-i18n="cvLabel" data-i18n-href="cvHref" class="hover:underline">CV</a>
            <span class="ml-auto"><span data-i18n="updated">Updated</span>: ${year}</span>
        </div>
    </footer>`;
    
    document.body.insertAdjacentHTML('beforeend', footerHTML);
}
