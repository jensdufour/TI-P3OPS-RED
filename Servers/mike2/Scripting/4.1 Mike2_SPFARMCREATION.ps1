$DBServer = 'November2'
$ConfigDB = 'Sharepoint_Config'
$PassPhrase = 'Mike2Mike2'
$SecPassPhrase = ConvertTo-SecureString $PassPhrase -AsPlaintext -Force


$CentralAdminContentDB = 'SharePointAdministrationContent'

$FarmAccount = 'red\Administrator'
$FarmPassword = 'Mike2Mike2'
$FarmPasEnc = ConvertTo-SecureString $FarmPassword  -AsPlaintext -Force

$cred_FarmAcc = New-Object System.Management.Automation.PsCredential $FarmAccount,$FarmPasEnc

$ServerRole = "SingleServerFarm"

Add-SPShellAdmin -UserName Red\Administrator


Write-Host " - Sharepoint PowerShell cmdlets..."
If ((Get-PsSnapin |?{$_.Name -eq "Microsoft.SharePoint.PowerShell"})-eq $null)
{
    Add-PsSnapin Microsoft.SharePoint.PowerShell | Out-Null
}
Start-SPAssignment -Global | Out-Null



Write-Host "Database config"
New-SPConfigurationDatabase -DatabaseServer "$DBServer" -DatabaseName "$ConfigDB" -AdministrationContentDatabaseName "$CentralAdminContentDB" -Passphrase $SecPassPhrase -FarmCredentials $cred_FarmAccount -LocalServerRole $ServerRole

Write-Host "Help collection voor sharepoint."
Install-SPHelpCollection -All

Write-Host "SharePoint Resource Security"
Initialize-SPResourceSecurity

Write-Host "SharePoint Services"
Install-SPService

Write-Host "SharePoint Features"
$Features = Install-SPFeature -AllExistingFeatures -Force

Write-Host "SharePoint Central Admininstration"
$NewCentralAdmin = New-SPCentralAdministration -Port $CentralAdminPort -WindowsAuthProvider "NTLM"

Write-Host " - provisioning" -NoNewline
sleep 10

Write-Host " SharePoint Application Content"
Install-SPApplicationContent



Stop-SPAssignment -Global | Out-Null
