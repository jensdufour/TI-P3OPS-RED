#Set Time Zone
Set-TimeZone -Name "Central Europe Standard Time" 
Write-Host "Changed timezone"

#Setup Firewall
Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False
Write-Host "Firewall all set!"

#Install IIS Webserver
Write-Host "We are installing IIS now, take a coffee and sit back..."
Install-WindowsFeature -name Web-Server -IncludeManagementTools
Enable-WindowsOptionalFeature -Online -FeatureName IIS-WebServerRole
Enable-WindowsOptionalFeature -Online -FeatureName IIS-WebServer
Enable-WindowsOptionalFeature -Online -FeatureName IIS-CommonHttpFeatures
Enable-WindowsOptionalFeature -Online -FeatureName IIS-HttpErrors
Enable-WindowsOptionalFeature -Online -FeatureName IIS-HttpRedirect
Enable-WindowsOptionalFeature -Online -FeatureName IIS-ApplicationDevelopment
Enable-WindowsOptionalFeature -Online -FeatureName IIS-HealthAndDiagnostics
Enable-WindowsOptionalFeature -Online -FeatureName IIS-HttpLogging
Enable-WindowsOptionalFeature -Online -FeatureName IIS-LoggingLibraries
Enable-WindowsOptionalFeature -Online -FeatureName IIS-RequestMonitor
Enable-WindowsOptionalFeature -Online -FeatureName IIS-HttpTracing
Enable-WindowsOptionalFeature -Online -FeatureName IIS-Security
Enable-WindowsOptionalFeature -Online -FeatureName IIS-RequestFiltering
Enable-WindowsOptionalFeature -Online -FeatureName IIS-Performance
Enable-WindowsOptionalFeature -Online -FeatureName IIS-WebServerManagementTools
Enable-WindowsOptionalFeature -Online -FeatureName IIS-IIS6ManagementCompatibility
Enable-WindowsOptionalFeature -Online -FeatureName IIS-Metabase
Enable-WindowsOptionalFeature -Online -FeatureName IIS-ManagementConsole
Enable-WindowsOptionalFeature -Online -FeatureName IIS-BasicAuthentication
Enable-WindowsOptionalFeature -Online -FeatureName IIS-WindowsAuthentication
Enable-WindowsOptionalFeature -Online -FeatureName IIS-StaticContent
Enable-WindowsOptionalFeature -Online -FeatureName IIS-DefaultDocument
Enable-WindowsOptionalFeature -Online -FeatureName IIS-WebSockets
Enable-WindowsOptionalFeature -Online -FeatureName IIS-ApplicationInit
Enable-WindowsOptionalFeature -Online -FeatureName IIS-ISAPIExtensions
Enable-WindowsOptionalFeature -Online -FeatureName IIS-ISAPIFilter
Enable-WindowsOptionalFeature -Online -FeatureName IIS-HttpCompressionStatic

#Install ASP.NET
Write-Host "Installing NET-Framework... " -ForegroundColor Green
Add-WindowsFeature NET-Framework-45-ASPNET
Write-Host "Installing NET-HTTP-Activation ..." -ForegroundColor Green
Add-WindowsFeature NET-WCF-HTTP-Activation45

#HTTPS SSL
Write-Host "HTTPS Certificate and binding"
$dnsName = 'www.red.local'
# create the ssl certificate
$newCert = New-SelfSignedCertificate -DnsName $dnsName -CertStoreLocation cert:\LocalMachine\My


Write-Host "Kopieer Orchard map naar c:/inetpub/wwwwroot"

Write-Host "Press any key to continue"
$x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
Write-Host


Write-Host "Setting folder permissions"

$acl = Get-Acl "C:\inetpub\wwwroot\Orchard\App_Data"
$AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule("IIS_IUSRS","Modify","Allow")
$acl.SetAccessRule($AccessRule)
$acl | Set-Acl "C:\inetpub\wwwroot\Orchard\App_Data"

$acl = Get-Acl "C:\inetpub\wwwroot\Orchard\Media"
$AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule("IIS_IUSRS","Modify","Allow")
$acl.SetAccessRule($AccessRule)
$acl | Set-Acl "C:\inetpub\wwwroot\Orchard\Media"

$acl = Get-Acl "C:\inetpub\wwwroot\Orchard\Modules"
$AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule("IIS_IUSRS","Modify","Allow")
$acl.SetAccessRule($AccessRule)
$acl | Set-Acl "C:\inetpub\wwwroot\Orchard\Modules"

$acl = Get-Acl "C:\inetpub\wwwroot\Orchard\Themes"
$AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule("IIS_IUSRS","Modify","Allow")
$acl.SetAccessRule($AccessRule)
$acl | Set-Acl "C:\inetpub\wwwroot\Orchard\Themes"


$siteName = 'Orchard'
#create site
New-WebSite -Name $SiteName -PhysicalPath C:\inetpub\wwwroot\Orchard -Force
# Create HTTPS binding
New-WebBinding -name $siteName -IP "*" -Port 443 -Protocol https
# get the web binding of the site
$binding = Get-WebBinding -Name $siteName -Protocol "https"
# set the ssl certificate
$binding.AddSslCertificate($newCert.GetCertHashString(), "My")
Write-Host "HTTPS Installed!"


Stop-WebSite -Name "Default Web Site"
Start-WebSite -Name "Orchard"


Write-Host "Volg nu het tweede script"