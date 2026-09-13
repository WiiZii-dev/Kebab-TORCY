"""Retire les traces WordPress du site statique."""
import re
import shutil
from pathlib import Path

ROOT = Path(r"C:\Users\wiizii\Desktop\KEBAB-TORCY SEDAN")
INDEX = ROOT / "index.html"

INSTAGRAM_BLOCK = """<div class="kt-instagram-grid">
<p class="kt-instagram-title">Suivez-nous sur Instagram</p>
<div class="kt-instagram-items">
<a class="kt-instagram-item" href="https://www.instagram.com/kebab_torcy/" target="_blank" rel="noopener noreferrer"><img loading="lazy" decoding="async" src="assets/kebab-torcy.webp" alt="Kebab torcy sur Instagram" width="400" height="400" /></a>
<a class="kt-instagram-item" href="https://www.instagram.com/kebab_torcy/" target="_blank" rel="noopener noreferrer"><img loading="lazy" decoding="async" src="assets/images/berliner-kebab-pita.webp" alt="Kebab pita torcy" width="400" height="400" /></a>
<a class="kt-instagram-item" href="https://www.instagram.com/kebab_torcy/" target="_blank" rel="noopener noreferrer"><img loading="lazy" decoding="async" src="assets/images/berliner-wrap.webp" alt="Wrap torcy" width="400" height="400" /></a>
</div>
<a class="kt-instagram-cta" href="https://www.instagram.com/kebab_torcy/" target="_blank" rel="noopener noreferrer">@kebab_torcy</a>
</div>"""

INSTAGRAM_CSS = """
.kt-instagram-grid {
	text-align: center;
	padding: 8px 0 18px;
}
.kt-instagram-title {
	font-family: "Thunder Bold", Montserrat, sans-serif;
	font-size: clamp(22px, 4vw, 34px);
	text-transform: uppercase;
	color: #F58220;
	margin: 0 0 18px;
}
.kt-instagram-items {
	display: grid;
	grid-template-columns: repeat(3, minmax(0, 1fr));
	gap: 10px;
	max-width: 920px;
	margin: 0 auto 16px;
}
.kt-instagram-item {
	display: block;
	border-radius: 12px;
	overflow: hidden;
	border: 2px solid #F58220;
}
.kt-instagram-item img {
	display: block;
	width: 100%;
	height: auto;
	aspect-ratio: 1;
	object-fit: cover;
}
.kt-instagram-cta {
	display: inline-block;
	font-weight: 800;
	text-transform: uppercase;
	color: #000;
	background: #F58220;
	padding: 10px 22px;
	border-radius: 999px;
	text-decoration: none;
}
@media (max-width: 767px) {
	.kt-instagram-items { grid-template-columns: 1fr; max-width: 320px; }
}
"""


def clean_index(html: str) -> str:
    html = re.sub(
        r'<meta content="Divi Child v\." name="generator"/><link rel=\'stylesheet\' id=\'sbi_styles-css\' href=\'assets/dxdra\.css\' media=\'all\' />\s*',
        "",
        html,
    )
    html = re.sub(
        r"<style id=\"global-styles-inline-css\">.*?</style>\s*",
        "",
        html,
        flags=re.DOTALL,
    )
    html = re.sub(
        r"<link rel='stylesheet' id='cmplz-general-css' href='assets/dxdra\.css' media='all' />\s*",
        "",
        html,
    )
    html = re.sub(
        r"<style>\.cmplz-hidden \{[^}]+\}</style>",
        "",
        html,
    )
    html = re.sub(
        r"<style id=\"custom-background-css\">.*?</style>\s*",
        "",
        html,
    )
    html = re.sub(
        r"#cmplz-cookiebanner-container,.*?\.cmplz-cookiebanner \.cmplz-btn\.cmplz-accept \{[^}]+\}\s*",
        "",
        html,
        flags=re.DOTALL,
    )
    html = html.replace(
        '<body data-rsssl=1 data-cmplz=1 class="home wp-singular page-template-default page page-id-11 custom-background wp-theme-Divi wp-child-theme-Divi_child et-tb-has-template et-tb-has-header et-tb-has-footer et_pb_button_helper_class et_cover_background et_pb_gutter et_pb_gutters3 et_pb_pagebuilder_layout et_no_sidebar et_divi_theme et-db">',
        '<body class="home et-tb-has-template et-tb-has-header et-tb-has-footer et_pb_button_helper_class et_cover_background et_pb_gutter et_pb_gutters3 et_pb_pagebuilder_layout et_no_sidebar et_divi_theme et-db">',
    )
    html = re.sub(
        r'<script type="speculationrules">\s*\{.*?\}\s*</script>\s*',
        "",
        html,
        flags=re.DOTALL,
    )
    html = re.sub(
        r"<!-- Consent Management powered by Complianz.*?<!-- Statistics script Complianz GDPR/CCPA -->\s*",
        "",
        html,
        flags=re.DOTALL,
    )
    html = re.sub(
        r'<script type="text/plain"[^>]*data-cmplz-src="https://www\.googletagmanager\.com/gtag/js\?id=G-F59006BTNB"></script>\s*',
        "",
        html,
    )
    html = re.sub(
        r'<script type="text/plain"[^>]*data-category="statistics">.*?</script>\s*',
        "",
        html,
        flags=re.DOTALL,
    )
    html = re.sub(
        r'<div id="sb_instagram"[^>]*>.*?</div>\s*</div></div>\s*</div>\s*</div>\s*<div class="et_pb_row_24',
        f'{INSTAGRAM_BLOCK}\n</div></div>\n</div>\n</div>\n<div class="et_pb_row_24',
        html,
        flags=re.DOTALL,
    )
    html = re.sub(
        r"<!-- WP Fastest Cache file was created.*?--><!-- via php -->",
        "",
        html,
        flags=re.DOTALL,
    )
    if INSTAGRAM_CSS.strip() not in html:
        html = html.replace(
            "</style>\nimg[src*=\"LEBERLINER_bleu\"]",
            INSTAGRAM_CSS + "\nimg[src*=\"LEBERLINER_bleu\"]",
            1,
        )
    return html


def delete_paths():
    targets = [
        ROOT / "assets" / "original-home.html",
        ROOT / "assets" / "dxdra.css",
        ROOT / "assets" / "remote" / "complianz.min.js",
        ROOT / "assets" / "remote" / "sbi-scripts.min.js",
        ROOT / "assets" / "remote" / "xmlrpc.php",
        ROOT / "assets" / "remote" / "uploads",
        ROOT / "assets" / "remote" / "fonts",
    ]
    for path in targets:
        if path.is_dir():
            shutil.rmtree(path, ignore_errors=True)
        elif path.exists():
            path.unlink()


def main():
    html = INDEX.read_text(encoding="utf-8")
    cleaned = clean_index(html)
    INDEX.write_text(cleaned, encoding="utf-8")
    delete_paths()
    print("index.html cleaned")
    print("removed wordpress plugin files and backups")


if __name__ == "__main__":
    main()
