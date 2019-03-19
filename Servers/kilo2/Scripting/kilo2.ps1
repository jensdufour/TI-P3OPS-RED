#Router ip moet hier nog aangepast worden aan het ip schema
$Vlan200RouterIP = "172.18.2.1"
$DNSserversIP = "172.18.0.34","172.18.0.35"
$ScopeName = "VLAN200"
$Vlan200ScopeId = "172.18.2.0"
$DHCPStartRangeScopeIP = "172.18.2.2"
$DHCPEndRangeScopeIP = "172.18.2.126"
$SubnetMask = "255.255.255.128"
$DHCPServerIP = "172.18.0.2"

write-host 'Installing DHCP-services'

# Install DHCP
Install-WindowsFeature -Name DHCP -IncludeManagementTools

# Configure DHCP Settings
Add-DhcpServerInDC -DnsName KILO2.red.local -IPAddress $DHCPServerIP

Add-DhcpServerv4Scope -Name $ScopeName -StartRange $DHCPStartRangeScopeIP -EndRange $DHCPEndRangeScopeIP -SubnetMask $SubnetMask -LeaseDuration 1.00:00:00 -State Active

Set-DhcpServerV4OptionValue -ScopeId $Vlan200ScopeId -DnsServer $DNSserversIP -DnsDomain red.local -Router $Vlan200RouterIP

#Restart DHCP service
Restart-service dhcpserver







