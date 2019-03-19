###                Variables               ###
##############################################
$ServerName = "OSCAR2"
$ServerIP = "172.18.0.6"
$SubnetMask = "27"			# DEVELOPMENT=24	PRODUCTION=27
$DefaultGateway = "172.18.0.34"
$DNSServerPreferred = "172.18.0.34"
$DNSServerAlternate = "172.18.0.33"
$DomainName = "red.local"
$AdminUsername = "RED\Administrator"
$AdminPassword = "Project2018"

$InstallerPathChrome = "D:\software\chrome\ChromeStandaloneSetup64.exe"
$InstallerPathPRTG = "D:\software\prtg\PRTGMonitoring.exe"
$ArgKey = "000014-166KFM-8FFGMQ-WBD3Y2-EHN6EA-02BEDT-UM6J56-1EH24Z-3UKVF8-ZDKTJM"
$ArgKeyName = "prtgtrial"
$ArgMail = "admin@red.local"
$ArgLang = "English"

$auth = "username=prtgadmin&password=prtgadmin"
$PRTGHost = "127.0.0.1"

$ALFA2 = "172.18.0.34"
$BRAVO2 = "172.18.0.35"
$CHARLIE2 = "172.18.0.36"
$DELTA2 = "172.18.0.37"
$KILO2 = "172.18.0.2"
$LIMA2 = "172.18.0.3"
$MIKE2 = "172.18.0.4"
$NOVEMBER2 = "172.18.0.5"
$OSCAR2 = "172.18.0.6"
$PAPA2 = "172.18.0.7"

###TODO:
#    - 



###    Installation Chrome   ###
##############################################
Write-Host "Start installation Chrome"
D:\software\chrome\ChromeStandaloneSetup64.exe /install
Write-Host "Completed installation Chrome"



###    Installation PRTG Network Monitor   ###
##############################################
Write-Host "Start installation PRTG Network Monitor"
Start-Process -Wait -FilePath $InstallerPathPRTG -ArgumentList /SILENT,/licensekey=$ArgKey,/licensekeyname=$ArgKeyName,/adminemail=$ArgMail,/LANG=$ArgLang 
Write-Host "Completed installation PRTG Network Monitor"



###          Installation PRTG API         ###
##############################################
Write-Host "Start installation PRTG API"
Install-Package PrtgAPI -Confirm:$False
Set-PSRepository -Name PSGallery -InstallationPolicy Trusted
Install-Package PrtgAPI -Source PSGallery -Confirm:$False
Write-Host "Completed installation PRTG API"



###        PRTG Self Configuration         ###
##############################################
Write-Host "Start PRTG Self Configuration"
Start-Process "chrome.exe" "http://127.0.0.1"
Start-Sleep -s 300
Write-Host "Completed PRTG Self Configuration"



###         PRTG SERVER CONNECTION         ###
##############################################
Write-Host "Start PRTG SERVER CONNECTION"
try{
Connect-PrtgServer http://127.0.0.1 (New-Credential prtgadmin prtgadmin)
Write-Host "Completed PRTG SERVER CONNECTION"
} catch{
Write-Host "Already connected"
}



###         Add PRTG Group Servers         ###
##############################################
Write-Host "Start Add PRTG Group Servers"
Get-Probe "Local Probe" | Add-Group Servers
Write-Host "Completed Add PRTG Group Servers"



###             Add PRTG Devices           ###
##############################################
Write-Host "Start Add PRTG Devices"
Get-Group Servers | Add-Device Alfa2 $ALFA2
Get-Group Servers | Add-Device Bravo2 $BRAVO2
Get-Group Servers | Add-Device Charlie2 $CHARLIE2
Get-Group Servers | Add-Device Delta2 $DELTA2
Get-Group Servers | Add-Device Kilo2 $KILO2
Get-Group Servers | Add-Device Lima2 $LIMA2
Get-Group Servers | Add-Device Mike2 $MIKE2
Get-Group Servers | Add-Device November2 $NOVEMBER2
Get-Group Servers | Add-Device Oscar2 $OSCAR2
Get-Group Servers | Add-Device Papa2 $PAPA2
Write-Host "Completed Add PRTG Devices"


