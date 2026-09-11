$src = 'C:\Users\wiizii\.cursor\projects\c-Users-wiizii-Desktop-berliner-do-com\assets\c__Users_wiizii_AppData_Roaming_Cursor_User_workspaceStorage_5807674626ed332a7110bb34d913a9e6_images_Design_sans_titre_2-354539d6-1d4c-497e-9ecb-23b5c8d37703.webp'
$dst = Join-Path $PSScriptRoot '..\assets\Berliner_titre_kebab.webp'
Copy-Item -LiteralPath $src -Destination $dst -Force

$htmlPath = Join-Path $PSScriptRoot '..\index.html'
$b64 = [Convert]::ToBase64String([IO.File]::ReadAllBytes($dst))
$dataUri = 'data:image/webp;base64,' + $b64
$html = [IO.File]::ReadAllText($htmlPath)
$pattern = '(<div class="et_pb_code_3 et_pb_code et_pb_text_align_center et_pb_module"><div class="et_pb_code_inner"><h3 class="brl-h3-image">\s*<img decoding="async" src=")[^"]+(" alt="LE KEBAB">)'
$newHtml = [regex]::Replace($html, $pattern, { param($m) $m.Groups[1].Value + $dataUri + $m.Groups[2].Value }, 1)
if ($newHtml -eq $html) { throw 'et_pb_code_3 kebab title not found' }
[IO.File]::WriteAllText($htmlPath, $newHtml)
Write-Output "Copied to $dst and embedded webp, b64 length=$($b64.Length)"
