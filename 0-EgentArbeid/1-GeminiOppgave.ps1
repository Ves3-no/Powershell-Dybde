$path = "$env:USERPROFILE\Downloads" #Lager en variabel med Downloads Mappen til brukeren
$fileTypes=@{ #Lager en hashtable med de ulike mappene eller typene av filer og har en liste med ulike Extentions som inngår den typen
    "Bilder"     = @(".png", ".jpg", ".jpeg", ".webp")
    "Dokumenter" = @(".pdf", ".docx", ".txt")
    "Arkiv"      = @(".zip", ".rar")
    "Programmer" = @(".exe", ".msix", ".hex")
    "Lyd og Video" = @(".mp3", ".mp4")
}
$filesMoved = New-Object -TypeName System.Collections.ArrayList
$filesTestet = New-Object -TypeName System.Collections.ArrayList
$txtFile = Join-Path $path "logs.txt"
$files = Get-ChildItem $path -File #Henter alle filene under vår path som er satt lenger oppe
$files.Remove("logs.txt")
foreach($file in $files){ #går gjennom alle filene i en løkke
    if($file -eq $txtFile ){
        break
    }
    $fileType = $file.Extension.ToLower() #Henter Extenitonen på filen den går gjennom nå og lagrer den i en variabel
    $filesTestet.Add($file)
    Write-Host "Sjekker fil: $($file.Name) med endelse: $fileType" #Skriver hvilke fil den jobber med(for debugging)
    foreach($type in $fileTypes.GetEnumerator()){ #går gjennom alle ulike typene fra våre fil typer i en ny løkke
        Write-Host "Tester: $($type.Value)" #Skriver verdien til filtypen den tester nå(for debugging)
        if($type.Value -contains $fileType){ #skjekker om listen med Extentions for filtypen har vår extention i seg
            Write-Host "Filen: $($file.Name) stemmer med endelse til: $($type.Key)" #(for debugging)
            $whereToPlace = Join-Path $path $type.Key #Lager en variabel om hvor filen skal, folderen ligger i vår donwloads og heter det samme som filtypen
            if(-not(Test-Path -Path $whereToPlace)){ #skjekker om folderen alerede finnes og kjører om den ikke finnes
                New-Item -ItemType Directory -Path $whereToPlace #Lager folderen i vår variabel med path og foldernavn
            }

            Move-Item -Path $file.FullName -Destination $whereToPlace #flytter filen til variabel med path og foldernavn
            $filesMoved.Add($file)
            
            break #stopper løkken for denne filen
            
        }
    }
}
if(-not(Test-Path -Path $txtFile)){
    New-Item -Path $path -Name "logs.txt" -ItemType File
}
$logContent = @"
Files tested:
$($filesTestet -join "`n" )

Files moved:
$( $filesMoved -join "`n" )

Files moved count: $($filesMoved.Count)

Files tested count: $($filesTestet.Count)

"@

$logContent > $txtFile