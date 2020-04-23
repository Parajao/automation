
choco install conemu -yr
choco install brave -yr
choco install 7zip -yr
choco install teamviewer -yr
choco install slack -yr
choco install visualstudio2019community -yr
choco install postman -yr
choco install nuget.commandline -yr
choco install nunit -yr
choco install visualstudiocode -yr
choco install nodejs -yr
choco install yarn -yr

$WshShell = New-Object -ComObject WScript.Shell
$Shortcut = $WshShell.CreateShortcut("$env:USERPROFILE\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\ComEmu.lnk")
$Shortcut.TargetPath = "$env:programFiles\ConEmu\ConEmu64.exe"
$Shortcut.Save()

Restart-Computer
