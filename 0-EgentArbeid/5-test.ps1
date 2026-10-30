$var = Test-Connection Google.com



Write-Host "----------------------------------------------------------------------------------" -ForegroundColor Green
Write-Host "`nTester $($var[0].Address)[$($var[0].Destination)] `n" -ForegroundColor Blue

Write-Host "----------------------------------------------------------------------------------" -ForegroundColor Green
Write-Host

$var | ForEach-Object { Write-Host "Forsøk $($_.Ping): $($_.Latency)ms" -ForegroundColor Yellow}
Write-Host
Write-Host "----------------------------------------------------------------------------------" -ForegroundColor Green