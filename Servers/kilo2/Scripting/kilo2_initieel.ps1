#vars
Write-Host "Joining the domain..."
$DomainName = "red.local"
$SafeModeAdministratorPassword = "Project2018" | ConvertTo-SecureString -AsPlainText -Force
$joindomainuser = "Administrator"
$credential = New-Object System.Management.Automation.PSCredential($joindomainuser,$SafeModeAdministratorPassword)
$DHCPServerIP = "172.18.0.2"
$RouterIP = "172.18.0.1"
$DNSserversIP = "172.18.0.34"

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
     Restart-Computer
}

catch{
    echo "Oops, we couldn't join the Domain, here is the error:" -force red
    $_   # error output
}
