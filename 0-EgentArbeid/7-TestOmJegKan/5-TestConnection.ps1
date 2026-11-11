$ip = "1.1.1.1"
$CardName = "WiFi"
$timesInARow = 0

while($true){
    $Test = Test-Connection $ip
    $count = 0
    foreach($Ping in $Test){
        if($Ping.Status -eq "Success"){
            Write-Host "`nPing nr$($Ping.Ping): $($Ping.Status)" -ForegroundColor Green
        } else {
            $count++
            Write-Host "`nPing nr$($Ping.Ping): $($Ping.Status)" -ForegroundColor Red
        }
    }
    if($count -gt 2){
        $timesInARow++
        Write-Host "`nTesten hadde $($count) tapte pakker" -ForegroundColor DarkYellow
        if($timesInARow -eq 1){
            Write-Host "`nStarter ny test med en gang" -ForegroundColor DarkYellow
        } elseif($timesInARow -eq 2){
            Write-Host "`nTesten har hatt mange tapte pakker $($timesInARow) ganger på rad og forgje test hadde $count tapte pakker" -ForegroundColor Red
            Write-Host "`nStarter nettverkskortet $CardName på nytt" -ForegroundColor DarkYellow

            Restart-NetAdapter -Name $CardName -Confirm:$false

            Start-Sleep -Seconds (3*60)

        } else{
            Write-Host "`nTesten har hatt mange tapte pakker $($timesInARow) ganger på rad. Du bør skjekke opp i det" -ForegroundColor Red
            Start-Sleep -Seconds (10*60)
        }
    }else{
        $timesInARow = 0
        Write-Host "`nTesten hadde $($count) tapte pakker" -ForegroundColor Green
        Start-Sleep -Seconds (30*60)
    }
}