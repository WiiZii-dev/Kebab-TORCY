(function () {
	'use strict';

	function openNav() {
		document.body.classList.add('kt-nav-open');
		document.body.style.overflow = 'hidden';
	}

	function closeNav() {
		document.body.classList.remove('kt-nav-open');
		document.body.style.overflow = '';
	}

	function toggleNav() {
		if (document.body.classList.contains('kt-nav-open')) closeNav();
		else openNav();
	}

	function bindClick(el, handler) {
		if (!el || el.dataset.ktNavBound === '1') return;
		el.dataset.ktNavBound = '1';
		el.addEventListener('click', handler, { passive: false });
		el.addEventListener('keydown', function (event) {
			if (event.key === 'Enter' || event.key === ' ') {
				event.preventDefault();
				handler(event);
			}
		});
	}

	/* Sous-pages (menu, horaires, actualités) */
	var toggle = document.querySelector('.kt-nav-toggle');
	if (toggle) {
		bindClick(toggle, function (event) {
			event.preventDefault();
			event.stopPropagation();
			var open = !document.body.classList.contains('kt-nav-open');
			if (open) openNav();
			else closeNav();
			toggle.setAttribute('aria-expanded', open ? 'true' : 'false');
		});

		document.querySelectorAll('.kt-site-header nav a').forEach(function (link) {
			bindClick(link, function () {
				closeNav();
			});
		});
	}

	document.addEventListener('keydown', function (event) {
		if (event.key === 'Escape') closeNav();
	});

	/* Accueil — canvas Divi + hamburger */
	var canvas = document.getElementById('brl-mobile-canvas');
	if (!canvas) return;

	var openSelectors = [
		'.et_pb_icon_0_tb_header',
		'.mobile_menu_bar',
		'.et_pb_section_1_tb_header [data-interaction-trigger]'
	];
	var closeSelectors = [
		'.et_pb_icon_1_tb_header',
		'.et_pb_section_2_tb_header [data-interaction-trigger="4pr2kdqjl3"]'
	];

	openSelectors.forEach(function (sel) {
		document.querySelectorAll(sel).forEach(function (el) {
			bindClick(el, function (event) {
				event.preventDefault();
				event.stopPropagation();
				openNav();
			});
		});
	});

	closeSelectors.forEach(function (sel) {
		document.querySelectorAll(sel).forEach(function (el) {
			bindClick(el, function (event) {
				event.preventDefault();
				event.stopPropagation();
				closeNav();
			});
		});
	});

	var canvasLinks = [
		{ sel: '.et_pb_text_0_tb_header', href: '#concept' },
		{ sel: '.et_pb_text_1_tb_header', href: 'menu.html' },
		{ sel: '.et_pb_text_2_tb_header', href: 'horaires.html' },
		{ sel: '.et_pb_text_3_tb_header', href: 'actualites.html' },
		{ sel: '.et_pb_text_4_tb_header', href: 'recrutement.html' }
	];

	canvasLinks.forEach(function (item) {
		document.querySelectorAll(item.sel).forEach(function (el) {
			var inner = el.querySelector('.et_pb_text_inner');
			if (!inner) return;

			var existing = inner.querySelector('a.kt-nav-link');
			if (existing) {
				existing.href = item.href;
				bindClick(existing, function (event) {
					event.stopPropagation();
					closeNav();
				});
				return;
			}

			var link = document.createElement('a');
			link.className = 'kt-nav-link';
			link.href = item.href;
			link.innerHTML = inner.innerHTML;
			inner.innerHTML = '';
			inner.appendChild(link);

			bindClick(link, function (event) {
				event.stopPropagation();
				closeNav();
			});
		});
	});
})();
