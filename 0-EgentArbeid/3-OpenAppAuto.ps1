$appsToOpen = New-Object -TypeName System.Collections.ArrayList
$appsToOpen.AddRange(@("C:\Program Files\Google\Chrome\Application\chrome.exe",
"spotify:",
"C:\Program Files\WindowsApps\MSTeams_26260.1717.5229.7049_x64__8wekyb3d8bbwe\ms-teams.exe",
 "C:\Users\HeineBaraneVestre\AppData\Local\Programs\Microsoft VS Code\Code.exe"))
$tabs = @("https://www.google.com/", "https://gemini.google.com/", "https://haugaland-vgs.inschool.visma.no/")

foreach ($app in $appsToOpen) {
    if($app -eq "C:\Program Files\Google\Chrome\Application\chrome.exe"){
        Start-Process $app -ArgumentList $tabs
    }else {
        Start-Process $app
    }
}
