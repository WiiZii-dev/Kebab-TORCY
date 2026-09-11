Add-Type -AssemblyName System.Drawing
$bmp = [System.Drawing.Bitmap]::FromFile((Join-Path $PSScriptRoot '..\assets\bowl.jpg'))
$w = $bmp.Width; $h = $bmp.Height
$cx = $w/2.0; $cy = $h/2.0 - ($h*0.03)
function IsTile($r,$g,$b) {
  $bright = ($r+$g+$b)/3.0
  $maxDiff = [Math]::Max([Math]::Abs($r-$g), [Math]::Max([Math]::Abs($r-$b), [Math]::Abs($g-$b)))
  return ($bright -gt 130 -and $maxDiff -lt 40 -and $b -gt 90)
}
foreach ($frac in @(0.20,0.25,0.28,0.30,0.32,0.35,0.40)) {
  $r = $w * $frac
  $tile=0; $total=0
  for ($a=0; $a -lt 360; $a+=2) {
    $rad = $a * [Math]::PI / 180
    $x = [int]($cx + $r * [Math]::Cos($rad))
    $y = [int]($cy + $r * [Math]::Sin($rad))
    if ($x -ge 0 -and $x -lt $w -and $y -ge 0 -and $y -lt $h) {
      $c = $bmp.GetPixel($x,$y)
      $total++
      if (IsTile $c.R $c.G $c.B) { $tile++ }
    }
  }
  Write-Output ("radius {0:P0} tile={1}/{2}" -f $frac, $tile, $total)
}
$bmp.Dispose()
