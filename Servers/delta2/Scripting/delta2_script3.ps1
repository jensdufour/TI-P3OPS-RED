#Requires -RunAsAdministrator

#SetIPAndFirewall
#Ip adres 
Write-host "Set IP"

New-NetIPAddress -InterfaceAlias "Ethernet" -IPAddress "172.18.0.37" -PrefixLength 27 -DefaultGateway "172.18.0.33"
Set-DnsClientServerAddress -InterfaceAlias "Ethernet" -ServerAddresses 172.18.0.34

Write-host "Firewall"
#firewall
Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False

Write-host "Domein joinen"
#Domein joinen
Write-Host "Trying to join domain red.local"
$domain = "red.local" 
$user = "Administrator" #Don't edit below this point 
$password = Read-Host -Prompt "Enter password for $user" -AsSecureString 
$username = "$domain\$user" 
$credential = New-Object System.Management.Automation.PSCredential($username,$password) 
Add-Computer -DomainName $domain -Credential $credential
Restart-Computer

Write-Host "Webserver up and running!"