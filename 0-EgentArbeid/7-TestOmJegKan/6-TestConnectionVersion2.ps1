$timesInARow = 0
$faliures = 0
$Time = 2

$googleIp = "8.8.8.8"
$cloudfareIp = "1.1.1.1"


while($true){
    $google = Test-Connection -TargetName $googleIp -Count 1
    $cloudfare = Test-Connection -TargetName $cloudfareIp -Count 1
    $googleBoolean = Test-Connection -TargetName $googleIp -Count 1 -Quiet
    $cloudfareBoolean = Test-Connection -TargetName $cloudfareIp -Count 1 -Quiet

    if($googleBoolean -or $cloudfareBoolean){
        $timesInARow = 0
    } else {
        $timesInARow++
        $faliures++

    }
    
    Write-Host "`n============== Network ==============`n" -ForegroundColor Blue

    Write-Host "Connection: $($googleBoolean -or $cloudfareBoolean ? "Online" : "Offline")" -ForegroundColor ($googleBoolean -or $cloudfareBoolean ? "Green" : "Red")
    Write-Host "Google: $($googleBoolean ? "Online" : $google.Status)" -ForegroundColor ($googleBoolean ? "Green" : "Red")
    Write-Host "Cloudfare: $($cloudfareBoolean ? "Online" : $cloudfare.Status)`n" -ForegroundColor ($cloudfareBoolean ? "Green" : "Red")

    Write-Host "Ping(ms): $($googleBoolean ? "$($google.Latency)ms" : $cloudfareBoolean ? "$($cloudfare.Latency)ms" : "None")" -ForegroundColor Blue
    Write-Host "Faliures: $faliures" -ForegroundColor ($faliures -gt 2 ? "Red" : $faliures -gt 1 ? "DarkYellow" : "Green")
    Write-Host "$($timesInARow -gt 0 ? "Faliures in a row: $timesInARow" : " ")" -ForegroundColor ($timesInARow -gt 1 ? "Red" : "Green")

    Write-Host "Last check: $(Get-Date -Format "yyyy-MM-dd HH:mm:ss")" -ForegroundColor Blue
    Write-Host "$($googleBoolean -eq $false -and $cloudfareBoolean -eq $false ? "! Noe kan være galt med ditt nettverk !`n" :  -not($googleBoolean) ? "! Noe kan være galt med Google sin DNS !`n" : -not($cloudfareBoolean) ? "! Noe kan være galt med Cloudfare sin DNS !`n" : " ")" -ForegroundColor Red
    
    Write-Host "=====================================`n" -ForegroundColor Blue
    Start-Sleep -Seconds (60*$Time)
}