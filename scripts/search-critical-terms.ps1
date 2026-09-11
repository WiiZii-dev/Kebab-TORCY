$html = [IO.File]::ReadAllText((Join-Path $PSScriptRoot '..\index.html'))
$cssStart = $html.IndexOf('<style id="et-critical-inline-css">')
$cssEnd = $html.IndexOf('</style>', $cssStart)
$css = $html.Substring($cssStart, $cssEnd - $cssStart)
foreach ($term in @('brl-h3','h3-image','code_3 ','code_5 ','code_7 ')) {
  $idx = 0
  $n = 0
  while (($idx = $css.IndexOf($term, $idx)) -ge 0 -and $n -lt 5) {
    $len = [Math]::Min(250, ($css.Length - $idx + 40))
    Write-Output "[$term] $($css.Substring([Math]::Max(0,$idx-40), $len))"
    Write-Output '---'
    $idx += $term.Length
    $n++
  }
}
