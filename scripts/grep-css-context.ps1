$html = [IO.File]::ReadAllText((Join-Path $PSScriptRoot '..\index.html'))
$patterns = @('brl-h3-image','\.et_pb_code_3','\.et_pb_code_5','\.et_pb_row_4','\.et_pb_column_6','\.et_pb_text_3')
foreach ($pat in $patterns) {
  $idx = 0
  while (($idx = $html.IndexOf($pat, $idx)) -ge 0) {
    $start = [Math]::Max(0, $idx - 60)
    $len = [Math]::Min(500, $html.Length - $start)
    Write-Output "=== $pat @ $idx ==="
    Write-Output $html.Substring($start, $len)
    Write-Output ''
    $idx += $pat.Length
    if ($idx -gt 500000) { break }
  }
}
