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

	function setToggleState(toggle, open) {
		if (!toggle) return;
		toggle.setAttribute('aria-expanded', open ? 'true' : 'false');
		toggle.setAttribute('aria-label', open ? 'Fermer le menu' : 'Ouvrir le menu');
	}

	/* Sous-pages (menu, horaires, actualités) */
	var toggle = document.querySelector('.kt-site-header .kt-nav-toggle');
	if (toggle) {
		bindClick(toggle, function (event) {
			event.preventDefault();
			event.stopPropagation();
			var open = !document.body.classList.contains('kt-nav-open');
			if (open) openNav();
			else closeNav();
			setToggleState(toggle, open);
		});

		document.querySelectorAll('.kt-site-header nav a').forEach(function (link) {
			bindClick(link, function () {
				closeNav();
				setToggleState(toggle, false);
			});
		});
	}

	document.addEventListener('keydown', function (event) {
		if (event.key === 'Escape') {
			closeNav();
			document.querySelectorAll('.kt-nav-toggle, .kt-home-nav-toggle').forEach(function (btn) {
				setToggleState(btn, false);
			});
		}
	});

	/* Accueil — logo + hamburger + overlay */
	var homeSection = document.querySelector('.et_pb_section_0_tb_header');
	if (homeSection) {
		var menuWrap = homeSection.querySelector('.et_pb_menu__wrap');
		var homeMenu = homeSection.querySelector('.et_pb_menu__menu');
		var homeToggle = homeSection.querySelector('.kt-home-nav-toggle');

		if (menuWrap && !homeToggle) {
			homeToggle = document.createElement('button');
			homeToggle.type = 'button';
			homeToggle.className = 'kt-nav-toggle kt-home-nav-toggle';
			homeToggle.setAttribute('aria-expanded', 'false');
			homeToggle.setAttribute('aria-label', 'Ouvrir le menu');
			homeToggle.innerHTML =
				'<span class="kt-nav-toggle-bar"></span>' +
				'<span class="kt-nav-toggle-bar"></span>' +
				'<span class="kt-nav-toggle-bar"></span>';
			menuWrap.appendChild(homeToggle);
		}

		if (homeToggle) {
			bindClick(homeToggle, function (event) {
				event.preventDefault();
				event.stopPropagation();
				var open = !document.body.classList.contains('kt-nav-open');
				if (open) openNav();
				else closeNav();
				setToggleState(homeToggle, open);
			});
		}

		if (homeMenu) {
			homeMenu.querySelectorAll('a[href]').forEach(function (link) {
				bindClick(link, function (event) {
					event.stopPropagation();
					closeNav();
					setToggleState(homeToggle, false);
				});
			});

			bindClick(homeMenu, function (event) {
				if (event.target === homeMenu) {
					closeNav();
					setToggleState(homeToggle, false);
				}
			});
		}
	}
})();
