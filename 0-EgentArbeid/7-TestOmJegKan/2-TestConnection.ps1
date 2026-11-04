Write-Host "`n------------------------------------" -ForegroundColor Blue
$ip = Read-Host -Prompt "`nChose an ip"
$timesInARow = 0
$minutes = Read-Host -Prompt "`nMinutes between each test" 
$typeAnswer = Read-Host -Prompt "`nAre you using Ethernet?(y/n)"
$type = "WiFi"
if($typeAnswer.ToLower() -eq "y"){
    $type = "Ethernet"
}
Add-Type -AssemblyName PresentationFramework


while ($true) {
    Write-Host "`n------------------------------------" -ForegroundColor Blue
    $count = 0
    $test_1 = Test-Connection -TargetName $ip
    foreach($test in $test_1){
        if($test.Status -eq "Success"){
            Write-Host "`nPing number $($test.Ping) has a status off $($test.Status)" -ForegroundColor Green
        } else{
            $count++
            Write-Host "`nPing number $($test.Ping) has a status off $($test.Status)" -ForegroundColor Red
        }
    }
    if($count -gt 2){
        $timesInARow++
        Write-Host "`n------------------------------------" -ForegroundColor Blue
        if($timesInARow -eq 2){
            Write-Host "`nLast test failed $($count) times and it has failed $($timesInARow) times in a row, restarting internett card" -ForegroundColor Red

            Start-Sleep -Milliseconds (6*$minutes)

            Restart-NetAdapter -Name $type -Confirm:$false
            
            Start-Sleep -Seconds (60*3)
        } elseif($timesInARow -gt 2){
            Write-Host "`nLast test failed $($count) times and it has failed $($timesInARow) times in a row" -ForegroundColor Red
            [System.Windows.MessageBox]::Show("The ping has failed $timesInARow times in a row. Check if your internett card is ok", "Error", "OK", "Error")
            Start-Sleep -Seconds (6*$minutes)
        } elseif ($timesInARow -eq 1) {
            Write-Host "`nLast test failed $($count) times, Starting a new test" -ForegroundColor DarkYellow
        }
    } else{
        $timesInARow = 0
        Write-Host "`n------------------------------------" -ForegroundColor Blue
        Write-Host "`nLast test looked good, with $($count) fails. Waiting $minutes minutes for the next test" -ForegroundColor Green
        Start-Sleep -Seconds (60*$minutes)
    }
}