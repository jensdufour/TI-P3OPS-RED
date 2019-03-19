###                Variables               ###
##############################################
$DomainName = "red.local"
$AdminUsername = "Administrator"
$AdminPassword = "Project2018"



###         PRTG SERVER CONNECTION         ###
##############################################
Write-Host "Start PRTG SERVER CONNECTION"
try{
Connect-PrtgServer http://127.0.0.1 (New-Credential prtgadmin prtgadmin)
Write-Host "Completed PRTG SERVER CONNECTION"
} catch{
Write-Host "Already connected"
}



###      Add PRTG Devices Credentials      ###
##############################################
Write-Host "Start Add PRTG Devices Credentials"
Get-Device Delta2 | Set-ObjectProperty -WindowsDomain $DomainName -WindowsUserName $AdminUsername -WindowsPassword $AdminPassword
Write-Host "Completed Add PRTG Devices Credentials"



###       Add PRTG Sensors To Devices      ###
##############################################
Write-Host "Start Add PRTG Sensors To Devices"
# !!LET OP: Sensors worden enkel toegevoegd bij connectie met desbetreffende HOST, HOST available, correct username and password!!
##Delta2: WEB Server
Get-Device Delta2 | New-SensorParameters -RawType wmivitalsystemdata | Add-Sensor
Get-Device Delta2 | New-SensorParameters -RawType http | Add-Sensor
Write-Host "Completed Add PRTG Sensors To Devices"