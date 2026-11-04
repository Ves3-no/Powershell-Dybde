$errorsInARow = 0

#henter WPF windows sitt framwork inn til koden
Add-Type -AssemblyName PresentationFramework
$cardToTest = [System.Windows.MessageBox]::Show("Are you using Ethernet(Cabeled)", "Chose card", "YesNo", "Question") -eq 6 ? "ethernet": "wifi"

while ($true) {
    "`n------------------------------------------------`n"
    $ipToTest = "1.1.1.1"
    $networkCardName = Get-NetAdapter | Where-Object {$_.Status.ToLower() -eq "up" -and $_.Name.ToLower() -like "*$cardToTest*"} | Select-Object -First 1
    Write-Host "Starting new test, on the WiFi-card: $($networkCardName.Name)" -ForegroundColor DarkYellow

    $Count = 0
    $Test = Test-Connection -TargetName $ipToTest
     "`n------------------------------------------------`n"
    foreach($Ping in $Test){
        if($Ping.Reply.Status -eq "Success"){
            Write-Host("Ping $($Ping.Ping) is ok") -ForegroundColor Green
            $errorsInARow = 0
        } else{
            Write-Host("Ping $($Ping.Ping) is not ok") -ForegroundColor Red
            $Count++
            $errorsInARow++
        }
    }
     "`n------------------------------------------------`n"
    if($Count -gt 2){
        Write-Host "Starting new security test after $Count errors in the last" -ForegroundColor DarkYellow
        "`n------------------------------------------------`n"
        $Test2 = Test-Connection -TargetName $ipToTest
        foreach($Ping2 in $Test2){
            if($Ping2.Reply.Status -eq "Success"){
                Write-Host("Ping $($Ping2.Ping) on Test2 is ok") -ForegroundColor Green
                $errorsInARow = 0
            } else{
                Write-Host("Ping $($Ping.Ping) is not ok") -ForegroundColor Red
                $Count++
                $errorsInARow++
            }
        }
        if($Count -gt 6){
             "`n------------------------------------------------`n"
            Write-Host("Restarting network card, got $Count errors while testing(CTRL + C to exit at any time)") -ForegroundColor Red
            $networkCardName | Disable-NetAdapter -Confirm:$false
            Start-Sleep -Milliseconds 200
            $networkCardName | Enable-NetAdapter -Confirm:$false
            "`n------------------------------------------------`n"
            Write-Host "Test done, WiFi-card is resetted" -ForegroundColor DarkYellow
            "`n------------------------------------------------`n"
            Start-Sleep -Seconds 10
            if($errorsInARow -gt 3){
                [System.Windows.MessageBox]::Show("Nettverkskortet har hatt mange problemer på rad(Du bør skjekke opp i det)", "Error", "OK", "Error")
            }
        }
    } else {
        Write-Host("Everything looks good(CTRL + C to exit at any time)") -ForegroundColor Green
        "`n------------------------------------------------`n"
        Write-Host "Test done" -ForegroundColor DarkYellow
        "`n------------------------------------------------`n"
        Start-Sleep -Seconds (60*30)
    }
}
