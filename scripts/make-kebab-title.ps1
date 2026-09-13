Add-Type -AssemblyName System.Drawing

$fontPath = Join-Path $PSScriptRoot '..\assets\Thunder-ExtraBoldLC.otf'
$outPng = Join-Path $PSScriptRoot '..\assets\Berliner_titre_kebab.png'
$w = 512
$h = 376
$clipTop = 78

$bmp = New-Object System.Drawing.Bitmap $w, $h, ([System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
$gfx = [System.Drawing.Graphics]::FromImage($bmp)
$gfx.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
$gfx.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::AntiAliasGridFit
$gfx.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic

$bg = [System.Drawing.Color]::FromArgb(255, 23, 25, 55)
$fg = [System.Drawing.Color]::FromArgb(255, 248, 180, 30)
$gfx.Clear($bg)

$pfc = New-Object System.Drawing.Text.PrivateFontCollection
$pfc.AddFontFile($fontPath)
$family = $pfc.Families[0]
$fontSize = 108.0
$font = New-Object System.Drawing.Font($family, $fontSize, [System.Drawing.FontStyle]::Regular, [System.Drawing.GraphicsUnit]::Pixel)
$brush = New-Object System.Drawing.SolidBrush($fg)
$format = New-Object System.Drawing.StringFormat
$format.Alignment = [System.Drawing.StringAlignment]::Near
$format.LineAlignment = [System.Drawing.StringAlignment]::Far
$format.Trimming = [System.Drawing.StringTrimming]::None
$format.FormatFlags = [System.Drawing.StringFormatFlags]::NoWrap

$lineHeight = 118
$left = 2
$yBottom = 360
for ($i = 0; $i -lt 3; $i++) {
    $y = $yBottom - ($i * $lineHeight)
    $rect = New-Object System.Drawing.RectangleF($left, ($y - $lineHeight), ($w - 4), $lineHeight)
    $gfx.SetClip([System.Drawing.Rectangle]::FromLTRB(0, $clipTop, $w, $h))
    $gfx.DrawString('LE KEBAB', $font, $brush, $rect, $format)
}

$bmp.Save($outPng, [System.Drawing.Imaging.ImageFormat]::Png)
$gfx.Dispose()
$bmp.Dispose()
Write-Output "Saved $outPng"
