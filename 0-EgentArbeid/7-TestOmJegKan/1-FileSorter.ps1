
$path = Read-Host -Prompt "Skriv inn filstien"

$types = @{
    "Documents" = @(".txt", ".docx", ".doc", ".pdf", ".xlsx",".xls", ".pptx", ".ppt", ".ai", ".json", ".md")
    "Images" = @(".jepg", ".jpg", ".png", ".gif", ".svg", ".tif". ".tiff", ".webp", ".ico")
    "Sound and Video" = @(".mp3", ".wav", ".mp4", ".mov", ".mkv")
    "Archives" = @(".zip", ".7z", ".rar")
    "Apps" = @(".py", ".js", ".cpp", ".html", ".exe", "msi", ".iso", ".hex")
}

$files = Get-ChildItem -Path $path -File

foreach($file in $files){

    $extention = $file.Extension.ToLower()

    foreach($type in $types.GetEnumerator()){
        if($type.Value -contains $extention){
            Write-Host "`nThe File $($file.Name) is in the category $($type.Key)" -ForegroundColor Green
            $targetFolder = Join-Path $path $type.Key 
            if(-not(Test-Path $targetFolder)){
                New-Item -ItemType Directory -Path $targetFolder
            }
            Move-Item -Path $file -Destination $targetFolder
            break
        }
    }
}