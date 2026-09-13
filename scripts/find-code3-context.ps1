$path = Join-Path $PSScriptRoot '..\index.html'
$text = [IO.File]::ReadAllText($path)
$needle = 'et_pb_code_3'
$idx = 0
$count = 0
while (($idx = $text.IndexOf($needle, $idx)) -ge 0 -and $count -lt 20) {
  $start = [Math]::Max(0, $idx - 80)
  $snippet = $text.Substring($start, [Math]::Min(220, $text.Length - $start))
  if ($snippet -match 'max-width|brl-h3|width') {
    Write-Output "=== at $idx ==="
    Write-Output $snippet
    Write-Output ''
  }
  $idx += $needle.Length
  $count++
}
