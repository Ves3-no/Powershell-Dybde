#Skrevet av alex vg2 (Leser koden for å se om jeg forstår noe etter videoene)

﻿$downloadsPath = "$env:USERPROFILE\Downloads"

$categoryMap = @{
    ".png"  = "Images"
    ".avif" = "Images"
    ".zip"  = "Archives"
    ".exe"  = "Installers"
    ".msi"  = "Installers"
    ".txt"  = "Documents"
    ".docx" = "Documents"
    ".pdf"  = "Documents"
    ".jpg"  = "images"
    ".mp4"  = "movies"
    ".sb3"  = "Scratch"
}

$files = Get-ChildItem $downloadsPath -File

foreach ($file in $files) {
    $ext = $file.Extension

    if ($categoryMap.ContainsKey($ext)) {
        $folderName = $categoryMap[$ext]
        $destFolder = Join-Path $downloadsPath $folderName

        if (-not (Test-Path $destFolder)) {
            New-Item -ItemType Directory -Path $destFolder | Out-Null
        }

        Move-Item $file.FullName -Destination $destFolder
    }
}

Write-Host "Done organizing!" -ForegroundColor Green