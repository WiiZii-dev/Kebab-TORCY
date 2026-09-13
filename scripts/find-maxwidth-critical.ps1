$html = [IO.File]::ReadAllText((Join-Path $PSScriptRoot '..\index.html'))
$cssStart = $html.IndexOf('<style id="et-critical-inline-css">')
$cssEnd = $html.IndexOf('</style>', $cssStart)
$css = $html.Substring($cssStart, $cssEnd - $cssStart)
$matches = [regex]::Matches($css, '.{0,60}max-width.{0,60}')
foreach ($m in $matches) {
  if ($m.Value -match 'code_[357]|brl-h3|h3-image') {
    Write-Output $m.Value
  }
}
Write-Output '--- all percent max-width ---'
[regex]::Matches($css, '\.et_pb[^}]*max-width:[^;]+%[^}]*\}') | ForEach-Object { $_.Value }
