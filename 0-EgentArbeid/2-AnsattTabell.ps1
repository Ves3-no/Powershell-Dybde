$path = "$env:USERPROFILE/ansatte.json"

function Find-Id{
    if(Test-Path $path){
        $FindAnsatte = [System.Collections.ArrayList]@(Get-Content -Path $path -Raw | ConvertFrom-Json)
    }
    $ID = $FindAnsatte.Count
    while ($FindAnsatte.ID -contains $ID) {
        $ID++
    }

    if($ID -eq 0) {$ID = 1}

    return [int]$ID
}

function Add-Ansatt {
    param (
        [string]$Name,
        [string]$Role,
        [string]$PhoneNumber,
        [string]$Adress,
        [string]$Group
    )
    $ID = Find-Id
    if(Test-Path $path){
        $AddAnsatte = [System.Collections.ArrayList]@(Get-Content -Path $path -Raw | ConvertFrom-Json)
    } else{
        $AddAnsatte = New-Object -TypeName System.Collections.ArrayList
    }
    $NyAnsatt = [PSCustomObject]@{
        ID = $ID
        Name = $Name
        Role = $Role
        PhoneNumber = $PhoneNumber
        Adress = $Adress
        Group = $Group
    }
    $AddAnsatte.Add($NyAnsatt)
    Write-Host "Opprettet ansatt $($NyAnsatt.Name), med id: $($NyAnsatt.ID)" -ForegroundColor Green

    $AddAnsatte | ConvertTo-Json -Depth 10 | Set-Content -Path $path

}
function Get-Ansatt{
    param (
        [int]$ID = $false,
        [string]$Name = $false,
        [string]$PhoneNumber = $false,
        [string]$Group = $false
    )
    if(Test-Path $path){
        $GetAnsatte = [System.Collections.ArrayList]@(Get-Content -Path $path -Raw | ConvertFrom-Json)
    }   
    if(-not($Name -eq $false)){
        $GetAnsatte.Where({$_.Name -eq $Name})
    } elseif(-not($ID -eq $false)){
        $GetAnsatte.Where({$_.ID -eq $ID})
    } elseif(-not($PhoneNumber -eq $false)){
        $GetAnsatte.Where({$_.PhoneNumber -eq $PhoneNumber})
    } elseif(-not($Group -eq $false)){
        $GetAnsatte.Where({$_.Group -like "*$Group*"})
    } else{
        $GetAnsatte
    }
}

function Del-Ansatt{
    param(
        [int]$ID = $false
    )
    if(Test-Path $path){
        $DelAnsatte = [System.Collections.ArrayList]@(Get-Content -Path $path -Raw | ConvertFrom-Json)
    } else{
        $DelAnsatte = New-Object -TypeName System.Collections.ArrayList
    }
    if(-not($ID -eq $false)){
        Write-Host $ID
        $target = $DelAnsatte | Where-Object {$_.ID -eq $ID}
        $DelAnsatte = $DelAnsatte | Where-Object {-not($_.ID -eq $ID)}
        Write-Host "Slettet ansatt $($target.Name), med id: $($target.ID)." -ForegroundColor Red
    } else{
        Write-Host "For å slette en ansatt må du spesifisere hvilken" -ForegroundColor DarkRed
    }
    
    if($null -eq $DelAnsatte){
        Remove-Item -Path $path
    } else{
        $DelAnsatte | ConvertTo-Json -Depth 10 | Set-Content -Path $path
    }
}
function Edit-Ansatt{
    param (
        [Int]$ID = $false,
        [string]$Name =  "False" ,
        [string]$Role = "False",
        [string]$PhoneNumber =  "False",
        [string]$Adress =  "False",
        [string]$Group =  "False"
    )
    if(Test-Path $path){
        $EditAnsatte = [System.Collections.ArrayList]@(Get-Content -Path $path -Raw | ConvertFrom-Json)
    }   
    if($ID -eq $false){
        Write-Host  "For å redigere en ansatt må du spesifisere hvilken" -ForegroundColor DarkRed
    } else{
        $target = $EditAnsatte | Where-Object {$_.ID -eq $ID}
        $target.Name = $Name -eq  "False" ? $target.Name : $Name
        $target.Role = $Role -eq  "False" ? $target.Role : $Role
        $target.PhoneNumber = $PhoneNumber -eq $false ? $target.PhoneNumber : $PhoneNumber
        $target.Adress = $Adress -eq  "False" ? $target.Adress : $Adress
        $target.Group = $Group -eq  "False" ? $target.Group : $Group

        $EditAnsatte | ConvertTo-Json -Depth 10 | Set-Content -Path $path

    }
}
