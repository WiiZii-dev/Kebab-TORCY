Add-Type -AssemblyName System.Drawing
$png = [System.Drawing.Bitmap]::FromFile((Join-Path $PSScriptRoot '..\assets\bowl-hero.png'))
$w = $png.Width; $h = $png.Height
$opaque = 0; $trans = 0
$cornerOpaque = 0
foreach ($pt in @(@(10,10), @(10,$h-10), @($w-10,10), @($w-10,$h-10))) {
    if ($png.GetPixel($pt[0], $pt[1]).A -gt 10) { $cornerOpaque++ }
}
for ($y = 0; $y -lt $h; $y++) {
  for ($x = 0; $x -lt $w; $x++) {
    if ($png.GetPixel($x,$y).A -gt 10) { $opaque++ } else { $trans++ }
  }
}
Write-Output "size ${w}x${h} opaque=$opaque trans=$trans cornerOpaque=$cornerOpaque"
$png.Dispose()
