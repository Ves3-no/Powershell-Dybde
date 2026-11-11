$($env:PsModulePath).Split(";")
"C:\Program Files\PowerShell\Modules"

Get-Module -ListAvailable


Import-Module -Name ScheduledTasks -Force #-Force = re import even if it is imported

Get-Module #Remove-Module

Get-Command -Module ScheduledTasks

Get-ScheduledTask 

Find-Module -Name AzureAD

Install-Module -Name AzureAD

Import-Module -Name AzureAD

#Uninstall-Module 