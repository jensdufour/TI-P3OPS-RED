#Installeer eerst de Guest additions indien gedeelde map nodig is.
#Variables
$hostname = 'Mike2'
$ethernetalias = 'Ethernet'

#Set Host Name
Rename-Computer -ComputerName $env:COMPUTERNAME  -newName $hostname -Force

#Configure Network Adapter
New-NetIPAddress -InterfaceAlias $ethernetalias -IPAddress "172.18.0.4" -PrefixLength 27 -DefaultGateway "172.18.0.1"

#Disable Firewall
Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False

#Join Domain
Set-DNSClientServerAddress –interfaceAlias $ethernetalias –ServerAddresses ("172.18.0.34") 
$cred = Get-Credential
Add-Computer -DomainName "red.local" -Credential $cred

#Restarting Server, niet zo handig als je foutmeding krijgt en je kan deze niet eens lezen. (bv. kan domein niet bereiken)
#Restart-Computer