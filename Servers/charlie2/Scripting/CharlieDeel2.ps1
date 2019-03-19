#Requires -RunAsAdministrator


ECHO "Creating folder for additional files"
if(!(Test-Path files))
{
new-item files -itemtype directory 
}else
{
ECHO "Already created"
}

ECHO "Creating folder for exchange"
if(!(Test-Path exchange))
{
new-item exchange -itemtype directory 
}else
{
ECHO "Already created"
}


Write-Host "Copy additional files to files folder and exchange in exchange folder."
Write-Host "Press any key to continue"
$x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
Write-Host

Write-Host "Installing Chrome"

.\files\chrome.msi /q

Write-Host "Installing UCMA"

.\files\ucma.exe -q

Write-Host "Installing .NET"

.\files\NDP471-KB4033342-x86-x64-AllOS-ENU.exe /passive /norestart

Write-Host "Installing Vcredist"

.\files\vcredist_x64.exe /passive /norestart


Write-Host "PLEASE WAIT TILL .NET FRAMEWORK IS INSTALLED"

Start-Sleep -s 30


Write-Host "Press any key to restart"
$x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
Write-Host

Restart-Computer


