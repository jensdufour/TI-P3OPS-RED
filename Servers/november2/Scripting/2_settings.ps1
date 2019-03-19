Write-Host 'Setting IP configuration'
#IP configuratie
New-NetIPAddress -InterfaceAlias Ethernet0 -IPAddress 172.18.0.5 -DefaultGateway 172.18.0.1 -PrefixLength 27
Set-DnsClientServerAddress -InterfaceAlias Ethernet0 -ServerAddresses 172.18.0.34, 172.18.0.35

#Firewall
Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False
#SQL toegang geven tot de firewall
New-NetFirewallRule -DisplayName "SQL port 1433" -Direction Inbound -LocalPort 1433 -Protocol TCP -Action Allow

#Domein joinen
Write-Host 'Trying to join domain red.local'
$DomainName = "red.local"
$SafeModeAdministratorPassword = "Project2018" | ConvertTo-SecureString -AsPlainText -Force
$domain = "red"
$joindomainuser = "Administrator"
$credential = New-Object System.Management.Automation.PSCredential($joindomainuser,$SafeModeAdministratorPassword)
Add-Computer -DomainName $DomainName -Credential $credential
Restart-Computer
