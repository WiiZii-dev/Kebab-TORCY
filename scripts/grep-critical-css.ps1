$html = [IO.File]::ReadAllText((Join-Path $PSScriptRoot '..\index.html'))
$cssStart = $html.IndexOf('<style id="et-critical-inline-css">')
$cssEnd = $html.IndexOf('</style>', $cssStart)
$css = $html.Substring($cssStart, $cssEnd - $cssStart)
$terms = @('brl-h3','et_pb_code_3','et_pb_code_5','et_pb_code_7','et_pb_text_3','et_pb_row_4','et_pb_column_6')
foreach ($t in $terms) {
  $idx = 0
  while (($idx = $css.IndexOf($t, $idx)) -ge 0) {
    $start = [Math]::Max(0, $idx - 20)
    Write-Output $css.Substring($start, [Math]::Min(300, $css.Length - $start))
    Write-Output '---'
    $idx += $t.Length
  }
}
