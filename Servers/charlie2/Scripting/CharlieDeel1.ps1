#Requires -RunAsAdministrator

#SetIPAndFirewall
#Ip adres 
Write-host "Set IP"

New-NetIPAddress -InterfaceAlias "Ethernet" -IPAddress "172.18.0.36" -PrefixLength 27 -DefaultGateway "172.18.0.33"
Set-DnsClientServerAddress -InterfaceAlias "Ethernet" -ServerAddresses 172.18.0.34

Write-host "Firewall"
#firewall
Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False

Write-host "Domein joinen"
#Domein joinen
Write-Host "Trying to join domain red.local"
$domain = "red.local" 
$user = "Administrator" #Don't edit below this point 
$password = "Project2018" | ConvertTo-SecureString -asPlainText -Force
$username = "$domain\$user" 
$credential = New-Object System.Management.Automation.PSCredential($username,$password) 
Add-Computer -DomainName $domain -Credential $credential
Restart-Computer

