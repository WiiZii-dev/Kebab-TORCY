$html = [IO.File]::ReadAllText((Join-Path $PSScriptRoot '..\assets\original-home.html'))
$cssStart = $html.IndexOf('<style id="et-critical-inline-css">')
$cssEnd = $html.IndexOf('</style>', $cssStart)
$css = $html.Substring($cssStart, $cssEnd - $cssStart)
foreach ($term in @('brl-h3-image','.et_pb_code_3','.et_pb_code_5','.et_pb_code_7')) {
  $idx = 0
  while (($idx = $css.IndexOf($term, $idx)) -ge 0) {
    $start = [Math]::Max(0, $idx - 10)
    Write-Output $css.Substring($start, [Math]::Min(180, $css.Length - $start))
    Write-Output '---'
    $idx += $term.Length
  }
}
