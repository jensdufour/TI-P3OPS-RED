###                Variables               ###
##############################################
$ServerName = "OSCAR2"
$ServerIP = "172.18.0.6"
$SubnetMask = "27"			# DEVELOPMENT=24	PRODUCTION=27
$DefaultGateway = "172.18.0.34"
$DNSServerPreferred = "172.18.0.34"
$DNSServerAlternate = "172.18.0.33"
$DomainName = "red.local"
$AdminUsername = "RED\Administrator"
$AdminPassword = ConvertTo-SecureString "Project2018" -AsPlainText -Force
$Credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $AdminUsername, $AdminPassword
$ETHERNET = "Ethernet"			
$LAN = "LAN"
$Connection = $false

###TODO:
#    - 



###            Set Firewall OFF            ###
##############################################
Write-Host "Start Set Firewall OFF"
Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False
Write-Host "Completed Set Firewall OFF"



###            Rename NetAdapter           ###
##############################################
Write-Host "Start Rename NetAdapter"
Rename-NetAdapter -Name $ETHERNET -NewName $LAN
Write-Host "Completed Rename NetAdapter"



###             Set Static IP              ###
##############################################
Write-Host "Start Set Static IP"
New-NetIPAddress –InterfaceAlias $LAN –IPAddress $ServerIP –PrefixLength $SubnetMask -DefaultGateway $DefaultGateway
Set-DNSClientServerAddress –InterfaceAlias $LAN –ServerAddresses ($DNSServerPreferred)
Write-Host "Completed Set Static IP"



###               Join Domain              ###
##############################################
Write-Host "Start Join Domain"
DO{
    IF(Test-Connection -ComputerName $DefaultGateway -ErrorAction SilentlyContinue){
        $Connection = $true
        Write-Host "CONNECTION TO ALFA2 OK" -ForegroundColor Green
        Add-Computer -DomainName $DomainName -Credential $Credential
    } ELSE{
        $Connection = $false
        Write-Host "CONNECTION TO ALFA2 FAILED" -ForegroundColor Red
    }
} WHILE($Connection -eq $false)
Write-Host "Completed Join Domain"



###              Rename Server             ###
##############################################
Write-Host "Start Rename Server"
Rename-Computer -ComputerName $env:COMPUTERNAME  -newName $ServerName -Force
Write-Host "Completed Rename Server"



###             Restart Server             ###
##############################################
Write-Host "Restart Server"
Restart-Computer