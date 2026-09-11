$html = [IO.File]::ReadAllText((Join-Path $PSScriptRoot '..\index.html'))
$cssStart = $html.IndexOf('<style id="et-critical-inline-css">')
$cssEnd = $html.IndexOf('</style>', $cssStart)
$css = $html.Substring($cssStart, $cssEnd - $cssStart)
$idx = 0
while (($idx = $css.IndexOf('brl-h3', $idx)) -ge 0) {
  Write-Output $css.Substring([Math]::Max(0,$idx-30), 200)
  Write-Output '---'
  $idx += 5
}
