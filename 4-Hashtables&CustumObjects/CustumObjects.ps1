$employee1=New-Object -TypeName PSCustomObject
$employee2=New-Object -TypeName PSCustomObject

Add-Member -InputObject $employee1 -MemberType NoteProperty -Name "EmployeeID" -Value 1002
Add-Member -InputObject $employee1 -MemberType NoteProperty -Name "FirstName" -Value "Heine"
Add-Member -InputObject $employee1 -MemberType NoteProperty -Name "Title" -Value "CEO"

Add-Member -InputObject $employee2 -MemberType NoteProperty -Name "EmployeeID" -Value 1004
Add-Member -InputObject $employee2 -MemberType NoteProperty -Name "FirstName" -Value "Sverre"
Add-Member -InputObject $employee2 -MemberType NoteProperty -Name "Title" -Value "Dish Washer"

Get-Member -InputObject $employee1

$employee3 = [PSCustomObject]@{
    EmployeeID=1003
    FirstName="Jonas"
}