$css = [IO.File]::ReadAllText((Join-Path $PSScriptRoot '..\assets\divi-deferred.css'))
foreach ($term in @('brl-h3','et_pb_code_3','et_pb_code_5','et_pb_code_7')) {
  $idx = 0
  while (($idx = $css.IndexOf($term, $idx)) -ge 0) {
    $start = [Math]::Max(0, $idx - 30)
    $end = [Math]::Min($css.Length, $idx + 150)
    Write-Output $css.Substring($start, $end - $start)
    Write-Output '---'
    $idx += $term.Length
  }
}
