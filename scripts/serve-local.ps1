$port = 8765
$root = Split-Path $PSScriptRoot -Parent

$mime = @{
    '.html' = 'text/html; charset=utf-8'
    '.css'  = 'text/css; charset=utf-8'
    '.js'   = 'application/javascript; charset=utf-8'
    '.json' = 'application/json; charset=utf-8'
    '.jpg'  = 'image/jpeg'
    '.jpeg' = 'image/jpeg'
    '.png'  = 'image/png'
    '.webp' = 'image/webp'
    '.gif'  = 'image/gif'
    '.svg'  = 'image/svg+xml'
    '.ico'  = 'image/x-icon'
    '.woff' = 'font/woff'
    '.woff2'= 'font/woff2'
    '.otf'  = 'font/otf'
}

$listener = New-Object System.Net.HttpListener
$listener.Prefixes.Add("http://127.0.0.1:$port/")
$listener.Start()
Write-Host "Serving $root on http://127.0.0.1:$port/"

while ($listener.IsListening) {
    $ctx = $listener.GetContext()
    $path = $ctx.Request.Url.LocalPath
    if ($path -eq '/') { $path = '/index.html' }

    $relative = $path.TrimStart('/').Replace('/', [IO.Path]::DirectorySeparatorChar)
    $file = Join-Path $root $relative

    if (Test-Path $file -PathType Leaf) {
        $bytes = [IO.File]::ReadAllBytes($file)
        $ext = [IO.Path]::GetExtension($file).ToLowerInvariant()
        $type = $mime[$ext]
        if (-not $type) { $type = 'application/octet-stream' }
        $ctx.Response.ContentType = $type
        $ctx.Response.OutputStream.Write($bytes, 0, $bytes.Length)
    } else {
        $ctx.Response.StatusCode = 404
    }
    $ctx.Response.Close()
}
