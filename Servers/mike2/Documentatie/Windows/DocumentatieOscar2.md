# Documentatie OSCAR2

## Opdracht

Een member server in het domein red.local. Deze server is een Real-Time Monitoring server die alle Windows Servers opvolgt. Deze Server maakt gebruik van de monitoring applicatie PRTG. Volgende parameters worden minimaal opgevolgd :
 - CPU gebruik
 - Geheugen gebruik
 - Toestand van de harde schij(f)(ven)
 - Toestand van elke specifieke service die op een Windows Server staat te  draaien. (Services zoals MS-SQL, Sharepoint, IIS, mail,...)

## Scripts
 dit script dient voor de configuratie van de netwerk adapter, het toevoegen van kilo2 aan red.local en het aanpassen van de default naam
 - Het script OSCAR2_BasisInstallatie.ps1 bevindt zich in de folder ~/servers/oscar2.
   Hierin wordt de firewall uitgeschakeld, de server krijgt een statisch ipadres, de servernaam wordt gewijzigd en de server wordt toegevoegd aan het domein.   
 - Het script OSCAR2_PRTGInstallatie.ps1 bevindt zich in de folder ~/servers/oscar2.
   Hierin wordt de server geïnstalleerd met de PRTG monitoring interface.
   En worden de servers toegevoegd in de monitoring software.
 - Het script OSCAR2_PRTG_AddSensors.ps1 bevindt zich in de folder ~/servers/oscar2.
   Hierin wordt de server geïnstalleerd met de PRTG monitoring interface.
   En worden de servers toegevoegd in de monitoring software.

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

5. Installeer PRTGMonitoring
   > Documenten\PRTGMonitoring.exe
     - Taalkeuze voor Setup: English
     - License Agreement: I accept the agreement > Next
     - Initializing License ...
     - Your Email Address: admin@red.local > Next
     - Your license key:
          - License Name: prtgtrial
          - License Key: 000014-128KFM-8FFHCK-6TKHBM-VBFCX1-WTPJYH-9ADA24-AKQZR2-59NG8D-GCB74R
       > Next
     - Installing ...
     - Setup Cleanup ...
     - Please wait until the PRTG web server is running...

6. Ga naar de webbrowser op de server en surf naar 'http://127.0.0.1/' of 'http://localhost/'
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









#### 6. Installation PRTG API
```
Install-Package PrtgAPI -Confirm:$False
Set-PSRepository -Name PSGallery -InstallationPolicy Trusted
Install-Package PrtgAPI -Source PSGallery -Confirm:$False
```

#### 7. PRTG Self Configuration
```
Start-Process "iexplore.exe" "http://127.0.0.1"
Start-Sleep -s 300
```

#### 8. PRTG SERVER CONNECTION
```
try{
Connect-PrtgServer http://127.0.0.1 (New-Credential prtgadmin prtgadmin)
Write-Host "Completed PRTG SERVER CONNECTION"
} catch{
Write-Host "Already connected"
}
```

#### 9. Add PRTG Group Servers
```
Get-Probe "Local Probe" | Add-Group Servers
```

#### 10. Add PRTG Devices
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

#### 11. Add PRTG Devices Credentials
```
Get-Device Kilo2 | Set-ObjectProperty -WindowsDomain 'red.local' -WindowsUserName 'unknown' -WindowsPassword 'unknown'
Get-Device Lima2 | Set-ObjectProperty -WindowsDomain 'red.local' -WindowsUserName 'unknown' -WindowsPassword 'unknown'
Get-Device Mike2 | Set-ObjectProperty -WindowsDomain 'red.local' -WindowsUserName 'unknown' -WindowsPassword 'unknown'
Get-Device November2 | Set-ObjectProperty -WindowsDomain 'red.local' -WindowsUserName 'unknown' -WindowsPassword 'unknown'
Get-Device Oscar2 | Set-ObjectProperty -WindowsDomain 'red.local' -WindowsUserName 'unknown' -WindowsPassword 'unknown'
Get-Device Papa2 | Set-ObjectProperty -WindowsDomain 'red.local' -WindowsUserName 'unknown' -WindowsPassword 'unknown'
Get-Device Alfa2 | Set-ObjectProperty -WindowsDomain 'red.local' -WindowsUserName 'unknown' -WindowsPassword 'unknown'
Get-Device Bravo2 | Set-ObjectProperty -WindowsDomain 'red.local' -WindowsUserName 'unknown' -WindowsPassword 'unknown'
Get-Device Charlie2 | Set-ObjectProperty -WindowsDomain 'red.local' -WindowsUserName 'unknown' -WindowsPassword 'unknown'
Get-Device Delta2 | Set-ObjectProperty -WindowsDomain 'red.local' -WindowsUserName 'unknown' -WindowsPassword 'unknown'
```

#### 12. Add PRTG Sensors To Devices
!!LET OP: Sensors worden enkel toegevoegd bij connectie met desbetreffende HOST, HOST available, correct username and password!!
##### Kilo2: DHCP Server
```
Get-Device Kilo2 | New-SensorParameters -RawType wmivitalsystemdata | Add-Sensor
```
##### Lima2: FILE Server
```
Get-Device Lima2 | New-SensorParameters -RawType wmivitalsystemdata | Add-Sensor
Get-Device Lima2 | New-SensorParameters -RawType folder | Add-Sensor
```
##### Mike2: Intranet/CMS (Sharepoint) Server
```
Get-Device Mike2 | New-SensorParameters -RawType wmivitalsystemdata | Add-Sensor
Get-Device Mike2 | New-SensorParameters -RawType wmisharepointprocess | Add-Sensor
```
##### November2: MS SQL Server
```
Get-Device November2 | New-SensorParameters -RawType wmivitalsystemdata | Add-Sensor
Get-Device November2 | New-SensorParameters -RawType mssqlv2 | Add-Sensor
Get-Device November2 | New-SensorParameters -RawType wmisqlserver2016 | Add-Sensor
```
##### Oscar2: PRTG Monitoring Server
```
Get-Device Oscar2 | New-SensorParameters -RawType wmivitalsystemdata | Add-Sensor
Get-Device Oscar2 | New-SensorParameters -RawType corestate | Add-Sensor
Get-Device Oscar2 | New-SensorParameters -RawType systemstate | Add-Sensor
```
##### Papa2: SCCM Server
```
Get-Device Papa2 | New-SensorParameters -RawType wmivitalsystemdata | Add-Sensor
Get-Device Papa2 | New-SensorParameters -RawType lastwindowsupdate | Add-Sensor
```
##### Alfa2: DNS Server
```
Get-Device Alfa2 | New-SensorParameters -RawType wmivitalsystemdata | Add-Sensor
Get-Device Alfa2 | New-SensorParameters -RawType dns | Add-Sensor
```
##### Bravo2: DNS Server
```
Get-Device Bravo2 | New-SensorParameters -RawType wmivitalsystemdata | Add-Sensor
Get-Device Bravo2 | New-SensorParameters -RawType dns | Add-Sensor
```
##### Charlie2: EXCHANGE (SMTP & POP3) Mail Server
```
Get-Device Charlie2 | New-SensorParameters -RawType wmivitalsystemdata | Add-Sensor
Get-Device Charlie2 | New-SensorParameters -RawType wmiexchangeserver | Add-Sensor
Get-Device Charlie2 | New-SensorParameters -RawType smtp | Add-Sensor
Get-Device Charlie2 | New-SensorParameters -RawType pop3 | Add-Sensor
```
##### Delta2: WEB Server
```
Get-Device Delta2 | New-SensorParameters -RawType wmivitalsystemdata | Add-Sensor
Get-Device Delta2 | New-SensorParameters -RawType http | Add-Sensor
```

#### 14. Rename Server
```
Rename-Computer -ComputerName $env:COMPUTERNAME  -newName Oscar2 -Force -Restart
```

#### 15. Set Execution Policy RemoteSigned
```
Set-ExecutionPolicy RemoteSigned
```

OPMERKINGEN:
- De IP-Adressen kunnen afwijken van het uiteindelijke IP-Schema. Hiervoor gaan we het script met netwerkbeheer is doornemen.
- De setup van de server zal niet werken totdat het er een DC en DNS server aanwezig zijn op het netwerk. Dit is door volgende commands:
```
Add-DhcpServerInDC -DnsName DHCP.red.local -IPAddress $DHCPServerIP
Set-DhcpServerV4OptionValue -DnsServer $DNSserverIP -Router $RouterIP
```

- De scope wordt wel juist opgezet.

## Vagrant File

```
	config.vm.define "KILO2" do |k|
 
		config.vm.provision "shell", path: "scripts/kilo2.ps1"
		k.vm.box = DEFAULT_SERVER_BOX
		k.vm.hostname = "KILO2"

		k.vm.provider :virtualbox do |v|
			v.name = "KILO2"
			v.gui = false
			v.memory = 2048
			v.cpus = 2
		end
	end
```

OPMERKINGEN: 
- Het kan zijn dat hier nog een paar veranderingen gebeuren. Zoals het meegeven van een statisch IP-address,...
 
## Ansible
```
- name : Assing IP and DefaultGateway
win_shell: New-NetIPAddress -InterfaceAlias "Ethernet" -IPAddress "172.18.0.17" -PrefixLength 28 -DefaultGateway "172.18.0.17"

- name : Install DHCP
win_shell: Install-WindowsFeature -name DHCP -IncludeManagementTools

- name : Configure DHCP Settings (Router ip address needs to be adjusted to match ip schema)
win_shell: Add-DhcpServerInDC -DnsName DHCP.red.local -IPAddress 172.18.0.17
win_shell: Add-DhcpServerv4Scope -name "VLAN200" -StartRange 172.18.0.2 -EndRange 172.18.0.14 -SubnetMask 255.255.255.240 -State Active
win_shell: Set-DhcpServerV4OptionValue -DnsServer 172.18.0.33 -Router 172.18.2.1
win_shell: Set-DhcpServerv4Scope -ScopeId 172.18.0.0 -LeaseDuration 3.00:00:00


- name : Restart DHCP service
win_shell: Restart-service dhcpserver
```

OPMERKINGEN:
- Doet hetzelfde als het script. Gemaakt in het geval dat we dit nodig hebben.
- Hetzelfde als bij het kilo2.ps1 script, IP-Adressen kunnen afwijken van het uiteindelijke IP-schema

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
