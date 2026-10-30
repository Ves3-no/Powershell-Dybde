Set-StrictMode -Version latest
[int]$myValue1=1.2
$myValue3=3
$myValue10=10

$myResult=$myValue10 % $myValue3
$myResult

($myValue1 -eq $myValue10)

$myStatement=$true

$myStatement

$myNewResult=$null

($null -eq $myNewResult)

$today=Get-Date

$today.Day