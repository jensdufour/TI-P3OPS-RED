Write-Host 'Installatie SQL Server 2017'
#Installatie SQL Server 2017
$folderpath="E:\"
$filepath="$folderpath\Setup.exe"
$Parms = " /qs /Install /ConfigurationFile=ConfigurationFile.ini"
Setup.exe /ConfigurationFile=ConfigurationFile.ini
Write-Host 'Done'
Restart-Computer
