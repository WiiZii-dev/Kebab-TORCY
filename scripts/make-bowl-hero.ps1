Add-Type -AssemblyName System.Drawing

$src = Join-Path $PSScriptRoot '..\assets\bowl.jpg'
$dst = Join-Path $PSScriptRoot '..\assets\bowl-hero.png'
$bmp = [System.Drawing.Bitmap]::FromFile($src)
$w = $bmp.Width
$h = $bmp.Height
$cx = $w / 2.0
$cy = $h / 2.0 - ($h * 0.03)
$keepRadius = $w * 0.315
$out = New-Object System.Drawing.Bitmap($w, $h, [System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
$out.SetResolution($bmp.HorizontalResolution, $bmp.VerticalResolution)

function Test-TilePixel([int]$r, [int]$g, [int]$b) {
    $bright = ($r + $g + $b) / 3.0
    $maxDiff = [Math]::Max([Math]::Abs($r - $g), [Math]::Max([Math]::Abs($r - $b), [Math]::Abs($g - $b)))
    return ($bright -gt 130 -and $maxDiff -lt 40 -and $b -gt 90 -and $r -lt 252)
}

function Test-EdgeBackground([int]$r, [int]$g, [int]$b) {
    if ($r -lt 72 -and $g -lt 72 -and $b -lt 72) { return $true }
    return (Test-TilePixel $r $g $b)
}

$mask = New-Object 'bool[,]' $w, $h
$queue = New-Object System.Collections.Generic.Queue[int[]]

for ($x = 0; $x -lt $w; $x++) {
    foreach ($y in @(0, ($h - 1))) {
        $c = $bmp.GetPixel($x, $y)
        if (Test-EdgeBackground $c.R $c.G $c.B) {
            if (-not $mask[$x, $y]) { $mask[$x, $y] = $true; $queue.Enqueue(@($x, $y)) }
        }
    }
}
for ($y = 0; $y -lt $h; $y++) {
    foreach ($x in @(0, ($w - 1))) {
        $c = $bmp.GetPixel($x, $y)
        if (Test-EdgeBackground $c.R $c.G $c.B) {
            if (-not $mask[$x, $y]) { $mask[$x, $y] = $true; $queue.Enqueue(@($x, $y)) }
        }
    }
}

while ($queue.Count -gt 0) {
    $p = $queue.Dequeue()
    $x = $p[0]
    $y = $p[1]
    foreach ($d in @(@(-1, 0), @(1, 0), @(0, -1), @(0, 1))) {
        $nx = $x + $d[0]
        $ny = $y + $d[1]
        if ($nx -lt 0 -or $ny -lt 0 -or $nx -ge $w -or $ny -ge $h) { continue }
        if ($mask[$nx, $ny]) { continue }
        $c = $bmp.GetPixel($nx, $ny)
        if (Test-EdgeBackground $c.R $c.G $c.B) {
            $mask[$nx, $ny] = $true
            $queue.Enqueue(@($nx, $ny))
        }
    }
}

for ($y = 0; $y -lt $h; $y++) {
    for ($x = 0; $x -lt $w; $x++) {
        $c = $bmp.GetPixel($x, $y)
        $dx = $x - $cx
        $dy = $y - $cy
        $dist = [Math]::Sqrt($dx * $dx + $dy * $dy)
        $remove = $mask[$x, $y] -or ($dist -gt $keepRadius)
        if (-not $remove -and $dist -gt ($keepRadius * 0.88) -and (Test-TilePixel $c.R $c.G $c.B)) { $remove = $true }
        if ($remove) {
            $out.SetPixel($x, $y, [System.Drawing.Color]::FromArgb(0, 0, 0, 0)) | Out-Null
        } else {
            $out.SetPixel($x, $y, [System.Drawing.Color]::FromArgb(255, $c.R, $c.G, $c.B)) | Out-Null
        }
    }
}

$out.Save($dst, [System.Drawing.Imaging.ImageFormat]::Png)
$bmp.Dispose()
$out.Dispose()
Write-Output "Saved $dst"
