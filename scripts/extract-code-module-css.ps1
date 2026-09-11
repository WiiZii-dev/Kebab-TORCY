$html = [IO.File]::ReadAllText((Join-Path $PSScriptRoot '..\index.html'))
$cssStart = $html.IndexOf('<style id="et-critical-inline-css">')
$cssEnd = $html.IndexOf('</style>', $cssStart)
$css = $html.Substring($cssStart, $cssEnd - $cssStart)
foreach ($m in [regex]::Matches($css, '\.et_pb_code_[357][^{]*\{[^}]*\}')) {
  Write-Output $m.Value
}
