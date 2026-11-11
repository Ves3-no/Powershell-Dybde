$path = "$env:USERPROFILE\Downloads"

$filesMoved = New-Object -TypeName System.Collections.ArrayList
$CountfilesMoved = 0
$filesGoneTrough = 0

$types = @{
    "Documents" = @(".txt", ".docx", ".doc", ".pdf", ".xlsx",".xls", ".pptx", ".ppt", ".ai", ".json", ".md")
    "Images" = @(".jpeg", ".jpg", ".png", ".gif", ".svg", ".tif", ".tiff", ".webp", ".ico")
    "Sound and Video" = @(".mp3", ".wav", ".mp4", ".mov", ".mkv")
    "Archives" = @(".zip", ".7z", ".rar")
    "Apps" = @(".py", ".js", ".cpp", ".html", ".exe", ".msi", ".iso", ".hex")
}

$files = Get-ChildItem -Path $path -File

function Write-Message{
    Write-Host "`n=========== Info ===========`n"

    Write-Host "Antall filer gjennomgått: $filesGoneTrough"
    Write-Host "Antall filer flyttet: $CountfilesMoved `n"

    Write-Host "Filer flyttet: `n"

    foreach ($fileName in $filesMoved) {
		Write-Host $fileName
	}

    Write-Host "`n============================`n"
    
}

foreach($file in $files){
    $extention = $file.Extension.ToLower()
    $filesGoneTrough++
    foreach($type in $types.GetEnumerator()){
        if($type.Value -contains $extention){
            $target = Join-Path $path $type.Key

            if(-not(Test-Path $target)){
                New-Item -Path $target -ItemType Directory
            }
            
            Move-Item -Destination $target -Path $file
            
            $CountfilesMoved++

            $filesMoved.Add($file.Name)

            break
        }
    }
}
Write-Message
