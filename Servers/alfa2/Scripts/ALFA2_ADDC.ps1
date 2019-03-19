#Declaring variables
$domainname = "red.local"
$ethernetalias = "Ethernet0"

#IP-adres en default gateway wijzigen
New-NetIPAddress -InterfaceAlias $ethernetalias -IPAddress "172.18.0.34" -PrefixLength 27 -DefaultGateway "172.18.0.33"

#Firewall uitschakelen
Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False

#DC en DNS installeren en domeinnaam instellen
Install-WindowsFeature AD-Domain-Services -IncludeManagementTools
Install-ADDSForest -DomainName $domainname -SafeModeAdministratorPassword:(ConvertTo-SecureString -String "Project2018" -AsPlainText -Force) -Force
