# Documentatie OSCAR2

## Opdracht

Een member server in het domein red.local. Deze server is een Real-Time Monitoring server die alle Windows Servers opvolgt. Deze Server maakt gebruik van de monitoring applicatie PRTG. Volgende parameters worden minimaal opgevolgd :
 - CPU gebruik
 - Geheugen gebruik
 - Toestand van de harde schij(f)(ven)
 - Toestand van elke specifieke service die op een Windows Server staat te  draaien. (Services zoals MS-SQL, Sharepoint, IIS, mail,...)

## Scripts
 Dit script dient voor de configuratie van de netwerk adapter, het toevoegen van kilo2 aan red.local en het aanpassen van de default naam
 - Het script OSCAR2_BasisInstallatie.ps1 bevindt zich in de folder ~/servers/oscar2/scripting
   Hierin wordt de firewall uitgeschakeld, de server krijgt een statisch ipadres, de servernaam wordt gewijzigd en de server wordt toegevoegd aan het domein.   
 - Het script OSCAR2_PRTGInstallatie.ps1 bevindt zich in de folder ~/servers/oscar2/scripting
   Hierin wordt de server geïnstalleerd met de PRTG monitoring interface.
   En worden de servers toegevoegd in de monitoring software.
 - Het script OSCAR2_PRTG_ADDALFA2.ps1 bevindt zich in de folder ~/servers/oscar2/scripting
   Hierin worden de sensoren geïnstalleerd voor de server ALFA2.
 - Het script OSCAR2_PRTG_ADDBRAVO2.ps1 bevindt zich in de folder ~/servers/oscar2/scripting
   Hierin worden de sensoren geïnstalleerd voor de server BRAVO2.
 - Het script OSCAR2_PRTG_ADDCHARLIE2.ps1 bevindt zich in de folder ~/servers/oscar2/scripting
   Hierin worden de sensoren geïnstalleerd voor de server CHARLIE2.
 - Het script OSCAR2_PRTG_ADDDELTA2.ps1 bevindt zich in de folder ~/servers/oscar2/scripting
   Hierin worden de sensoren geïnstalleerd voor de server DELTA2.
 - Het script OSCAR2_PRTG_ADDKILO2.ps1 bevindt zich in de folder ~/servers/oscar2/scripting
   Hierin worden de sensoren geïnstalleerd voor de server KILO2.
 - Het script OSCAR2_PRTG_ADDLIMA2.ps1 bevindt zich in de folder ~/servers/oscar2/scripting
   Hierin worden de sensoren geïnstalleerd voor de server LIMA2.
 - Het script OSCAR2_PRTG_ADDMIKE2.ps1 bevindt zich in de folder ~/servers/oscar2/scripting
   Hierin worden de sensoren geïnstalleerd voor de server MIKE2.
 - Het script OSCAR2_PRTG_ADDNOVEMBER2.ps1 bevindt zich in de folder ~/servers/oscar2/scripting
   Hierin worden de sensoren geïnstalleerd voor de server NOVEMBER2.
 - Het script OSCAR2_PRTG_ADDOSCAR2.ps1 bevindt zich in de folder ~/servers/oscar2/scripting
   Hierin worden de sensoren geïnstalleerd voor de server OSCAR2.
 - Het script OSCAR2_PRTG_ADDPAPA2.ps1 bevindt zich in de folder ~/servers/oscar2/scripting
   Hierin worden de sensoren geïnstalleerd voor de server PAPA2.


# Initiële configuratie manueel
1. Zet alle firewall instellingen uit.
   > Lokale server > EIGENSCHAPPEN > Windows Firewall > Geavanceerde instellingen > Eigenschappen van Windows Firewall
     - Domeinprofiel > Status van firewall: Uitgeschakeld
     - Privé profiel > Status van firewall: Uitgeschakeld
     - Openbaar profiel > Status van firewall: Uitgeschakeld

2. Geef de server een statisch IP-adres.
   > Lokale server > EIGENSCHAPPEN > Ethernet > Eigenschappen
   > Eigenschappen van Ethernet > Internet Protocol versie 6 (TCP/IPv6) > Uitvinken
   > Eigenschappen van Ethernet > Internet Protocol versie 4 (TCP/IPv4) > Eigenschappen
   > Eigenschappen van Internet Protocol versie 4 (TCP/IPv4)
	- IP-adres: 172.18.0.6
	- Subnetmasker: 255.255.255.0
	- Standaardgateway:    .   .   . 
	- Voorkeurs-DNS-server: 172.18.0.34
	- Alternatieve DNS-server:    .   .   .

3. Geef de server de naam 'Oscar2' en voeg de server toe aan het domein 'red.local'
   > Lokale server > EIGENSCHAPPEN > Computernaam > Wijzigen > Computernaam: OSCAR2
							     > Lid van Domein: red.local> OK
											  - Gebruikersnaam: Administrator
											  - Wachtwoord: Project2018
   > Nu opnieuw opstarten


4. Login op het domein:
   - Gebruikersnaam: RED\Administrator
   - Wachtwoord: Project2018

5. Installeer Chrome
   > D:\software\chrome\ChromeStandaloneSetup64.exe

6. Installeer PRTGMonitoring
   > D:\software\prtg\PRTGMonitoring.exe
     - Taalkeuze voor Setup: English
     - License Agreement: I accept the agreement > Next
     - Initializing License ...
     - Your Email Address: admin@red.local > Next
     - Your license key:
          - License Name: prtgtrial
          - License Key: 000014-166KFM-8FFGMQ-WBD3Y2-EHN6EA-02BEDT-UM6J56-1EH24Z-3UKVF8-ZDKTJM
       > Next
     - Installing ...
     - Setup Cleanup ...
     - Please wait until the PRTG web server is running...

7. Ga naar de webbrowser Chrome op de server en surf naar 'http://127.0.0.1/' of 'http://localhost/'
   > De PRTG Network Monitor initialisatie start automatisch
   > Login
        - Login Name: prtgadmin
        - Password: prtgadmin



# Initiële configuratie automatisch

## Script OSCAR2_BasisInstallatie
#### Variables
$ServerName = "OSCAR2"
$ServerIP = "172.18.0.6"
$SubnetMask = "27"
$DefaultGateway = "172.18.0.34"
$DNSServerPreferred = "172.18.0.34"
$DNSServerAlternate = "172.18.0.33"
$DomainName = "red.local"
$AdminUsername = "RED\Administrator"
$AdminPassword = ConvertTo-SecureString "Project2018" -AsPlainText -Force
$Credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $AdminUsername, $AdminPassword
$ETHERNET = "Ethernet"			
$LAN = "LAN"
$Connection = $false

#### 1. Set Firewall OFF
```
Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False
```

#### 2. Rename NetAdapter
```
Rename-NetAdapter -Name $ETHERNET -NewName $LAN
```

#### 3. Set Static IP
```
New-NetIPAddress –InterfaceAlias $LAN –IPAddress $ServerIP –PrefixLength $SubnetMask -DefaultGateway $DefaultGateway
Set-DNSClientServerAddress –InterfaceAlias $LAN –ServerAddresses ($DNSServerPreferred)
```

#### 4. Join Domain
```
DO{
    IF(Test-Connection -ComputerName $DefaultGateway -ErrorAction SilentlyContinue){
        $Connection = $true
        Write-Host "CONNECTION TO ALFA2 OK" -ForegroundColor Green
        Add-Computer -DomainName $DomainName -Credential $Credential
    } ELSE{
        $Connection = $false
        Write-Host "CONNECTION TO ALFA2 FAILED" -ForegroundColor Red
    }
} WHILE($Connection -eq $false)
```

#### 5. Rename Server
```
Rename-Computer -ComputerName $env:COMPUTERNAME  -newName $ServerName -Force
```

#### 5. Installation PRTG Network Monitor
```
Start-Process -Wait -FilePath "C:\Users\Administrator\Documents\prtg\PRTG Network Monitor 18.3.44.2059 Setup (Stable).exe" -ArgumentList /SILENT, "/licensekey='000014-128KFM-8FFHCK-6TKHBM-VBFCX1-WTPJYH-9ADA24-AKQZR2-59NG8D-GCB74R'", "/licensekeyname='prtgtrial'", "/adminemail='admin@red.local'", "/LANG=English"
```

#### 6. Installation PRTG Network Monitor
```
Restart-Computer
```


## Script OSCAR2_PRTGInstallatie
#### Variables
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

#### 1. Installation Chrome
```
D:\software\chrome\ChromeStandaloneSetup64.exe /install
```

#### 2. Installation PRTG Network Monitor
```
Start-Process -Wait -FilePath $InstallerPathPRTG -ArgumentList /SILENT,/licensekey=$ArgKey,/licensekeyname=$ArgKeyName,/adminemail=$ArgMail,/LANG=$ArgLang
```

#### 3. Installation PRTG API
```
Install-Package PrtgAPI -Confirm:$False
Set-PSRepository -Name PSGallery -InstallationPolicy Trusted
Install-Package PrtgAPI -Source PSGallery -Confirm:$False
```

#### 4. PRTG Self Configuration
```
Start-Process "chrome.exe" "http://127.0.0.1"
Start-Sleep -s 300
```

#### 5. PRTG SERVER CONNECTION
```
try{
Connect-PrtgServer http://127.0.0.1 (New-Credential prtgadmin prtgadmin)
Write-Host "Completed PRTG SERVER CONNECTION"
} catch{
Write-Host "Already connected"
}
```

#### 6. Add PRTG Group Servers
```
Get-Probe "Local Probe" | Add-Group Servers
```

#### 7. Add PRTG Devices
```
Get-Group Servers | Add-Device Kilo2 172.18.0.2
Get-Group Servers | Add-Device Lima2 172.18.0.3
Get-Group Servers | Add-Device Mike2 172.18.0.4
Get-Group Servers | Add-Device November2 172.18.0.5
Get-Group Servers | Add-Device Oscar2 172.18.0.6
Get-Group Servers | Add-Device Papa2 172.18.0.7
Get-Group Servers | Add-Device Alfa2 172.18.0.34
Get-Group Servers | Add-Device Bravo2 172.18.0.35
Get-Group Servers | Add-Device Charlie2 172.18.0.36
Get-Group Servers | Add-Device Delta2 172.18.0.37
```


## Script OSCAR2_ADDALFA2
#### Variables
$DomainName = "red.local"
$AdminUsername = "Administrator"
$AdminPassword = "Project2018"

#### 1. PRTG SERVER CONNECTION
```
try{
Connect-PrtgServer http://127.0.0.1 (New-Credential prtgadmin prtgadmin)
Write-Host "Completed PRTG SERVER CONNECTION"
} catch{
Write-Host "Already connected"
}
```

#### 2. Add PRTG Devices Credentials
```
Get-Device Alfa2 | Set-ObjectProperty -WindowsDomain $DomainName -WindowsUserName $AdminUsername -WindowsPassword $AdminPassword
```

#### 3. Add PRTG Sensors To Devices
!!LET OP: Sensors worden enkel toegevoegd bij connectie met desbetreffende HOST, HOST available, correct username and password!!
```
##Alfa2: DNS Server
Get-Device Alfa2 | New-SensorParameters -RawType wmivitalsystemdata | Add-Sensor
Get-Device Alfa2 | New-SensorParameters -RawType dns | Add-Sensor
```

#### 4. Add PRTG Sensors To Devices Manually
!!LET OP: Niet alle sensoren kunnen automatisch toegevoegd worden, probeer deze manueel toe te voegen, voer alvorens een auto-discovery uit!!
```
Surf naar http://127.0.0.1 via Chrome
> Devices
> ALFA2 > Auto-Discovery > Run Auto-Discovery
> ALFA2 > Add Sensor
```


## Script OSCAR2_ADDBRAVO2
#### Variables
$DomainName = "red.local"
$AdminUsername = "Administrator"
$AdminPassword = "Project2018"

#### 1. PRTG SERVER CONNECTION
```
try{
Connect-PrtgServer http://127.0.0.1 (New-Credential prtgadmin prtgadmin)
Write-Host "Completed PRTG SERVER CONNECTION"
} catch{
Write-Host "Already connected"
}
```

#### 2. Add PRTG Devices Credentials
```
Get-Device Bravo2 | Set-ObjectProperty -WindowsDomain $DomainName -WindowsUserName $AdminUsername -WindowsPassword $AdminPassword
```

#### 3. Add PRTG Sensors To Devices
!!LET OP: Sensors worden enkel toegevoegd bij connectie met desbetreffende HOST, HOST available, correct username and password!!
```
##Bravo2: DNS Server
Get-Device Bravo2 | New-SensorParameters -RawType wmivitalsystemdata | Add-Sensor
Get-Device Bravo2 | New-SensorParameters -RawType dns | Add-Sensor
```

#### 4. Add PRTG Sensors To Devices Manually
!!LET OP: Niet alle sensoren kunnen automatisch toegevoegd worden, probeer deze manueel toe te voegen, voer alvorens een auto-discovery uit!!
```
Surf naar http://127.0.0.1 via Chrome
> Devices
> BRAVO2 > Auto-Discovery > Run Auto-Discovery
> BRAVO2 > Add Sensor
```


## Script OSCAR2_ADDCHARLIE2
#### Variables
$DomainName = "red.local"
$AdminUsername = "Administrator"
$AdminPassword = "Project2018"

#### 1. PRTG SERVER CONNECTION
```
try{
Connect-PrtgServer http://127.0.0.1 (New-Credential prtgadmin prtgadmin)
Write-Host "Completed PRTG SERVER CONNECTION"
} catch{
Write-Host "Already connected"
}
```

#### 2. Add PRTG Devices Credentials
```
Get-Device Charlie2 | Set-ObjectProperty -WindowsDomain $DomainName -WindowsUserName $AdminUsername -WindowsPassword $AdminPassword
```

#### 3. Add PRTG Sensors To Devices
!!LET OP: Sensors worden enkel toegevoegd bij connectie met desbetreffende HOST, HOST available, correct username and password!!
```
##Charlie2: EXCHANGE (SMTP & POP3) Mail Server
Get-Device Charlie2 | New-SensorParameters -RawType wmivitalsystemdata | Add-Sensor
Get-Device Charlie2 | New-SensorParameters -RawType wmiexchangeserver | Add-Sensor
Get-Device Charlie2 | New-SensorParameters -RawType smtp | Add-Sensor
Get-Device Charlie2 | New-SensorParameters -RawType pop3 | Add-Sensor
```

#### 4. Add PRTG Sensors To Devices Manually
!!LET OP: Niet alle sensoren kunnen automatisch toegevoegd worden, probeer deze manueel toe te voegen, voer alvorens een auto-discovery uit!!
```
Surf naar http://127.0.0.1 via Chrome
> Devices
> CHARLIE2 > Auto-Discovery > Run Auto-Discovery
> CHARLIE2 > Add Sensor
```


## Script OSCAR2_ADDDELTA2
#### Variables
$DomainName = "red.local"
$AdminUsername = "Administrator"
$AdminPassword = "Project2018"

#### 1. PRTG SERVER CONNECTION
```
try{
Connect-PrtgServer http://127.0.0.1 (New-Credential prtgadmin prtgadmin)
Write-Host "Completed PRTG SERVER CONNECTION"
} catch{
Write-Host "Already connected"
}
```

#### 2. Add PRTG Devices Credentials
```
Get-Device Delta2 | Set-ObjectProperty -WindowsDomain $DomainName -WindowsUserName $AdminUsername -WindowsPassword $AdminPassword
```

#### 3. Add PRTG Sensors To Devices
!!LET OP: Sensors worden enkel toegevoegd bij connectie met desbetreffende HOST, HOST available, correct username and password!!
```
##Delta2: WEB Server
Get-Device Delta2 | New-SensorParameters -RawType wmivitalsystemdata | Add-Sensor
Get-Device Delta2 | New-SensorParameters -RawType http | Add-Sensor
```

#### 4. Add PRTG Sensors To Devices Manually
!!LET OP: Niet alle sensoren kunnen automatisch toegevoegd worden, probeer deze manueel toe te voegen, voer alvorens een auto-discovery uit!!
```
Surf naar http://127.0.0.1 via Chrome
> Devices
> DELTA2 > Auto-Discovery > Run Auto-Discovery
> DELTA2 > Add Sensor
```


## Script OSCAR2_ADDKILO2
#### Variables
$DomainName = "red.local"
$AdminUsername = "Administrator"
$AdminPassword = "Project2018"

#### 1. PRTG SERVER CONNECTION
```
try{
Connect-PrtgServer http://127.0.0.1 (New-Credential prtgadmin prtgadmin)
Write-Host "Completed PRTG SERVER CONNECTION"
} catch{
Write-Host "Already connected"
}
```

#### 2. Add PRTG Devices Credentials
```
Get-Device Kilo2 | Set-ObjectProperty -WindowsDomain $DomainName -WindowsUserName $AdminUsername -WindowsPassword $AdminPassword
```

#### 3. Add PRTG Sensors To Devices
!!LET OP: Sensors worden enkel toegevoegd bij connectie met desbetreffende HOST, HOST available, correct username and password!!
```
##Kilo2: DHCP Server
Get-Device Kilo2 | New-SensorParameters -RawType wmivitalsystemdata | Add-Sensor
```

#### 4. Add PRTG Sensors To Devices Manually
!!LET OP: Niet alle sensoren kunnen automatisch toegevoegd worden, probeer deze manueel toe te voegen, voer alvorens een auto-discovery uit!!
```
Surf naar http://127.0.0.1 via Chrome
> Devices
> KILO2 > Auto-Discovery > Run Auto-Discovery
> KILO2 > Add Sensor
```



## Script OSCAR2_ADDLIMA2
#### Variables
$DomainName = "red.local"
$AdminUsername = "Administrator"
$AdminPassword = "Project2018"

#### 1. PRTG SERVER CONNECTION
```
try{
Connect-PrtgServer http://127.0.0.1 (New-Credential prtgadmin prtgadmin)
Write-Host "Completed PRTG SERVER CONNECTION"
} catch{
Write-Host "Already connected"
}
```

#### 2. Add PRTG Devices Credentials
```
Get-Device Lima2 | Set-ObjectProperty -WindowsDomain $DomainName -WindowsUserName $AdminUsername -WindowsPassword $AdminPassword
```

#### 3. Add PRTG Sensors To Devices
!!LET OP: Sensors worden enkel toegevoegd bij connectie met desbetreffende HOST, HOST available, correct username and password!!
```
##Lima2: FILE Server
Get-Device Lima2 | New-SensorParameters -RawType wmivitalsystemdata | Add-Sensor
Get-Device Lima2 | New-SensorParameters -RawType folder | Add-Sensor
```

#### 4. Add PRTG Sensors To Devices Manually
!!LET OP: Niet alle sensoren kunnen automatisch toegevoegd worden, probeer deze manueel toe te voegen, voer alvorens een auto-discovery uit!!
```
Surf naar http://127.0.0.1 via Chrome
> Devices
> KILO2 > Auto-Discovery > Run Auto-Discovery
> KILO2 > Add Sensor
```



## Script OSCAR2_ADDMIKE2
#### Variables
$DomainName = "red.local"
$AdminUsername = "Administrator"
$AdminPassword = "Project2018"

#### 1. PRTG SERVER CONNECTION
```
try{
Connect-PrtgServer http://127.0.0.1 (New-Credential prtgadmin prtgadmin)
Write-Host "Completed PRTG SERVER CONNECTION"
} catch{
Write-Host "Already connected"
}
```

#### 2. Add PRTG Devices Credentials
```
Get-Device Mike2 | Set-ObjectProperty -WindowsDomain $DomainName -WindowsUserName $AdminUsername -WindowsPassword $AdminPassword
```

#### 3. Add PRTG Sensors To Devices
!!LET OP: Sensors worden enkel toegevoegd bij connectie met desbetreffende HOST, HOST available, correct username and password!!
```
##Mike2: Intranet/CMS (Sharepoint) Server
Get-Device Mike2 | New-SensorParameters -RawType wmivitalsystemdata | Add-Sensor
Get-Device Mike2 | New-SensorParameters -RawType wmisharepointprocess | Add-Sensor
```

#### 4. Add PRTG Sensors To Devices Manually
!!LET OP: Niet alle sensoren kunnen automatisch toegevoegd worden, probeer deze manueel toe te voegen, voer alvorens een auto-discovery uit!!
```
Surf naar http://127.0.0.1 via Chrome
> Devices
> MIKE2 > Auto-Discovery > Run Auto-Discovery
> MIKE2 > Add Sensor
```


## Script OSCAR2_ADDNOVEMBER2
#### Variables
$DomainName = "red.local"
$AdminUsername = "Administrator"
$AdminPassword = "Project2018"

#### 1. PRTG SERVER CONNECTION
```
try{
Connect-PrtgServer http://127.0.0.1 (New-Credential prtgadmin prtgadmin)
Write-Host "Completed PRTG SERVER CONNECTION"
} catch{
Write-Host "Already connected"
}
```

#### 2. Add PRTG Devices Credentials
```
Get-Device November2 | Set-ObjectProperty -WindowsDomain $DomainName -WindowsUserName $AdminUsername -WindowsPassword $AdminPassword
```

#### 3. Add PRTG Sensors To Devices
!!LET OP: Sensors worden enkel toegevoegd bij connectie met desbetreffende HOST, HOST available, correct username and password!!
```
##November2: MS SQL Server
Get-Device November2 | New-SensorParameters -RawType wmivitalsystemdata | Add-Sensor
Get-Device November2 | New-SensorParameters -RawType mssqlv2 | Add-Sensor
Get-Device November2 | New-SensorParameters -RawType wmisqlserver2016 | Add-Sensor
```

#### 4. Add PRTG Sensors To Devices Manually
!!LET OP: Niet alle sensoren kunnen automatisch toegevoegd worden, probeer deze manueel toe te voegen, voer alvorens een auto-discovery uit!!
```
Surf naar http://127.0.0.1 via Chrome
> Devices
> NOVEMBER2 > Auto-Discovery > Run Auto-Discovery
> NOVEMBER2 > Add Sensor
```


## Script OSCAR2_ADDOSCAR2
#### Variables
$DomainName = "red.local"
$AdminUsername = "Administrator"
$AdminPassword = "Project2018"

#### 1. PRTG SERVER CONNECTION
```
try{
Connect-PrtgServer http://127.0.0.1 (New-Credential prtgadmin prtgadmin)
Write-Host "Completed PRTG SERVER CONNECTION"
} catch{
Write-Host "Already connected"
}
```

#### 2. Add PRTG Devices Credentials
```
Get-Device Oscar2 | Set-ObjectProperty -WindowsDomain $DomainName -WindowsUserName $AdminUsername -WindowsPassword $AdminPassword
```

#### 3. Add PRTG Sensors To Devices
!!LET OP: Sensors worden enkel toegevoegd bij connectie met desbetreffende HOST, HOST available, correct username and password!!
```
##Oscar2: PRTG Monitoring Server
Get-Device Oscar2 | New-SensorParameters -RawType wmivitalsystemdata | Add-Sensor
Get-Device Oscar2 | New-SensorParameters -RawType corestate | Add-Sensor
Get-Device Oscar2 | New-SensorParameters -RawType systemstate | Add-Sensor
```

#### 4. Add PRTG Sensors To Devices Manually
!!LET OP: Niet alle sensoren kunnen automatisch toegevoegd worden, probeer deze manueel toe te voegen, voer alvorens een auto-discovery uit!!
```
Surf naar http://127.0.0.1 via Chrome
> Devices
> OSCAR2 > Auto-Discovery > Run Auto-Discovery
> OSCAR2 > Add Sensor
```


## Script OSCAR2_ADDPAPA2
#### Variables
$DomainName = "red.local"
$AdminUsername = "Administrator"
$AdminPassword = "Project2018"

#### 1. PRTG SERVER CONNECTION
```
try{
Connect-PrtgServer http://127.0.0.1 (New-Credential prtgadmin prtgadmin)
Write-Host "Completed PRTG SERVER CONNECTION"
} catch{
Write-Host "Already connected"
}
```

#### 2. Add PRTG Devices Credentials
```
Get-Device Papa2 | Set-ObjectProperty -WindowsDomain $DomainName -WindowsUserName $AdminUsername -WindowsPassword $AdminPassword
```

#### 3. Add PRTG Sensors To Devices
!!LET OP: Sensors worden enkel toegevoegd bij connectie met desbetreffende HOST, HOST available, correct username and password!!
```
##Papa2: SCCM Server
Get-Device Papa2 | New-SensorParameters -RawType wmivitalsystemdata | Add-Sensor
Get-Device Papa2 | New-SensorParameters -RawType lastwindowsupdate | Add-Sensor
```

#### 4. Add PRTG Sensors To Devices Manually
!!LET OP: Niet alle sensoren kunnen automatisch toegevoegd worden, probeer deze manueel toe te voegen, voer alvorens een auto-discovery uit!!
```
Surf naar http://127.0.0.1 via Chrome
> Devices
> PAPA2 > Auto-Discovery > Run Auto-Discovery
> PAPA2 > Add Sensor
```


OPMERKINGEN:
- ...




## Bronnen

https://www.faqforge.com/windows/configure-dhcp-powershell/
https://docs.microsoft.com/nl-nl/windows-server/networking/technologies/dhcp/dhcp-deploy-wps

## Documentatie Week 7 D-Day

### 9:15 - Servernaam instellen / IP instellen / Firewall uitschakelen
Verbinden met de EXSI is verlopen zonder problemen.
De servernaam is verandert naar OSCAR2
IP is ingesteld op 172.18.0.6
Firewall is uitgeschakeld
Domein joinen gaat voorlopig niet, geen verbinding met ALFA2 -> fout bij inter-vlan routing

### 10:50 - Domein joinen
Er is verbinding met ALFA2
OSCAR2 is het domein red.local gejoined.
De server wordt uitgeschakeld voor het moment voor ruimte vrij te maken op de server

### 12:45 - Installatie PRTG
Probleem met installatie executable, waarschijnlijk corrupt.

### 14:00 - Installatie PRTG
Tweede poging installatie PRTG met nieuwe executable.


Het testplan is overlopen en alle testen zijn successvol voltooid
