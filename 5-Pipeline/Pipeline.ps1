$serviceName = "Spooler"

Get-Service -Name $serviceName 

Start-Service -Name $serviceName

Get-Help Stop-Service -Full

#test

(Get-Service -Name $serviceName).GetType()

#pipe

#Get-Service -Name $serviceName | Stop-Service

Get-Help Get-Service

#flere pipes

$serviceName | Get-Service | Start-Service

$service = New-Object -TypeName System.Collections.ArrayList
$service.AddRange(@("spooler", "w32time"))

$service | Get-Service | Start-Service

#$_ refererer til objectet i løkken
$service | Get-Service | ForEach-Object{Write-Host "Service: $($_.displayname) is currently $($_.status)" -ForegroundColor Cyan}