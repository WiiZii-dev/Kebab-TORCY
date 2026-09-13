$htmlPath = Join-Path $PSScriptRoot '..\index.html'
$pngPath = Join-Path $PSScriptRoot '..\assets\bowl-hero.png'
$b64 = [Convert]::ToBase64String([IO.File]::ReadAllBytes($pngPath))
$html = [IO.File]::ReadAllText($htmlPath)
$markerStart = '<div class="et_pb_image_4 et_pb_image et_pb_module et_flex_module"><span class="et_pb_image_wrap"><img loading="lazy" decoding="async" src="data:image/png;base64,'
$markerEnd = '" class="wp-image-160" title="Berliner_bowl" /></span></div>'
$startIdx = $html.IndexOf($markerStart)
if ($startIdx -lt 0) { throw 'et_pb_image_4 PNG marker not found' }
$dataStart = $startIdx + $markerStart.Length
$endIdx = $html.IndexOf($markerEnd, $dataStart)
if ($endIdx -lt 0) { throw 'et_pb_image_4 end marker not found' }
$newHtml = $html.Substring(0, $dataStart) + $b64 + $html.Substring($endIdx)
[IO.File]::WriteAllText($htmlPath, $newHtml)
Write-Output "Updated et_pb_image_4 PNG base64, length=$($b64.Length)"
