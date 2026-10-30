$os = Get-CimInstance Win32_OperatingSystem
$uptime = Get-Uptime
$drive = Get-PSDrive C
$Ram = [math]::Round(($os.TotalVisibleMemorySize - $os.FreePhysicalMemory) / $os.TotalVisibleMemorySize * 100, 2)
Write-Host "`n------------------------------------------------------------------`n" -ForegroundColor Green
Write-Host "The pc is using $($Ram)% of its ram" -ForegroundColor $(if ($Ram -gt 80) { "Red" } elseif($Ram -gt 50){"DarkYellow"} else { "Green" })
Write-Host "`n------------------------------------------------------------------`n" -ForegroundColor Green
Write-Host "Your pc has been running for $($uptime.Days) days, $($uptime.Hours) hours and $($uptime.Minutes) minutes" -ForegroundColor Green
Write-Host "`n------------------------------------------------------------------`n" -ForegroundColor Green
Write-Host "$($env:USERNAME) is using the pc" -ForegroundColor Green
Write-Host "`n------------------------------------------------------------------`n" -ForegroundColor Green
Write-Host "You have $([math]::Round($drive.Free / 1GB, 2)) disk space, and your using $([math]::Round($drive.Used / 1GB, 2))" -ForegroundColor Green
Write-Host "`n------------------------------------------------------------------`n" -ForegroundColor Green