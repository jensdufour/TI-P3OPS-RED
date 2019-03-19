# Vars
## Basic
$ExpectedHostname = "KILO2"
$ExpectedIPAddress = "172.18.0.2"
$ExpectedPrefix = "27"
$ExpectedDefaultGateway = "172.18.0.1"
$ExpectedDNS = "172.18.0.34"

## DHCP
$ExpectedDHCPStatus = "Running"
$ExpectedDHCPIPAddress = "172.18.0.2"

$ExpectedScopeDefaultGateway = "172.18.2.1"
$ExpectedScopeDomain = "red.local"
$ExpectedScopeName = "VLAN200"
$ExpectedScopeSubnet = "255.255.255.128"
$ExpectedScopeRangeStart = "172.18.2.2"
$ExpectedScopeRangeEnd = "172.18.2.126"
$ExpectedScopeState = "Active"
$ExpectedScopeLeaseDuration = "1.00:00:00"

 

# Amount of passed tests
$passed = 0

# Green checkmark
$greenCheck = @{
  Object = [Char]8730
  ForegroundColor = 'Green'
  NoNewLine = $true
}

## Tests basic config KILO2
Function CheckIP {
    $KILO2IP = Get-NetAdapter -Name "Ethernet" | Get-NetIPAddress -AddressFamily IPv4 | Select -ExpandProperty IPV4Address
    if($KILO2IP -eq $ExpectedIPAddress){
        Write-Host @greenCheck
        Write-Host " IP configured correctly."
        $global:passed++
    } else {
        Write-Host "x" -ForegroundColor Red -NoNewline
        Write-Host " IP configured incorrectly: The IP for KILO2 should be 172.18.0.2."
    }
}

Function CheckSubnet {
    $KILO2Subnet = Get-NetAdapter -Name "Ethernet" | Get-NetIPAddress -AddressFamily IPv4 | Select -ExpandProperty PrefixLength
    if($KILO2Subnet -eq $ExpectedPrefix){
        Write-Host @greenCheck
        Write-Host " KILO2 is in the correct subnet."
        $global:passed++
    } else {
        Write-Host "x" -ForegroundColor Red -NoNewline
        Write-Host " Subnetmask configured incorrectly: KILO2 should be in the 172.18.0.0/27 subnet."
    }
}

Function CheckDG {
    $KILO2DG = Get-NetIPConfiguration | Foreach IPv4DefaultGateway | Select -ExpandProperty NextHop
    if($KILO2DG -eq $ExpectedDefaultGateway){
        Write-Host @greenCheck
        Write-Host " The Default gateway for KILO2 is configured correctly."
        $global:passed++
    } else {
        Write-Host "x" -ForegroundColor Red -NoNewline
        Write-Host " Default Gateway configured incorrectly: The default gateway for KILO2 should be 172.18.0.1."
    }
}

Function CheckDNS {
    $KILO2DNS = Get-DnsClientServerAddress | Where-Object InterfaceAlias -eq "Ethernet" | Select -ExpandProperty ServerAddresses
    if($KILO2DNS -eq $ExpectedDNS){
        Write-Host @greenCheck
        Write-Host " The DNS server address for KILO2 is configured correctly."
        $global:passed++
    } else {
        Write-Host "x" -ForegroundColor Red -NoNewline
        Write-Host " The DNS server address is configured incorrectly: The DNS server address should be 172.18.0.34."
    }
}

Function CheckHostname {
    $KILO2Hostname = Hostname
    if($KILO2Hostname -eq $ExpectedHostname){
        Write-Host @greenCheck
        Write-Host " Hostname Configured correctly."
        $global:passed++
    } else {
        Write-Host "x" -ForegroundColor Red -NoNewline
        Write-Host " Hostname configured incorrectly: The hostname should be KILO2."
    }
}


## Tests DHCP installation
Function CheckDHCPService {
    $DHCPStatus = Get-Service -Name *dhcp* | Where-Object DisplayName -Match "DHCP Server" | Select -ExpandProperty Status
    if($DHCPStatus -eq $ExpectedDHCPStatus){
        Write-Host @greenCheck
        Write-Host " DHCP server service is running."
        $global:passed++
    } else {
        Write-Host "x" -ForegroundColor Red -NoNewline
        Write-Host " DHCP server service is not running."
    }
}

Function CheckDhcpInDC {
    $DHCPInDC = Get-DhcpServerInDC | Select -ExpandProperty IPAddress
    if($DHCPInDC.IPAddressToString -eq $ExpectedDHCPIPAddress){
        Write-Host @greenCheck
        Write-Host " KILO2 is assigned as DHCP server in DC."
        $global:passed++
    } else {
        Write-Host "x" -ForegroundColor Red -NoNewline
        Write-Host " KILO2 is not assigned as the DHCP server in the domain red.local."
    }
} 


## Tests DHCP scope for VLAN200
Function CheckScopeDG {
    $ScopeDG = Get-DhcpServerV4OptionValue -ScopeId 172.18.2.0 | Where-Object OptionID -Match "3" | Select -ExpandProperty Value
    if($ScopeDG -eq $ExpectedScopeDefaultGateway){
        Write-Host @greenCheck
        Write-Host " The Default gateway of the VLAN200 scope is configured correctly."
        $global:passed++
    } else {
        Write-Host "x" -ForegroundColor Red -NoNewline
        Write-Host " The default gateway for the VLAN200 scope is configured incorrectly: Should be 172.18.2.1."
    }
} 


Function CheckScopeDNS {
    $ScopeDNS = Get-DhcpServerV4OptionValue -ScopeId 172.18.2.0 | Where-Object OptionID -Match "6" | Select -ExpandProperty Value
    if($ScopeDNS -eq $ExpectedDNS){
        Write-Host @greenCheck
        Write-Host " The DNS server of the VLAN200 scope is configured correctly."
        $global:passed++
    } else {
        Write-Host "x" -ForegroundColor Red -NoNewline
        Write-Host " The DNS server for the VLAN200 scope is configured incorrectly: Should be 172.18.0.34."
    }
} 


Function CheckScopeDomain {
    $ScopeDomain = Get-DhcpServerV4OptionValue -ScopeId 172.18.2.0 | Where-Object OptionID -Match "15" | Select -ExpandProperty Value
    if($ScopeDomain -eq $ExpectedScopeDomain){
        Write-Host @greenCheck
        Write-Host " VLAN200 scope is part of the correct domain."
        $global:passed++
    } else {
        Write-Host "x" -ForegroundColor Red -NoNewline
        Write-Host " The VLAN200 scope is not part of of the red.local domain."
    }
} 


Function CheckScopeName {
    $ScopeName = Get-DhcpServerV4Scope -ScopeId 172.18.2.0 | Select -ExpandProperty Name
    if($ScopeName -eq $ExpectedScopeName){
        Write-Host @greenCheck
        Write-Host " The name of the scope is correctly configured as VLAN200."
        $global:passed++
    } else {
        Write-Host "x" -ForegroundColor Red -NoNewline
        Write-Host " Unexpected name of the scope."
    }
} 


Function CheckScopeSubnet {
    $ScopeSubnet = Get-DhcpServerV4Scope -ScopeId 172.18.2.0 | Select -ExpandProperty SubnetMask
    if($ScopeSubnet -eq $ExpectedScopeSubnet){
        Write-Host @greenCheck
        Write-Host " The subnetmask of the scope is correctly configured as 255.255.255.128."
        $global:passed++
    } else {
        Write-Host "x" -ForegroundColor Red -NoNewline
        Write-Host " The subnetmask for the VLAN200 scope is configured incorrectly: Should be 255.255.255.128."
    }
} 


Function CheckScopeRange {
    $ScopeStart = Get-DhcpServerV4Scope -ScopeId 172.18.2.0 | Select -ExpandProperty StartRange
    $ScopeEnd = Get-DhcpServerV4Scope -ScopeId 172.18.2.0 | Select -ExpandProperty EndRange
    if($ScopeStart -eq $ExpectedScopeRangeStart -and $ScopeEnd -eq $ExpectedScopeRangeEnd){
        Write-Host @greenCheck
        Write-Host " The range of the scope is correctly configured as 172.18.2.2 - 172.18.2.126."
        $global:passed++
    } else {
        Write-Host "x" -ForegroundColor Red -NoNewline
        Write-Host "The range of the VLAN200 is configured incorrectly: Should be 172.18.2.2 - 172.18.2.126"
    }
} 



Function CheckScopeState {
    $ScopeState = Get-DhcpServerV4Scope -ScopeId 172.18.2.0 | Select -ExpandProperty State
    if($ScopeState -eq $ExpectedScopeState){
        Write-Host @greenCheck
        Write-Host " The scope is active as expected."
        $global:passed++
    } else {
        Write-Host "x" -ForegroundColor Red -NoNewline
        Write-Host " The VLAN200 scope is inactive."
    }
} 


Function CheckScopeLease {
    $ScopeLease = Get-DhcpServerV4Scope -ScopeId 172.18.2.0 | Select -ExpandProperty LeaseDuration
    if($ScopeLease -eq $ExpectedScopeLeaseDuration){
        Write-Host @greenCheck
        Write-Host " The lease duration in the scope is correctly configured as 1 day."
        $global:passed++
    } else {
        Write-Host "x" -ForegroundColor Red -NoNewline
        Write-Host " The lease duration for the VLAN200 scope is not set to 1 day."
    }
}


## Execute functions
Write-Host "Testing KILO2 basic config... `n"
CheckHostname
CheckIP
CheckSubnet
CheckDG
CheckDNS

Write-Host "`nTesting DHCP installation... `n"
CheckDHCPService
CheckDhcpInDC

Write-Host "`nTesting VLAN200 scope configuration... `n"
CheckScopeName
CheckScopeState
CheckScopeDG
CheckScopeDNS
CheckScopeDomain
CheckScopeRange
CheckScopeSubnet 
CheckScopeLease
Write-Host "`n"$passed"/15 tests passed"
