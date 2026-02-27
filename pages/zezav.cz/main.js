// ── Bootstrap ────────────────────────────────────────────────
renderHeader('Jan Troják');

// (footer is rendered after the DOM is ready — see bottom)

// ── Language badge colours ────────────────────────────────────
const langColors = {
  English:    'bg-sky-100 text-sky-800 dark:bg-sky-900 dark:text-sky-200',
  Angličtina: 'bg-sky-100 text-sky-800 dark:bg-sky-900 dark:text-sky-200',
  Czech:      'bg-amber-100 text-amber-800 dark:bg-amber-900 dark:text-amber-200',
  Čeština:    'bg-amber-100 text-amber-800 dark:bg-amber-900 dark:text-amber-200',
};

const tagColors = {
  'Bachelor Thesis':   'bg-purple-100 text-purple-800 dark:bg-purple-900 dark:text-purple-200',
  'Bakalářská práce':  'bg-purple-100 text-purple-800 dark:bg-purple-900 dark:text-purple-200',
  'Master Thesis':     'bg-indigo-100 text-indigo-800 dark:bg-indigo-900 dark:text-indigo-200',
  'Diplomová práce':   'bg-indigo-100 text-indigo-800 dark:bg-indigo-900 dark:text-indigo-200',
  Presentation:        'bg-rose-100 text-rose-800 dark:bg-rose-900 dark:text-rose-200',
  Prezentace:          'bg-rose-100 text-rose-800 dark:bg-rose-900 dark:text-rose-200',
  Awarded:             'bg-green-100 text-green-800 dark:bg-green-900 dark:text-green-200',
  Oceněno:             'bg-green-100 text-green-800 dark:bg-green-900 dark:text-green-200',
};

// ── Date formatting helper ───────────────────────────────────
function formatDate(d) {
  if (!d) return '';
  const parts = d.split('-');
  if (parts.length === 1) return parts[0];
  const date = new Date(parts[0], (parts[1] || 1) - 1);
  return date.toLocaleDateString('en-US', { month: 'long', year: 'numeric' });
}

// ── Escape HTML helper ───────────────────────────────────────
function esc(s) {
  const el = document.createElement('span');
  el.textContent = s;
  return el.innerHTML;
}

// ── Render a collapsible section ─────────────────────────────
function collapsible(label, inner) {
  return `<details class="foldable group">
    <summary class="cursor-pointer text-xs font-medium text-gray-500 dark:text-gray-400 hover:text-gray-800 dark:hover:text-gray-200 select-none list-none [&::-webkit-details-marker]:hidden">
      <span class="fold-arrow inline-block transition-transform duration-200 mr-1">&#9654;</span>${label}
    </summary>
    <div class="mt-2">${inner}</div>
  </details>`;
}

// ── Render one publication card ──────────────────────────────
function renderCard(pub) {
  const langBadge = langColors[pub.language] || langColors.English;
  const badges = `<span class="text-xs font-medium px-2 py-0.5 rounded-full ${langBadge}">${esc(pub.language)}</span>`
    + (pub.tags || []).map(t => {
        const tc = tagColors[t] || 'bg-gray-100 text-gray-800 dark:bg-gray-800 dark:text-gray-200';
        return `<span class="text-xs font-medium px-2 py-0.5 rounded-full ${tc}">${esc(t)}</span>`;
      }).join('');

  const linksHtml = (pub.links || []).map(l =>
    `<span>•</span><a href="${esc(l.url)}" class="hover:underline text-blue-500" target="_blank" rel="noopener">${esc(l.label)}</a>`
  ).join('');

  let abstractsHtml = '';
  if (pub.abstract) {
    const inner = `<p class="text-sm text-gray-600 dark:text-gray-400">${esc(pub.abstract)}</p>`;
    abstractsHtml = collapsible('Abstract', `<div class="p-3 rounded-lg bg-gray-100 dark:bg-gray-800">${inner}</div>`);
  }

  let keywordsHtml = '';
  if (pub.keywords && pub.keywords.length) {
    const inner = pub.keywords.map(w =>
      `<span class="inline-block text-xs px-2 py-0.5 mr-1 mb-1 rounded-full bg-gray-200 dark:bg-gray-700 text-gray-700 dark:text-gray-300">${esc(w)}</span>`
    ).join('');
    keywordsHtml = collapsible('Keywords', `<div class="p-3 rounded-lg bg-gray-100 dark:bg-gray-800">${inner}</div>`);
  }

  return `
    <article class="rounded-xl border border-gray-200 dark:border-gray-800 bg-white dark:bg-gray-900 p-5 shadow-sm hover:shadow-md transition-shadow">
      <div class="flex flex-wrap items-start justify-between gap-2 mb-2">
        <h2 class="text-lg font-semibold">
          ${pub.links && pub.links.length
            ? `<a href="${esc(pub.links[0].url)}" class="hover:underline text-blue-600 dark:text-blue-400" target="_blank" rel="noopener">${esc(pub.title)}</a>`
            : `<span>${esc(pub.title)}</span>`}
        </h2>
        <div class="flex gap-2 flex-shrink-0">${badges}</div>
      </div>
      <p class="text-sm text-gray-600 dark:text-gray-400 mb-2">${esc(pub.description)}</p>
      <div class="flex items-center gap-3 text-xs text-gray-500 dark:text-gray-500 mb-3">
        <time>${esc(formatDate(pub.date))}</time>
        ${linksHtml}
      </div>
      <div class="space-y-2">
        ${abstractsHtml}
        ${keywordsHtml}
      </div>
    </article>`;
}

// ── Render project cards ─────────────────────────────────────
function renderProjects(lang) {
  const projects = i18n[lang]?.projects || i18n['en'].projects;
  if (!projects) return;
  document.getElementById('projects').innerHTML = projects.map(p => `
    <a href="${esc(p.url)}" target="_blank" rel="noopener"
      class="group rounded-xl border border-gray-200 dark:border-gray-800 bg-white dark:bg-gray-900 p-5 shadow-sm hover:shadow-md hover:border-blue-300 dark:hover:border-blue-700 transition-all">
      <h3 class="text-base font-semibold text-blue-600 dark:text-blue-400 group-hover:underline mb-1">${esc(p.name)}</h3>
      <p class="text-sm text-gray-500 dark:text-gray-400 leading-relaxed">${esc(p.description)}</p>
    </a>`).join('');
}

// ── Render publication cards ─────────────────────────────────
function renderPublications(lang) {
  const pubs = i18n[lang]?.publications || i18n['en'].publications;
  if (!pubs) return;
  const container = document.getElementById('publications');
  container.innerHTML = pubs.map(renderCard).join('');
  container.querySelectorAll('details.foldable').forEach(d => {
    d.addEventListener('toggle', () => {
      const arrow = d.querySelector('.fold-arrow');
      if (arrow) arrow.style.transform = d.open ? 'rotate(90deg)' : '';
    });
  });
}

// ── Render all dynamic content ───────────────────────────────
function renderAll(lang) {
  renderProjects(lang);
  renderPublications(lang);
}

// ── Init: footer + deferred render after initLang() ──────────
renderFooter();

setTimeout(() => {
  const lang = document.documentElement.lang || 'en';
  renderAll(lang);

  const btn = document.getElementById('lang-toggle');
  if (btn) btn.addEventListener('click', () => {
    setTimeout(() => renderAll(document.documentElement.lang), 0);
  });
}, 0);
