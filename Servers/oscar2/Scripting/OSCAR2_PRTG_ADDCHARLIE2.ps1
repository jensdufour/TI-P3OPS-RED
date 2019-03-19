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
Get-Device Charlie2 | Set-ObjectProperty -WindowsDomain $DomainName -WindowsUserName $AdminUsername -WindowsPassword $AdminPassword
Write-Host "Completed Add PRTG Devices Credentials"



###       Add PRTG Sensors To Devices      ###
##############################################
Write-Host "Start Add PRTG Sensors To Devices"
# !!LET OP: Sensors worden enkel toegevoegd bij connectie met desbetreffende HOST, HOST available, correct username and password!!
##Charlie2: EXCHANGE (SMTP & POP3) Mail Server
Get-Device Charlie2 | New-SensorParameters -RawType wmivitalsystemdata | Add-Sensor
Get-Device Charlie2 | New-SensorParameters -RawType wmiexchangeserver | Add-Sensor
Get-Device Charlie2 | New-SensorParameters -RawType smtp | Add-Sensor
Get-Device Charlie2 | New-SensorParameters -RawType pop3 | Add-Sensor
Write-Host "Completed Add PRTG Sensors To Devices"