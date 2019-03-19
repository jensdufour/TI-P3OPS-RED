#This script tests basic configurations of all servers in the domain red.local
#How to use: ./algemene_testen.ps1 -name 'your servernaam' -ipaddress 'your ip' -defaultgateway 'your default gateway address' -ethernet 'the name of your ethernet adapter (standard Ethernet0)'

#params
param([String]$name='PAPA2',
	[String]$ipaddress='172.18.0.7',
	[String]$defaultgateway='172.18.0.1',
	[String]$ethernet='Ethernet0'
)

#Variables
$passed = 0
$failed = 0

# Green checkmark
$greenCheck = @{
	Object = [Char]8730
	ForegroundColor = 'Green'
	NoNewLine = $true
}

$redCheck = @{
	Object = [Char]120
	ForegroundColor = 'Red'
	NoNewLine = $true
}

function check-firewall{
	$statePriv = netsh advfirewall show private | select-string -pattern "State " | Out-String
	$statePub = netsh advfirewall show public | select-string -pattern "State " | Out-String
	$stateDom = netsh advfirewall show private | select-string -pattern "State " | Out-String

	if($statePriv.replace(' ','').replace('State','').replace("`n","").replace("`r","") -eq 'OFF'){
		write-host @greenCheck
		write-host 'Private firewall is disabled'
		$Script:passed++
	}else{
		write-host @redCheck
		write-host 'Private firewall is still enabled'
		$Script:failed++
	}
	if($statePub.replace(' ','').replace('State','').replace("`n","").replace("`r","") -eq 'OFF'){
		write-host @greenCheck
		write-host 'Public firewall is disabled'
		$Script:passed++
	}else{
		write-host @redCheck
		write-host 'Public firewall is still enabled'
		$Script:failed++
	}
	if($stateDom.replace(' ','').replace('State','').replace("`n","").replace("`r","") -eq 'OFF'){
		write-host @greenCheck
		write-host 'Domain firewall is disabled'
		$Script:passed++
	}else{
		write-host @redCheck
		write-host 'Domain Firewall is still enabled'
		$Script:failed++
	}

}

function check-ip-settings{
	$ip = Test-Connection -ComputerName (hostname) -Count 1  | Select -ExpandProperty IPV4Address
	if($ip.IPAddressToString -eq $ipaddress){
		write-host @greenCheck
		write-host 'IP Address is correctly configured'
		$Script:passed++
	}else{
		write-host @redCheck
		write-host 'IP Address is not correctly configured'
		$Script:failed++
	}

	$sm = Get-NetIPAddress -InterfaceAlias $ethernet -AddressFamily IPv4 | Select -ExpandProperty PrefixLength
	if($sm -eq 27){
		write-host @greenCheck
		write-host 'Subnet Mask is correctly configured'
		$Script:passed++
	}else{
		write-host @redCheck
		write-host 'Subnet Mask is not correctly configured'
		$Script:failed++
	}

	$dg = Get-NetIPConfiguration | Foreach IPv4DefaultGateway | Select -ExpandProperty NextHop
	if($dg -eq $defaultgateway){
		write-host @greenCheck
		write-host 'Default Gateway is correctly configured'
		$Script:passed++
	}else{
		write-host @redCheck
		write-host 'Default Gateway is not correctly configured'
		$Script:failed++
	}

	$dns_raw = Get-DnsClientServerAddress | Select-Object -ExpandProperty ServerAddresses
	$dns_splitted = $dns_raw -Split "`r`n"
	if($dns_splitted.Contains('172.18.0.34')){
		write-host @greenCheck
		write-host 'ALFA2 is configured as the DNS Server'
		$Script:passed++
	}else{
		write-host @redCheck
		write-host 'ALFA2 is not configured as the DNS Server'
		$Script:failed++
	}
	if($dns_splitted.Contains('172.18.0.35')){
		write-host @greenCheck
		write-host 'BRAVO2 is configured as the backup DNS Server'
		$Script:passed++
	}else{
		write-host @redCheck
		write-host 'BRAVO2 is not configured as the backup DNS Server'
		$Script:failed++
	}
}

function check-name{
	$hostname = Hostname
	if($hostname -eq $name){
		write-host @greenCheck
		write-host 'Computername is correctly configured'
		$Script:passed++
	}else{
		write-host @redCheck
		write-host 'Computername is not correctly configured'
		$Script:failed++
	}
}

check-name
check-firewall
check-ip-settings
read-host "$passed test(s) passes, $failed test(s) failed"
