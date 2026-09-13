Add-Type -AssemblyName System.Drawing
$png = [System.Drawing.Bitmap]::FromFile((Join-Path $PSScriptRoot '..\assets\bowl-hero.png'))
$w = $png.Width; $h = $png.Height
$minX=$w; $maxX=0; $minY=$h; $maxY=0
for ($y=0; $y -lt $h; $y++) {
  for ($x=0; $x -lt $w; $x++) {
    if ($png.GetPixel($x,$y).A -gt 20) {
      if ($x -lt $minX) { $minX=$x }
      if ($x -gt $maxX) { $maxX=$x }
      if ($y -lt $minY) { $minY=$y }
      if ($y -gt $maxY) { $maxY=$y }
    }
  }
}
Write-Output "opaque bbox: x=$minX..$maxX y=$minY..$maxY (w=$($maxX-$minX+1) h=$($maxY-$minY+1))"
foreach ($y in @(0, $h/2, $h-1)) {
  $row = @()
  foreach ($x in @(0, $w/4, $w/2, 3*$w/4, $w-1)) {
    $row += $png.GetPixel([int]$x,[int]$y).A
  }
  Write-Output "row y=$y alphas: $($row -join ',')"
}
$png.Dispose()
