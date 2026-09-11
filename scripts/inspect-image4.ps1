$line = (Get-Content (Join-Path $PSScriptRoot '..\index.html'))[1127]
$idx = $line.IndexOf('data:image/png;base64,')
Write-Output "png idx: $idx"
Write-Output "tail: $($line.Substring($line.Length - 250))"
