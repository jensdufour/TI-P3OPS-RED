# Documentatie KILO2

## Opdracht

Een interne member-server in het domein red.local die dienst doet als DHCP-server voor de interneclients.

## Scripts
 - Het script kilo2_initieel.ps1 bevindt zich in de folder ~/servers/kilo2. dit script dient voor de configuratie van de netwerk adapter, het toevoegen van kilo2 aan red.local en het aanpassen van de default naam
 - Het script kilo2.ps1 bevindt zich in de folder ~/servers/kilo2. Hierin wordt de server geinstalleerd met dhcp services en configuratie van de dhcp service.
 
## Manuele Uitvoering

Er is een manuele uitvoering te vinden (met GUI screenshots) in het testplan.md van KILO2
https://github.com/HoGentTIN/p3ops-red/tree/master/Servers/kilo2/Testplan - GUI.md

# Initiële configuratie

```
#vars
Write-Host "Joining the domain..."
$DomainName = "red.local"
$SafeModeAdministratorPassword = "Project2018" | ConvertTo-SecureString -AsPlainText -Force
$domain = "red"
$joindomainuser = "Administrator"
$credential = New-Object System.Management.Automation.PSCredential($joindomainuser,$SafeModeAdministratorPassword)
$DHCPServerIP = "172.18.0.2"
$RouterIP = "172.18.0.1"
$DNSserversIP = "172.18.0.34"
$hostname = "KILO2"

#IP-adres en default gateway wijzigen
Write-Host "Configuring network interface settings..."
New-NetIPAddress -InterfaceAlias "Ethernet" -IPAddress $DHCPServerIP -PrefixLength 27 -DefaultGateway $RouterIP
Set-DNSClientServerAddress –interfaceAlias 'Ethernet' –ServerAddresses $DNSserversIP

#Firewall uitschakelen
Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False

#DomainName toewijzen
Write-Host "Joining the domain..."
try{
     Add-Computer -DomainName $DomainName -Credential $credential -ErrorAction Stop
     Rename-Computer -ComputerName $env:COMPUTERNAME  -newName $hostname -Force -Restart
}

catch{
    echo "Oops, we couldn't join the Domain, here is the error:" -fore red
    $_   # error output
}
```

# DHCP installatie

```
Install-WindowsFeature -name DHCP -IncludeManagementTools
```

# Configuratie van DHCP service

```
$Vlan200RouterIP = "172.18.2.1"
$DNSserversIP = "172.18.0.34","172.18.0.35"
$ScopeName = "VLAN200"
$Vlan200ScopeId = "172.18.2.0"
$DHCPStartRangeScopeIP = "172.18.2.2"
$DHCPEndRangeScopeIP = "172.18.2.126"
$SubnetMask = "255.255.255.128"
$DHCPServerIP = "172.18.0.2"

write-host 'Installing DHCP-services'

# Configure DHCP Settings
Add-DhcpServerInDC -DnsName KILO2.red.local -IPAddress $DHCPServerIP

Add-DhcpServerv4Scope -Name $ScopeName -StartRange $DHCPStartRangeScopeIP -EndRange $DHCPEndRangeScopeIP -SubnetMask $SubnetMask -LeaseDuration 1.00:00:00 -State Active

Set-DhcpServerV4OptionValue -ScopeId $Vlan200ScopeId -DnsServer $DNSserversIP -DnsDomain red.local -Router $Vlan200RouterIP

#Restart DHCP service
Restart-service dhcpserver
```

OPMERKINGEN:
- De IP-Adressen kunnen afwijken van het uiteindelijke IP-Schema. Hiervoor gaan we het script met netwerkbeheer is doornemen.
- De setup van de server zal niet werken totdat het er een DC en DNS server aanwezig zijn op het netwerk. Dit is door volgende commands:
```
Add-DhcpServerInDC -DnsName DHCP.red.local -IPAddress $DHCPServerIP
Set-DhcpServerV4OptionValue -DnsServer $DNSserversIP -Router $RouterIP
```

- De scope wordt wel juist opgezet.

## Bronnen

https://www.faqforge.com/windows/configure-dhcp-powershell/  
https://docs.microsoft.com/nl-nl/windows-server/networking/technologies/dhcp/dhcp-deploy-wps

## Documentatie Week 7 D-DAY

### 9:15 - Servernaam instellen / IP instellen / Firewall uitschakelen
Verbinden met de EXSI is verlopen zonder problemen.
De servernaam is verandert naar KILO2
IP is ingesteld op 172.18.0.2
Firewall is uitgeschakeld
Domein joinen gaat voorlopig niet, geen verbinding met ALFA2 -> fout bij inter-vlan routing

### 10:50 - Domein joinen
Er is verbinding met ALFA2
KILO2 is het domein red.local gejoined.
De server wordt uitgeschakeld voor het moment voor ruimte vrij te maken op de server

### 12:45 - Server Configuratie
problemen bij ' Add-DhcpServerInDC -DnsName KILO2.red.local -IPAddress 172.18.0.2 '
We zaten nog lokaal ingelogd
De rest van de configuratie geen vlotteloos

Opmerking: Alternatieve dns-server moet nog ingevuld worden bij de IP settings

Het testplan is overlopen en alle testen zijn successvol voltooid

### 


