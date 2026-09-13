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

	/* Sous-pages (menu, horaires, actualités) */
	var toggle = document.querySelector('.kt-nav-toggle');
	if (toggle) {
		toggle.addEventListener('click', function () {
			var open = !document.body.classList.contains('kt-nav-open');
			if (open) openNav();
			else closeNav();
			toggle.setAttribute('aria-expanded', open ? 'true' : 'false');
		});

		document.querySelectorAll('.kt-site-header nav a').forEach(function (link) {
			link.addEventListener('click', closeNav);
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
			el.addEventListener('click', function (event) {
				event.preventDefault();
				event.stopPropagation();
				openNav();
			});
		});
	});

	closeSelectors.forEach(function (sel) {
		document.querySelectorAll(sel).forEach(function (el) {
			el.addEventListener('click', function (event) {
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
			el.addEventListener('click', function () {
				closeNav();
				if (item.href.charAt(0) === '#') {
					var dest = document.getElementById(item.href.slice(1));
					if (dest) dest.scrollIntoView({ behavior: 'smooth', block: 'start' });
					else window.location.href = 'index.html' + item.href;
				} else {
					window.location.href = item.href;
				}
			});
		});
	});
})();
