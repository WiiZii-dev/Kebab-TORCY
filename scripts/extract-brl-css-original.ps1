$html = [IO.File]::ReadAllText((Join-Path $PSScriptRoot '..\assets\original-home.html'))
$cssStart = $html.IndexOf('<style id="et-critical-inline-css">')
$cssEnd = $html.IndexOf('</style>', $cssStart)
$css = $html.Substring($cssStart, $cssEnd - $cssStart)
$matches = [regex]::Matches($css, '[^}]{0,80}(brl-h3|et_pb_code_[357])[^}]{0,120}')
foreach ($m in $matches) { Write-Output $m.Value; Write-Output '---' }
