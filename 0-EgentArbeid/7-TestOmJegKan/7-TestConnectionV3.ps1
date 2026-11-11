$format = "yyyy-MM-dd HH:mm:ss"
$timesInARow = 0
$faliures = 0

$networkCard = "Ethernet"



While($true){
    function Start-Print(){
        Write-Host "`n============ Network ============`n" -ForegroundColor Blue

        Write-Host "Status: $($GoogleBool -or $CloudfareBool ? "Online" : "Offline")"
        Write-Host "Google: $($GoogleBool ? "Online" : $($Google.Status))"
        Write-Host "Cloudfare: $($CloudfareBool ? "Online" : $($Cloudfare.Status))`n"

        Write-Host "Ping: $($GoogleBool ?  $($Google.Latency) : $Cloudfare ?  $($Cloudfare.Latency) : " ")"
        Write-Host "Faliures: $faliures"
        if($timesInARow -gt 0){
            Write-Host "Faliures in a row: $timesInARow" 
        }

        Write-Host "`nLast checked: $(Get-Date -Format $format)"

        Write-Host "`n=================================" -ForegroundColor Blue

    }   
    $Google = Test-Connection -TargetName 8.8.8.8 -Count 1
    $Cloudfare = Test-Connection -TargetName 1.1.1.1 -Count 1
    $GoogleBool = Test-Connection -TargetName 8.8.8.8 -Count 1 -Quiet
    $CloudfareBool = Test-Connection -TargetName 1.1.1.1 -Count 1 -Quiet

    if($GoogleBool -or $CloudfareBool){
        $timesInARow = 0
        if (-not($GoogleBool)){
            $faliures++
        } elseif (-not($CloudfareBool)){
            $faliures++
        }
        Start-Print
        Start-Sleep -Seconds 120
    } else{
        $timesInARow++
        $faliures++
        Start-Print
        Start-Sleep -Seconds 60
    }

    if($timesInARow -gt 2){
        Write-Host "`n========== Notification ==========" -ForegroundColor Blue

        Write-Host "`nRestarted Network Card`n" -ForegroundColor Red

        Write-Host "==================================" -ForegroundColor Blue
        $timesInARow = 0
        Restart-NetAdapter -Name $networkCard -WhatIf -Confirm:$false
        Start-Sleep -Seconds 180
    }

}
