$path = "$env:USERPROFILE\Downloads"

$types = @{
    "Documents" = @(".txt", ".docx", ".doc", ".pdf", ".xlsx",".xls", ".pptx", ".ppt", ".ai", ".json", ".md")
    "Images" = @(".jpeg", ".jpg", ".png", ".gif", ".svg", ".tif", ".tiff", ".webp", ".ico")
    "Sound and Video" = @(".mp3", ".wav", ".mp4", ".mov", ".mkv")
    "Archives" = @(".zip", ".7z", ".rar")
    "Apps" = @(".py", ".js", ".cpp", ".html", ".exe", ".msi", ".iso", ".hex")
}

$files = Get-ChildItem -Path $path -File

foreach($file in $files){
    $extention = $file.Extension.ToLower()

    foreach($type in $types.GetEnumerator()){
        if($type.Value -contains $extention){
            $target = Join-Path $path $type.Key

            if(-not(Test-Path $target)){
                New-Item -Path $target -ItemType Directory
            }

            Move-Item -Path $file -Destination $target

            break
        }
    }

}