$($env:PsModulePath).Split(";")
"C:\Program Files\PowerShell\Modules"

Get-Module -ListAvailable


Import-Module -Name ScheduledTasks -Force

Get-Module #Remove-Module

Get-Command -Module ScheduledTasks

Get-ScheduledTask 

